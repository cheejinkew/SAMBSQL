using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBusinessLogic;
using System.Collections;
using System.Web.Script.Services;
public partial class index : System.Web.UI.Page
{
    public string Regcnt = "0";
    public string ActiveCnt = "0";
    public string DeActivecnt = "0";
    public string BlacklistCnt = "0";
    BusinessLogic bl = new BusinessLogic();
    public static Userinfo uinfo;
    protected void Page_Load(object sender, EventArgs e)
    {
        SubscriberStatusSummary summary = new SubscriberStatusSummary();
        try
        {
            uinfo = new Userinfo();
            if (Session["userinfo"] == null)
            { Response.Redirect("Login.aspx"); }
            else
            { uinfo = (Userinfo)Session["userinfo"]; }

            summary = bl.GetSubscriberStatusInfo();
            Regcnt = summary.Registered.ToString ();
            ActiveCnt = summary.Active.ToString();
            DeActivecnt = summary.Deactive.ToString();
            BlacklistCnt = summary.Blocked.ToString();
        }
        catch (Exception ex)
        {
             
        }
    }

    [System.Web.Services.WebMethod()]  
    public static List<ArrayList> GetPackageSummary()
    {
        BusinessLogic bl = new BusinessLogic();
        List<ArrayList> a = new List<ArrayList>();
        try
        {
            a = bl.GetpackageStatusInfo(uinfo.OperatorType);
        }
        catch (Exception ex)
        { 

        }
        return a;
    }
}