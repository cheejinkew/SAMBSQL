<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%
	dim page_title = "Matang-Jasin"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=page_title%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet href="_objects.css" title="Contemporary">
</head><body bgcolor="#ffffff">
<div id="BPH" style="Z-INDEX:1;LEFT:2px;POSITION:absolute;TOP:1px">
			<img src="img/Matang-Jasin.jpg">
<!--			<div onclick="window.location='_jkolam_3.aspx';" class="pointer" style="Z-INDEX:2;LEFT:4px;POSITION:absolute;TOP:383px"><img src="../images/left.jpg"></div>-->
			<div id="header"><%=page_title%></div>
			<div id="footer" style="Z-INDEX:1;TEXT-ALIGN:right">
				<font color="#5373a2" face="Verdana" size="1">Copyright © 2006 Gussmann 
					Technologies Sdn Bhd. All rights reserved.</font>
			</div>
			<!-- level -->
			<!--<div id="water_level1" style="Z-INDEX:2;BACKGROUND:none transparent scroll repeat 0% 0%;LEFT:30px;WIDTH:309px;POSITION:absolute;TOP:390px;HEIGHT:60px">
				<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="309" height="10"></div>
			</div>-->
			<!-- indicator -->
			<div id="rtu_stat1" style="Z-INDEX:3;LEFT:13px;POSITION:absolute;TOP:40px" class="rtu_island">
				<div id="rtu_stat1_title" style="LEFT:3px;POSITION:absolute;TOP:0px" class="labelhead">RTU#</div>
			</div>
			<div style="Z-INDEX:3;LEFT:215px;CURSOR:pointer;POSITION:absolute;TOP:20px">
				<div id="Flow1" style="POSITION:absolute;TOP:0px" class="indicator">???</div>
				<div id="Total1" style="POSITION:absolute;TOP:17px" class="indicator">???</div>
			</div>
			<div style="Z-INDEX:3;LEFT:215px;CURSOR:pointer;POSITION:absolute;TOP:195px">
				<div id="Flow2" style="POSITION:absolute;TOP:0px" class="indicator">???</div>
				<div id="Total2" style="POSITION:absolute;TOP:17px" class="indicator">???</div>
			</div>
			<div style="Z-INDEX:3;LEFT:255px;CURSOR:pointer;POSITION:absolute;TOP:275px">
				<div id="Flow3" style="POSITION:absolute;TOP:0px" class="indicator">???</div>
				<div id="Total3" style="POSITION:absolute;TOP:17px" class="indicator">???</div>
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
	
	
	sv_element('Flow1',r(arrdata[2]) + ' m<sup>3</sup>h')
	sv_element('Total1',r(arrdata[5]) + ' m<sup>3</sup>')
	sv_element('Flow2',r(arrdata[3]) + ' m<sup>3</sup>h')
	sv_element('Total2',r(arrdata[6]) + ' m<sup>3</sup>')
	sv_element('Flow3',r(arrdata[4]) + ' m<sup>3</sup>h')
	sv_element('Total3',r(arrdata[7]) + ' m<sup>3</sup>')
	
	rtu('rtu_stat1',arrdata[0])
} 
}

function init_the_show(){
	loader_dia();
	show_indicator();	
}

//window.onload = init_the_show;
</script>