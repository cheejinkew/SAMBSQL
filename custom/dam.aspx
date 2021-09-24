<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<% 	dim BPHSiteID = request.querystring("siteid")
	dim BPHSiteName = request.QueryString("sitename")
	dim BPHDistrict = request.QueryString("district")		
	dim page_title = BPHSiteName	
	dim blank_gif = "<img src='../images/blank.gif' align='absmiddle' border='0' height='17' width='17'>"
	
	dim max_value_es = 30

	dim L1 = 2

'========== Try getting the data ===========

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=page_title%></title>
<script language="JavaScript" src="../Telemetry_extension/diagnose/script.aspx?u=1181639850"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet type="text/css" href="_objects.css" title="Contemporary">
</head><body id="karman" bgcolor="#1e62af">	
	<div id="water_level1" title="Dam Water Level" style="position:absolute;z-index:1;top:190px;left:12px;width:595px;height:311px;background:transparent">
		<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="100%" height="10"></div>
	</div>

	<div id="BPH" style="position:absolute;z-index:1;left:2px;top:0px;">
	<img src="../images/dam.png" style="position:absolute;z-index:2;left:10px;top:50px;">
	<!-- arrows -->	
	
	<!-- level -->

	<!-- level -->
	</div>
	
	<div id="l_level1" class="indicator" title="Water Level (<%=BPHSiteID%>)" style="position:absolute;width:100px;height:33px;top:76px;left:27px;z-index:2;text-align:center;cursor:pointer;" onclick="">	
	<div onclick="s_trend('<%=BPHSiteID%>','<%=BPHSiteName%>','<%=BPHDistrict%>','Level%201',<%=L1%>,window.location);" style="position:absolute;top:2px;left:10px;" id="l_level1_value" class="indicator">???</div>
	<div onclick="s_trend('<%=BPHSiteID%>','<%=BPHSiteName%>','<%=BPHDistrict%>','Level%201',<%=L1%>,window.location);" style="position:absolute;top:16px;left:10px;" id="f_level1_value" class="indicator">???</div>
	</div>
	
<div id="rtu_stat1" style="position:absolute;z-index:3;top:180px;left:390px" class="rtu_island">
	<div id="rtu_stat1_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=BPHSiteID%></div>
	<div id="rtu_stat1_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat1_power" style="position:absolute;top:16px;left:62px" class="ok">???</div>
	<div id="rtu_stat1_batt" style="position:absolute;top:16px;left:172px" class="ok">???</div>
</div>
	
	<div id="header" onclick="de_active();"><%=page_title%></div>
	<div id="site_status"></div>

<div id="hijab"></div>	
<div id="btn_1" onmouseover="this.className='poll_btn_o';" onmousedown="this.className='poll_btn_d';" onclick="show_xboxes(0,63);selectedsiteid=sms_site_1;" onmouseup="this.className='poll_btn_o';" onmouseout="this.className='poll_btn_n';" class="poll_btn_n" style="top:z-index:5;top:82px;left:125px;"></div>
	<div id="xbox" class="xbox" style="top:400px;left:155px">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><span>&nbsp;insert password&nbsp;</span>
	<input type="password" id="inputPass" name="inputPass" class="inputStyle" onkeyup="key_in(event);">	
	</div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>	
	</div>
	<div id="xbox_butt" class="xbox_butt" style="top:400px;left:435px">
	<div id="send" onmouseover="this.className='send_btn_o';" onmousedown="this.className='send_btn_d';" onclick="sms_outbox(selectedsiteid);" onmouseup="this.className='send_btn_o';" onmouseout="this.className='send_btn_n';" class="send_btn_n"></div>
	<div id="cancel" onmouseover="this.className='cancel_btn_o';" onmousedown="this.className='cancel_btn_d';" onclick="hide_xboxes();" onmouseup="this.className='cancel_btn_o';" onmouseout="this.className='cancel_btn_n';" class="cancel_btn_n"></div>
	</div>
	
	<div id="xstatus">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><span id="poll">dd</span></div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>	
	</div>	
	
	<div id="footnote" style="position:absolute;top:530px;left:470px;z-index:2;visibility:hidden"><font color="black" face="Verdana" size="1">* Click on clickable values to show trending option.</font></div>
	<div id="footer" style="visibility:hidden"><font color="black" face="Verdana" size="1">Copyright © 2007 Gussmann Technologies Sdn Bhd. All rights reserved.</font></div>	
	<div id="debug" style="position:absolute;top:500px;left:0px;z-index:2"></div>
<%
select case BPHSiteID
	case "8567"
		max_value_es = 28.4
%><!--#include file="dt_scale.html"--><%
	case "8568"
		max_value_es = 75.7 ' 73
%><!--#include file="jus_scale.html"--><%
	case else
%>&nbsp;<%
end select
%>
</body>
<script language="JavaScript" src="pump_control.js"></script>
<script>
var xmlHttpfeed;
var xmlHttpfeed_2;
var HTTP_commission;
var selectedsiteid;
var sms_site_1 = '<%=BPHSiteID%>';

var Level_1 = <%=max_value_es%>;

function sms_outbox(siteid)
{	
	var url = "smspoll.aspx?timeStamp=" + new Date().getTime();
	var queryString = 'siteid=' + siteid + '&c=poll';
	if (checking_passx2(siteid)== 'NO'){
		return false;
	}else{
		document.getElementById("xstatus").style.visibility="visible";
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
    if(HTTP_commission.responseText=='Done'){		
		sv_element('poll','Command Successfully Sent!');		
		setTimeout('hide_xboxes()', 1000);
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
var url="../ajx/realtimefeed.aspx?sid=" + Math.random() + "&siteid=<%=BPHSiteID%>&c=xml"
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
		var arr_data = total_feed.getElementsByTagName("equipment");		
		sv_element('l_level1_value',r(get_values(arr_data,"no",2,"value")))
		sv_element('f_level1_value',meter2feet(get_values(arr_data,"no",2,"value")))
		var tinggi = document.getElementById('water_level1').offsetHeight;
		wt_level('show_level1',tinggi,get_values(arr_data,"no",2,"value"),Level_1)		
		
		rtu_s('rtu_stat1',total_feed.getAttribute("timestamp") + " " + total_feed.getAttribute("timing"),0,0)
		
		show_site_status(total_feed.getAttribute("status"));
	}else{		
		sv_element('site_status','Status: under maintenance')
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