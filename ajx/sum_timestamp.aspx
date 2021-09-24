<%
    Dim SiteID = Request.QueryString("siteid")
    Dim v = Request.QueryString("v")
dim timestamp
dim objConn 
dim strConn 
dim sqlRs 

strConn = ConfigurationSettings.AppSettings("DSNPG") 
objConn = new ADODB.Connection()
sqlRs = new ADODB.Recordset()
    
objConn.open(strConn)
    If v = "M6" Then
        sqlRs.Open("select dtimestamp from telemetry_equip_status_table_m6 where siteid='" & SiteID & "' order by position", objConn)
    Else
        sqlRs.Open("select dtimestamp from telemetry_equip_status_table where siteid='" & SiteID & "' order by position", objConn)
    End If
   

if sqlRs.EOF then
	response.write("N/A")
else
        timestamp = String.Format("{0:dd/M/yyyy}", sqlRs("dtimestamp").value) & "-" & FormatDateTime(sqlRs("dtimestamp").value, 3)
end if

response.write(timestamp)
sqlRs.Close()
objConn.close()
sqlRs = nothing
objConn = nothing
%>