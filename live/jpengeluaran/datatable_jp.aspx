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

dim i

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
'response.write("<body>")
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

response.write("<span id=" & chr(34) & "test" & chr(34) & " class=" & chr(34) & "tdo" & chr(34) & "></span>")
		
if InStr(metar,"Melaka Tengah") then
%>
<h1 align="center">DISTRICT MELAKA TENGAH</h1>
<table id="MT" class="tbl_1" align="center"><tr><td class="tdc" rowspan="2">Site No</td><td class="tdc" rowspan="2">Site Name</td><td id="MT_pghead" class="<%=class_pg%>" colspan="2">Time (At 8.00 AM)</td><td id="MT_ptghead" class="<%=class_ptg%>" colspan="2">Time (At 4.00 PM)</td><td id="MT_mlmhead" class="<%=class_mlm%>" colspan="2">Time (At 12.00 AM)</td></tr><tr><td id="MT_pghead_value" class="<%=class_pg%>">Read (m)</td><td id="MT_pghead_status" class="<%=class_pg%>">Status</td><td id="MT_ptghead_value" class="<%=class_ptg%>">Read (m)</td><td id="MT_ptghead_status" class="<%=class_ptg%>">Status</td><td id="MT_mlmhead_value" class="<%=class_mlm%>">Read (m)</td><td id="MT_mlmhead_status" class="<%=class_mlm%>">Status</td></tr>
	<tr><td id="MT_siteid1" class="tdc">8536</td><td id="MT_sitename1" title="8536" class="tdc">BUKIT BERANGAN</td><td id="MT_pg_value1" class="<%=class_pg%>" align="center"></td><td id="MT_pg_status1" class="<%=class_pg%>" align="center"></td><td id="MT_ptg_value1" class="<%=class_ptg%>" align="center"></td><td id="MT_ptg_status1" class="<%=class_ptg%>" align="center"></td><td id="MT_mlm_value1" class="<%=class_mlm%>" align="center"></td><td id="MT_mlm_status1" class="<%=class_mlm%>" align="center"></td></tr>
	<tr><td id="MT_siteid2" class="tdc">8537</td><td id="MT_sitename2" title="8537" class="tdc">SENANDONG A</td><td id="MT_pg_value2" class="<%=class_pg%>" align="center"></td><td id="MT_pg_status2" class="<%=class_pg%>" align="center"></td><td id="MT_ptg_value2" class="<%=class_ptg%>" align="center"></td><td id="MT_ptg_status2" class="<%=class_ptg%>" align="center"></td><td id="MT_mlm_value2" class="<%=class_mlm%>" align="center"></td><td id="MT_mlm_status2" class="<%=class_mlm%>" align="center"></td></tr>
	<tr><td id="MT_siteid3" class="tdc">8539</td><td id="MT_sitename3" title="8539" class="tdc">BUKIT LESONG BATU</td><td id="MT_pg_value3" class="<%=class_pg%>" align="center"></td><td id="MT_pg_status3" class="<%=class_pg%>" align="center"></td><td id="MT_ptg_value3" class="<%=class_ptg%>" align="center"></td><td id="MT_ptg_status3" class="<%=class_ptg%>" align="center"></td><td id="MT_mlm_value3" class="<%=class_mlm%>" align="center"></td><td id="MT_mlm_status3" class="<%=class_mlm%>" align="center"></td></tr>
</table><br>
<%
end if
if InStr(metar,"Jasin") then
%>
<h1 align="center">DISTRICT JASIN</h1>
<table id="J" class="tbl_1" align="center"><tr><td class="tdc" rowspan="2">Site No</td><td class="tdc" rowspan="2">Site Name</td><td id="J_pghead" class="<%=class_pg%>" colspan="2">Time (At 8.00 AM)</td><td id="J_ptghead" class="<%=class_ptg%>" colspan="2">Time (At 4.00 PM)</td><td id="J_mlmhead" class="<%=class_mlm%>" colspan="2">Time (At 12.00 AM)</td></tr><tr><td id="J_pghead_value" class="<%=class_pg%>">Read (m)</td><td id="J_pghead_status" class="<%=class_pg%>">Status</td><td id="J_ptghead_value" class="<%=class_ptg%>">Read (m)</td><td id="J_ptghead_status" class="<%=class_ptg%>">Status</td><td id="J_mlmhead_value" class="<%=class_mlm%>">Read (m)</td><td id="J_mlmhead_status" class="<%=class_mlm%>">Status</td></tr>
<tr><td id="J_siteid1" class="tdc">8501</td><td id="J_sitename1" title="8501" class="tdc">BKT. SENANDONG</td><td id="J_pg_value1" class="<%=class_pg%>" align="center"></td><td id="J_pg_status1" class="<%=class_pg%>" align="center"></td><td id="J_ptg_value1" class="<%=class_ptg%>" align="center"></td><td id="J_ptg_status1" class="<%=class_ptg%>" align="center"></td><td id="J_mlm_value1" class="<%=class_mlm%>" align="center"></td><td id="J_mlm_status1" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="J_siteid2" class="tdc">8508</td><td id="J_sitename2" title="8508" class="tdc">KOLAM BKT BAHUDIN 1</td><td id="J_pg_value2" class="<%=class_pg%>" align="center"></td><td id="J_pg_status2" class="<%=class_pg%>" align="center"></td><td id="J_ptg_value2" class="<%=class_ptg%>" align="center"></td><td id="J_ptg_status2" class="<%=class_ptg%>" align="center"></td><td id="J_mlm_value2" class="<%=class_mlm%>" align="center"></td><td id="J_mlm_status2" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="J_siteid3" class="tdc">8509</td><td id="J_sitename3" title="8509" class="tdc">KOLAM BKT BAHUDIN 2</td><td id="J_pg_value3" class="<%=class_pg%>" align="center"></td><td id="J_pg_status3" class="<%=class_pg%>" align="center"></td><td id="J_ptg_value3" class="<%=class_ptg%>" align="center"></td><td id="J_ptg_status3" class="<%=class_ptg%>" align="center"></td><td id="J_mlm_value3" class="<%=class_mlm%>" align="center"></td><td id="J_mlm_status3" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="J_siteid4" class="tdc">8510</td><td id="J_sitename4" title="8510" class="tdc">KOLAM BKT PERAH</td><td id="J_pg_value4" class="<%=class_pg%>" align="center"></td><td id="J_pg_status4" class="<%=class_pg%>" align="center"></td><td id="J_ptg_value4" class="<%=class_ptg%>" align="center"></td><td id="J_ptg_status4" class="<%=class_ptg%>" align="center"></td><td id="J_mlm_value4" class="<%=class_mlm%>" align="center"></td><td id="J_mlm_status4" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="J_siteid5" class="tdc">8514</td><td id="J_sitename5" title="8514" class="tdc">ASAHAN</td><td id="J_pg_value5" class="<%=class_pg%>" align="center"></td><td id="J_pg_status5" class="<%=class_pg%>" align="center"></td><td id="J_ptg_value5" class="<%=class_ptg%>" align="center"></td><td id="J_ptg_status5" class="<%=class_ptg%>" align="center"></td><td id="J_mlm_value5" class="<%=class_mlm%>" align="center"></td><td id="J_mlm_status5" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="J_siteid6" class="tdc">8523</td><td id="J_sitename6" title="8523" class="tdc">KESANG PAJAK</td><td id="J_pg_value6" class="<%=class_pg%>" align="center"></td><td id="J_pg_status6" class="<%=class_pg%>" align="center"></td><td id="J_ptg_value6" class="<%=class_ptg%>" align="center"></td><td id="J_ptg_status6" class="<%=class_ptg%>" align="center"></td><td id="J_mlm_value6" class="<%=class_mlm%>" align="center"></td><td id="J_mlm_status6" class="<%=class_mlm%>" align="center"></td></tr>
</table><br />
<%
end if
if InStr(metar,"Alor Gajah") then
%>
<h1 align="center">DISTRICT ALOR GAJAH</h1>
<table id="AG" class="tbl_1" align="center"><tr><td class="tdc" rowspan="2">Site No</td><td class="tdc" rowspan="2">Site Name</td><td id="AG_pghead" class="<%=class_pg%>" colspan="2">Time (At 8.00 AM)</td><td id="AG_ptghead" class="<%=class_ptg%>" colspan="2">Time (At 4.00 PM)</td><td id="AG_mlmhead" class="<%=class_mlm%>" colspan="2">Time (At 12.00 AM)</td></tr><tr><td id="AG_pghead_value" class="<%=class_pg%>">Read (m)</td><td id="AG_pghead_status" class="<%=class_pg%>">Status</td><td id="AG_ptghead_value" class="<%=class_ptg%>">Read (m)</td><td id="AG_ptghead_status" class="<%=class_ptg%>">Status</td><td id="AG_mlmhead_value" class="<%=class_mlm%>">Read (m)</td><td id="AG_mlmhead_status" class="<%=class_mlm%>">Status</td></tr>
<tr><td id="AG_siteid1" class="tdc">8526</td><td id="AG_sitename1" title="8526" class="tdc">KOLAM BUKIT TIGA 1</td><td id="AG_pg_value1" class="<%=class_pg%>" align="center"></td><td id="AG_pg_status1" class="<%=class_pg%>" align="center"></td><td id="AG_ptg_value1" class="<%=class_ptg%>" align="center"></td><td id="AG_ptg_status1" class="<%=class_ptg%>" align="center"></td><td id="AG_mlm_value1" class="<%=class_mlm%>" align="center"></td><td id="AG_mlm_status1" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="AG_siteid2" class="tdc">8527</td><td id="AG_sitename2" title="8527" class="tdc">BUKIT SENANDUNG 2</td><td id="AG_pg_value2" class="<%=class_pg%>" align="center"></td><td id="AG_pg_status2" class="<%=class_pg%>" align="center"></td><td id="AG_ptg_value2" class="<%=class_ptg%>" align="center"></td><td id="AG_ptg_status2" class="<%=class_ptg%>" align="center"></td><td id="AG_mlm_value2" class="<%=class_mlm%>" align="center"></td><td id="AG_mlm_status2" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="AG_siteid3" class="tdc">8528</td><td id="AG_sitename3" title="8528" class="tdc">BUKIT SENANDUNG 1</td><td id="AG_pg_value3" class="<%=class_pg%>" align="center"></td><td id="AG_pg_status3" class="<%=class_pg%>" align="center"></td><td id="AG_ptg_value3" class="<%=class_ptg%>" align="center"></td><td id="AG_ptg_status3" class="<%=class_ptg%>" align="center"></td><td id="AG_mlm_value3" class="<%=class_mlm%>" align="center"></td><td id="AG_mlm_status3" class="<%=class_mlm%>" align="center"></td></tr>
<tr><td id="AG_siteid4" class="tdc">8560</td><td id="AG_sitename4" title="8560" class="tdc">TJ BIDARA</td><td id="AG_pg_value4" class="<%=class_pg%>" align="center"></td><td id="AG_pg_status4" class="<%=class_pg%>" align="center"></td><td id="AG_ptg_value4" class="<%=class_ptg%>" align="center"></td><td id="AG_ptg_status4" class="<%=class_ptg%>" align="center"></td><td id="AG_mlm_value4" class="<%=class_mlm%>" align="center"></td><td id="AG_mlm_status4" class="<%=class_mlm%>" align="center"></td></tr>
</table>
<%
end if

	case 2 'WEEKLY

		response.write("Do Nothing!")

	case 3 'MONTHLY

		response.write("Do Nothing!")

end select
%>
<!--#include file="table_foot.aspx"-->