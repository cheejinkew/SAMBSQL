<%
dim filename = request.querystring("wtf")
Response.Buffer=true
Response.ContentType="application/vnd.ms-excel"
Response.AddHeader("Content-Disposition", "attachment; filename=" & filename &";")
%>