<%@ Page Language="VB" Debug="true" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<!--#include file="kont_id.aspx"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<% 	dim SiteID = request.querystring("siteid")
	dim SiteName = request.QueryString("sitename")
	dim District = request.QueryString("district") %>
	
<meta http-equiv="refresh" content="60; URL=cascade.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.style3 {
	font-size: 36px;
	font-weight: bold;
}
-->
</style></head>
<%
	dim strConn
	dim objConn
	dim rsrecords
	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
   	objConn.open(strConn)
	dim i as integer
	dim events(1) as string
	dim sequence as string
	dim readings(1) as string
	rsRecords.Open("select dtimestamp, value, sevent from telemetry_equip_status_table where siteid='" & SiteID & "' order by position asc",objConn)
   	if rsrecords.eof = false then
		i = 1
		events(0) = "Time"
		events(1) = "Date"
		readings(0) = "Time"
		readings(1) = "Date"
		do while not rsRecords.EOF
			i = i + 1
			redim preserve events(i)
			redim preserve readings(i)
            events(i) = rsrecords.fields("sevent").value
			sequence = rsrecords.fields("dtimestamp").value 
			readings(i) = rsrecords.fields("value").value
			if readings(i) < 0 then readings(i) = 0
			rsrecords.movenext
		loop
	else
		response.Write("Data Not Available")
		exit sub
	end if
	rsrecords.close
	
	dim PH as string
	dim PHPos as integer
	dim CH as string
	dim CHPos as integer
	dim Treated1 as string
	dim Treated1Pos as integer
	dim Treated2 as string
	dim Treated2Pos as integer
	dim Pressure1 as string
	dim Pressure1Pos as integer
	dim Pressure2 as string
	dim Pressure2Pos as integer
	dim RawFlow as string
	dim RawFlowPos as integer
	dim BWashFlow as string
	dim BWashFlowPos as integer
	dim Storage1 as string
	dim Storage1Pos as integer
	dim Storage2 as string
	dim Storage2Pos as integer
	dim Suction1 as string
	dim Suction1Pos as integer
	dim Suction2 as string
	dim Suction2Pos as integer
	dim Turbidity as string
	dim TurbidityPos as integer
	dim sqlstr as string
	sqlstr = "select siteid, sitename, sitedistrict, associate from telemetry_site_list_table where associate='" & SiteID & "' and siteid NOT IN ("& strKontID &")"
	i = 2
	
    
    rsrecords.Open("select * from telemetry_equip_list_table where siteid='" & SiteID & "' order by position asc", objConn)
   	do while not rsRecords.EOF
        Select Case rsrecords.fields("sdesc").value
            Case "TREATED FLOW METER 1"
                Treated1 = readings(i)
                Treated1Pos = i
                i = i + 1
            Case "TREATED FLOW METER 2"
                Treated2 = readings(i)
                Treated2Pos = i
                i = i + 1
            Case "PRESSURE SENSOR 1"
                Pressure1 = readings(i)
                Pressure1Pos = i
                i = i + 1
            Case "PRESSURE SENSOR 2"
                Pressure2 = readings(i)
                Pressure2Pos = i
                i = i + 1
            Case "LEVEL SENSOR 1 (SUCTION)"
                Suction1 = readings(i)
                Suction1Pos = i
                i = i + 1
            Case "LEVEL SENSOR 2 (SUCTION)"
                Suction2 = readings(i)
                Suction2Pos = i
                i = i + 1
            Case "LEVEL SENSOR 1 (STORAGE)"
                Storage1 = readings(i)
                Storage1Pos = i
                i = i + 1
            Case "LEVEL SENSOR 2 (STORAGE)"
                Storage2 = readings(i)
                Storage2Pos = i
                i = i + 1
            Case "RAW FLOW METER"
                RawFlow = readings(i)
                RawFlowPos = i
                i = i + 1
            Case "B/WASH FLOW METER"
                BWashFlow = readings(i)
                BWashFlowPos = i
                i = i + 1
            Case "PH ANALYZER"
                PH = readings(i)
                PHPos = i
                i = i + 1
            Case "CHLORINE ANALYZER"
                CH = readings(i)
                CHPos = i
                i = i + 1
            Case "TURBIDITY"
                Turbidity = readings(i)
                TurbidityPos = i
                i = i + 1
            Case "RESERVOIR"
                sqlstr = "select siteid, sitename, sitedistrict, associate from telemetry_site_list_table where siteid='" & SiteID & "' and siteid NOT IN (" & strKontID & ")"
        End Select
		rsRecords.MoveNext
	loop

	rsrecords.close

	i = 0
	dim arrsiteid(0) as string
	dim arrsitename(0) as string
	dim arrdistrict(0) as string
	dim associate(0) as string
	rsRecords.Open(sqlstr,objConn)
   	do while not rsRecords.EOF
		arrsiteid(i) = rsrecords.fields("siteid").value
		arrsitename(i) = rsrecords.fields("sitename").value
		arrdistrict(i) = rsrecords.fields("sitedistrict").value
		associate(i) = rsrecords.fields("associate").value
		i = i + 1
		redim preserve arrsiteid(i)
		redim preserve arrsitename(i)
		redim preserve arrdistrict(i)
		redim preserve associate(i)
		rsrecords.movenext
	loop	
	rsrecords.close
%>



<body>
<p>
</p>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="70%">
    <tr>
      <td width="100%" height="50" colspan="4">
        <p align="center"><img border="0" src="images/CascadeOverview.jpg">
      </td>
    </tr>
  </table>
</div>
<div id="RawIntake" style="position:absolute; width:200px; height:115px; z-index:1; left: 15px; top: 238px; font-weight: bold;"><img src="images/RawWater.jpg" width="282" height="186"></div>
<div id="Purify" style="position:absolute; width:200px; height:115px; z-index:2; left: 396px; top: 232px; font-weight: bold;"><img src="images/WTP.jpg" width="387" height="176"></div>
<div id="Output" style="position:absolute; width:255px; height:152px; z-index:3; left: 356px; top: 481px; font-weight: bold;"><img src="images/KolamAir.jpg" width="260" height="159"></div>
<div id="Household" style="position:absolute; width:200px; height:115px; z-index:4; left: 63px; top: 1011px; font-weight: bold;"><img src="images/Reservoir.jpg" width="410" height="221"></div>
<div id="Storage" style="position:absolute; width:200px; height:115px; z-index:5; left: 492px; top: 768px; font-weight: bold;"><img src="images/Balancing.jpg" width="287" height="160"></div>
<div id="Suction" style="position:absolute; width:200px; height:115px; z-index:6; left: 62px; top: 770px; font-weight: bold;"><img src="images/Balancing.jpg" width="287" height="160"></div>

<strong>
<% if RawFlow <> "" then %>
</strong>
<div id="RawFlow" style="position:absolute; width:118px; height:19px; z-index:7; left: 147px; top: 288px; font-size: 10px; font-weight: bold;">
  <table width="136" border="1">
    <tr>
      <td width="53"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Raw Flowmeter&position=<%=RawflowPos%>">Raw Flow</a></td>
      <td width="67"><%=RawFlow%> m3/h</td>
    </tr>
  </table>
</div>
<strong>
<% end if %>

<% if BWashFlow <> "" then %>
</strong>
<div id="BWashFlow" style="position:absolute; width:136px; height:19px; z-index:8; left: 552px; top: 249px; font-size: 10px; font-weight: bold;">
  <table width="136" border="1">
    <tr>
      <td width="55"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Backwash Flowmeter&position=<%=BWashflowPos%>">B/W Flow </a></td>
      <td width="65"><%=BWashflow%> m3/h</td>
    </tr>
  </table>
</div>
<strong>
<% end if %>

<% if Treated1 <> "" then %>
</strong>
<div id="TreatedFlow1" style="position:absolute; width:151px; height:19px; z-index:9; left: 196px; top: 505px; font-size: 10px; font-weight: bold;">
  <table width="153" border="1">
    <tr>
      <td width="76"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Treated Flowmeter 1&position=<%=Treated1Pos%>">Treated Flow 1</a></div></td>
      <td width="61"><%=Treated1%> m3/h</td>
    </tr>
  </table>
</div>
<strong>
<% end if %>

<% if Treated2 <> "" then %>
</strong>
<div id="TreatedFlow2" style="position:absolute; width:133px; height:19px; z-index:10; left: 196px; top: 537px; font-size: 10px; font-weight: bold;">
  <table width="153" border="1">
    <tr>
      <td width="76"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Treated Flowmeter 2&position=<%=Treated2Pos%>">Treated Flow 2</a></div></td>
      <td width="61"><%=Treated2%> m3/h</td>
    </tr>
  </table>
</div>
<strong>
<% end if %>

<% if Pressure1 <> "" then %>
</strong>
<div id="Pressure1" style="position:absolute; width:117px; height:19px; z-index:12; left: 196px; top: 578px; font-size: 10px; font-weight: bold;">
  <div align="left">
  <table width="153" border="1">
    <tr>
      <td width="68"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Pressure Meter 1&position=<%=Pressure1Pos%>">Pressure 1</a></div></td>
      <td width="69"><%=Pressure1%> bar</td>
    </tr>
  </table>
</div></div>
<strong>
<% end if %>

<% if Pressure2 <> "" then %>
</strong>
<div id="Pressure2" style="position:absolute; width:116px; height:19px; z-index:13; left: 196px; top: 610px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="68"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Pressure Meter 2&position=<%=Pressure2Pos%>">Pressure 2 </a></div></td>
        <td width="69"><%=Pressure2%> bar</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>

<% if CH <> "" then %>
</strong>
<div id="CH" style="position:absolute; width:116px; height:19px; z-index:13; left: 622px; top: 498px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="68"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Chlorine Analyzer&position=<%=CHPos%>">Chlorine</a></div></td>
        <td width="69"><%=Ch%> mg/l</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>

<% if ph <> "" %>
</strong>
<div id="PH" style="position:absolute; width:116px; height:19px; z-index:13; left: 623px; top: 586px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="68"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=pH Analyzer&position=<%=PHPos%>">PH Level</a></div></td>
        <td width="69"><%=ph%> pH</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>
<% if Turbidity <> "" then %>
</strong>
<div id="Turbidity" style="position:absolute; width:116px; height:19px; z-index:13; left: 624px; top: 542px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="68"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Turbidity&position=<%=TurbidityPos%>">Turbidity</a></div></td>
        <td width="69"><%=Turbidity%> NTU</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>
<% if Suction1 <> "" then %>
</strong>
<div id="Suction1" style="position:absolute; width:116px; height:19px; z-index:13; left: 62px; top: 719px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="76"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Suction Tank 1&position=<%=Suction1Pos%>">Suction Tank 1 </a></div></td>
        <td width="61"><%=Suction1%> m</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>
<% if Suction2 <> "" then %>
</strong>
<div id="Suction2" style="position:absolute; width:116px; height:19px; z-index:13; left: 62px; top: 746px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="76"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Suction Tank 2&position=<%=Suction2Pos%>">Suction Tank 2</a> </div></td>
        <td width="61"><%=Suction2%> m</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>
<% if Storage1 <> "" then %>
</strong>
<div id="Storage1" style="position:absolute; width:116px; height:19px; z-index:13; left: 491px; top: 717px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="76"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Storage Tank 1&position=<%=Storage1Pos%>">Storage Tank 1</a> </div></td>
        <td width="61"><%=Storage1%> m</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>
<% if Storage2 <> "" %>
</strong>
<div id="Storage2" style="position:absolute; width:116px; height:19px; z-index:13; left: 492px; top: 743px; font-size: 10px; font-weight: bold;">
  <div align="left">
    <table width="153" border="1">
      <tr>
        <td width="76"><div align="right"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Storage Tank 2&position=<%=Storage2Pos%>">Storage Tank 2</a> </div></td>
        <td width="61"><%=Storage2%> m</td>
      </tr>
    </table>
  </div>
</div>
<strong>
<% end if %>

</strong>
<div id="Stage1" style="position:absolute; width:45px; height:34px; z-index:16; left: 319px; top: 313px; font-weight: bold;"><img src="images/rightarrow.gif" width="42" height="34"></div>
<div id="Stage2" style="position:absolute; width:36px; height:47px; z-index:17; left: 475px; top: 415px; font-weight: bold;"><img src="images/downarrow.gif" width="34" height="42"></div>
<div id="Stage3" style="position:absolute; width:36px; height:47px; z-index:18; left: 402px; top: 656px; font-weight: bold;"><img src="images/downarrow.gif" width="34" height="42"></div>
<div id="Stage4" style="position:absolute; width:36px; height:47px; z-index:19; left: 410px; top: 942px; font-weight: bold;"><img src="images/downarrow.gif" width="34" height="42"></div>

<table width="486" border="1">
  <tr>
    <td width="161"><div align="right">District :</div></td>
    <td width="309"><%=district%></td>
  </tr>
  <tr>
    <td><div align="right">Site ID :</div></td>
    <td><%=siteid%></td>
  </tr>
  <tr>
    <td><div align="right">Site Name : </div></td>
    <td><%=sitename%></td>
  </tr>
  <tr>
    <td><div align="right">Timestamp : </div></td>
    <td><%=sequence%></td>
  </tr>
</table>

<div id="Tanks" style="position:absolute; width:339px; height:58px; z-index:20; left: 444px; top: 1055px;">
<table width="337" border="1">

<%	
	for i = 0 to ubound(associate)
		rsRecords.Open("select value from telemetry_equip_status_table where siteid='" & arrsiteid(i) & "' order by position asc",objConn)
		if rsrecords.eof = false then %>
	  	<tr>
      <td width="91"><img src="images/Tank.JPG" width="91" height="49"></td>
      <td width="110"><span class="style2"><a href="Summary.aspx?siteid=<%=arrsiteid(i)%>&sitename=<%=arrsitename(i)%>&district=<%=arrdistrict(i)%>"><%=arrsitename(i)%></a></span></td>
	  <td width="110"><span class="style2"><a href="Trending.aspx?siteid=<%=arrsiteid(i)%>&sitename=<%=arrsitename(i)%>&district=<%=arrdistrict(i)%>&equipname=Reservoir Level&position=0">Water Level</a> </span></td>
      <td width="114"><span class="style2"><%=rsrecords.fields("value").value%> m</span></td>
		</tr>

<%		
		end if
		rsrecords.close
	next i 
%>
</table>
</div>
<table width="486" border="1">
  <tr>
    <td width="476"><div align="center"><a href="Summary.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>">Summary</a></div></td>
  </tr>
</table>

	
<%	
	rsrecords = nothing
	objConn.close
	objConn = Nothing
%>

<br>

</body>

</html>
