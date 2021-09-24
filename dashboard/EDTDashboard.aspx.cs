using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dashboard_EDTDashboard :  System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static data GetDashBoardJson(string sDist)
    {

        data rtdata=new data();
        ArrayList aain = new ArrayList();
        ArrayList ain = new ArrayList();
        ArrayList aaout = new ArrayList();
        ArrayList aout = new ArrayList();
        ArrayList categ = new ArrayList();
        ArrayList daydata = new ArrayList();
        ArrayList totinout = new ArrayList();
        ArrayList totinlet = new ArrayList();
        ArrayList totoutlet = new ArrayList();
        int tinlet = 0;
        int toutlet = 0;
        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand cmd = new SqlCommand();

            cmd = new SqlCommand("select t1.siteid,t2.sitename ,Position,dtimestamp,counter,value, case when t1.siteid in('DA1M','DA2M','DA6M','DA8M') then 'Inlet' when t1.siteid in('DA5M','DA9M','DA10') then 'Outlet' else 'Sub' end as st   from telemetry_equip_status_table_m6 t1 inner join telemetry_site_list_table t2 on t1.siteid=t2.siteid and POsition=2  and sitetype='FLOWRATE' ", conn);
 
            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                if (dr["st"].ToString() == "Inlet")
                {
                    ain = new ArrayList();
                    ain.Add(dr["sitename"].ToString());
                    ain.Add(Convert.ToInt32(dr["counter"].ToString()));
                    aain.Add(ain);
                    tinlet = tinlet + Convert.ToInt32(dr["counter"].ToString());
                }
                else if (dr["st"].ToString() == "Outlet")
                {
                    aout = new ArrayList();
                    aout.Add(dr["sitename"].ToString());
                    aout.Add(Convert .ToInt32 (dr["counter"].ToString()));
                    aaout.Add(aout);
                    toutlet = toutlet + Convert.ToInt32(dr["counter"].ToString());
                }

                //else if (dr["st"].ToString() == "Sub")
                //{
                //    switch (dr["sitename"].ToString())
                //    {
                //        case "DA3M": da8m = da8m + Convert.ToInt32(dr["counter"].ToString());
                //            break;
                //        case "DA7M": da8m = da8m + Convert.ToInt32(dr["counter"].ToString());
                //            break;
                //        case "DA11": da8m = da8m - Convert.ToInt32(dr["counter"].ToString());
                //            break;
                //        case "DA12": da8m = da8m - Convert.ToInt32(dr["counter"].ToString());
                //            break;
                //        case "DA4M": da8m = da8m - Convert.ToInt32(dr["counter"].ToString());
                //            break;
                //    }
                //}
            }
            totinlet.Add("Total Inlet Water");
            totinlet.Add(tinlet);
            totoutlet.Add("Total Outlet Water");
            totoutlet.Add(toutlet); 
            totinout.Add(totinlet);
            totinout.Add(totoutlet);

            //ain = new ArrayList();
            //ain.Add("Inlet EDT ( RW from Grisek)");
            //ain.Add(da8m);
            //aain.Add(ain);

            rtdata.inData = aain;
            rtdata.Outdata = aaout;
            rtdata.totinoutdata = totinout;

            conn.Close(); 
        }
        catch (Exception ex)
        {
            throw new HttpException(ex.ToString());
        }

        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand cmd = new SqlCommand();
            
            cmd = new SqlCommand("select distinct siteid,  CONVERT(varchar,dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](siteid,dtimestamp) as daycount from telemetry_log_table_m6 where   position=2 and siteid in (select siteid from telemetry_site_list_table where sitetype = 'FLOWRATE') and dtimestamp between '"+DateTime .Now .ToString ("yyyy/MM/dd 00:00:00")+ "' and '" + DateTime.Now.ToString("yyyy/MM/dd 23:59:59") + "'", conn);

            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                categ.Add(dr["siteid"].ToString());
                daydata .Add(Convert.ToInt32( dr["daycount"].ToString()));
            }

            rtdata.categories = categ;
            rtdata.daydata = daydata;

            conn.Close();
        }
        catch (Exception ex)
        {
            throw new HttpException(ex.ToString());
        }

        return rtdata;
    }

    public class data
    {
        public ArrayList inData { get; set; }
        public ArrayList Outdata { get; set; }
        public ArrayList totinoutdata { get; set; }
        public ArrayList categories { get; set; }
        public ArrayList daydata { get; set; }
    }

     
}