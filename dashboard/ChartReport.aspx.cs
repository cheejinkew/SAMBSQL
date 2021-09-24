using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;

public partial class dashboard_ChartReport : System.Web.UI.Page
{
    SqlConnection strConn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"]);
    public String ec = "false";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            txtBeginDate.Value = DateTime .Now.ToString("yyyy-MM-dd");
            txtEndDate.Value = DateTime. Now.ToString("yyyy-MM-dd");
            load_sitename();
        }

    }
    //public void load_district()
    //{
    //    strConn.Open();
    //    SqlCommand strSql = new SqlCommand("select distinct(sitedistrict)  from telemetry_site_list_table where sitedistrict='TESTING'", strConn);
    //    SqlDataReader dr = strSql.ExecuteReader();
    //    while (dr.Read())
    //    { 
    //        ddlSiteDistrict.Items.Add(new ListItem(dr["sitedistrict"].ToString(), dr["sitedistrict"].ToString()));
    //    }

    //    strConn.Close();
    //}

    public void load_sitename()
    {
        strConn.Open();
        string strSql4 = "";
        SqlDataReader dr;
        strSql4 = "select sitename,siteid from telemetry_site_list_table where  sitedistrict='TESTING' and sitetype='FLOWRATE' order by sitename asc";
        SqlCommand strSql5 = new SqlCommand(strSql4, strConn);
        dr = strSql5.ExecuteReader();
        while (dr.Read())
        {
            ddlSiteName.Items.Add(new ListItem(dr["sitename"].ToString(), dr["siteid"].ToString()));
        }

        strConn.Close();
    }

     


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static data GetData(string siteid,string fromdate,string todate)
    {

        data rtdata = new data(); 
        ArrayList categ = new ArrayList();
        ArrayList daydata = new ArrayList();  
        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["sqlserverconnectionSAMB"];
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand cmd = new SqlCommand();
            string fdate = Convert.ToDateTime(fromdate).ToString("yyyy/MM/dd 00:00:00");
            string tdate = Convert.ToDateTime(todate ).ToString("yyyy/MM/dd 23:59:59");
            cmd = new SqlCommand("select distinct siteid,  CONVERT(varchar,dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](siteid,dtimestamp) as daycount from telemetry_log_table_m6 where siteid='"+ siteid +"' and  position=2 and siteid in (select siteid from telemetry_site_list_table where sitetype = 'FLOWRATE') and dtimestamp between '" + fdate + "' and '" + tdate  + "'", conn);

            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                categ.Add(Convert .ToDateTime( dr["dtimestamp"].ToString()).ToString ("yyyy/MM/dd"));
                daydata.Add(Convert.ToInt32(dr["daycount"].ToString()));
            }

            rtdata.categories = categ;
            rtdata.daydata = daydata;

            conn.Close();
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.Message);
        }

        return rtdata;
    }

    public class data
    {
         
        public ArrayList categories { get; set; }
        public ArrayList daydata { get; set; }
    }
}