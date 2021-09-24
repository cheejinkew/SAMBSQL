<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Odbc" %>
<%@ Import Namespace="System.IO" %>

<script language="VB" runat="server">
   
  dim objConn as OdbcConnection
  dim objComm as OdbcCommand
  dim sqlRs as OdbcDataReader
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
  dim strDate
  dim strTime
  dim strEquip
  dim intCount = 4
  dim j = 0
  
   
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
    
     objComm = new OdbcCommand ("select ""sdesc"", equipname, dtimestamp, value  " & _
                                "from telemetry_log_table l, telemetry_equip_list_table e " & _
                                "where l.siteid ='" & strSite  & "' and l.siteid = e.siteid " & _
                                "  and l.position = e.position " & _
                                "  and dtimestamp >= '" & strBeginDateTime & "' and dtimestamp <= '" & strEndDateTime & "'", objConn)

    sbrHTML = new StringBuilder()

    objConn.Open()
    sqlRs = objComm.ExecuteReader()

     sbrHTML.Append("<TABLE Border=1 width=400>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Log History Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Date</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Time</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Equipment</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Value</TH></TR>")

       do while sqlRs.Read()
         j = j +1
         strDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(sqlRs.GetValue(2).ToString()))
         strTime = String.Format("{0:hh:mm:ss tt}", Date.Parse(sqlRs.GetValue(2).ToString()))
         strEquip = sqlRs.GetValue(0).ToString() & " : " & sqlRs.GetValue(1).ToString()
         
         sbrHTML.Append("<TR><TD align='left'>" & strDate & "</TD><TD align='left'>" & _
	                strTime & "</TD><TD>" & _
	  	        strEquip & "</TD><TD>" & _
		        sqlRs.GetValue(3).ToString() & "</TD></TR>")
       loop
     
     sbrHTML.Append("</TABLE>")
     sbrHTML.Append("<BR><BR><B>Total Number of Records are " & j.ToString() & "</B>")
    
     Response.Buffer =true
     Response.ContentType = "application/vnd.ms-excel"
     Response.AddHeader("Content-Disposition", "attachment; filename=LogHistoryReport.xls;")
    
     Response.Write(sbrHTML.ToString) 

  End Sub 
</script>

