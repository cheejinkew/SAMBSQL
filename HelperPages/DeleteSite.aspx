<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlSp
   dim strConn
   dim arrySite
   dim i
   dim strSiteDistrict

   arrySite = split(Request.Form("chkDelete"), ",")
   strSiteDistrict = Request.Form("ddDistrict")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

   for i = 0 to ubound(arrySite)
     sqlSp = "Delete from telemetry_site_list_table where siteid='" & ltrim(arrySite(i)) & "'"
     objConn.Execute (sqlSp)
   next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteSite" method="post" action="../Site.aspx">
  <input type="hidden" name="ddDistrict" value="<%=strSiteDistrict%>">
</form>
</body></html>
<script language="javascript">
  document.frmDeleteSite.submit();
</script>