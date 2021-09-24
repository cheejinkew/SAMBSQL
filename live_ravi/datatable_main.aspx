<%@ Page Language="VB" Debug="true" %>

<!--#include file="table_head.aspx"-->

<%
dim objConn 
dim strConn 
dim sqlRs
dim table = request.querystring("table")
dim district = request.querystring("dist")
dim start_date = request.querystring("start")
dim speriod = request.querystring("p")
dim uid = request.querystring("uid")
dim end_date
dim level_read, RF_read, cumRainfall, maya, tempoh
dim total_rainfall,counter

strConn = ConfigurationSettings.AppSettings("DSNPG")
'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
objConn = new ADODB.Connection()
sqlRs = new ADODB.Recordset()
makeHTMLHeader_Open()
%>
<!--#include file="table_style.inc"-->
<%
makeHTMLHeader_Close()
response.write("<body onload=" & chr(34) & "parent.startTimer();" & chr(34) & ">")
dim metar
if district = "All" Then
	metar = GetDistrict(strConn,uid,2).replace("|","'")
else
	metar = "'" & district & "'"
end if

select case table
	case 1 'DAILY	
		dim text,x,class_pg,class_ptg,class_mlm
		tempoh = 23
		'end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(start_date).AddHours(8))
		response.write("<br><center><h1>")
		response.write("INCOMING DATA TABLE (" & ucase(metar.replace("'","")) & ")")
		select case speriod
			case 1				
				class_pg = "tdc"
				class_ptg = "tdc"
				class_mlm = "tdc_incoming"
			case 2
				class_pg = "tdc_incoming"
				class_ptg = "tdc"
				class_mlm = "tdc"
			case 3
				class_pg = "tdc"
				class_ptg = "tdc_incoming"
				class_mlm = "tdc"
		end select
		response.write("</h1></center>" & vbcrlf)
		objConn.open(strConn)
		text ="select siteid from telemetry_site_list_table where sitedistrict in (" & metar & ") and sitetype='RESERVOIR' order by siteid"
        sqlRs.Open(text,objConn)
        response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & "align=" & chr(34) & "center" & chr(34) & ">")
		response.write("<tr><td class=" & chr(34) & "tdc" & chr(34) & " rowspan=" & chr(34) & "2" & chr(34) & ">Site No</td><td class=" & chr(34) & "tdc" & chr(34) & " rowspan=" & chr(34) & "2" & chr(34) & ">Site Name</td>")
		response.write("<td id=" & chr(34) & "pghead" & chr(34) & " class=" & chr(34) & class_pg & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">Time (At 8.00 AM)</td>")
		response.write("<td id=" & chr(34) & "ptghead" & chr(34) & " class=" & chr(34) & class_ptg & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">Time (At 4.00 PM)</td>")
		response.write("<td id=" & chr(34) & "mlmhead" & chr(34) & " class=" & chr(34) & class_mlm & chr(34) & " colspan=" & chr(34) & "2" & chr(34) & ">Time (At 12.00 AM)</td>")
		response.write("</tr><tr>")
		response.write("<td id=" & chr(34) & "pghead_value" & chr(34) & " class=" & chr(34) & class_pg & chr(34) & ">Read (m)</td><td id=" & chr(34) & "pghead_status" & chr(34) & " class=" & chr(34) & class_pg & chr(34) & ">Status</td>")
		response.write("<td id=" & chr(34) & "ptghead_value" & chr(34) & " class=" & chr(34) & class_ptg & chr(34) & ">Read (m)</td><td id=" & chr(34) & "ptghead_status" & chr(34) & " class=" & chr(34) & class_ptg & chr(34) & ">Status</td>")
		response.write("<td id=" & chr(34) & "mlmhead_value" & chr(34) & " class=" & chr(34) & class_mlm & chr(34) & ">Read (m)</td><td id=" & chr(34) & "mlmhead_status" & chr(34) & " class=" & chr(34) & class_mlm & chr(34) & ">Status</td>")
		response.write("</tr>" & vbcrlf)
            
 		do until sqlRs.EOF
			counter = counter + 1
			
			response.write("<tr><td id=" & chr(34) & "siteid" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & ">" & sqlRs("siteid").value & "</td><td id=" & chr(34) & "sitename" & counter & chr(34) & " title=" & chr(34) & sqlRs("siteid").value & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & ">" & GetSiteName(strConn,sqlRs("siteid").value) & "</td>")
			response.write("<td id=" & chr(34) & "pg_value" & counter & chr(34) & " class=" & chr(34) & class_pg & chr(34) & " align=" & chr(34) & "center" & chr(34) & "></td>")
			response.write("<td id=" & chr(34) & "pg_status" & counter & chr(34) & " class=" & chr(34) & class_pg & chr(34) & " align=" & chr(34) & "center" & chr(34) & "></td>")
			response.write("<td id=" & chr(34) & "ptg_value" & counter & chr(34) & " class=" & chr(34) & class_ptg & chr(34) & " align=" & chr(34) & "center" & chr(34) & "></td>")
			response.write("<td id=" & chr(34) & "ptg_status" & counter & chr(34) & " class=" & chr(34) & class_ptg & chr(34) & " align=" & chr(34) & "center" & chr(34) & "></td>")
			response.write("<td id=" & chr(34) & "mlm_value" & counter & chr(34) & " class=" & chr(34) & class_mlm & chr(34) & " align=" & chr(34) & "center" & chr(34) & "></td>")
			response.write("<td id=" & chr(34) & "mlm_status" & counter & chr(34) & " class=" & chr(34) & class_mlm & chr(34) & " align=" & chr(34) & "center" & chr(34) & "></td>")
			sqlRs.MoveNext
			response.write("</tr>" & vbcrlf)
		loop
		response.write("<tr><td id=" & chr(34) & "something" & chr(34) & " class=" & chr(34) & "tdo" & chr(34) & " colspan=" & chr(34) & "4" & chr(34) & "></td></tr>")
		response.write("</table>")
		response.write("<br />")
		sqlRs.Close()
		objConn.close()
		sqlRs = nothing
		objConn = nothing
		
	case 2 'WEEKLY

		response.write("Do Nothing!")

	case 3 'MONTHLY

		response.write("Do Nothing!")

end select
%>
<!--#include file="table_foot.aspx"-->