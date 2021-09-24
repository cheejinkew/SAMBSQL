<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlSp
   dim strConn
   dim arryRule
   dim i
   dim intSiteID

   arryRule = split(Request.Form("chkDelete"), ",")
   intSiteID = Request.Form("ddSite")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

   for i = 0 to ubound(arryRule)
     sqlSp = "Delete from telemetry_rule_list_table where ruleid='" & ltrim(arryRule(i)) & "'"
     objConn.Execute (sqlSp)
   next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteRule" method="post" action="../Rule.aspx">
  <input type="hidden" name="ddSite" value="<%=intSiteID%>">
</form>
</body></html>
<script language="javascript">
  document.frmDeleteRule.submit();
</script>