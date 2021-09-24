<!--#include file="kont_id.aspx"-->
<%
   dim objConn 
   dim strConn 
   dim sqlRs1,sqlRs2
   dim strSiteName
   dim strEvent
   dim current_date = "2006-06-27 00:00:00"'Date.Parse(today()).AddHours(-3384)
   current_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(current_date))   
   
   'response.write(current_date)
   'response.write("<br>")

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
   sqlRs1 = new ADODB.Recordset()
   sqlRs2 = new ADODB.Recordset()
    
   objConn.open(strConn)

   if arryControlDistrict(0) <> "ALL" then     
     sqlRs1.Open("select distinct(sitename),siteid from telemetry_alert_message_table " & _
                "where siteid in (select siteid from telemetry_site_list_table " & _
                "                 where sitedistrict in (" & strControlDistrict & ")) and siteid NOT IN ("& strKontID &") " & _
                "  and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _
                "  and sequence > '" & current_date & "' " & _
                "  ", objConn)
   else
     sqlRs1.Open("select sitename, alarmtype, sequence from telemetry_alert_message_table " & _
                " where siteid NOT IN ("& strKontID &") and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                "  order by sequence desc", objConn)
   end if
   

'     strSiteName = sqlRs1("sitename").value
'     strEvent = sqlRs1("alarmtype").value


dim x

response.write("<font size=1 color=#c0c0c0 face=arial>")

'for each x in sqlRs1.Fields
'response.write(x.name)
'if NOT sqlRs1.EOF then response.write(" | ")
'next

'response.write("<br>")

do until sqlRs1.EOF
for each x in sqlRs1.Fields
response.write(x.value)
if NOT sqlRs1.EOF then response.write(" ; ")
next
response.write("<br>")
sqlRs1.MoveNext
loop
response.write("</font>")


   sqlRs1.Close()
   objConn.close()
   sqlRs1 = nothing
   objConn = nothing
%>