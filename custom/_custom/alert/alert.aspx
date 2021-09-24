<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	dim page_title = "Kina Benua Pumping Station"
%>
<html>
<head>
<title><%=page_title%></title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet href="_objects.css" title="Contemporary">
</head><body bgcolor="#0071bb">
<div id="BPH" style="position:absolute;z-index:1;left:2px;top:1px">
	<img src="../images/_Kina-Benua.png">
	<div onclick="window.location='ips_bukit_kallambooster.aspx';" class="pointer" style="position:absolute;top:291px;left:142px;z-index:2;background:transparent"><img src="../images/blank.gif" width="33" height="30"></div>
	<div id="header"><%=page_title%></div>
<!-- level -->
<div style="Z-INDEX:3;LEFT:333px;POSITION:absolute;TOP:175px"><img src="../images/TANGKI/Tangki-kina-benua.png"></div>
<div id="water_level1" style="Z-INDEX:2;BACKGROUND:none transparent scroll repeat 0% 0%;LEFT:345px;WIDTH:100px;POSITION:absolute;TOP:209px;HEIGHT:50px">
<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="100" height="10"></div>		
</div>
<!-- indicator -->
<div id="rtu_stat1" style="position:absolute;z-index:3;top:459px;left:10px" class="rtu_island">
	<div id="rtu_stat1_title" style="position:absolute;top:0px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat1_power" style="position:absolute;top:14px;left:62px" class="ok">???</div>
	<div id="rtu_stat1_batt" style="position:absolute;top:14px;left:172px" class="ok">???</div>
</div>

<div onclick="s_trend('RTU12','Kina Benua Pumping Station','Labuan','Level Meter',48,window.location);" id="tower" title="tower" style="Z-INDEX:3;LEFT:370px;POSITION:absolute;TOP:139px;cursor:pointer">
	<div id="levelm" style="POSITION:absolute;TOP:0px" class="indicator">???</div>
	<div id="levelf" style="POSITION:absolute;TOP:14px" class="indicator">???</div>
</div>
<div id="flow" title="Flow" style="Z-INDEX:3;LEFT:559px;POSITION:absolute;TOP:235px;cursor:pointer">
	<div onclick="s_trend('RTU12','Kina Benua Pumping Station','Labuan','Flow Rate',53,window.location);" id="flowrate1" style="POSITION:absolute;TOP:0px" class="indicator">???</div>
	<div onclick="s_trend('RTU12','Kina Benua Pumping Station','Labuan','Flow Rate',53,window.location);" id="flowrate2" style="POSITION:absolute;TOP:15px" class="indicator">???</div>
	<div onclick="s_trend('RTU12','Kina Benua Pumping Station','Labuan','Flow Total',57,window.location);" id="flowtotal" style="POSITION:absolute;TOP:30px" class="indicator">???</div>
</div>
<!-- indicator -->
</div>
<div id="footer">
	<div class="foot_copy">Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.</div>
	<div class="foot_note">* Click on clickable values to show trending option.</div>
</div>
</body>
<script language="JavaScript" src="pump_control.js"></script>
<script>
var xmlHttpfeed;
var HTTP_commission;

function on_pump(id){    
    pump_controller(id,"ON");
}
function off_pump(id){	
	pump_controller(id,"OFF")
}
function show_status(id,stat){
	if (id==999){
		eval('window.status=stat;');
	}else{
		eval('window.status="Turn Pump " + id + " " + stat;');
	}
}
function reset_status()
{
	eval('window.status=""');
}
function pump_controller(id,suis)
{
	HTTP_commission=GetXmlHttpObject(pump_commission_status);	
	HTTP_commission.open('POST','pump_control.aspx?siteid=9012&c=' + id + '&o=' + suis,false);
	HTTP_commission.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	//HTTP_commission.send("siteid=9012&c=" + id + "&o=" + suis);
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
var url="../ajx/realtimefeed.aspx?siteid=12&c=feed&sid=" + Math.random()
xmlHttpfeed=GetXmlHttpObject(ChangingState)
xmlHttpfeed.open("GET", url , true)
xmlHttpfeed.send(null)
setTimeout('show_indicator()', 4000);
}

function ChangingState() 
{
if (xmlHttpfeed.readyState==4 || xmlHttpfeed.readyState=="complete")
{
	var total_feed = xmlHttpfeed.responseText;
	var arrdata = total_feed.split("|");

	sv_element('header',pageheader)	
	if (arrdata[3]==undefined){	
		return;
	};

	rtu_s('rtu_stat1',arrdata[0],arrdata[2],arrdata[3])	

	sv_element('levelm',arrdata[49] + ' m')
	sv_element('levelf',meter2feet(arrdata[49]) + ' ft')
	
	sv_element('flowrate1',arrdata[53])
	sv_element('flowrate2',cubic_meter_per_hour2litre_per_sec(arrdata[53]))
	sv_element('flowtotal',arrdata[57])
	
	var tinggi = document.getElementById('water_level1').offsetHeight;
	wt_level('show_level1',tinggi,arrdata[49],5.569)
	
	rtu_s('rtu_stat1',arrdata[0],arrdata[2],arrdata[3])

} 
}

function init_the_show(){
	loader_dia();
	show_indicator();	
}

window.onload = init_the_show;
</script>