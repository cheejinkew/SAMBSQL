<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<% 	dim BPHSiteID = request.querystring("siteid")
	dim BPHSiteName = request.QueryString("sitename")
	dim BPHDistrict = request.QueryString("district")
		
	dim page_title = BPHSiteName
	
	dim blank_gif = "<img src='../images/blank.gif' align='absmiddle' border='0' height='17' width='17'>"
	
'========== Try getting the data ===========

%>
<!-- Loji Tepus Class : 1 local Flowmeter with associated Level 
     Loji Tepus Flow with
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=page_title%></title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet type="text/css" href="_objects.css" title="Contemporary"/>
</head><body bgcolor="#ffffff">
<xml src="flow_info.xml" id="xmldso" async="false"></xml>
<div id="BPH" style="position:absolute;z-index:1;left:2px;top:0px;">	
	<img src="imej/aquamaster2.png" />
	
	<!-- balloon -->
	<div id="xflow" class="xflow" style="visibility:hidden;"><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="tip"></div>
		<div id="xballoon_F1">
		<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
		<div class="xboxcontent" style="visibility:hidden;">			
			<p>
			<img datasrc="#xmldso" datafld="image">
			Brand: <span datasrc="#xmldso" datafld="brand"></span><br />
			Model: <span datasrc="#xmldso" datafld="model"></span><br />
			Size: <span datasrc="#xmldso" datafld="size"></span>
			</p>
		</div>
		<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>		
		</div>		
		</a>
	</div>
	<!-- arrows -->

	<!-- level -->

	<!-- level -->

	</div>
	
	<div id="flow1" style="Z-INDEX:3;POSITION:absolute;width:200px;height:31px;TOP:215px;LEFT:250px;">
		<div title="Click for Flow Trends" onclick="window.location='CascadeTSelection.aspx?siteid=<%=BPHSiteID%>&sitename=<%=server.urlencode(page_title)%>&district=<%=BPHDistrict%>&sitetype=FLOWMETER&equipname=Flow%20Meter&position=2';" id="flow1rate1"  style="TOP:2px;LEFT:35px;cursor:pointer;font-size:15px;text-align:center;"  class="indicator">???</div>
		<div title="Click for Totalizer Trends" onclick="window.location='CascadeTSelection.aspx?siteid=<%=BPHSiteID%>&sitename=<%=server.urlencode(page_title)%>&district=<%=BPHDistrict%>&sitetype=FLOWMETER&equipname=Totalizer&position=3';" id="flow1total" style="TOP:24px;LEFT:35px;cursor:pointer;text-align:center;" class="indicator">???</div>       
	</div>
	
<div id="rtu_stat1" style="position:absolute;z-index:3;height:16px;top:420px;left:205px; width: 219px;" class="rtu_island">
	<div id="rtu_stat1_tag" style="position:absolute;top:2px;left:7px;" class="tag"><%=BPHSiteID%></div>
	<div id="rtu_stat1_title" style="position:absolute;top:1px;left:57px" class="labelhead">RTU#</div>
	<div id="rtu_stat1_power" style="position:absolute;top:16px;left:62px;visibility:hidden" class="ok">???</div>
	<div id="rtu_stat1_batt" style="position:absolute;top:16px;left:172px;visibility:hidden" class="ok">???</div>
</div>
	
	<div id="header" style="position:absolute;top:20px;left:175px;z-index:2;font-size:18px;"><%=page_title%></div>
	<div id="site_status" style="position:absolute;top:40px;left:178px;z-index:2;"></div>
	<div id="footnote" style="position:absolute;top:330px;left:167px;z-index:2"><font color="black" face="Verdana" size="1">* Click on clickable values to show trending option.</font></div>
	<div id="footer"><font color="black" face="Verdana" size="1">Copyright © 2007 Gussmann Technologies Sdn Bhd. All rights reserved.</font></div>	
	<div id="debug" style="position:absolute;top:500px;left:0px;z-index:2"></div>
	
	<div id="xisland_label" style="visibility:hidden;position:absolute;top:398px;left:100px;z-index:2;font-family:verdana;font-size:10px;">Poll for the most recent data.</div>
	<div id="xisland" style="visibility:hidden;position:absolute;top:417px;left:100px;z-index:2">
	<table style="position:absolute;top:0px;left:0px"><tr><td style="height: 25px">
		<input style="width:119px;height:17px" type="password" id="inputPass" name="inputPass" class="inputStyle">
	</td><td style="height: 25px">
		<span><input style="height:23px" type="submit" name="Poll_butt" value="SMS Poll" onclick="sms_outbox();"></span>
	</td></tr></table>
	<div style="position:absolute;top:28px;left:0px;" class="some"><font size="-3">* Key in password before polling.</font></div>
	<div id="poll" style="position:absolute;top:10px;left:220px;width:150px"><font face="verdana" size="2"></font></div>
	</div>


</body>
</html>
<script language="JavaScript" src="pump_control.js"></script>
<script>
var xmlHttpfeed;
var HTTP_commission;

var Level_1 = 10;
var siteid1 = '<%=BPHSiteID%>';
var siteid2;

function sms_outbox()
{
	var url = "smspoll.aspx?timeStamp=" + new Date().getTime();
	var queryString = 'siteid=<%=BPHSiteID%>&c=poll';
	if (checking_passx2('<%=BPHSiteID%>')== 'NO'){
		return false;
	}else{
		document.getElementById('poll').innerHTML='Polling...';
	}
	
	url = url + '&' + queryString;
	
	HTTP_commission=GetXmlHttpObject(sms_outbox_status);	
	HTTP_commission.open('POST',url,true);
	HTTP_commission.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	HTTP_commission.send(null);

}

function sms_outbox_status()
{
  if (HTTP_commission.readyState==4 || HTTP_commission.readyState=="complete")
  { 
    if(HTTP_commission.responseText=='Done!!!'){
		//alert("Polling Succeed!");
		sv_element('poll','Done!');
    }else{		
		//alert("Error Occured!");
		//sv_element('poll',HTTP_commission.responseText);
		document.getElementById('poll').innerHTML=HTTP_commission.responseText;
    }    
    document.getElementById('inputPass').value="";
  } 
}

function show_indicator()
{
var url="../ajx/flow_realtimefeed.aspx?sid=" + Math.random() + "&siteid=<%=BPHSiteID%>&c=xml"
xmlHttpfeed=GetXmlHttpObject(ChangingState)
xmlHttpfeed.open("GET", url , true)
xmlHttpfeed.send(null)
setTimeout('show_indicator()', 10000);
}

function ChangingState() 
{
if (xmlHttpfeed.readyState==4 || xmlHttpfeed.readyState=="complete")
{
var total_feed = xmlHttpfeed.responseXML.documentElement;

	if (total_feed.hasChildNodes()){
		var arr_data1 = total_feed.getElementsByTagName("site")[0].getElementsByTagName("equipment");
		//var arr_data2 = total_feed.getElementsByTagName("site")[1].getElementsByTagName("equipment");

		if (arr_data1.length==0){
			//rtu_s('rtu_stat1',total_feed.getElementsByTagName("site")[0].getAttribute("timestamp") + ' &nbsp; ' + total_feed.getElementsByTagName("site")[0].getAttribute("timing"),0,0)
			sv_element('flow1rate1','???')
			sv_element('flow1total','???')
			sv_element('site_status','Status: under maintenance');
		}else{
			rtu_s('rtu_stat1',total_feed.getElementsByTagName("site")[0].getAttribute("timestamp") + '&nbsp;' + total_feed.getElementsByTagName("site")[0].getAttribute("timing"),0,0)
			sv_element('flow1rate1',get_values(arr_data1,"pos",2,"textContent") + ' m<sup>3</sup>/hr')
			sv_element('flow1total',get_values(arr_data1,"pos",3,"textContent") + ' m<sup>3</sup>')
			show_site_status(total_feed.getAttribute("status"));
		}		
	}else{
		sv_element('site_status','Status: under maintenance');
	}
	sv_element('header',pageheader);
} 
}

function init_the_show(){	
	loader_dia();
	show_indicator();
}

window.onload = init_the_show;

</script>