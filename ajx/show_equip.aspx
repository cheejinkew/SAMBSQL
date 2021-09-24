<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB"%>
<%
   dim objConn 
   dim strConn 
   dim sqlRs
   dim SQLString
   dim SiteID = 9012   

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
    
   objConn.open(strConn)

   'SQLString = "select " & chr(34) & "desc" & chr(34) & ", equipname, equiptype, position from telemetry_equip_list_table where siteid='" & SiteID & "' order by position"
   SQLString = "select * from telemetry_equip_list_table where siteid='" & SiteID & "' order by position"
   'SQLString = "select * from telemetry_site_list_table where siteid='" & SiteID & "'"
   'SQLString = "select * from telemetry_equip_status_table where siteid='" & SiteID & "' order by position"
   sqlRs.Open(SQLString, objConn) 
   
dim x 

do until sqlRs.EOF
response.write("<table border=1>" + System.Environment.NewLine)
'=== header should be place here
for each x in sqlRs.Fields
response.write("<tr><td><font size=2>" &x.name & "</font></td>")
response.write("<td><font size=2>" &x.value & "</font></td></tr>")
next
sqlRs.MoveNext
response.write("</table>&nbsp;" + System.Environment.NewLine)
loop

   
   sqlRs.Close()
   objConn.close()
   sqlRs = nothing
   objConn = nothing
%>