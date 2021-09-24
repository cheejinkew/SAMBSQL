<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Al-Muktafi Billah Shah BPH</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet href="_objects.css" title="Contemporary">
</head><body bgcolor="#ffffff">
<div id="BPH" style="position:absolute;z-index:1;left:2px;top:1px">
	<img src="../images/AMBS.JPG">
	<div onclick="window.location='_jkolam_3.aspx';" class="pointer" style="position:absolute;top:383px;left:4px;z-index:2"><img src="../images/left.jpg"></div>
	<div id="header">Al-Muktafi Billah Shah BPH</div>
	<div id="footer" style="z-index:1;text-align:right" onclick="naim()">
	<font color="#5373a2" face="Verdana" size="1">Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.</font>
	</div>
<!-- pumps -->
<div id="pump1" class="pump_stop" style="position:absolute;z-index:3;top:330px;left:180px"></div>
<div id="pump2" class="pump_stop" style="position:absolute;z-index:3;top:330px;left:280px"></div>
<div id="pump3" class="pump_stop" style="position:absolute;z-index:3;top:330px;left:380px"></div>
<div style="position:absolute;z-index:3;left:160px;top:380px">
<div style="position:absolute;left:0px;top:0px" id="chck1"><input type="checkbox" id="nid1" onclick="" value="id1" checked><b><font face="Verdana" size=-3>pump1</font></b></div>
<div style="position:absolute;left:100px;top:0px" id="chck2"><input type="checkbox" id="nid2" onclick="" value="id2" checked><b><font face="Verdana" size=-3>pump2</font></b></div>
<div style="position:absolute;left:200px;top:0px" id="chck3"><input type="checkbox" id="nid3" onclick="" value="id3" checked><b><font face="Verdana" size=-3>pump3</font></b></div>
<div style="position:absolute;left:100px;top:40px" id="chck3"><input type="submit" id="submit" onclick="ambs_pam(checking_cbx('nid1'),checking_cbx('nid2'),checking_cbx('nid3')); return false;" value="submit"></div>
</div>
<!-- level -->
<div id="water_level1" style="position:absolute;z-index:2;top:92px;left:63px;width:309px;height:60px;background:transparent">
	<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="309" height="10"></div>
</div>
<div id="water_level2" style="position:absolute;z-index:3;top:282px;left:520px;width:309px;height:60px;background:transparent">
	<div id="show_level2color" class="waterlevel"><img id="show_level2" src="../images/blank.gif" width="309" height="10"></div>
</div>
<!-- indicator -->
<div id="rtu_stat1" style="position:absolute;z-index:3;top:170px;left:90px" class="rtu_island">
	<div id="rtu_stat1_title" style="position:absolute;top:0px;left:3px" class="labelhead">RTU#</div>
</div>
<div id="rtu_stat2" style="position:absolute;z-index:3;top:370px;left:550px" class="rtu_island">
	<div id="rtu_stat2_title" style="position:absolute;top:0px;left:3px" class="labelhead">RTU#</div>
</div>
<div id="tank1" title="tank1" onclick="s_trend('9012','RMAF Tanks','Labuan','Level Meter 1',48,window.location);" style="position:absolute;z-index:3;top:110px;left:385px;cursor:pointer">
	<div id="level1m" style="position:absolute;top:0px" class="indicator">???</div>
	<div id="level1f" style="position:absolute;top:17px" class="indicator">???</div>
</div>
<div id="tank2" title="tank2" onclick="s_trend('9003','RMAF Tanks','Labuan','Level Meter 2',49,window.location);" style="position:absolute;z-index:3;top:202px;left:700px;cursor:pointer">
	<div id="level2m" style="position:absolute;top:0px" class="indicator">???</div>
	<div id="level2f" style="position:absolute;top:17px" class="indicator">???</div>
</div>
<div style="position:absolute;z-index:3;top:220px;left:80px;cursor:pointer">
	<div id="FlowM" style="position:absolute;top:0px" class="indicator">???</div>
	<div id="PressureM" style="position:absolute;top:17px" class="indicator">???</div>
</div>
<!-- indicator -->
<div style="position:absolute;z-index:3;top:500px;left:500px;border-width:1px;border-style:solid;border-color:darkslateblue;padding:1px;background:skyblue">
<table><tr>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue">1 (V)</td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue">2 (V)</td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue">3 (V)</td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue">4 (A)</td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue">5 (A)</td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue">6 (A)</td>
</tr><tr>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue"><span id=n1>1</span></td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue"><span id=n2>2</span></td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue"><span id=n3>3</span></td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue"><span id=n4>4</span></td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue"><span id=n5>5</span></td>
<td style="border-width:1px;border-style:solid;border-color:darkslateblue"><span id=n6>6</span></td>
</tr></table>
</div>
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

var url="../ajx/realtimefeed.aspx?siteid=9003&c=feed&sid=" + Math.random()
xmlHttpfeed_2=GetXmlHttpObject(ChangingReservoir)
xmlHttpfeed_2.open("GET", url , true)
xmlHttpfeed_2.send(null)

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
	
	sv_element('level1m',arrdata[2] + ' m')
	sv_element('level1f',meter2feet(arrdata[2]) + ' ft')
	
	sv_element('n1',arrdata[15])
	sv_element('n2',arrdata[16])
	sv_element('n3',arrdata[17])
	sv_element('n4',arrdata[18])
	sv_element('n5',arrdata[19])
	sv_element('n6',arrdata[20])

	sp_stat02(1,arrdata[3],arrdata[4],arrdata[5],arrdata[6]);
	sp_stat02(2,arrdata[7],arrdata[8],arrdata[9],arrdata[10]);
	sp_stat02(3,arrdata[11],arrdata[12],arrdata[13],arrdata[14]);
		
	var tinggi = document.getElementById('water_level1').offsetHeight;
	wt_level('show_level1',tinggi,arrdata[2],8)
	
	rtu('rtu_stat1',arrdata[0])
} 
}

function ChangingReservoir() 
{
if (xmlHttpfeed_2.readyState==4 || xmlHttpfeed_2.readyState=="complete")
{
var total_feed = xmlHttpfeed_2.responseText;
var arrdata = total_feed.split("|");

	sv_element('header',pageheader)
	
	if (arrdata[1]==undefined){		
		return;
	};

	sv_element('level2m',r(arrdata[2]) + ' m')
	sv_element('level2f',meter2feet(arrdata[2]) + ' ft')
	
	var tinggi = document.getElementById('water_level2').offsetHeight;
	wt_level('show_level2',tinggi,arrdata[2],5)
	
	rtu('rtu_stat2',arrdata[0])
} 
}
function init_the_show(){
	loader_dia();
	show_indicator();	
}

window.onload = init_the_show;
</script>