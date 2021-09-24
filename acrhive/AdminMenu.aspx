<%@ Page Language="VB" Debug="true" %>
<script language="JavaScript" src="custom/_xmlobject.js"></script>
<script language="javascript">

var strSession = '<%=session("login")%>';
if (strSession != "true")
{
    alert("Session Timeout !");
    top.location.href = "login.aspx";
}

var BPH = ""
var scroll_img = ""

function show_menu(){
	var something =''
	something = something + '<table bgcolor="black" cellspacing="1" cellpadding="3" style="border-width:0px;border-style:solid;border-color:black"><tr>'
	something = something + '<td width="5%" bgcolor="#AAB9FD" height="18" align="center"> >> </td>'
	something = something + '<td width="5%" bgcolor="#AAB9FD" height="18" align="center"><a href="custom/amr/"  target="main">AMR</a></td>'
	something = something + '<td width="5%" bgcolor="#AAB9FD" height="18" align="center"> << </td>'
	something = something + '</tr></table>'
	something = something + '<table width="100%" border=0 cellspacing="0" cellpadding="0"><tr><td width="75" align="center" valign="top"><img id="tip" src="images/white.gif" border="0"></td><td>&nbsp;</td></tr></table>'
	
	document.getElementById('hiddenmenu').innerHTML = something;
	//document.getElementById('tip').innerHTML = '';
}
function hide_menu(){	
	document.getElementById('hiddenmenu').innerHTML = '';
}
function scroll_img_click(){
//	alert_marquee.scrollIntoView();
	if (scroll_img == ''){
		scroll_img = 'stopped'		
		alert_marquee.stop();
		document.getElementById('scroll_img').src = 'images/rightwhite.gif';
	}else{
		scroll_img = ''
		alert_marquee.start();
		document.getElementById('scroll_img').src = 'images/pause.gif';
	}
}
function BPH_onclick(){
	if (BPH == ''){
		BPH = 'expanded'		
		show_menu();
		document.getElementById('BPH').innerHTML = 'Jump &nbsp; <img id="tip" src="images/white.gif" border="0">';
	}else{
		BPH = ''
		hide_menu();
		document.getElementById('BPH').innerHTML = 'Jump &nbsp; <img id="tip" src="images/upwhite.gif" border="0">';
	}
}
function set_scroll(){
	var _w = document.getElementById('logos').offsetWidth;
	var _h = document.getElementById('m').offsetHeight;
	document.getElementById('scroll_island').style.width = _w - 10;
	document.getElementById('scroll_island').style.height = _h - 2;
	document.getElementById('alert_marquee').style.width = _w - (25);	
}
</script>
<html>
<head>
<title>Gussmann Telemetry Management System</title>
<style>
a:link {text-decoration: none;color:black}
a:visited {text-decoration: none;color:black}
a:hover {text-decoration: none;color:white}
 
 div#hiddenmenu {position:relative;z-index:3;top:10px;height:30px;background:transparent;width:300px;}
 div#BPH{cursor:pointer}
 div#scroll_island {position:absolute;z-index:2;bottom:3px;left:0px;width:350px;height:13px;background:#AAB9FD;border-width:1px;border-color:grey;border-style:solid;filter:alpha(opacity=75);-moz-opacity:.75;opacity:.75;}
 div#scroll_alert {position:absolute;top:2px;left:12px;background:transparent;font-family:verdana;font-size:10px;color:black;border-width:0px;border-color:grey;border-style:solid} 
 .stylo {width:300px}
 .txtWelcome{width:150px;font-family:verdana;font-size:10px;color:#3366FF}
 td{font-family:Verdana;font-size:10px;font-weight:bold}    
</style>
<base target="contents">
</head>
<body topmargin="0" leftmargin="0">
<form>
  <table border="0" cellspacing="1" width="100%" cellpadding="3" height="60">
    <tr>
      <td id="logos" width="242" rowspan="2" valign="middle">
		<img border="0" src="images/Logo_small.jpg" align="left" >
      </td>
      <td colspan="9">
      <table border=0 width="100%"><tr><td>      
		<div id="scroll_island"><div style="position:absolute;top:3px;left:2px;cursor:pointer"><img id="scroll_img" onclick="scroll_img_click();" src="images/pause.gif"></div>		
		<div id="scroll_alert"><marquee id="alert_marquee" scrolldelay="10" scrollamount="3" behavior="slide" loop="999" class="stylo" onMouseover="this.scrollAmount=1" onMouseout="this.scrollAmount=3">
		<%	dim i
			for i = 1 to 10
				response.write("RTU" & i & ": 00 events &bull; ")
			next i
		%>
		</marquee></div></div>
		<div id="hiddenmenu" align="left"></div>
      </td>
	  <td width="150" align="right"><div class="txtWelcome">
<%
         dim strUsername         
         strUsername = request.cookies("Telemetry")("UserName")
         response.write("<b>Hello " & strUsername & " !</b>")
         response.write("<br>")
%></div><div id="timingu" class="txtWelcome"><%         
         response.write(Now().ToString("yyyy/MM/dd hh:mm:ss tt"))     
%>     
        </div>
        </td></tr></table>
      </td>
    </tr>
    <tr>     
      <td id="m" width="8%" bgcolor="#AAB9FD" height="15" align="center"><div id="BPH" onclick="BPH_onclick();return false;">Jump &nbsp; <img id="tip" src="images/upwhite.gif" border="0"></div></td>       
     
      <td width="13%" bgcolor="#AAB9FD" height="15" align="center"><a href="Admin.aspx"  target="main">Admin Management</a></td>
      
      <td width="5%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1"><a href="DisplayMap.aspx?Command=MAP"  target="main">GIS</a></font></b></td>

      <td width="13%" bgcolor="#AAB9FD" height="15" align="center"><a href="Alarm.aspx"  target="main">Alarm Notification</a></td>

      <td width="8%" bgcolor="#AAB9FD" height="15" align="center"><a href="GraphicalAnalysis.aspx"  target="main">Analysis</a></td>

      <td width="8%" bgcolor="#AAB9FD" height="15" align="center"><a href="Reportsmenu.aspx"  target="main">Report</a></td>

      <td width="8%" bgcolor="#AAB9FD" height="15" align="center"><a href="Logout.aspx"  target="_top">Logout</a></td>
    </tr>
  </table>
</form>
</body>
</html>
<script>
var xml_alertfeed;

function show_indicator()
{ 
var url="ajx/mapalertfeed.aspx?&c=marquee&sid=" + Math.random()
xml_alertfeed=GetXmlHttpObject(ChangingState)
xml_alertfeed.open("GET", url , true)
xml_alertfeed.send(null)
setTimeout('show_indicator()', 4000);
}

function ChangingState() 
{
if (xml_alertfeed.readyState==4 || xml_alertfeed.readyState=="complete")
{
var total_feed = xml_alertfeed.responseText;
	
/*	if (arrdata[52]==undefined){
		return;
	}; */
	
	sv_element('alert_marquee',total_feed);
	alert_marquee.normalize();
	alert_marquee.align= 'middle';
} 
}

function init_the_show(){
	set_scroll();
	//show_indicator();	
}

window.onload = init_the_show;
</script>