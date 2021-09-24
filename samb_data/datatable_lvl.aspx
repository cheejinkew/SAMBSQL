<%@ Page Language="VB" Debug="true" %>
<%
if request.querystring("ekspot")="yes" then
%>
<!--#include file="save2excel.aspx"-->
<%
end if
%>
<!--#include file="report_head.aspx"-->
<%
dim objConn 
dim strConn 
dim sqlRs
dim siteName
dim level_read
dim RF_read
dim dailyRainfall
dim maya, counter, overall
'dim siteid = "C001"
dim siteid = request.querystring("siteid")
dim t_o_choice = request.querystring("t")

'dim start_date = "2005-12-29 0:00:00" 'request.querystring("s")
'dim end_date = "2005-12-29 23:59:59" 'request.querystring("e")

dim start_date = request.querystring("s")
dim end_date

dim i

strConn = ConfigurationSettings.AppSettings("DSNPG")
'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
objConn = new ADODB.Connection()
sqlRs = new ADODB.Recordset()

makeHTMLHeader_Open()
%>
<!--#include file="report_style.inc"-->
<%
makeHTMLHeader_Close()
response.write("<body><p />")

siteName = GetSiteName(strConn,siteid)
select case t_o_choice
	case 1 'DAILY
		overall = 23
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(overall))
		response.write("<center><h1>")
		response.write("DAILY LEVEL DATA FOR " & siteName)
		response.write("</h1>")
		response.write("</center>" & vbcrlf)

		counter = 0
		response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		response.write("Start Timestamp: " & Format_Full_Time(start_date,3) & "<br />")
		response.write("End Timestamp: " & Format_Full_Time(end_date,3))
		response.write("</td></tr>")
		response.write("<tr><th>Site No</th><th>Site Name</th><th>Time Stamp</th><th>Level (m)</th>")
		response.write("</tr>" & vbcrlf)

			for i = 0 to overall				
				level_read = Get_readings_per_hour(strConn,siteid,48,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not level_read = "-" then
					level_read = FormatNumber(level_read)
					counter = counter + 1
				end if
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(level_read)
				response.write("</td></tr>" & vbcrlf)
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		response.write("Data Percentage:")
		counter = counter - 1
		if counter < 0 then counter = 0
		response.write(math.round(counter/overall*100,2))
		response.write("%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		
		response.write("</td></tr>")
		response.write("</table>")
	case 2 'WEEKLY
		overall = 167
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(overall))
		response.write("<center><h1>")
		response.write("WEEKLY LEVEL DATA FOR " & siteName)
		response.write("</h1>")
		response.write("</center>" & vbcrlf)

		counter = 0
		response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		response.write("Start Timestamp: " & Format_Full_Time(start_date,3) & "<br />")
		response.write("End Timestamp: " & Format_Full_Time(end_date,3))
		response.write("</td></tr>")
		response.write("<tr><th>Site No</th><th>Site Name</th><th>Time Stamp</th><th>Level (m)</th>")
		response.write("</tr>" & vbcrlf)

			for i = 0 to overall
				level_read = Get_readings_per_hour(strConn,siteid,48,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not level_read = "-" then
					level_read = FormatNumber(level_read)
					counter = counter + 1
				end if
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(level_read)
				response.write("</td></tr>" & vbcrlf)
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		response.write("Data Percentage:")
		counter = counter - 1
		if counter < 0 then counter = 0
		response.write(math.round(counter/overall*100,2))
		response.write("%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")

		response.write("</td></tr>")
		response.write("</table>")
	case else 'MONTHLY
		overall = 719
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(overall))
		response.write("<center><h1>")
		response.write("MONTHLY LEVEL DATA FOR " & siteName)
		response.write("</h1>")
		response.write("</center>" & vbcrlf)

		counter = 0
		response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		response.write("Start Timestamp: " & Format_Full_Time(start_date,3) & "<br />")
		response.write("End Timestamp: " & Format_Full_Time(end_date,3))
		response.write("</td></tr>")
		response.write("<tr><th>Site No</th><th>Site Name</th><th>Time Stamp</th><th>Level (m)</th>")
		response.write("</tr>" & vbcrlf)

			for i = 0 to overall
				level_read = Get_readings_per_hour(strConn,siteid,48,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not level_read = "-" then
					level_read = FormatNumber(level_read)
					counter = counter + 1
				end if
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(level_read)
				response.write("</td></tr>" & vbcrlf)
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		response.write("Data Percentage:")
		counter = counter - 1
		if counter < 0 then counter = 0
		response.write(math.round(counter/overall*100,2))
		response.write("%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">")
		
		response.write("</td></tr>")
		response.write("</table>")
end select
%>
<!--#include file="report_foot.aspx"-->