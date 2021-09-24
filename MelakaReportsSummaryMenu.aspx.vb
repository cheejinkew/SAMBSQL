
Partial Class MelakaReportsSummaryMenu
    Inherits System.Web.UI.Page

    Public SiteIDStr
    Public StrSiteName

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        SiteIDStr = Request.QueryString("siteid")
        StrSiteName = Request.QueryString("sitename")
        'SiteIDStr1 = Request.QueryString("sitename")
        'Response.Write(StrSiteName)
    End Sub
End Class
