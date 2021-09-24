<%@ Page Language="VB" Debug="true" %>
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

makeHTMLHeader()
response.write("<body><br />")

siteName = GetSiteName(strConn,siteid)
select case t_o_choice
	case 1 'DAILY	
		overall = 24
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(24))
		response.write("<center><h1>")
		response.write("DAILY RAINFALL DATA FOR " & siteName)
		response.write("</h1>")
		response.write("</center>" & vbcrlf)

		counter = 0
		response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Start Timestamp: " & Format_Full_Time(start_date,3) & "<br />")
		response.write("End Timestamp: " & Format_Full_Time(end_date,3))
		response.write("</td></tr>")
		response.write("<tr><th>Site No</th><th>Site Name</th><th>Time Stamp</th><th>Rainfall (mm)</th><th>Daily Rainfall(mm)</th><th>Hourly Rainfall (mm)</th><th>Total Rainfall (mm)</th>")
		response.write("</tr>" & vbcrlf)

			for i = 0 to 24				
				level_read = Get_readings_per_hour(strConn,siteid,2,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				RF_read = Get_readings_per_hour(strConn,siteid,2,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not RF_read = "-" then
					dailyRainfall = dailyRainfall + Convert.ChangeType(RF_read, GetType(double))
					maya = dailyRainfall
					counter = counter + 1
				else
					maya = "-"
				end if
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(maya)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(maya)
				response.write("</td></tr>" & vbcrlf)
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Data Percentage:" & math.round(counter/overall*100,2) & "%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Total Rainfall:" & maya & "mm")
		response.write("</td></tr>")
		response.write("</table>")
	case else 'WEEKLY
		overall = 168
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(168))
		response.write("<center><h1>")
		response.write(siteName & " WEEKLY DATA FOR " & Format_Full_Time(start_date,3) & " TO " & Format_Full_Time(end_date,3))
		response.write("</h1>")
		response.write("</center>" & vbcrlf)

		counter = 0
		response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Start Timestamp: " & Format_Full_Time(start_date,3) & "<br />")
		response.write("End Timestamp: " & Format_Full_Time(end_date,3))
		response.write("</td></tr>")
		response.write("<tr><th>Site No</th><th>Site Name</th><th>Time Stamp</th><th>Level (m)</th><th>Rainfall (mm)</th><th>Daily Rainfall(mm)</th><th>Hourly Rainfall (mm)</th><th>Total Rainfall (mm)</th>")
		response.write("</tr>" & vbcrlf)

			for i = 0 to 168
				level_read = Get_readings_per_hour(strConn,siteid,2,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				RF_read = Get_readings_per_hour(strConn,siteid,2,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not RF_read = "-" then
					dailyRainfall = dailyRainfall + Convert.ChangeType(RF_read, GetType(double))
					maya = dailyRainfall
					counter = counter + 1
				else
					maya = "-"
				end if
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(level_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(maya)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(maya)
				response.write("</td></tr>" & vbcrlf)
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Data Percentage:" & math.round(counter/overall*100,2) & "%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Total Rainfall:" & maya & "mm")
		response.write("</td></tr>")
		response.write("</table>")
end select
%>
<!--#include file="report_foot.aspx"-->