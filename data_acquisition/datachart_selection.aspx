<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<html>
<head>

<link rel="StyleSheet" type="text/css" href="report.css" title="Contemporary" />

</head>
<body onresize="resizing_trends('trends');" scroll="no">
<script type="text/javascript" src="Kalendar.js"></script>
<script type="text/javascript" src="report.js"></script>
<div id="header"></div>
<form name="formX" action="TrendDetails.aspx" method="POST">
<script lanaguage="javascript">DrawCalendarLayout();</script>

<div style="position:absolute;top:8px;left:5px;"><img border="0" src="../images/report.jpg"></div>

<div class="report_select" id="report_select">
    <div class="title">Report:</div>
    <div class="left_arrow" onclick="rotate_report(-1);"><img src="imej/leftwhite.gif"></div>
    <div class="box" id="report_type">Daily</div>
    <div class="right_arrow" onclick="rotate_report(1);"><img src="imej/rightwhite.gif"></div>
</div>

<div class="date_select">
	<div class="title"><font face="Verdana" size="1" color="#5F7AFC"><b>Select a Date:</b></font></div>      
	<div class="box" id="SelectDate"></div>
    <div class="cal" onclick="ShowCalendar('SelectDate', 100, 50);"><img border="1" src="../images/Calendar.jpg" width="19" height="14"></div>
</div>

<div class="submission_box" onclick="submission();"><img src="../images/Submit_s.jpg" border=0></div>
</form>
<div id="trends"></div>
<div id="footnote" style="position:absolute;top:9px;right:5px;">*daily, weekly & monthly selection based on hourly logged data.<br /> Daily data logged between 0:00 to 23:59.</div>
</body>
</html>
<script language="javascript">

resizing_trends('trends');

</script>