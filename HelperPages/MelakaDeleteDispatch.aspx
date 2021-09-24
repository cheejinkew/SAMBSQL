<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlSp
   dim strConn
   dim arryTmp
   dim arryRule
   dim i
   dim intSiteID

   arryTmp = split(Request.Form("chkDelete"), ",")
   intSiteID = Request.Form("ddSite")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

   for i = 0 to ubound(arryTmp)
     arryRule = split(arryTmp(i), "|")
     sqlSp = "Delete from telemetry_dispatch_list_table where ruleid='" & ltrim(arryRule(0)) & "' and simno='" & ltrim(arryRule(1)) & "'"
     objConn.Execute (sqlSp)
   next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteDispatch" method="post" action="../Dispatch.aspx">
  <input type="hidden" name="ddSite" value="<%=intSiteID%>">
</form>
</body></html>
<script language="javascript">
  document.frmDeleteDispatch.submit();
</script>