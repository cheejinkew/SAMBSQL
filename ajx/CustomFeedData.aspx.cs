using System;
using System.Data.SqlClient;

public partial class ajx_CustomFeedData : System.Web.UI.Page
{
    public static String strSiteID = "";
    public static Boolean getRule = false;

    SqlCommand Cmd = new SqlCommand();
    SqlConnection Con = new SqlConnection();
    SqlDataReader dr;
    String Query = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        //Genaral.CheckUserInfo(this);
        strSiteID = Request.QueryString["ID"] == null ? "" : Request.QueryString["ID"];
        getRule = Request.QueryString["Rule"] == null ? false : true;

        getData();
    }

    public void getData()
    {
        using (Con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]))
        {
            try
            {
                String strData = "";
                int intCount = 0;
                int intPosition = 1;

                String strValue = "";
                String strPosition = "";
                String strTimeStamp = "-";
                String strLastTimeStamp = "-";

                if (strSiteID == "S1J0")
                {
                    Query = "SELECT * FROM telemetry_equip_status_table WHERE siteid in ('S1J0','S1J13','S1J15') AND position >= '2' ORDER BY position ASC";
                }
                else
                {
                    Query = "SELECT * FROM telemetry_equip_status_table WHERE siteid = '" + strSiteID + "' AND position >= '2' ORDER BY position ASC";
                }
                Cmd = new SqlCommand(Query, Con);

                Con.Open();
                dr = Cmd.ExecuteReader();

                while (dr.Read())
                {
                    intCount = intCount + 1;
                    intPosition = intPosition + 1;

                    strValue = dr.IsDBNull(dr.GetOrdinal("value")) ? "-" : (dr["value"].ToString().IndexOf('.') > -1 ? Convert.ToDouble(dr["value"]).ToString("0.00") : dr["value"]).ToString();
                    strPosition = dr.IsDBNull(dr.GetOrdinal("position")) ? "-" : dr["position"].ToString();

                    while (intPosition.ToString() != strPosition)
                    {
                        intCount = intCount + 1;
                        intPosition = intPosition + 1;
                        strData = strData + "-|";
                    }

                    strData = strData + strValue + "|";

                    strTimeStamp = dr.IsDBNull(dr.GetOrdinal("dtimestamp")) ? "-" : dr["dtimestamp"].ToString();
                    if (strTimeStamp != "-")
                    {
                        if (strLastTimeStamp != "-" && Convert.ToDateTime(strTimeStamp) > Convert.ToDateTime(strLastTimeStamp))
                        {
                            strLastTimeStamp = strTimeStamp;
                        }
                        else if (strLastTimeStamp == "-")
                        {
                            strLastTimeStamp = strTimeStamp;
                        }
                    }
                }

                String strRule = "";
                if (getRule)
                {
                    String strHH = "-";
                    String strH = "-";
                    String strL = "-";
                    String strLL = "-";

                    String strAlarmType = "";
                    String strMultiplier = "";
                    String[] strMinMax;

                    Query = "SELECT * FROM telemetry_rule_list_table WHERE siteid='" + strSiteID + "' ORDER BY alarmtype";
                    Cmd = new SqlCommand(Query, Con);
                    dr = Cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        strAlarmType = dr.IsDBNull(dr.GetOrdinal("alarmtype")) ? "" : dr["alarmtype"].ToString();
                        strMultiplier = dr.IsDBNull(dr.GetOrdinal("multiplier")) ? "" : dr["multiplier"].ToString();
                        strMinMax = strMultiplier.Split(';');

                        if (strMinMax.Length > 2)
                        {
                            if (strMinMax[0].ToUpper() == "RANGE")
                            {
                                switch (strAlarmType)
                                {
                                    case "HH":
                                        {
                                            strHH = strMinMax[1];
                                        }
                                        break;

                                    case "H":
                                        {
                                            strH = strMinMax[1];
                                        }
                                        break;

                                    case "L":
                                        {
                                            strL = strMinMax[2];
                                        }
                                        break;

                                    case "LL":
                                        {
                                            strLL = strMinMax[2];
                                        }
                                        break;
                                }
                            }
                        }
                    }

                    //String strLastValue = "0";

                    //Query = "SELECT TOP 1 * FROM telemetry_rule_list_table WHERE siteid='" + strSiteID + "' ORDER BY alarmtype";
                    //Cmd = new SqlCommand(Query, Con);
                    //dr = Cmd.ExecuteReader();

                    strRule = "|" + strHH + "|" + strH + "|" + strL + "|" + strLL;
                }

                strData = (strLastTimeStamp == "-" ? "Data No Available" : Convert.ToDateTime(strLastTimeStamp).ToString("dd/MM/yyyy hh:mm:ss tt")) + "|" + intCount + "|" + strData + strSiteID + strRule;
                Response.Write(strData);
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                Cmd.Dispose();
                Con.Close();
            }
        }
    }
}