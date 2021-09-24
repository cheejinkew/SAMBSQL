<!--#include file="../kont_id.aspx"-->
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
     sqlRs.Open("select sitename, alarmtype from telemetry_alert_message_table " & _
                "where siteid in (select siteid from telemetry_site_list_table " & _
                "                 where sitedistrict in (" & strControlDistrict & ") and siteid NOT IN ("& strKontID &")) " & _
                "  and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                "  order by sequence desc  limit 1", objConn)
   else
     sqlRs.Open("select sitename, alarmtype from telemetry_alert_message_table " & _
                " where siteid NOT IN ("& strKontID &") and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                "  order by sequence desc  limit 1", objConn)
   end if

dim x

response.write("<font size=1 color=#c0c0c0 face=arial>")
do until sqlRs.EOF
for each x in sqlRs.Fields
response.write(x.value)
if NOT sqlRs.EOF then response.write(" ; ")
next
sqlRs.MoveNext
loop
response.write("</font>")

   sqlRs.Close()
   objConn.close()
   sqlRs = nothing
   objConn = nothing
%>