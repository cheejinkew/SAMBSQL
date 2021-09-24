<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
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
  dim intCount = 6
  dim j =0

  Dim strSelectedSite
  Dim strSiteList
   
   
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
     

    Dim strControlDistrict as String
    Dim i

    Dim arryControlDistrict = split(request.cookies("Telemetry")("ControlDistrict"), ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1)
                strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "', "
            Else
                strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
    End If


    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = new ADODB.Connection()
    sqlRs = new ADODB.Recordset()
    'sqlRs1 = new ADODB.Recordset()
    'sqlRs2 = new ADODB.Recordset()

    objConn.Open(strConn)

    If strSite = "All" Then
        strSiteList = "(sitedistrict in (" & strControlDistrict & ") and l.siteid not in ("& strKontID &"))"
        'strSiteList = "siteid not in ("& strKontID &")"
    Else
        strSiteList = "l.siteid ='" & strSelectedSite & "'"
    End If

    if strAlert="-1" then
       sqlRs.Open("select DISTINCT l.siteid, sitename, ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _  
                  "from telemetry_event_history_table l, telemetry_equip_list_table e, telemetry_site_list_table ss " & _ 
                  "where " & strSiteList  & " and l.siteid = e.siteid and l.siteid=ss.siteid " & _
                  "  and l.position = e.position " & _
                  "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                  "' and equipname not in ('DATE','TIME')", objConn)
                  '"where l.siteid ='" & strSelectedSite  & "' and l.siteid = e.siteid " & _
        'response.write("----")
       else
       sqlRs.Open("select DISTINCT l.siteid, sitename, ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _  
                  "from telemetry_event_history_table l, telemetry_equip_list_table e, telemetry_site_list_table ss " & _ 
                  "where " & strSiteList  & " and l.siteid = e.siteid and l.siteid=ss.siteid " & _
                  "  and l.position = e.position " & _ 
                  "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                  "' and event='"& strAlert & "'", objConn)
                  '"where l.siteid ='" & strSelectedSite  & "' and l.siteid = e.siteid " & _
        'response.write("select DISTINCT l.siteid, sitename, ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _  
                  '"from telemetry_event_history_table l, telemetry_equip_list_table e, telemetry_site_list_table ss " & _ 
                  '"where " & strSiteList  & " and l.siteid = e.siteid and l.siteid=ss.siteid " & _
                  '"  and l.position = e.position " & _ 
                  '"  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                  '"' and event='"& strAlert & "'")
       end If

       'response.end
       

'    if strAlert="-1" then
'       sqlRs.Open("select DISTINCT l.siteid, l.sequence, l.index, ""desc"" || ' : ' || equipname as mydesc, l.value, l.event " & _  
'                  "from telemetry_event_history_table l, telemetry_equip_list_table e, telemetry_site_list_table ss " & _ 
'                  "where " & strSiteList  & " and l.siteid = e.siteid and l.siteid=ss.siteid " & _
'                  "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
'                  "' and equipname not in ('DATE','TIME')", objConn)
'                  '"where l.siteid ='" & strSite  & "' and l.siteid = e.siteid " & _
'
'      sqlRs1.open ("Select alarmtype from telemetry_rule_list_table where siteid ='"& strSite & "' and alarmmode='EVENT'", objConn)
'      'sqlRs1.open ("Select alarmtype from telemetry_rule_list_table where siteid ='"& strSite & "' and alarmmode='EVENT'", objConn)
'   
'
'    else
'       sqlRs.Open("select DISTINCT l.siteid, l.sequence, l.index, ""desc"" || ' : ' || equipname as mydesc, l.value, l.event " & _  
'                  "from telemetry_event_history_table l, telemetry_equip_list_table e, telemetry_site_list_table ss " & _ 
'                  "where " & strSiteList  & " and l.siteid = e.siteid and l.siteid=ss.siteid " & _
'                  "  and l.position = e.position " & _ 
'                  "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
'                  "' and event='"& strAlert & "'", objConn)
'                  '"where l.siteid ='" & strSite  & "' and l.siteid = e.siteid and l.siteid=ss.siteid " & _
'
'      
'      sqlRs1.open ("Select '" & strAlert & "' as alarmtype", objConn)
'      'sqlRs1.open ("Select '" & strAlert & "' as alarmtype", objConn)
'    end if

    sbrHTML = new StringBuilder()

     sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Event Detail Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>SiteID</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>DateTime</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Index</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Equipment</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Value</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Event</TH></TR>")

     do while not sqlRs.EOF
       j = j +1
       sbrHTML.Append("<TR><TD align='left'>" & sqlRs("siteid").value & "</TD><TD>" & _
		      sqlRs("sequence").value & "</TD><TD>" & _
		      sqlRs("index").value & "</TD><TD>" & _
              sqlRs("desc").value & "</TD><TD>" & _
		      FormatNumber(sqlRs("value").value, 3) & "</TD><TD>" & _
		      sqlRs("event").value & "</TD></TR>")
              'response.write(sqlRs("index").value &"<br />")
       sqlRs.movenext()
     loop
     
     sqlRs.Close()
     
     sbrHTML.Append("</TABLE>")
     sbrHTML.Append("<BR><B>Total Number of Records are :&nbsp; " & j.ToString() & "</B><br><br><br>")

'     sbrHTML.Append("<TABLE Border=1>")
'     sbrHTML.Append("<TR><TD ColSpan=2><Font Size=5><center>Event Summary Report</center></Font></TD><TR>")
'     sbrHTML.Append("<TR><TD ColSpan=2 align='left'><b>Site :</b> " & strSiteName & "</TD><TR>")
'     sbrHTML.Append("<TR><TD ColSpan=2 align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
'     sbrHTML.Append("<TR><TD ColSpan=2 align='left'>&nbsp;</TD><TR>")
'     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Event</TH><TH style='background-color: #465AE8; color: #FFFFFF'># Alerts</TH></TR>")
'
'     do while not sqlRs1.EOF
'       sqlRs2.open("select count(event) as AlarmCount from telemetry_event_history_table " & _
'                                   " where siteid ='" & strSite  & "' " & _
'                                   " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
'                                   " and event ='" & sqlRs1(0).value  & "'", objConn)
'       do while not sqlRs2.EOF
'         sbrHTML.Append("<TR><TD align='left'>" & sqlRs1(0).value & "</TD><TD>" & sqlRs2(0).value & "</TD></TR>")
'         sqlRs2.movenext()
'       loop
'       sqlRs2.close()
'       
'       sqlRs1.movenext()
'     loop
'     sqlRs1.Close()
     objConn.Close() 
     objConn = nothing
'     
'     
'     sbrHTML.Append("</TABLE>")
   
     Response.Buffer =true
     Response.ContentType = "application/vnd.ms-excel"
     Response.AddHeader("Content-Disposition", "attachment; filename=EventHistoryReport.xls;")
    
     Response.Write(sbrHTML.ToString) 

%>

