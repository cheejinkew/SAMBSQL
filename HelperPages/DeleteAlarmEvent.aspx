<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%
   dim objConn
   dim sqlSp
   dim strConn
   dim i
   dim arryDateTime
   dim arrySite
   dim strtmp

  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  objConn.open(strConn)
  
  arryDateTime = split(Request.Form("chkDelete"), ",")
   for i = 0 to ubound(arryDateTime)
     strtmp = split(arryDateTime(i),"|")
     sqlSp = "Delete from telemetry_alert_message_table where dtimestamp='" & ltrim(strtmp(0)) & "' and siteid='" & ltrim(strtmp(1)) & "'"
     objConn.Execute (sqlSp)
   next
   
  objConn.close
  objConn = nothing
  'Response.Redirect("../Alarm.aspx")
%>
<head><title>.</title></head>
<body>
<form name="frmDeleteAlarm" method="post" action="../Alarm.aspx"></form>
<script language="javascript"> document.forms[0].submit();</script>
</body></html>