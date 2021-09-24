<!--#include file="kont_id.aspx"-->
<%
   dim objConn 
   dim strConn 
   dim sqlRs 
   dim strSiteName
   dim strEvent

   dim i
   dim strControlDistrict

   dim arryControlDistrict = split(request.cookies("Telemetry")("ControlDistrict"), ",")
   if arryControlDistrict.length() > 1 then
     for i = 0 to (arryControlDistrict.length() - 1)
       if i <> (arryControlDistrict.length() - 1)
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "', "
       else
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "'"
       end if
     next i
   else
     strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
   end if


   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
    
   objConn.open(strConn)

   if arryControlDistrict(0) <> "ALL" then     
     sqlRs.Open("select sitename, alarmtype, sequence from telemetry_alert_message_table " & _
                "where siteid in (select siteid from telemetry_site_list_table " & _
                "                 where sitedistrict in (" & strControlDistrict & ") and siteid NOT IN ("& strKontID &")) " & _
                "  and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                "  order by sequence desc  limit 1", objConn)
   else
     sqlRs.Open("select sitename, alarmtype, sequence from telemetry_alert_message_table " & _
                " where siteid NOT IN ("& strKontID &") and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                "  order by sequence desc  limit 1", objConn)
   end if
   
   if not sqlRs.EOF then
     strSiteName = sqlRs("sitename").value
     strEvent = sqlRs("alarmtype").value
%>
<embed id="1"src="images/notify.wav" autostart="true" hidden="true" loop="true" width="1" height="1" controls="console">
</embed>

<div id="alert" class="divStyle">
   <u>P/S - ALERT :</u>
  <br>
  <%=strSiteName%> ; <%=strEvent%>
  <br>
  <br>
</div>
<div id="AlertSound" >
    <a href="javascript: StopAlert();"><img src="images/StopAlert.jpg" style="border:0;"></a>
</div>
<%    
   end if
   sqlRs.Close()
   objConn.close()
   sqlRs = nothing
   objConn = nothing
%>