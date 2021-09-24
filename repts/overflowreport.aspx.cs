using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections.Generic;

public partial class ReportManagement_overflowreport : System.Web.UI.Page
{
    SqlCommand Cmd = new SqlCommand();
    SqlConnection Con = new SqlConnection();
    SqlDataReader dr;
    String Query = "";
    public String strControlDistrict = "";
    public String[] arryControlDistrict;
    public static double dbMax = 10.0;
    public static double dbRestore = 0.0;
    public double elekw = 0.0;
    public double elekwtariff = 0.0;
    public double flowrate = 0.0;
    public double flowratetariff = 0.0;
    public static double[] dbValue;
    public static String[] dtDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        Genaral.CheckUserInfo(this);

        Reset_gv();
        if (Request.Cookies["Telemetry"] != null)
        {
            arryControlDistrict = Request.Cookies["Telemetry"]["ControlDistrict"] == null ? strControlDistrict.Split(',') : Request.Cookies["Telemetry"]["ControlDistrict"].Split(',');
        }

        if (arryControlDistrict.Length > 1)
        {
            for (int i = 0; i < arryControlDistrict.Length; i++)
            {
                if (i != arryControlDistrict.Length - 1)
                {
                    strControlDistrict = strControlDistrict + "'" + arryControlDistrict[i].Trim() + "', ";
                }
                else
                {
                    strControlDistrict = strControlDistrict + "'" + arryControlDistrict[i].Trim() + "'";
                }
            }
        }
        else
        {
            strControlDistrict = strControlDistrict + "'" + arryControlDistrict[0] + "'";
        }

        if (!IsPostBack)
        {
            Fill_ddlDistrict();
            Fill_ddlTime();

            if (txtBeginDate.Text == "")
            {
                txtBeginDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (txtEndDate.Text == "")
            {
                txtEndDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            }
        }
    }

    public void Reset_gv()
    {
        DataTable dtEvents = new DataTable();
        dtEvents.Columns.Add(new DataColumn("No"));
        dtEvents.Columns.Add(new DataColumn("DateTime"));
        dtEvents.Columns.Add(new DataColumn("SiteName"));
        dtEvents.Columns.Add(new DataColumn("Value"));
        dtEvents.Columns.Add(new DataColumn("Event"));

        DataTable dt = new DataTable();
        dt.Columns.Add("sno"); 
        dt.Columns.Add("sitename"); 
        dt.Columns.Add("Fromtime");
        dt.Columns.Add("totime");
        dt.Columns.Add("duration");

        DataRow dtRow;

        dtRow = dtEvents.NewRow();

        dtRow["No"] = "-";
        dtRow["DateTime"] = "-";
        dtRow["SiteName"] = "-";
        dtRow["Value"] = "-";
        dtRow["Event"] = "-";

        dtEvents.Rows.Add(dtRow);

        gvReport.DataSource = dt;
        gvReport.DataBind();
    }

    public void Fill_ddlTime()
    {
        for (int i = 0; i < 24; i++)
        {
            String value = i.ToString().Length == 1 ? "0" + i : i.ToString();

            beginHour.Items.Add(new ListItem(value, value));
            endHour.Items.Add(new ListItem(value, value));

        }

        for (int i = 0; i < 60; i++)
        {
            String value = i.ToString().Length == 1 ? "0" + i : i.ToString();

            beginMinute.Items.Add(new ListItem(value, value));
            endMinute.Items.Add(new ListItem(value, value));
        }

        endHour.SelectedIndex = 23;
        endMinute.SelectedIndex = 59;
    }

    public void Fill_ddlDistrict()
    {
        using (Con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]))
        {
            try
            {
                ddlDistrict.Items.Clear();
                //ddlDistrict.Items.Add(new ListItem("-All District--", "0"));
                if (strControlDistrict=="'ALL'")
                    Query = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table   ORDER BY sitedistrict";
                else 
                    Query = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table where sitedistrict in (" + strControlDistrict + ")  ORDER BY sitedistrict";
                Cmd = new SqlCommand(Query, Con);

                Con.Open();
                dr = Cmd.ExecuteReader();

                while (dr.Read())
                {
                    ddlDistrict.Items.Add(new ListItem(dr["sitedistrict"].ToString(), dr["sitedistrict"].ToString()));
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Fill_ddlDistrict Error - " + ex.Message;
            }
            finally
            {
                Cmd.Dispose();
                Con.Close();
            }

            Fill_ddlType(null, null);
        }
    }

    public void Fill_ddlType(object sender, EventArgs e)
    {
        using (Con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]))
        {
            try
            {
                String strSiteDistrict = ddlDistrict.Items.Count > 0 ? ddlDistrict.SelectedValue : "";

                ddlType.Items.Clear();
                //ddlType.Items.Add(new ListItem("-All Type--", "0"));

                Query = "SELECT DISTINCT(sitetype) FROM telemetry_site_list_table WHERE sitedistrict = '" + strSiteDistrict +
                        "' and sitetype='RESERVOIR' ORDER BY sitetype";
                Cmd = new SqlCommand(Query, Con);

                Con.Open();
                dr = Cmd.ExecuteReader();

                while (dr.Read())
                {
                    ddlType.Items.Add(new ListItem(dr["sitetype"].ToString(), dr["sitetype"].ToString()));
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Fill_ddlType Error - " + ex.Message;
            }
            finally
            {
                Cmd.Dispose();
                Con.Close();
            }

            Fill_ddlSiteName(null, null);
        }
    }

    public void Fill_ddlSiteName(object sender, EventArgs e)
    {
        using (Con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]))
        {
            try
            {
                String strSiteDistrict = ddlDistrict.Items.Count > 0 ? ddlDistrict.SelectedValue : "";
                String strSiteType = ddlType.Items.Count > 0 ? ddlType.SelectedValue : "";

                ddlSiteName.Items.Clear();
                //ddlSiteName.Items.Add(new ListItem("-All Site Name--", "0"));

                Query = "SELECT DISTINCT(sitename), siteid FROM telemetry_site_list_table WHERE sitedistrict = '" + strSiteDistrict +
                        "' AND sitetype = '" + strSiteType + "' ORDER BY sitename";
                Cmd = new SqlCommand(Query, Con);

                Con.Open();
                dr = Cmd.ExecuteReader();

                while (dr.Read())
                {
                    ddlSiteName.Items.Add(new ListItem(dr["sitename"].ToString(), dr["siteid"].ToString()));
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Fill_ddlSiteName Error - " + ex.Message;
            }
            finally
            {
                Cmd.Dispose();
                Con.Close();
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Fill_gvReports();
    }

    public void getEventName()
    {
    }

    public void Fill_gvReports()
    {
        
        using (Con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]))
        {
            try
            {
                String strBeginDate = txtBeginDate.Text.Split('/')[1] + "/" + txtBeginDate.Text.Split('/')[0] + "/" + txtBeginDate.Text.Split('/')[2] + " " + beginHour.SelectedValue + ":" + beginMinute.SelectedValue + ":00";
                String strEndDate = txtEndDate.Text.Split('/')[1] + "/" + txtEndDate.Text.Split('/')[0] + "/" + txtEndDate.Text.Split('/')[2] + " " + endHour.SelectedValue + ":" + endMinute.SelectedValue + ":59";

                List<double> lstDbValue = new List<double>();
                List<DateTime> lstDateTime = new List<DateTime>();

                String[] llRange = new String[2] { "0", "0" };
                String[] lRange = new String[2] { "0", "0" };
                String[] nnRange = new String[2] { "0", "0" };
                String[] hRange = new String[2] { "0", "0" };
                String[] hhRange = new String[2] { "0", "0" };

                DataTable dtEvents = new DataTable();
                dtEvents.Columns.Add(new DataColumn("No"));
                dtEvents.Columns.Add(new DataColumn("DateTime"));
                dtEvents.Columns.Add(new DataColumn("SiteName"));
                dtEvents.Columns.Add(new DataColumn("Value"));
                dtEvents.Columns.Add(new DataColumn("Event"));


                DataTable dt = new DataTable();
                dt.Columns.Add("sno");
                dt.Columns.Add("sitename");
                dt.Columns.Add("Fromtime");
                dt.Columns.Add("totime");
                dt.Columns.Add("duration");
                dt.Columns.Add("elec");
                dt.Columns.Add("electariff");
                dt.Columns.Add("elewaste");
                dt.Columns.Add("flowarte");
                dt.Columns.Add("flowtarif");
                dt.Columns.Add("waterwaste");
                dt.Columns.Add("totalwaste");


                DataRow dtRow;

                Query = "SELECT max FROM telemetry_equip_list_table WHERE siteid = '" + ddlSiteName.SelectedValue + "' AND position = '2'";
                Cmd = new SqlCommand(Query, Con);

                Con.Open();
                dr = Cmd.ExecuteReader();

                if (dr.Read())
                {
                    dbMax = Convert.ToDouble(dr["max"].ToString());
                    dr.Close();
                }

                Query = "SELECT  * FROM telemetry_tariffdetails_table where siteid='" + ddlSiteName.SelectedValue + "'";
                Cmd = new SqlCommand(Query, Con);
                dr = Cmd.ExecuteReader();
                if (dr.Read())
                {
                    elekw = Convert.ToDouble(dr["electricitykw"].ToString());
                    elekwtariff = Convert.ToDouble(dr["electricitytariff"].ToString());
                    flowrate = Convert.ToDouble(dr["inletflowrate"].ToString());
                    flowratetariff = Convert.ToDouble(dr["flowtariff"].ToString());
                }
                Query = "SELECT * FROM telemetry_rule_list_table WHERE siteid = '" + ddlSiteName.SelectedValue + "' AND alarmmode = 'EVENT'";
                Cmd = new SqlCommand(Query, Con);
                dr = Cmd.ExecuteReader();

                while (dr.Read())
                {
                    String[] tmpRange = dr["multiplier"].ToString().Split(';');

                    switch (dr["alarmtype"].ToString())
                    {
                        case "LL":
                            {
                                if (tmpRange[0].ToString().ToUpper() == "RANGE")
                                {
                                    llRange[0] = tmpRange[1];
                                    llRange[1] = tmpRange[2];
                                }
                                else
                                {
                                    llRange[0] = "0";
                                    llRange[1] = "0";
                                }
                                break;
                            }
                        case "L":
                            {
                                if (tmpRange[0].ToString().ToUpper() == "RANGE")
                                {
                                    lRange[0] = tmpRange[1];
                                    lRange[1] = tmpRange[2];
                                }
                                else
                                {
                                    lRange[0] = "0";
                                    lRange[1] = "0";
                                }
                                break;
                            }
                        case "NN":
                            {
                                if (tmpRange[0].ToString().ToUpper() == "RANGE")
                                {
                                    nnRange[0] = tmpRange[1];
                                    nnRange[1] = tmpRange[2];
                                }
                                else
                                {
                                    nnRange[0] = "0";
                                    nnRange[1] = "0";
                                }
                                break;
                            }
                        case "H":
                            {
                                if (tmpRange[0].ToString().ToUpper() == "RANGE")
                                {
                                    hRange[0] = tmpRange[1];
                                    hRange[1] = tmpRange[2];
                                }
                                else
                                {
                                    hRange[0] = "0";
                                    hRange[1] = "0";
                                }
                                break;
                            }
                        case "HH":
                            {
                                if (tmpRange[0].ToString().ToUpper() == "RANGE")
                                {
                                    hhRange[0] = tmpRange[1];
                                    hhRange[1] = tmpRange[2];
                                }
                                else
                                {
                                    hhRange[0] = "0";
                                    hhRange[1] = "0";
                                }
                                break;
                            }
                        default:
                            break;
                    }
                }

                Query = "SELECT * FROM telemetry_log_table WHERE siteid = '" + ddlSiteName.SelectedValue + "' AND position = '2' AND dtimestamp " +
                    "BETWEEN '" + strBeginDate + "' AND '" + strEndDate + "' ORDER BY dtimestamp";
                Cmd = new SqlCommand(Query, Con);
                dr = Cmd.ExecuteReader();

                while (dr.Read())
                {
                    lstDbValue.Add(Convert.ToDouble(dr["value"].ToString()));
                    lstDateTime.Add(Convert.ToDateTime(dr["dtimestamp"].ToString()));
                }

                //Filtering
                //************************************************
                dbValue = new double[lstDbValue.Count];
                dtDate = new String[lstDateTime.Count];

                dbRestore = lstDbValue.Count > 0 ? lstDbValue[0] : 0.00;
                for (int i = 0; i < lstDbValue.Count; i++)
                {
                    if (Convert.ToDouble(lstDbValue[i]) < dbMax)
                    {
                        dbRestore = lstDbValue[i];
                        i = lstDbValue.Count;
                    }
                }

                for (int i = 0; i < lstDbValue.Count; i++)
                {
                    double dbTmp = 0;
                    DateTime dtTmp;

                    dbTmp = lstDbValue[i];
                    dtTmp = lstDateTime[i];

                    if (i > 0)
                    {
                        //if (dbTmp >= dbMaxValue || dbTmp <= 0)
                        //{
                        if (dtTmp.Subtract(lstDateTime[i - 1]).TotalMinutes <= 20)
                        {
                            if (dbTmp - lstDbValue[i - 1] > 1 || dbTmp - lstDbValue[i - 1] < -1)
                            {
                                lstDbValue[i] = lstDbValue[i - 1];
                            }
                        }
                        //}
                    }
                    else
                    {
                        if (dbTmp > dbMax)
                        {
                            lstDbValue[i] = dbRestore;
                        }

                        if (dbTmp > dbMax)
                        {
                            dbMax = dbTmp;
                        }
                    }

                    dbValue[i] = lstDbValue[i];
                    dtDate[i] = lstDateTime[i].ToString("dd/MM/yyyy hh:mm:ss tt");
                }
                //************************************************

                for (int i = 0; i < lstDbValue.Count; i++)
                {
                    dtRow = dtEvents.NewRow();

                    dtRow["No"] = i + 1;
                    dtRow["DateTime"] = lstDateTime[i].ToString("yyyy/MM/dd HH:mm:ss");
                    dtRow["SiteName"] = ddlSiteName.SelectedItem;
                    dtRow["Value"] = lstDbValue[i].ToString("0.00");

                    if (lstDbValue[i] >= Convert.ToDouble(llRange[0]) && lstDbValue[i] <= Convert.ToDouble(llRange[1]))
                    {
                        dtRow["Event"] = "LL";
                    }
                    else if (lstDbValue[i] >= Convert.ToDouble(lRange[0]) && lstDbValue[i] <= Convert.ToDouble(lRange[1]))
                    {
                        dtRow["Event"] = "L";
                    }
                    else if (lstDbValue[i] >= Convert.ToDouble(nnRange[0]) && lstDbValue[i] <= Convert.ToDouble(nnRange[1]))
                    {
                        dtRow["Event"] = "NN";
                    }
                    else if (lstDbValue[i] >= Convert.ToDouble(hRange[0]) && lstDbValue[i] <= Convert.ToDouble(hRange[1]))
                    {
                        dtRow["Event"] = "H";
                    }
                    else if (lstDbValue[i] >= Convert.ToDouble(hhRange[0]) && lstDbValue[i] <= Convert.ToDouble(hhRange[1]))
                    {
                        dtRow["Event"] = "HH";
                    }
                    else
                    {
                        dtRow["Event"] = "-";
                    }

                    dtEvents.Rows.Add(dtRow);
                }

                string prevstatus = "Normal";
                string currentstatus = "Normal"; 
                DateTime tempprevtime =Convert .ToDateTime( strBeginDate);
                DateTime prevtime = Convert .ToDateTime(strBeginDate);
                DateTime currenttime =Convert .ToDateTime( strBeginDate); 
                int sno = 1;
                DataRow r;
                TimeSpan totalSpan=new TimeSpan ();
                double total1=0.0;
                   double total2=0.0;
                   double total3=0.0;
                   
                try
                {
                    for (int i = 0; i < dtEvents.Rows.Count;i++ )
                    {
                    
                        currenttime = Convert.ToDateTime(dtEvents.Rows[i]["DateTime"]);

                        if (dtEvents.Rows[i]["Event"] != "-" && dtEvents.Rows[i]["Event"] != "HH")
                        {
                            currentstatus = "Normal";
                        }
                        else
                        {
                            currentstatus = "Overflow";
                        }
                        
                            if (prevstatus != currentstatus)
                            {
                                tempprevtime = currenttime;
                                TimeSpan temptime = tempprevtime - prevtime;
                                //currenttime - prevtime
                                Int16 minutes =Convert .ToInt16( temptime.TotalMinutes);
                                if (prevstatus == "Overflow")
                                {
                                    if ((temptime.Hours * 60) + temptime.Minutes >= 1)
                                    {
                                        r = dt.NewRow() ;
                                        r[0] = sno;
                                        r[1] = dtEvents.Rows[i]["SiteName"]; 
                                        r[2] = prevtime.ToString("yyyy-MM-dd HH:mm:ss");
                                        r[3] = currenttime.ToString("yyyy-MM-dd HH:mm:ss"); 
                                        r[4] = ((temptime.Days*24)+ temptime.Hours).ToString("00") + ":" + temptime.Minutes.ToString("00") +":"+ temptime.Seconds.ToString("00");
                                        r[5] = elekw;
                                        r[6] = elekwtariff;
                                        r[7] = (temptime.TotalHours * elekw * elekwtariff).ToString("0.00") ;
                                        total1 = total1 + (temptime.TotalHours * elekw * elekwtariff);
                                        r[8] = flowrate;
                                        r[9] = flowratetariff;
                                        r[10] = (temptime.TotalHours * flowrate * flowratetariff).ToString("0.00");
                                        total2 = total2 + (temptime.TotalHours * flowrate * flowratetariff);
                                        r[11] = ((temptime.TotalHours * elekw * elekwtariff) + (temptime.TotalHours * flowrate * flowratetariff)).ToString("0.00");
                                        total3=total1+total2;
                                        totalSpan = totalSpan + temptime;
                                        dt.Rows.Add(r);
                                        sno = sno + 1;
                                    }
                                }
                                prevtime = currenttime;
                                prevstatus = currentstatus;
                            }
                         
                    }
                }
                catch (Exception ex1)
                {
                    Response.Write("Err:" +ex1.Message);
                }
                if (prevtime != currenttime)
                {
                    TimeSpan temptime = tempprevtime - prevtime;
                    //currenttime - prevtime
                    Int32 minutes = Convert.ToInt32(temptime.TotalMinutes);
                    if (prevstatus == "Overflow")
                    {
                        if ((temptime.Hours * 60) + temptime.Minutes >= 1)
                        {
                            r = dt.NewRow();
                            r[0] = sno;
                            r[1] = ddlSiteName.SelectedItem .Text ;
                            r[2] = prevtime.ToString("yyyy-MM-dd HH:mm:ss");
                            r[3] = currenttime.ToString("yyyy-MM-dd HH:mm:ss");
                            r[4] = ((temptime.Days * 24) + temptime.Hours).ToString("00") + ":" + temptime.Minutes.ToString("00") + ":" + temptime.Seconds.ToString("00");
                            r[5] = elekw;
                            r[6] = elekwtariff;
                            r[7] = (temptime.TotalHours * elekw * elekwtariff).ToString("0.00");
                            total1 = total1 + (temptime.TotalHours * elekw * elekwtariff);
                            r[8] = flowrate;
                            r[9] = flowratetariff;
                            r[10] = (temptime.TotalHours * flowrate * flowratetariff).ToString("0.00");
                            total2 = total2 + (temptime.TotalHours * flowrate * flowratetariff);
                            r[11] = ((temptime.TotalHours * elekw * elekwtariff) + (temptime.TotalHours * flowrate * flowratetariff)).ToString("0.00");
                            total3 = total1 + total2;
                            totalSpan = totalSpan + temptime;
                            dt.Rows.Add(r);
                            sno = sno + 1;
                        }
                    }
                }
               
                if (dt.Rows.Count == 0)
                {
                    r = dt.NewRow();
                    r[0] = "--";
                    r[1] = "--";
                    r[2] = "--";
                    r[3] = "--";
                    r[4] = "--";
                    r[5] = "--";
                    r[6] = "--";
                    r[7] = "--";
                    r[8] = "--";
                    r[9] = "--";
                    r[10] = "--";
                    r[11] = "--";  
                    dt.Rows.Add(r);
                }

               
                Session.Remove("exceltable");
                Session["exceltable"]= dt;
               
                gvReport.DataSource = dt;
                gvReport.DataBind();
                
                gvReport.FooterRow.Cells[4].Text =  totalSpan.Duration().TotalHours.ToString("00") + ":" + totalSpan.Duration().Minutes.ToString("00") + ":" + totalSpan.Duration().Seconds.ToString("00");
                 gvReport.FooterRow.Cells[7].Text=total1.ToString ("0.00");
                      gvReport.FooterRow.Cells[10].Text=total2.ToString ("0.00");
                      gvReport.FooterRow.Cells[11].Text = total3.ToString("0.00");
               
            }
            catch (Exception ex)
            {
                lblError.Text = "Fill_gvReports Error - " + ex.Message;
            }
            finally
            {
                Cmd.Dispose();
                Con.Close();
            }
        }
    }

    
}