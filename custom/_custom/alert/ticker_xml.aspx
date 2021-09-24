<%
   dim objConn 
   dim strConn 
   dim sqlRs 
   dim strSiteName
   dim strEvent

   dim i

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
    
   objConn.open(strConn)


   sqlRs.Open("select * from telemetry_rule_list_table " & _
                "  order by siteid,position asc", objConn)


dim x

response.write("<font size=1 color=#c0c0c0 face=arial>")

for each x in sqlRs.Fields
response.write(x.name)
if NOT sqlRs.EOF then response.write(" | ")
next

response.write("<br>")

do until sqlRs.EOF
for each x in sqlRs.Fields
response.write(x.value)
if NOT sqlRs.EOF then response.write(" ; ")
next
response.write("<br>")
sqlRs.MoveNext
loop
response.write("</font>")

   sqlRs.Close()
   objConn.close()
   sqlRs = nothing
   objConn = nothing
%>