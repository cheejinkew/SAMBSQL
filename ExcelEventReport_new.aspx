<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB"%>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="ChartDirector" %>


<%   
    Dim objConn
    Dim sqlRs
    Dim sqlRs1
    Dim sqlRs2
    Dim strConn
    Dim sbrHTML As StringBuilder
  
    Dim intCount = 5
    Dim j = 0


    Dim SiteID = Request.QueryString("ddSite")
    Dim SiteName = Request.QueryString("ddSiteName")
    Dim EquipName = Request.QueryString("EquipName")
    Dim Alert = Request.QueryString("ddAlert")
    Dim BeginDateTime = Request.QueryString("txtBeginDate") & " " & Request.QueryString("ddBeginHour") & ":" & Request.QueryString("ddBeginMinute") & ":00"
    Dim EndDateTime = Request.QueryString("txtEndDate") & " " & Request.QueryString("ddEndHour") & ":" & Request.QueryString("ddEndMinute") & ":00"
     
     'response.write(BeginDateTime &" <br /><br />"& EndDateTime)
     'response.end
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    
    objConn = new ADODB.Connection()
    sqlRs = new ADODB.Recordset()
    sqlRs1 = new ADODB.Recordset()
    sqlRs2 = new ADODB.Recordset()

       
    Dim rsRecords
    Dim values(0) As Double
    Dim sequence(0) As String
    Dim i As Integer
	
    rsRecords = New ADODB.Recordset()
    objConn.open(strConn)
    If Alert = "ALL Types" Then ''must be all types
        If SiteID = "All" Then
            sqlRs.Open("select l.sequence, l.index, ""desc"" || ' : ' || equipname, l.value, l.event " & _
                    "from telemetry_event_history_table l, telemetry_equip_list_table e " & _
                    "where l.siteid = e.siteid " & _
                    "  and l.position = e.position " & _
                    "  and sequence between '" & BeginDateTime & "' and '" & EndDateTime & "' " & _
                    "  and equipname not in ('DATE','TIME') order by sequence asc", objConn)
                  
            sqlRs1.open("Select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where  alarmmode='EVENT'", objConn)
        Else
            sqlRs.Open("select l.sequence, l.index, ""desc"" || ' : ' || equipname, l.value, l.event " & _
               "from telemetry_event_history_table l, telemetry_equip_list_table e " & _
               "where l.siteid ='" & SiteID & "' and l.siteid = e.siteid " & _
               "  and l.position = e.position " & _
               "  and sequence between '" & BeginDateTime & "' and '" & EndDateTime & "' " & _
               "  and equipname not in ('DATE','TIME')  order by sequence asc", objConn)
                  
            sqlRs1.open("Select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid ='" & _
                             SiteID & "' and alarmmode='EVENT'", objConn)
            
        End If
    Else
        If SiteID = "All" Then
            sqlRs.Open("select l.sequence, l.index, ""desc"" || ' : ' || equipname, l.value, l.event " & _
                 "from telemetry_event_history_table l, telemetry_equip_list_table e " & _
                 "where l.siteid = e.siteid " & _
                 "  and l.position = e.position " & _
                 "   and sequence between '" & BeginDateTime & "' and '" & EndDateTime & "' " & _
                 " and event='" & Alert & "'", objConn)
                  
            sqlRs1.Open("Select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where  alarmmode='EVENT' and alarmtype='" & Alert & "'", objConn)
        Else
            sqlRs.Open("select l.sequence, l.index, ""desc"" || ' : ' || equipname, l.value, l.event " & _
                 "from telemetry_event_history_table l, telemetry_equip_list_table e " & _
                 "where l.siteid ='" & SiteID & "' and l.siteid = e.siteid " & _
                 "  and l.position = e.position " & _
                 "   and sequence between '" & BeginDateTime & "' and '" & EndDateTime & "' " & _
                 " and event='" & Alert & "' ", objConn)
                  
            sqlRs1.Open("Select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid ='" & _
                                 SiteID & "' and alarmmode='EVENT' and alarmtype='" & Alert & "'", objConn)
        End If
    End If
                  
	
    Do While Not sqlRs.EOF
        values(i) = sqlRs.fields("value").value
        sequence(i) = sqlRs.fields("sequence").value
        sqlRs.movenext()
        If sqlRs.eof = False Then
            i = i + 1
            ReDim Preserve values(i)
            ReDim Preserve sequence(i)
        End If
    Loop
   
        
    sbrHTML = New StringBuilder()

    sbrHTML.Append("<table><tr><td><TABLE Border=1>")
    sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Event Detail Report</center></Font></TD><TR>")
    sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>Site :</b> " & SiteName & "</TD></TR>")
    sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Printed Date :</b> " & DateTime.Now & "</TD><TR>")
    sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>DateTime</TH>")
    sbrHTML.Append("<TH style='background-color: #465AE8; color: #FFFFFF'>Index</TH>")
    sbrHTML.Append("<TH style='background-color: #465AE8; color: #FFFFFF'>Equipment</TH>")
    sbrHTML.Append("<TH style='background-color: #465AE8; color: #FFFFFF'>Value</TH>")
    sbrHTML.Append("<TH style='background-color: #465AE8; color: #FFFFFF'>Event</TH></TR>")

if i>0 then
 sqlRs.MoveFirst()
end if

    
     do while not sqlRs.EOF
       j = j +1
       sbrHTML.Append("<TR><TD align='left'>" & sqlRs(0).value & "</TD><TD>" & _
		      sqlRs(1).value & "</TD><TD>" & _
		      sqlRs(2).value & "</TD><TD>" & _
		      FormatNumber(sqlRs(3).value, 3) & "</TD><TD>" & _
		      sqlRs(4).value & "</TD></TR>")
       sqlRs.movenext()
     loop
     
     sqlRs.Close()
     
    'Dim uri As String = Request.UrlReferrer.AbsoluteUri
    'Dim strarry() As String = uri.Split("/"c)
    'Dim url As String = uri.Remove(uri.LastIndexOf("/"c), strarry(strarry.Length - 1).Length + 1)
    Dim url as String = ""
    
     sbrHTML.Append("</TABLE></td><td><table><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr/><tr><td>-</td></tr></table></td></tr><table>")
     'sbrHTML.Append("</TABLE></td><td><table><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr/><tr><td><img src='" + url + "/ChartImage.aspx?SiteID=" + SiteID + "&SiteName=" + SiteName + "&District=&EquipName=" + EquipName + "&BeginDateTime=" + BeginDateTime + "&EndDateTime=" + EndDateTime + "&EventType=" + Alert + "'></td></tr></table></td></tr><table>")
     sbrHTML.Append("<BR><B>Total Number of Records are :&nbsp; " & j.ToString() & "</B><br><br><br>")

     sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=2><Font Size=5><center>Event Summary Report</center></Font></TD><TR>")
    sbrHTML.Append("<TR><TD ColSpan=2 align='left'><b>Site :</b> " & SiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=2 align='left'> <b>Printed Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=2 align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Event</TH><TH style='background-color: #465AE8; color: #FFFFFF'># Alerts</TH></TR>")

if i>0 then
    sqlRs1.MoveFirst()
end if

     do while not sqlRs1.EOF
        sqlRs2.open("select count(event) as AlarmCount from telemetry_event_history_table " & _
                                   " where siteid ='" & SiteID & "' " & _
                                   " and sequence >= '" & BeginDateTime & "' and sequence <= '" & EndDateTime & "'" & _
                                   " and event ='" & sqlRs1(2).value & "'", objConn)
       do while not sqlRs2.EOF
         sbrHTML.Append("<TR><TD align='left'>" & sqlRs1(2).value & "</TD><TD>" & sqlRs2(0).value & "</TD></TR>")
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
    'Response.ContentType = "application/vnd.ms-excel"
    'Response.AddHeader("Content-Disposition", "attachment; filename=EventHistoryReport.xls;")
    Response.Write(sbrHTML.ToString)
        

%>

