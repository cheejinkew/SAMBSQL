<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%
	dim page_title = "MRCB Merlimau"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=page_title%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet href="_objects.css" title="Contemporary">
</head><body bgcolor="#ffffff">
<div id="BPH" style="position:absolute;z-index:1;left:2px;top:1px">
	<img src="img/MRCB.gif">
	<div onclick="window.location='_jkolam_3.aspx';" class="pointer" style="position:absolute;top:383px;left:4px;z-index:2"><img src="../images/left.jpg"></div>
	<div id="header"><%=page_title%></div>
	<div id="footer" style="z-index:1;text-align:right">
	<font color="#5373a2" face="Verdana" size="1">Copyright © 2006 Gussmann Technologies Sdn Bhd. All rights reserved.</font>
	</div>
<!-- level -->
<div id="water_level1" style="position:absolute;z-index:2;top:92px;left:63px;width:309px;height:60px;background:transparent">
	<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="309" height="10"></div>
</div>
<div id="water_level2" style="position:absolute;z-index:3;top:282px;left:520px;width:309px;height:60px;background:transparent">
	<div id="show_level2color" class="waterlevel"><img id="show_level2" src="../images/blank.gif" width="309" height="10"></div>
</div>
<!-- indicator -->
<div id="rtu_stat1" style="position:absolute;z-index:3;top:40px;left:13px" class="rtu_island">
	<div id="rtu_stat1_title" style="position:absolute;top:0px;left:3px" class="labelhead">RTU#</div>
</div>
<div style="position:absolute;z-index:3;top:90px;left:400px;cursor:pointer">
	<div id="Flow" style="position:absolute;top:0px" class="indicator">???</div>
	<div id="Total" style="position:absolute;top:17px" class="indicator">???</div>
</div>
<!-- indicator -->
</div>
</body>
<script language="JavaScript" src="pump_control.js"></script>
<script>
// this site have 2 RTUs
// AMBS BPH 9012, AMBS 9003
var xmlHttpfeed_1;
var xmlHttpfeed_2;
var HTTP_commission;

function pump_controller(choice,combination)
{
	HTTP_commission=GetXmlHttpObject(pump_commission_status);	
	HTTP_commission.open('POST','pump_control.aspx?siteid=9012&c=' + choice + '&h=' + combination,false);
	HTTP_commission.setRequestHeader('Content-Type','application/x-www-form-urlencoded');	
	HTTP_commission.send(null);
}
function pump_commission_status()
{
  if (HTTP_commission.readyState==4 || HTTP_commission.readyState=="complete")
  { 
    alert(HTTP_commission.responseText);    
  } 
}
function show_indicator()
{ 
var url="../ajx/realtimefeed.aspx?siteid=9012&c=feed&sid=" + Math.random()
xmlHttpfeed_1=GetXmlHttpObject(ChangingBPH)
xmlHttpfeed_1.open("GET", url , true)
xmlHttpfeed_1.send(null)

setTimeout('show_indicator()', 4000);
}

function ChangingBPH() 
{
if (xmlHttpfeed_1.readyState==4 || xmlHttpfeed_1.readyState=="complete")
{
var total_feed = xmlHttpfeed_1.responseText;
var arrdata = total_feed.split("|");

	if (arrdata[1]==undefined){
		return;
	};
	
	sv_element('Flow',r(arrdata[2]) + ' m<sup>3</sup>h')
	sv_element('Total',r(arrdata[3]) + ' m<sup>3</sup>')
	
	rtu('rtu_stat1',arrdata[0])
} 
}

function init_the_show(){
	loader_dia();
	show_indicator();	
}

//window.onload = init_the_show;
</script>