<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<html>
<head>

<!--#include file="table_style.inc"-->
<%
	dim uid=70
%>
</head>
<body onresize="resizing_trends('trends');" scroll="no">
<script type="text/javascript" src="table.js"></script>
<script type="text/javascript" src="url.js"></script>
<div id="header"></div>

	<div id="xloading">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><img style="position:absolute;top:5px;left:5px;" border="0" src="../images/loading.gif"><span id="loading_text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Retrieving data...</span></div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>	
	<div id="xlogo">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><img border="0" src="../images/logo_small.jpg"></div>	
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>
	<div id="live_logo"><img border="0" src="live.png"></div>
	<div id="beta_logo" onclick="alert(change2bit(flag1) + ' ' + change2bit(flag2) + ' ' + change2bit(flag3));">BETA</div>

<form name="formX" action="TrendDetails.aspx" method="POST">

<div style="position:absolute;top:1px;left:2px;"></div>

<div class="report_select" id="report_select">
    <div class="title" id="report_title">Reservoirs Incoming Log Data Table for</div>
    <div class="left_arrow" onclick="rotate_report(-1);"><img src="../images/leftwhite.gif"></div>
    <div class="box" id="report_type">Status</div>
    <div class="right_arrow" onclick="rotate_report(1);"><img src="../images/rightwhite.gif"></div>
</div>

<div class="district_select" id="district_select">
	<div class="title">District</div>
    <div class="left_arrow" onclick="rotate_district(-1);submission();"><img src="../images/leftwhite.gif"></div>
    <div class="box" id="district">Select District</div>
    <div class="right_arrow" onclick="rotate_district(1);submission();"><img src="../images/rightwhite.gif"></div>
</div>

<div class="date_select">	
	<div class="box1" id="SelectDate"></div>
	<div class="box2" id="ShowedDate" onclick="fetch_datatable();"></div>    
</div>

<div class="submission_box" onclick="submission();" style="visibility:hidden"><img src="../images/Submit_s.jpg" border=0></div>
<div class="print_box" onclick="print_the_frame();"><img src="../images/print.jpg" border=0></div>
</form>
<div id="trends"></div><IFRAME id="_excel" name="_excel" style="width:100px;height:100px;position:absolute;top:0;left:0;display:none;" frameborder=0 scrolling=yes marginwidth=0 src="about:blank" marginheight=0></iframe>
<div id="footnote" style="position:absolute;top:90px;right:5px;">*daily, weekly & monthly selection based on hourly logged data.<br /> Daily data logged between 0:00 to 23:59.</div>
<div id="tempo" style="position:absolute;top:1px;right:1px;visibility:hidden">ssssssssssss</div>

</body>
</html>
<script language="javascript">
var xmlHttpfeed_1;
var running = false;
var requesting = false;
var the_fetch;
var time,value,status;
var uid=<%=uid%>;

resizing_trends('trends');
window.onload = load_firstDate;

</script>