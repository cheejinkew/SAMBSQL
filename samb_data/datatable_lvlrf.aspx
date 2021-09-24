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
dim dailyRainfall, total_page_RF
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
response.write("<body><br />")

siteName = GetSiteName(strConn,siteid)
select case t_o_choice
	case 1 'DAILY	
		overall = 23
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(overall))
		response.write("<center><h1>")
		response.write("DAILY LEVEL AND RAINFALL DATA FOR " & siteName)
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

			for i = 0 to overall				
				level_read = Get_readings_per_hour(strConn,siteid,48,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not level_read = "-" then
					level_read = FormatNumber(level_read)
				end if
				RF_read = Get_RF_per_hour(strConn,siteid,49,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not RF_read = "-" then
					dailyRainfall = dailyRainfall + Convert.ChangeType(RF_read, GetType(double))
					maya = dailyRainfall
					counter = counter + 1
					maya = FormatNumber(maya,1)
					RF_read = FormatNumber(RF_read,1)
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
		response.write("Data Percentage:")
		counter = counter - 1
		if counter < 0 then counter = 0
		response.write(math.round(counter/overall*100,2))
		response.write("%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Total Rainfall:" & maya & "mm")
		response.write("</td></tr>")
		response.write("</table>")
	case 2 'WEEKLY
		overall = 167
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(overall))
		response.write("<center><h1>")
		response.write("WEEKLY LEVEL AND RAINFALL DATA FOR " & siteName)
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

			for i = 0 to overall
				level_read = Get_readings_per_hour(strConn,siteid,48,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not level_read = "-" then
					level_read = FormatNumber(level_read)
				end if
				RF_read = Get_readings_per_hour(strConn,siteid,49,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not RF_read = "-" then
					total_page_RF = total_page_RF + Convert.ChangeType(RF_read, GetType(double))
					dailyRainfall = dailyRainfall + Convert.ChangeType(RF_read, GetType(double))
					maya = total_page_RF
					counter = counter + 1
					maya = FormatNumber(maya,1)
					RF_read = FormatNumber(RF_read,1)
				else
					maya = "-"
				end if
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(level_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				if RF_read = "-" Then
					response.write("-")
				else
					response.write(FormatNumber(dailyRainfall,1))
				end if				
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(maya)
				response.write("</td></tr>" & vbcrlf)
				if not i = 0 and (i mod 24) = 0 then
					dailyRainfall = 0
				end if
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Data Percentage:")
		counter = counter - 1
		if counter < 0 then counter = 0
		response.write(math.round(counter/overall*100,2))
		response.write("%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Total Rainfall:" & FormatNumber(total_page_RF,1) & "mm")
		response.write("</td></tr>")
		response.write("</table>")
	case else 'MONTHLY
		overall = 719
		end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(overall))
		response.write("<center><h1>")
		response.write("MONTHLY LEVEL AND RAINFALL DATA FOR " & siteName)
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

			for i = 0 to overall
				level_read = Get_readings_per_hour(strConn,siteid,48,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not level_read = "-" then
					level_read = FormatNumber(level_read)
				end if
				RF_read = Get_readings_per_hour(strConn,siteid,49,String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)))
				if Not RF_read = "-" then					
					total_page_RF = total_page_RF + Convert.ChangeType(RF_read, GetType(double))
					dailyRainfall = dailyRainfall + Convert.ChangeType(RF_read, GetType(double))
					maya = total_page_RF
					counter = counter + 1
					maya = FormatNumber(maya,1)
					RF_read = FormatNumber(RF_read,1)					
				else
					maya = "-"
				end if				
				response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteid & "</td><td class=" & chr(34) & "tdc" & chr(34) & ">" & siteName & "</td>")
				response.write("<td class=" & chr(34) & "tdc" & chr(34) & ">" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(i)) & "</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(level_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				if RF_read = "-" Then
					response.write("-")
				else
					response.write(FormatNumber(dailyRainfall,1))
				end if	
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(RF_read)
				response.write("</td><td class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
				response.write(maya)
				response.write("</td></tr>" & vbcrlf)
				if not i = 0 and (i mod 24) = 0 then
					dailyRainfall = 0
				end if
			next i	
		response.write("<tr><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Data Percentage:")
		counter = counter - 1
		if counter < 0 then counter = 0
		response.write(math.round(counter/overall*100,2))
		response.write("%")
		response.write("</td><td class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & ">")
		response.write("Total Rainfall:" & FormatNumber(total_page_RF,1) & "mm")
		response.write("</td></tr>")
		response.write("</table>")
end select
%>
<!--#include file="report_foot.aspx"-->