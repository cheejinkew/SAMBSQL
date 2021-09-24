<%
'dim masa = String.Format("{0:yyyy/MM/dd}", + " 07:45:00")
dim masa = DatePart("yyyy", System.DateTime.Today) & "/" & DatePart("MM", System.DateTime.Today) & "/" & DatePart("dd", System.DateTime.Today)
response.write(masa)
%>