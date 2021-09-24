using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data.SqlClient;
using Newtonsoft.Json;

public partial class WindowsWaterLevel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string Siteid = Request.QueryString["sid"];


            GetJson(Siteid);
        }
        catch (Exception ex)
        {
            throw new HttpException(ex.ToString());
        }

    }

    protected string GetJson(string Siteid)
    {

        string Json = "";
        ArrayList JsonArr = new ArrayList();

        try
        {
            string connstr = System.Configuration.ConfigurationManager.AppSettings["SAMBconnection"];
            SqlConnection conn = new SqlConnection(connstr);

            SqlCommand cmd = new SqlCommand("SELECT value, dtimestamp ,slt.sitename from telemetry_equip_status_table  st left outer join telemetry_site_list_table slt on st.siteid =slt.siteid   where st.siteid=@Siteid and position =2", conn);

            cmd.Parameters.Add(new SqlParameter("@Siteid", Siteid));

            SqlCommand cmd1 = new SqlCommand("SELECT alarmtype, multiplier from telemetry_rule_list_table where siteid= @Siteid and alarmmode  ='EVENT'", conn);

            cmd1.Parameters.Add(new SqlParameter("@Siteid", Siteid));
            

            conn.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                ReturnData temp = new ReturnData();
                temp.Sitename = dr["sitename"].ToString();
                temp.WaterLevel = dr["value"].ToString();
                temp.Status = "";
                temp.TimeStamp = dr["dtimestamp"].ToString();

                JsonArr.Add(temp);

            }


            if (JsonArr.Count > 0)
            {
                string strStatusData = "";
                ReturnData tempData =(ReturnData ) JsonArr[0];

                SqlDataReader dr1 = cmd1.ExecuteReader();

                while (dr1.Read())
                {

                    string strTemp = dr1["multiplier"].ToString();
                    string strStatus = dr1["alarmtype"].ToString();
                    string[] strRange = strTemp.Split(';');
                    if (strStatus.Length >1)
                    strStatusData = strStatusData +  strStatus + " ;" + strTemp+"\n";
                    else
                        strStatusData = strStatusData + strStatus + "  ;" + strTemp + "\n";

                    if (double.Parse(tempData.WaterLevel) >= double.Parse(strRange[1]) & double.Parse(tempData.WaterLevel) <= double.Parse(strRange[2]))
                    {
                        tempData.Status = strStatus;
                    }

                }

                //if (strStatusData.Length > 0)
                //{
                //    strStatusData = strStatusData.Substring(1, strStatusData.Length - 1);
                //}
              
                tempData.StatusData = strStatusData;
                JsonArr[0] = tempData;

            }

            conn.Close();

            if (JsonArr.Count == 0)
            {
                ReturnData temp = new ReturnData();
                temp.Sitename  = "-";
                temp.WaterLevel = "0 meter";
                temp.Status = "dffaa";
                temp.TimeStamp = "-";
                temp.StatusData = "-";
                JsonArr.Add(temp);
            }
            else
            {
                ReturnData temp = (ReturnData)JsonArr[0];
                temp.WaterLevel = temp.WaterLevel + " meters";
                JsonArr[0] = temp;
            }

            Json = JsonConvert.SerializeObject(JsonArr);
            Json = Json.Substring(1, Json.Length - 2);

            Context.Response.ContentType = "application/json";
            Context.Response.Write(Json);

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

        return Json;

    }

    private struct ReturnData
    {
        public string Sitename;
        public string WaterLevel;
        public string Status;
        public string TimeStamp;
        public string StatusData;
    }
}