using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class dashboard_Dashboard1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static dbdata GetDashBoardJson(string sDist)
    {

        dbdata JsonArr = new dbdata();
        statusdata sd = new statusdata();
        delaydata dd = new delaydata();
        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand cmd = new SqlCommand();
            if (sDist == "ALL")
            {
                // cmd = new SqlCommand("select t.sitetype, t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid,st.sitetype,st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Active' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where   t.Status ='Active' and  t.sitetype='RESERVOIR' group by t.sitetype, t.Delaystatsus order by t.sitetype", conn);
                cmd = new SqlCommand("select  t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid, st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Active' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where   t.Status ='Active'  group by  t.Delaystatsus ", conn);

            }
            else
            {
                cmd = new SqlCommand("select t.sitetype, t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid,st.sitetype,st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Active' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict='" + sDist + "' and position =2 ) t where   t.Status ='Active' and  t.sitetype='RESERVOIR' group by t.sitetype, t.Delaystatsus order by t.sitetype", conn);
            }

            SqlCommand cmd1 = new SqlCommand();
            if (sDist == "ALL")
            {
                cmd1 = new SqlCommand("select  sevent , COUNT(siteid) as cnt from telemetry_equip_status_table  where siteid in (select siteid from telemetry_site_list_table where sitetype ='RESERVOIR' and sitedistrict <>'Testing') and DATEDIFF(day,dtimestamp,getdate())<31   and position =2 group by sevent", conn);
            }
            else
            {
                cmd1 = new SqlCommand("select  sevent , COUNT(siteid) as cnt from telemetry_equip_status_table  where siteid in (select siteid from telemetry_site_list_table where sitetype ='RESERVOIR' and sitedistrict='" + sDist + "') and DATEDIFF(day,dtimestamp,getdate())<31  and position =2 group by sevent", conn);
            }

            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                if (dr["Delaystatsus"].ToString() == "Active")
                    dd.updated = Convert.ToInt16(dr["cnt"].ToString());
                else if (dr["Delaystatsus"].ToString() == "Delay")
                    dd.delay = Convert.ToInt16(dr["cnt"].ToString());
                else if (dr["Delaystatsus"].ToString() == "Stopped")
                    dd.stopped = Convert.ToInt16(dr["cnt"].ToString());
                dd.total = dd.total + Convert.ToInt16(dr["cnt"].ToString());
            }

            SqlDataReader dr1 = cmd1.ExecuteReader();
            while (dr1.Read())
            {
                switch (dr1["sevent"].ToString())
                {
                    case "HH":
                        sd.HH = Convert.ToInt16(dr1["cnt"].ToString());
                        break;
                    case "H":
                        sd.H = Convert.ToInt16(dr1["cnt"].ToString());
                        break;
                    case "NN":
                        sd.NN = Convert.ToInt16(dr1["cnt"].ToString());
                        break;
                    case "L":
                        sd.L = Convert.ToInt16(dr1["cnt"].ToString());
                        break;
                    case "LL":
                        sd.LL = Convert.ToInt16(dr1["cnt"].ToString());
                        break;
                }
                sd.TOTAL = sd.TOTAL + Convert.ToInt16(dr1["cnt"].ToString());

            }

            conn.Close();

            JsonArr.dd = dd;
            JsonArr.sd = sd;
        }
        catch (Exception ex)
        {
            throw new HttpException(ex.ToString());
        }

        return JsonArr;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<SummaryData> GetSatusSummaryDataJson(string sDist, string status)
    {
        List<SummaryData> JsonArr = new List<SummaryData>();
        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand cmd = new SqlCommand();
            if (sDist == "ALL")
                cmd = new SqlCommand("select t.sitetype,t.sitedistrict, t.Delaystatsus,t.siteid,t.sitename,t.dtimestamp,t.value from (Select est.siteid,st.sitetype,st.sitename ,est.dtimestamp ,est.value , st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Updated' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where t.Status ='Active' and t.Delaystatsus='" + status + "' and  t.sitetype='RESERVOIR'  order by t.sitetype", conn);
            else
                cmd = new SqlCommand("select t.sitetype,t.sitedistrict, t.Delaystatsus,t.siteid,t.sitename,t.dtimestamp,t.value  from (Select est.siteid,st.sitetype,st.sitename ,est.dtimestamp,est.value , st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Updated' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict='" + status + "' and position =2 ) t where t.Status ='Active' and t.Delaystatsus='" + status + "' and  t.sitetype='RESERVOIR'  order by t.sitetype", conn);
            //   HttpContext.Current.Response.Write(cmd.CommandText);
            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                SummaryData temp = new SummaryData();
                if (DBNull.Value.Equals(dr["sitedistrict"]))
                {
                    temp.District = "-";
                }
                else
                {
                    temp.District = dr["sitedistrict"].ToString();
                }

                if (DBNull.Value.Equals(dr["sitetype"]))
                {
                    temp.Type = "-";
                }
                else
                {
                    temp.Type = dr["sitetype"].ToString();
                }

                if (DBNull.Value.Equals(dr["sitename"]))
                {
                    temp.SiteName = "-";
                }
                else
                {
                    temp.SiteName = dr["sitename"].ToString();
                }


                if (DBNull.Value.Equals(dr["dtimestamp"]))
                {
                    temp.TimeStamp = "-";
                }
                else
                {
                    DateTime strTemp = Convert.ToDateTime(dr["dtimestamp"]);
                    temp.TimeStamp = strTemp.ToString("MM/dd/yyyy HH:mm:ss");
                }

                if (DBNull.Value.Equals(dr["value"]))
                {
                    temp.Level = "-";
                }
                else
                {
                    double tempValue = Convert.ToDouble(dr["value"]);
                    temp.Level = tempValue.ToString("N2");
                }



                JsonArr.Add(temp);
            }

        }
        catch (Exception ex)
        {
            throw new HttpException(ex.ToString());
        }

        return JsonArr;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static qualitydata GetQualityWaterDataJson(string sDist)
    {
        string fromdate, todate;
        fromdate=DateTime .Now.AddMonths(-1) .ToString ("yyyy/MM/dd");
        todate =DateTime .Now.ToString ("yyyy/MM/dd");
        qualitydata JsonArr = new qualitydata();
        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand cmd = new SqlCommand();
            if (sDist == "ALL")
                cmd = new SqlCommand("select sitedist,siteid,SUM(rawwater) rawwater,SUM(treatedwater) treatedwater  from telemetry_waterquality_maintainence where timestamp between  '" + fromdate + "' and  '" + todate + "' group by sitedist,siteid ", conn);
                
            else
                cmd = new SqlCommand(" select sitedist,siteid,SUM(rawwater) rawwater,SUM(treatedwater) treatedwater  from telemetry_waterquality_maintainence where sitedist='" + sDist + "' and  timestamp between '" + fromdate + "' and  '" + todate + "' group by sitedist,siteid ", conn);
            //   HttpContext.Current.Response.Write(cmd.CommandText);
            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            List<qualityseries> qs = new List<qualityseries>();
            qualityseries qss = new qualityseries();
            List<string> sname = new List<string>();
              List<string> color = new List<string>();
            List<double> qf=new List<double> ();
            while (dr.Read())
            {
                
                sname.Add(dr["siteid"].ToString());
                  
                qss.name = "Raw Water";
                int index=qs.FindIndex(dx => dx.name == "Raw Water");
                if (index > -1)
                {
                    qs[index].data.Add(Convert.ToDouble(dr["rawwater"].ToString()));
                }
                else {
                    qf = new List<double>();
                    qf.Add(Convert.ToDouble(dr["rawwater"].ToString()));
                    qss.data = qf;
                    qss.color = "#FF5733";
                    qs.Add(qss);
                }
                qss.name = "Treated Water";
                int index1 = qs.FindIndex(dx => dx.name == "Treated Water");
                if (index1 > -1)
                {
                    qs[index1].data.Add(Convert.ToDouble(dr["treatedwater"].ToString()));
                }
                else {
                    qf = new List<double>();
                    qf.Add(Convert.ToDouble(dr["treatedwater"].ToString()));
                    qss.data = qf;
                    qss.color = "#0640E8";
                    qs.Add(qss);
                } 
            }
            JsonArr.sitename = sname;
            JsonArr.series = qs;

        }
        catch (Exception ex)
        {
            throw new HttpException(ex.ToString());
        }

        return JsonArr;
    }

    public class dbdata
    {
        protected internal dbdata()
        {

        }
        public statusdata sd { get; set; }
        public delaydata dd { get; set; }
    }

    public class SummaryData
    {
        protected internal SummaryData()
        {

        }
        public string District { get; set; }
        public string Type { get; set; }
        public string SiteName { get; set; }
        public string TimeStamp { get; set; }
        public string Level { get; set; }

    }
    public struct statusdata
    {
        public int HH { get; set; }
        public int H { get; set; }
        public int NN { get; set; }
        public int L { get; set; }
        public int LL { get; set; }
        public int TOTAL { get; set; }
    }

    public struct delaydata
    {
        public int total { get; set; }
        public int updated { get; set; }
        public int delay { get; set; }
        public int stopped { get; set; }
    }

    public struct data
    {
        public string timestamp { get; set; }
        public string value { get; set; }
    }

    public struct qualitydata
    {
        public List<string> sitename { get; set; }
        public List<qualityseries> series { get; set; }
       
       
    }
    public struct qualityseries
    {
        public string name { get; set; }
        public List<double> data { get; set; }
        public string color { get; set; }
    }



}