<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlSp
   dim strConn
   dim arryUser
   dim i
   dim strSiteDistrict

   arryUser = split(Request.Form("chkDelete"), ",")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

   for i = 0 to ubound(arryUser)
     sqlSp = "Delete from telemetry_user_table where userid='" & ltrim(arryUser(i)) & "'"
     objConn.Execute (sqlSp)
   next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteUser" method="post" action="../User.aspx">
</form>
</body></html>
<script language="javascript">
  document.frmDeleteUser.submit();
</script>