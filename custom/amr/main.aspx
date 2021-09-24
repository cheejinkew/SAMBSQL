<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Labuan RTU Site Allocation</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript"></script>
<link rel=StyleSheet href="main_ss.css" title="Front">

</head><body bgcolor="#b3b3b3">
<div id="mainframe" style="background:blue">
<div id="BPH" style="position:absolute;z-index:1;left:2px;top:20px">	
	<img src="../amr/img/district_map1.bmp" width="480">	

<!-- circles -->
<!-- label -->	
<!--	<div class="labeling1" style="position:absolute;top:200px;left:5px">LAUT CHINA SELATAN</div>
	<div onclick="alert('');" class="labeling1" style="position:absolute;top:350px;left:100px;cursor:pointer">SUNGAI PAGAR DAM</div>
	<div class="labeling1" style="position:absolute;top:400px;left:400px">TERUSAN TIMUR</div>
	<div class="labeling1" style="position:absolute;top:500px;left:10px">TERUSAN KERAMAN</div>
	<div class="labeling2" style="position:absolute;top:50px;left:329px">Chimney</div>
	<div class="labeling2" style="position:absolute;top:490px;left:410px">Pulau Papan</div>
	<div onclick="window.location='_bktkuda.aspx';" class="labeling1" style="position:absolute;top:155px;left:160px;cursor:pointer">BUKIT KUDA DAM</div>	
	<div onclick="window.location='_kerupang.aspx';" class="labeling1" style="position:absolute;top:240px;left:350px;cursor:pointer">KERUPANG DAM</div>
 -->	
<!-- label -->
<div id="header"></div>
</div>
<!-- the words -->
<div class="outer" style="position:absolute;top:1px;left:600px;z-index:3;background:transparent">
    <table class="tableone" summary="This table lists rtus in the island of Labuan.">
      <caption>Melaka Water Supply Scheme</caption>

      <thead>
        <tr>
          <th class="th1" scope="col">RTU</th> 
          <th class="th2" scope="col">SITE NAME</th>
        </tr>
      </thead>

      <tfoot>
        <tr>
          <td colspan="5"><div id="timestamp">DATE : <%=String.Format("{0:dd MMMM yyyy  HH:mm:ss}", now())%></div>
          </td>
        </tr>
      </tfoot>
<tbody>
<tr><td colspan="2">
<div class="innerb">
	  <table class="tabletwo">
      
      <tr>
        <th scope="row">1</th>
       <td onclick="window.location='asahan.aspx'" style="cursor:pointer">asahan Tower</td>
      </tr>
      <tr class="dk">
        <th scope="row">2</th>
        <td onclick="window.location='Hospital-Jasin.aspx'" style="cursor:pointer">Hospital-Jasin Tower</td>
      </tr>
      <tr>
        <th scope="row">3</th>
        <td onclick="window.location='Hualon2-lot1500_TanggaBatu.aspx'" style="cursor:pointer"><span id="line5">Hualon2-lot1500_TanggaBatu</span></td>
      </tr>
      <tr class="dk">
        <th scope="row">4</th>
        <td onclick="window.location='Hualon3-lot435.aspx'" style="cursor:pointer"><span id="line6">Hualon3-lot435,-TanggaBatu</span></td>
      </tr>
      <tr>
        <th scope="row">5</th>
        <td onclick="window.location='Matang-Jasin.aspx'" style="cursor:pointer"><span id="line7">Matang-Jasin</span></td>
      </tr>
      <tr class="dk">
        <th scope="row">6</th>
        <td onclick="window.location='mrcb_merlimau.aspx'" style="cursor:pointer">MRCB</td>
      </tr>
      <tr>
        <th scope="row">7</th>
        <td onclick="window.location='Sinmah.M.Tanah.aspx'" style="cursor:pointer"><span id="line9">Sinmah.M.Tanah</span></td>
      </tr>
     
     
</table>
</div>
</td></tr>
</tbody>
</table>
</div>
<!-- the words -->
</div>
<div id="footer" style="z-index:1;text-align:right">Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.</div>
</body>
<script language="JavaScript" src="pump_control.js"></script>
<script>
var xmlHttpfeed;
var title = new Array();

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
function show_indicator()
{ 
var url="../ajx/mapalertfeed.aspx?sid=" + Math.random() + "&c=feed"
xmlHttpfeed=GetXmlHttpObject(ChangingState)
xmlHttpfeed.open("GET", url , true)
xmlHttpfeed.send(null)
setTimeout('show_indicator()', 10000);
}

function ChangingState() 
{
if (xmlHttpfeed.readyState==4 || xmlHttpfeed.readyState=="complete")
{
var total_feed = xmlHttpfeed.responseText;
var strpoint = total_feed.split("|");
var arrpoint = strpoint[0].split(",");
var _obj,jj;
var time_stamp = arrpoint[0];
    
    for (var xc=1; xc <= 35; xc++) // 37
    {
    var _obj = strpoint[xc].split(",");
		if(_obj[1]!=0){
			document.getElementById('point' + xc ).className='alert';
			document.getElementById('point' + xc ).title=title[xc]+ " (" + _obj[1] + ' alert!)';
			document.getElementById('line'+ xc).style.textDecoration='blink';
		}else{
			document.getElementById('point' + xc ).className='normal';
			document.getElementById('point' + xc ).title=title[xc];
			document.getElementById('line'+ xc).style.textDecoration='none';
		}

		sv_element('timestamp','Timestamp : ' + time_stamp);

    }
} 
}

function init_the_show(){	
	for (var i=1;i<=35;i++) // 37
	{		
		title[i] = eval("document.getElementById('point" + i + "').title;");
	}
	show_indicator();	
}

window.onload = init_the_show;
//window.onload = show_clock;
</script>