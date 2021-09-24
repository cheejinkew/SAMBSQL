using System;
using System.Collections.Generic; 
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.IO;
using System.Collections;
using Newtonsoft.Json;

/// <summary>
/// Summary description for PollService
/// </summary>
[WebService(Namespace = "http://sambservice.g1.com.my/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
//[System.Web.Script.Services.ScriptService]
public class SAMBService : System.Web.Services.WebService {

    public SAMBService()
    { 
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
            [WebMethod]
            [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
            public bool Authenticate(string u, string p)
            {

                bool res = false;
                SqlCommand cmd = new SqlCommand();
                SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);

                try
                {
                    cmd = new SqlCommand("select username,pwd from telemetry_user_table where username = @u", conn);
                    cmd.Parameters.AddWithValue("@u", u);
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        if (dr["pwd"].ToString().ToUpper() == p.ToUpper())
                        {
                            res = true; 
                        }
                        else
                        {
                            res = false; 
                        }
                    }
                    conn.Close();
                }
                catch (Exception ex)
                { 
                    WriteLog("Authentication ERROR: " + ex.Message);
                }
                return res;
            }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String GetControldist(string u)
        { 
            string ctrlDistrict = "";
            string[] ctdist;
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = new SqlCommand("select control_district from telemetry_user_table where username = @u", conn);
                cmd.Parameters.AddWithValue("@u", u); 
                conn.Open(); 
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["control_district"].ToString() != "ALL" && dr["control_district"].ToString() != "")
                    {
                        ctdist = dr["control_district"].ToString().Split(',');
                        for (int i = 0; i < ctdist.Length; i++)
                        {
                            if(ctrlDistrict=="")
                            ctrlDistrict =  "'" + ctdist[i] + "'";
                            else
                            ctrlDistrict = ctrlDistrict + ",'" + ctdist[i] + "'";
                        }
                    }
                    else
                    {
                        ctrlDistrict = dr["control_district"].ToString();
                    }
                } 
                conn.Close();  
            }
            catch (Exception ex)
            {
                throw new HttpException(ex.ToString());
            } 
            return ctrlDistrict;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<Sitelist> GetSiteListJson(string dist,string type)
        {
            List<Sitelist> aa = new List<Sitelist>(); 
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);

            try
            {
                cmd = new SqlCommand("select siteid ,sitename  from telemetry_site_list_table where sitetype ='RESERVOIR' and sitedistrict ='" + dist + "' and sitetype='" + type + "' order by sitename", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                Sitelist sl; 
                while (dr.Read())
                {
                    sl = new Sitelist();
                    sl.siteid = dr["siteid"].ToString(); 
                    sl.sitename = dr["sitename"].ToString();
                    //INSERTtoFLOWStatus(ms.id.ToString (), ms.sMessage, ms.destination, dn);
                    aa.Add(sl);
                   // Json = JsonConvert.SerializeObject(sl); 
                   // WriteSendLog("Request: " + Json + " " + dist);
                }
            }
            catch (Exception ex)
            { 
                //WriteSendLog("Request ERROR: " + ex.Message); 
            }
            return aa;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<distlist > GetDistListJson(string u)
        {
            List<distlist> aa = new List<distlist>();
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);
            string ctrldist = "";
            try
            {
                ctrldist = GetControldist(u);
                if (ctrldist != "ALL" && ctrldist != "")
                {
                    cmd = new SqlCommand("select distinct sitedistrict  from telemetry_site_list_table where sitedistrict in (" + ctrldist + ") order by sitedistrict", conn);
                }
                else
                {
                    cmd = new SqlCommand("select distinct sitedistrict  from telemetry_site_list_table where sitedistrict <>'' order by sitedistrict", conn);
                }
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                distlist dl;
                while (dr.Read())
                {
                   dl = new distlist();
                   dl.district = dr["sitedistrict"].ToString(); 
                   aa.Add(dl); 
                }
            }
            catch (Exception ex)
            {
                WriteLog("Request ERROR: " + ex.Message); 
            }
            return aa;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<types> GetSiteType(string u)
        {
            List<types> aa = new List<types>();
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);
           
            try
            {
                cmd = new SqlCommand("select distinct sitetype  from telemetry_site_list_table where sitetype<>'' order by sitetype", conn); 
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                types dl;
                while (dr.Read())
                {
                    dl = new types();
                    dl.sitetype = dr["sitetype"].ToString();
                    aa.Add(dl);
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                //WriteSendLog("Request ERROR: " + ex.Message); 
            }
            return aa;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<ReturnData> GetDataJson(string sDist, string sType, string sName)
        {
            
            ArrayList JsonArr = new ArrayList();
            List<ReturnData> rd = new List<ReturnData>();
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = new SqlCommand();
                //if (sType == "RESERVOIR")
                //{
                //    cmd = new SqlCommand("SELECT value, dtimestamp from telemetry_equip_status_table where siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn);
                //    var _with1 = cmd.Parameters;
                //    _with1.Add(new SqlParameter("@SiteName", sName));
                //    _with1.Add(new SqlParameter("@SiteType", sType));
                //    _with1.Add(new SqlParameter("@SiteDist", sDist));
                //}
                //else if (sType == "BPH")
                //{
                //    bphsname = sName.Split("_")(0);
                //    bphsdesc = sName.Split("_")(1);
                string version = GetVersionByname(sName);
                if (version == "M6")
                { cmd = new SqlCommand("select t2.sdesc, t1.value,t1.dtimestamp  from telemetry_equip_status_table_m6 t1 inner join telemetry_equip_list_table t2 on t1.siteid =t2.siteid  and t1.position=t2.position  where t1.siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn); }
                 else
                { cmd = new SqlCommand("select t2.sdesc, t1.value,t1.dtimestamp  from telemetry_equip_status_table t1 inner join telemetry_equip_list_table t2 on t1.siteid =t2.siteid  and t1.position=t2.position  where t1.siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn); }
                    
                    var _with2 = cmd.Parameters;
                    _with2.Add(new SqlParameter("@SiteName", sName));
                    _with2.Add(new SqlParameter("@SiteType", sType));
                    _with2.Add(new SqlParameter("@SiteDist", sDist));
                    //_with2.Add(new SqlParameter("@bphsdec", bphsdesc));
              //  }



                SqlCommand cmd1 = new SqlCommand("SELECT alarmtype, multiplier from telemetry_rule_list_table where siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn);
                var _with3 = cmd1.Parameters;
                _with3.Add(new SqlParameter("@SiteName", sName));
                _with3.Add(new SqlParameter("@SiteType", sType));
                _with3.Add(new SqlParameter("@SiteDist", sDist));

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                
                while (dr.Read())
                {
                    ReturnData temp = new ReturnData();
                    temp.Equipname = dr["sdesc"].ToString();
                    temp.WaterLevel = dr["value"].ToString ();
                    temp.Status = "";
                    temp.TimeStamp = dr["dtimestamp"].ToString ();
                    rd.Add(temp); 
                }
                if (rd.Count > 0)
                {
                    string strStatusData = "";
                    ReturnData tempData = rd[0]; 
                    SqlDataReader dr1 = cmd1.ExecuteReader(); 
                    while (dr1.Read())
                    {
                        string strTemp = dr1["multiplier"].ToString ();
                        string strStatus = dr1["alarmtype"].ToString ();
                        string[] strRange = strTemp.Split(';');
                       
                      //  strStatusData = strStatusData + "-" + strStatus + ";" + strTemp;
                           strStatusData = strStatusData + ";" + strStatus + "-" + strRange[1] + " to " + strRange[2];

                        if (double.Parse(tempData.WaterLevel) >= double.Parse(strRange[1]) & double.Parse(tempData.WaterLevel) <= double.Parse(strRange[2]))
                        {
                            tempData.Status = strStatus;
                        } 
                     }

                    if (strStatusData.Length > 0)
                    {
                        strStatusData = strStatusData.Substring(1, strStatusData.Length - 1);
                    }

                    tempData.StatusData = strStatusData;
                    rd[0] = tempData; 
                }

                conn.Close();

                if (rd.Count == 0)
                {
                    ReturnData temp = new ReturnData();
                    temp.Equipname = "";
                    temp.WaterLevel = "0 meter";
                    temp.Status = "-";
                    temp.TimeStamp = "-";
                    temp.StatusData = "-";
                    rd.Add(temp);
                }
                else
                {
                    ReturnData temp = rd[0];
                    temp.WaterLevel = temp.WaterLevel + " meters";
                    rd[0] = temp;
                }

                
                 
            }
            catch (Exception ex)
            {
                throw new HttpException(ex.ToString());
            }

            return rd;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        //[EnableCors(origins: "*", headers: "*", methods: "*")]
        public dbdata GetDashBoardJson(string sDist)
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
                    cmd = new SqlCommand("select t.sitetype, t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid,st.sitetype,st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Yes' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Yes' else 'No' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where    t.Status ='Active' and  t.sitetype='RESERVOIR' group by t.sitetype, t.Delaystatsus order by t.sitetype", conn);

                }
                else
                {
                    cmd = new SqlCommand("select t.sitetype, t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid,st.sitetype,st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Yes' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Yes' else 'No' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where   t.sitedistrict='" + sDist + "' and t.Status ='Active' and  t.sitetype='RESERVOIR' group by t.sitetype, t.Delaystatsus order by t.sitetype", conn);
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

                //if (sDist == "ALL")
                //{
                //    // cmd = new SqlCommand("select t.sitetype, t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid,st.sitetype,st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Active' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where   t.Status ='Active' and  t.sitetype='RESERVOIR' group by t.sitetype, t.Delaystatsus order by t.sitetype", conn);
                //    cmd = new SqlCommand("select  t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid, st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Active' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict <>'Testing' and position =2 ) t where   t.Status ='Active'  group by  t.Delaystatsus ", conn);

                //}
                //else
                //{
                //    cmd = new SqlCommand("select t.sitetype, t.Delaystatsus,COUNT(t.siteid) as cnt from (Select est.siteid,st.sitetype,st.sitedistrict, smt.sitemode, case when DATEDIFF(day,dtimestamp,getdate())<31 then 'Active' else 'Down' end as Status,case when smt.sitemode=0 and  DATEDIFF(mi,dtimestamp,getdate())>45 then 'Delay' when smt.sitemode=1 and  DATEDIFF(mi,dtimestamp,getdate())>500 then 'Delay' when    DATEDIFF(mi,dtimestamp,getdate())>1440  then 'Stopped'  else 'Active' end as Delaystatsus from telemetry_equip_status_table est inner join telemetry_site_list_table st on est.siteid =st.siteid inner join telemetry_sitemode_table smt on smt.siteid=st.siteid where st.sitedistrict='" + sDist + "' and position =2 ) t where   t.Status ='Active' and  t.sitetype='RESERVOIR' group by t.sitetype, t.Delaystatsus order by t.sitetype", conn);
                //}

                //SqlCommand cmd1 = new SqlCommand();
                //if (sDist == "ALL")
                //{
                //    cmd1 = new SqlCommand("select  sevent , COUNT(siteid) as cnt from telemetry_equip_status_table  where siteid in (select siteid from telemetry_site_list_table where sitetype ='RESERVOIR' and sitedistrict <>'Testing') and DATEDIFF(day,dtimestamp,getdate())<31   and position =2 group by sevent", conn);
                //}
                //else
                //{
                //    cmd1 = new SqlCommand("select  sevent , COUNT(siteid) as cnt from telemetry_equip_status_table  where siteid in (select siteid from telemetry_site_list_table where sitetype ='RESERVOIR' and sitedistrict='" + sDist + "') and DATEDIFF(day,dtimestamp,getdate())<31  and position =2 group by sevent", conn);
                //}
                
                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    if (dr["Delaystatsus"].ToString() == "No")
                        dd.updated =Convert.ToInt16(dr["cnt"].ToString());
                    else if (dr["Delaystatsus"].ToString() == "Yes")
                        dd.delay = Convert.ToInt16(dr["cnt"].ToString());
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
        public List<SummaryData> GetSummaryDataJson(string sDist)
        {
           
            List<SummaryData> JsonArr = new List<SummaryData>(); 
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = default(SqlCommand);
                if (sDist == "ALL")
                {
                    cmd = new SqlCommand("SELECT distinct(sl.sitename) as sitename,sl.sitetype ,sl.sitedistrict , es.dtimestamp, es.value,es.sevent  FROM telemetry_site_list_table sl left outer join telemetry_equip_status_table es on sl.siteid = es.siteid where sl.sitetype = 'RESERVOIR' and es.position='2'  order by sl.sitename", conn);
                }
                else
                {
                    cmd = new SqlCommand("SELECT distinct(sl.sitename) as sitename,sl.sitetype ,sl.sitedistrict , es.dtimestamp, es.value,es.sevent  FROM telemetry_site_list_table sl left outer join telemetry_equip_status_table es on sl.siteid = es.siteid where sl.sitedistrict = @SiteDist and sl.sitetype = 'RESERVOIR' and es.position='2'  order by sl.sitename", conn);

                    var _with1 = cmd.Parameters;
                    _with1.Add(new SqlParameter("@SiteDist", sDist));
                }



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
                        temp.SiteName = dr["sitename"].ToString ();
                    }


                    if (DBNull.Value.Equals(dr["dtimestamp"]))
                    {
                        temp.TimeStamp = "-";
                    }
                    else
                    {
                         DateTime strTemp =Convert .ToDateTime( dr["dtimestamp"]);
                        temp.TimeStamp = strTemp.ToString("MM/dd/yyyy HH:mm:ss");
                    }

                    if (DBNull.Value.Equals(dr["value"]))
                    {
                        temp.Level = "-";
                    }
                    else
                    {
                        double tempValue =Convert .ToDouble( dr["value"]);
                        temp.Level = tempValue.ToString("N2");
                    }

                    if (DBNull.Value.Equals(dr["sevent"]))
                    {
                        temp.Status = "-";
                    }
                    else
                    {
                        if (dr["sevent"] == "No Event")
                        {
                            temp.Status = "NN";
                        }
                        else
                        {
                            temp.Status = dr["sevent"].ToString ();
                        }
                    }

                    JsonArr.Add(temp);
                }
                conn.Close();

                if (JsonArr.Count < 1)
                {
                    SummaryData temp = new SummaryData();
                    temp.District = "-";
                    temp.Type = "-";
                    temp.SiteName = "-";
                    temp.TimeStamp = "-";
                    temp.Level = "-";
                    temp.Status = "-";
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
        public List<SummaryData> GetSatusSummaryDataJson(string sDist, string status)
        {
            List<SummaryData> JsonArr = new List<SummaryData>();
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = new SqlCommand();
                if (sDist == "ALL")
                    cmd = new SqlCommand("select st.siteid ,t.dtimestamp,t.value,t.sevent ,st.sitename,st.sitetype ,st.sitedistrict  from telemetry_equip_status_table t inner join telemetry_site_list_table st on t.siteid =st.siteid  where t.position =2 and st.sitetype ='RESERVOIR'  and sitedistrict <>'Testing' and DATEDIFF(day,dtimestamp,getdate())<31 and t.sevent='" + status + "' order by st.sitedistrict", conn);
                else
                    cmd = new SqlCommand("select st.siteid ,t.dtimestamp,t.value,t.sevent ,st.sitename ,st.sitetype ,st.sitedistrict  from telemetry_equip_status_table t inner join telemetry_site_list_table st on t.siteid =st.siteid  where t.position =2 and st.sitetype ='RESERVOIR' and st.sitedistrict='" + sDist + "'  and DATEDIFF(day,dtimestamp,getdate())<31 and  t.sevent='" + status + "' order by st.sitedistrict", conn);
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

                    if (DBNull.Value.Equals(dr["sevent"]))
                    {
                        temp.Status = "-";
                    }
                    else
                    {
                        if (dr["sevent"] == "No Event")
                        {
                            temp.Status = "NN";
                        }
                        else
                        {
                            temp.Status = dr["sevent"].ToString();
                        }
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
        public DataLog GetTrendingDataJson(string siteid, string fromdate, string todate)
        {

            DataLog JsonArr = new DataLog();
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = default(SqlCommand);
                string version = GetVersion(siteid);
                if(version=="M6")
                cmd = new SqlCommand("SELECT * from telemetry_log_table_m6 where siteid='" + siteid + "' and dtimestamp between '" + fromdate + "' and '" + todate + "' and position=2 ", conn);
                else
                cmd = new SqlCommand("SELECT * from telemetry_log_table where siteid='" + siteid + "' and dtimestamp between '" + fromdate + "' and '" + todate + "' ", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                List<data> lgdata = new List<data>();
                while (dr.Read())
                {
                    data temp = new data();
                    temp.timestamp =Convert .ToDateTime ( dr["dtimestamp"]).ToString("yyyy/MM/dd HH:mm:ss");
                    temp.value = dr["value"].ToString();
                    lgdata.Add(temp);
                }
                dr.Close();
                cmd = new SqlCommand("select alarmtype ,multiplier  from telemetry_rule_list_table where siteid='"+siteid +"' and alarmmode ='EVENT' ", conn);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    switch (dr["alarmtype"].ToString ())
                    { 
                        case "HH":
                            JsonArr.HH = dr["multiplier"].ToString().Split(';')[1];
                            break;
                        case "H":
                             JsonArr.H = dr["multiplier"].ToString().Split(';')[1];
                            break;
                        case "L":
                             JsonArr.L = dr["multiplier"].ToString().Split(';')[2];
                            break;
                        case "LL":
                             JsonArr.LL = dr["multiplier"].ToString().Split(';')[2];
                            break;

                    }
                }
                dr.Close();
                conn.Close();
                JsonArr.logdata = lgdata;
                

            }
            catch (Exception ex)
            {
              
            }

            return JsonArr;
        }


        public static string GetVersion(string unitid)
        {

            string res = "";
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);

            try
            {
                cmd = new SqlCommand("select versionid from unit_list where unitid='"+ unitid +"'", conn); 
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    res = dr["versionid"].ToString();
                    
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                
            }
            return res;
        }

        public static string GetVersionByname(string sitename)
        {

            string res = "";
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);

            try
            {
                cmd = new SqlCommand("  select versionid from telemetry_site_list_table a inner join    unit_list b  on a.unitid =b.unitid  where a.sitename ='" + sitename + "'", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    res = dr["versionid"].ToString();

                }
                conn.Close();
            }
            catch (Exception ex)
            {

            }
            return res;
        } 

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public DataLog Get24hrsTrendingDataJson(string siteid)
        {

            DataLog JsonArr = new DataLog();
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = default(SqlCommand);
                string version = GetVersion(siteid);
                if (version == "M6")
                cmd = new SqlCommand("SELECT * from telemetry_log_table_m6 where siteid='" + siteid + "' and dtimestamp between '" + DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd HH:mm:ss") + "' and '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' and position=2 ", conn);
                else
                cmd = new SqlCommand("SELECT * from telemetry_log_table where siteid='" + siteid + "' and dtimestamp between '" + DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd HH:mm:ss") + "' and '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' ", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                List<data> lgdata = new List<data>();
                while (dr.Read())
                {
                    data temp = new data();
                    temp.timestamp = Convert.ToDateTime(dr["dtimestamp"]).ToString("yyyy/MM/dd HH:mm:ss");
                    temp.value = dr["value"].ToString();
                    lgdata.Add(temp);
                }
                dr.Close();
                cmd = new SqlCommand("select alarmtype ,multiplier  from telemetry_rule_list_table where siteid='" + siteid + "' and alarmmode ='EVENT' ", conn);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    switch (dr["alarmtype"].ToString())
                    {
                        case "HH":
                            JsonArr.HH = dr["multiplier"].ToString().Split(';')[1];
                            break;
                        case "H":
                            JsonArr.H = dr["multiplier"].ToString().Split(';')[1];
                            break;
                        case "L":
                            JsonArr.L = dr["multiplier"].ToString().Split(';')[2];
                            break;
                        case "LL":
                            JsonArr.LL = dr["multiplier"].ToString().Split(';')[2];
                            break;

                    }
                }
                dr.Close();
                conn.Close();
                JsonArr.logdata = lgdata;


            }
            catch (Exception ex)
            {

            }

            return JsonArr;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public DataLog GetWeekTrendingDataJson(string siteid)
        {

            DataLog JsonArr = new DataLog();
            try
            {
                string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
                SqlConnection conn = new SqlConnection(connstr);
                SqlCommand cmd = default(SqlCommand);
                string version = GetVersion(siteid);
                if(version == "M6")
                    cmd = new SqlCommand("SELECT * from telemetry_log_table_m6 where siteid='" + siteid + "' and dtimestamp between '" + DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd HH:mm:ss") + "' and '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' and position=2 ", conn);
                else
                cmd = new SqlCommand("SELECT * from telemetry_log_table where siteid='" + siteid + "' and dtimestamp between '" + DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd HH:mm:ss") + "' and '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' ", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                List<data> lgdata = new List<data>();
                while (dr.Read())
                {
                    data temp = new data();
                    temp.timestamp = Convert.ToDateTime(dr["dtimestamp"]).ToString("yyyy/MM/dd HH:mm:ss");
                    temp.value = dr["value"].ToString();
                    lgdata.Add(temp);
                }
                dr.Close();
                cmd = new SqlCommand("select alarmtype ,multiplier  from telemetry_rule_list_table where siteid='" + siteid + "' and alarmmode ='EVENT' ", conn);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    switch (dr["alarmtype"].ToString())
                    {
                        case "HH":
                            JsonArr.HH = dr["multiplier"].ToString().Split(';')[1];
                            break;
                        case "H":
                            JsonArr.H = dr["multiplier"].ToString().Split(';')[1];
                            break;
                        case "L":
                            JsonArr.L = dr["multiplier"].ToString().Split(';')[2];
                            break;
                        case "LL":
                            JsonArr.LL = dr["multiplier"].ToString().Split(';')[2];
                            break;

                    }
                }
                dr.Close();
                conn.Close();
                JsonArr.logdata = lgdata;


            }
            catch (Exception ex)
            {

            }

            return JsonArr;
        }

        protected void WriteLog(string message)
        {
            try
            {
                if ((message.Length > 0))
                {
                    StreamWriter sw = File.AppendText(Server.MapPath("").ToString() + "\\GetDelData.txt");
                    sw.WriteLine(DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + " - " + message);
                    sw.Close();
                } 
            }
            catch (Exception ex)
            {
            }
        }

}
public class Sitelist
{
    protected internal Sitelist()
    {

    }
    public string siteid { get; set; } 
    public string sitename { get; set; }
}
public class CmdList
{
    protected internal CmdList()
    {

    }
    public string cmdname { get; set; }
    public string cmd { get; set; }
}
public class centreslist
{
    protected internal centreslist()
    {

    }
    public string mobile { get; set; }
}
public class distlist
{
    protected internal distlist()
    {

    }
    public string district { get; set; }
}
public class types
{
    protected internal types()
    {

    }
    public string sitetype { get; set; }
}
public class ReturnData
{
    protected internal ReturnData()
    {

    }
    public string Equipname { get; set; }
    public string WaterLevel { get; set; }
      public string Status { get; set; }
      public string TimeStamp { get; set; }
      public string StatusData { get; set; }

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
      public string Status { get; set; }
   
}

public class DataLog
{
    protected internal DataLog()
    {

    } 
    public string HH { get; set; }
    public string H { get; set; }
    public string L { get; set; }
    public string LL { get; set; }
    public List<data> logdata { get; set; }
   
}

public class dbdata
{
    protected internal dbdata()
    {

    }
    public statusdata sd { get; set; }
    public delaydata dd { get; set; } 
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
}

public struct data
{
    public string timestamp { get; set; }
    public string value { get; set; }
}
  

