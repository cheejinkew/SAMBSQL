<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB"%>
<%@ Import Namespace="System.IO" %>

<%   
  dim objConn
  dim sqlRs 
  dim sqlRs1 
  dim sqlRs2 
  dim strConn
  dim sbrHTML as StringBuilder
  dim swXLS as StreamWriter
 
  dim strSite
  dim strSiteName
  dim strAlert
  dim strBeginDate
  dim strBeginHour
  dim strBeginMin
  dim strBeginDateTime
  dim strEndDate 
  dim strEndHour
  dim strEndMin
  dim strEndDateTime
  dim intCount = 2
  dim j = 0

  
   
  
    strSite = request.querystring("ddSite")
    strSiteName = request.querystring("ddSiteName")
    strAlert = request.querystring("ddAlert")
    strBeginDate = request.querystring("txtBeginDate")
    strBeginHour = request.querystring("ddBeginHour")
    strBeginMin = request.querystring("ddBeginMinute")
    strBeginDateTime = strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00"

    strEndDate = request.querystring("txtEndDate")
    strEndHour = request.querystring("ddEndHour")
    strEndMin = request.querystring("ddEndMinute")
    strEndDateTime = strEndDate & " " & strEndHour & ":" & strEndMin & ":59"   
     
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = new ADODB.Connection()
    sqlRs = new ADODB.Recordset()
    sqlRs1 = new ADODB.Recordset()
    sqlRs2 = new ADODB.Recordset()

    objConn.Open(strConn)


    if strAlert="-1" then
      sqlRs.open ("Select sequence, alarm from telemetry_alarm_history_table " & _
                  " where siteid ='" & strSite  & "' " & _
                  " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)

      sqlRs1.open ("Select alarmtype from telemetry_rule_list_table where siteid ='" & _
                   strSite & "' and alarmmode='ALARM'", objConn)

    else
      sqlRs.open ("Select sequence, alarm from telemetry_alarm_history_table " & _
                  " where siteid ='" & strSite  & "' and alarm='" & strAlert & "'" & _
                  " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)

      sqlRs1.open ("Select '" & strAlert & "' as alarmtype", objConn)
    end if
    
    sbrHTML = new StringBuilder()

     
     sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Alarm Detail Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>DateTime</TH><TH style='background-color: #465AE8; color: #FFFFFF'>Alarm</TH></TR>")
     
     do while not sqlRs.EOF
       j = j +1
       sbrHTML.Append("<TR><TD align='left'>" & sqlRs("sequence").value & "</TD><TD>" & _
		      sqlRs("alarm").value & "</TD></TR>")
		sqlRs.movenext()      
     loop
     sqlRs.Close()
     
     sbrHTML.Append("</TABLE>")
     sbrHTML.Append("<BR><B>Total Number of Records are :&nbsp; " & j.ToString() & "</B><br><br><br>")

     sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Alarm Summary Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Alarm</TH><TH style='background-color: #465AE8; color: #FFFFFF'># Alerts</TH></TR>")


     do while not sqlRs1.EOF
       sqlRs2.open ("select count(alarm) as AlarmCount from telemetry_alarm_history_table " & _
                    " where siteid ='" & strSite  & "' " & _
                    " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                    " and alarm ='" & sqlRs1("alarmtype").value  & "'", objConn)
       do while not sqlRs2.EOF
         sbrHTML.Append("<TR><TD align='left'>" & sqlRs1("alarmtype").value & "</TD><TD>" & sqlRs2("AlarmCount").value & "</TD></TR>")
       sqlRs2.movenext()
       loop
       sqlRs2.close()
       
       sqlRs1.movenext()
     loop
     sqlRs1.Close()
     objConn.Close()     
     objConn = nothing
     
     
     sbrHTML.Append("</TABLE>")
   
     Response.Buffer =true
     Response.ContentType = "application/vnd.ms-excel"
     Response.AddHeader("Content-Disposition", "attachment; filename=AlarmHistoryReport.xls;") 
    
     Response.Write(sbrHTML.ToString) 

%>

