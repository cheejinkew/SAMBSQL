<%@ Page Language="VB" %>

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

        strSite = Request.QueryString("siteid") 
    
     
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New OdbcConnection(strConn)
        If strSite = "ALL" Then
            objComm = New OdbcCommand("select d.sitedistrict ,c.siteid,d.sitename , c.sdesc+':'+b.alarmtype  srule,a.sname ,a.post ,a.simno ,a.priority  from telemetry_dispatch_list_table a inner join telemetry_rule_list_table b on a.ruleid=b.ruleid inner join telemetry_equip_list_table c inner join telemetry_site_list_table d on c.siteid =d.siteid   on b.siteid =c.siteid and b.position =c.position where d.sitedistrict<>'Testing' order by d.sitedistrict, c.siteid", objConn)
        Else
            objComm = New OdbcCommand("select d.sitedistrict , c.siteid,d.sitename , c.sdesc+':'+b.alarmtype  srule,a.sname ,a.post ,a.simno ,a.priority  from telemetry_dispatch_list_table a inner join telemetry_rule_list_table b on a.ruleid=b.ruleid inner join telemetry_equip_list_table c inner join telemetry_site_list_table d on c.siteid =d.siteid   on b.siteid =c.siteid and b.position =c.position  where c.siteid ='" & strSite & "'", objConn)
        End If
   

    sbrHTML = new StringBuilder()
                      
        
    objConn.Open()
    sqlRs = objComm.ExecuteReader()

     sbrHTML.Append("<TABLE Border=1 width=400>")
        sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Dispatch List Report</center></Font></TD><TR>") 
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & DateTime.Now & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
        sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Site District</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Site ID</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Site Name</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Rule</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'> Name</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Post</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Sim No</TH>")
        sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>Priority</TH></TR>")

       do while sqlRs.Read()
         j = j +1 
            sbrHTML.Append("<TR><TD align='left'>" & sqlRs.GetValue(0).ToString() & "</TD><TD align='left'>" & _
                 sqlRs.GetValue(1).ToString() & "</TD><TD>" & _
            sqlRs.GetValue(2).ToString() & "</TD><TD>" & _
          sqlRs.GetValue(3).ToString() & "</TD><TD>" & sqlRs.GetValue(4).ToString() & "</TD><TD>" & sqlRs.GetValue(5).ToString() & "</TD><TD>" & sqlRs.GetValue(6).ToString() & "</TD><TD>" & sqlRs.GetValue(7).ToString() & "</TD></TR>")
       loop
     
     sbrHTML.Append("</TABLE>")
     sbrHTML.Append("<BR><BR><B>Total Number of Records are " & j.ToString() & "</B>")
    
     Response.Buffer =true
     Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=DispatchListReport.xls;")
    
     Response.Write(sbrHTML.ToString) 

  End Sub 
</script>

