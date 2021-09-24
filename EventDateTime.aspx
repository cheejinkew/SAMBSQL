<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB"%>
<html>
<body>
<%
   dim objConn 
   dim strConn 
   dim sqlRs 
   dim strSiteID = request.QueryString("siteid")
   dim intPosition = 2
  

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
    
   objConn.open(strConn)

   sqlRs.Open("select sequence from telemetry_equip_status_table where siteid='" & strSiteID & "' and position =" & intPosition & " order by sequence desc limit 1",objConn)
   if not sqlRs.EOF then
     response.write (sqlRs("sequence").value)
   end if
     'response.write (strSiteID & " : " & intPosition)
     sqlRs.close()
   objConn.close()
   objConn = nothing
%>

</body>
</html>
<script language="Javascript">

 var refreshInterval 
 refreshInterval = 10000;  
 setTimeout('window.location.reload()', refreshInterval);

</script>