<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>BPH Cascade Diagram</title>
<% 	dim SiteID = request.querystring("siteid")
	dim SiteName = request.QueryString("sitename")
	dim District = request.QueryString("district") %>
	
<meta http-equiv="refresh" content="60; URL=cascadeReservoir.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
-->
</style>
<div align="center">
    5<table border="0" cellpadding="0" cellspacing="0" width="70%">
    <tr>
      <td width="100%" height="50" colspan="4">
        <p align="center"><img border="0" src="images/CascadeOverview.jpg">
      </td>
    </tr>
  </table>
</div>
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
    rsrecords.Open("select dtimestamp, value, sevent from telemetry_equip_status_table where siteid='" & SiteID & "' order by position asc", objConn)
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
	rsrecords = nothing
	objconn = nothing
%>

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

<div id="Tanks" style="position:absolute; width:266px; height:27px; z-index:20; left: 231px; top: 327px;">
  <table width="267" border="1">
    <tr>
      <td width="118"><span class="style2"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Reservoir Level&position=2">Water Level</a> </span></td>
      <td width="133"><span class="style2"><%=readings(2)%> m</span></td>
    </tr>
  </table>
</div>
<table width="486" border="1">
  <tr>
    <td width="476"><div align="center"><a href="Summary.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&sitetype=RESERVOIR">Summary</a></div></td>
  </tr>
</table>
<div id="BPH" style="position:absolute; z-index:1; left: 13px; top: 215px;">

<img src="images/Reservoir75.JPG" width="740" height="511">

<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright � 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>
</div>
<p>&nbsp;</p>
<html>

</html>

