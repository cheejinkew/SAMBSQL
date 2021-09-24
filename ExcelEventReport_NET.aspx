<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Odbc" %>
<%@ Import Namespace="System.IO" %>

<script language="VB" runat="server">
   
  dim objConn as OdbcConnection
  dim objComm as OdbcCommand
  dim sqlRs as OdbcDataReader
  dim objComm1 as OdbcCommand
  dim sqlRs1 as OdbcDataReader
  dim objComm2 as OdbcCommand
  dim sqlRs2 as OdbcDataReader
  dim strConn as String
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
  dim intCount = 5
  dim j =0
  
   
  Sub Page_Load(Source As Object, E As EventArgs) 

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
    objConn = New OdbcConnection(strConn)
    if strAlert="-1" then
      objComm = new OdbcCommand ("select sequence, index, position, value, event from telemetry_event_history_table " & _
                               " where siteid ='" & strSite  & "' " & _
                               " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)

      objComm1 = new OdbcCommand ("Select alarmtype from telemetry_rule_list_table where siteid ='" & _
                                   strSite & "' and alarmmode='EVENT'", objConn)
   

    else
      objComm = new OdbcCommand ("select sequence, index, position, value, event from telemetry_event_history_table " & _
                               " where siteid ='" & strSite  & "' and event='" & strAlert & "'" & _
                               " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)

      objComm1 = new OdbcCommand ("Select '" & strAlert & "' as alarmtype", objConn)
    end if

    sbrHTML = new StringBuilder()

    objConn.Open()
    sqlRs = objComm.ExecuteReader()

     sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Event Detail Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>DateTime</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Index</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Position</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Value</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Event</TH></TR>")

     do while sqlRs.Read()
       j = j +1
       sbrHTML.Append("<TR><TD align='left'>" & sqlRs.GetValue(0).ToString() & "</TD><TD>" & _
		      sqlRs.GetValue(1).ToString() & "</TD><TD>" & _
		      sqlRs.GetValue(2).ToString() & "</TD><TD>" & _
		      sqlRs.GetValue(3).ToString() & "</TD><TD>" & _
		      sqlRs.GetValue(4).ToString() & "</TD></TR>")
     loop
     
     sqlRs.Close()
     objConn.Close()
     sbrHTML.Append("</TABLE>")
     sbrHTML.Append("<BR><B>Total Number of Records are :&nbsp; " & j.ToString() & "</B><br><br><br>")

     sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=2><Font Size=5><center>Event Summary Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=2 align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=2 align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=2 align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Event</TH><TH style='background-color: #465AE8; color: #FFFFFF'># Alerts</TH></TR>")

     objConn.Open()
     sqlRs1 = objComm1.ExecuteReader()
     do while sqlRs1.Read()
       objComm2 = new OdbcCommand ("select count(event) as AlarmCount from telemetry_event_history_table " & _
                                   " where siteid ='" & strSite  & "' " & _
                                   " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                                   " and event ='" & sqlRs1.GetValue(0).ToString()  & "'", objConn)
       sqlRs2 = objComm2.ExecuteReader()
       do while sqlRs2.Read()
         sbrHTML.Append("<TR><TD align='left'>" & sqlRs1.GetValue(0).ToString() & "</TD><TD>" & sqlRs2.GetValue(0).ToString() & "</TD></TR>")
       loop
       sqlRs2.close()
     loop
     sqlRs1.Close()
     objConn.Close() 
     objConn = nothing
     
     
     sbrHTML.Append("</TABLE>")
   
     Response.Buffer =true
     Response.ContentType = "application/vnd.ms-excel"
     Response.AddHeader("Content-Disposition", "attachment; filename=EventHistoryReport.xls;")
    
     Response.Write(sbrHTML.ToString) 

  End Sub 
</script>

