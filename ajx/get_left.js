var xmlHttp
var xmlHttp_Option
var xmlHttp_list

function IntervalCall()
{
  var refreshInterval =2;//0.33
  refreshInterval = refreshInterval * 60000; 
  setTimeout('showAlert()', refreshInterval);
}
function fun(checkVal)
{

if(checkVal.checked)
{
var url="ajx/alert.aspx?pilih=mute&sid=" + Math.random()

  document.getElementById("1").stop();
  document.getElementById("1").url="images/silence.wav";
  document.getElementById("1").src="images/silence.wav";
 // document.getElementById("AlertSound").style.visibility= "hidden";
  

    xmlHttp_Option=GetXmlHttpObject(stopsound)
  xmlHttp_Option.open("GET", url , true)
  xmlHttp_Option.send(null)
}
else
{
var url="ajx/alert.aspx?pilih=unmute&sid=" + Math.random()

  document.getElementById("1").stop();
  document.getElementById("1").url="images/notify.wav";
  document.getElementById("1").src="images/notify.wav";
  document.getElementById("1").play();
 // document.getElementById("AlertSound").style.visibility= "hidden";
  

    xmlHttp_Option=GetXmlHttpObject(stopsound)
  xmlHttp_Option.open("GET", url , true)
  xmlHttp_Option.send(null)
}
}
function StopAlert()
{
  var url="ajx/alert.aspx?pilih=mute&sid=" + Math.random()

  document.getElementById("1").url="images/silence.wav";
  document.getElementById("1").src="images/silence.wav";
  document.getElementById("AlertSound").style.visibility= "hidden";
  
  
    xmlHttp_Option=GetXmlHttpObject(stopsound)
  xmlHttp_Option.open("GET", url , true)
  xmlHttp_Option.send(null)
  
 
}


function stopsound() 
{ 
  if (xmlHttp_Option.readyState==4 || xmlHttp_Option.readyState=="complete")
  { 
   
  } 
} 

function refillOption(dist,typ)
{ 
  var url="ajx/left.aspx?sid=" + Math.random() + "&ddDistrict=" + dist + "&ddType=" + typ + "&choice=ddTypeOption"
  xmlHttp_Option=GetXmlHttpObject(make_combo_list)
  xmlHttp_Option.open("GET", url , true)
  xmlHttp_Option.send(null)
 }

function showList(dist,typ)
{ 
  var url="ajx/left.aspx?sid=" + Math.random() + "&ddDistrict=" + dist + "&ddType=" + typ + "&choice=list"
  xmlHttp_list=GetXmlHttpObject(make_list)
  xmlHttp_list.open("GET", url , true)
  xmlHttp_list.send(null)
}
function refillOption1(dist,typ)
{ 
  var url="ajx/left.aspx?sid=" + Math.random() + "&ddDistrict=" + dist + "&ddType=" + typ + "&choice=ddTypeOption"
  xmlHttp_Option=GetXmlHttpObject(make_combo_list)
  xmlHttp_Option.open("GET", url , false)
  xmlHttp_Option.send(null)
}

function showList1(dist,typ)
{ 
  var url="ajx/left.aspx?sid=" + Math.random() + "&ddDistrict=" + dist + "&ddType=" + typ + "&choice=list"
  xmlHttp_list=GetXmlHttpObject(make_list)
  xmlHttp_list.open("GET", url , false)
  xmlHttp_list.send(null)
  
}
function showAlert()
{
   var list="";
   var currentTime = new Date()
   
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	
    var currentTime1 = new Date()
	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
		
	var begindate = year + "-" + month + "-" + day + " 00:00";
	var enddate = year1 + "-" + month1 + "-" + day1 + " 23:59";
	
 var url="alert.aspx?sid=" + Math.random() + "&begindate=" + begindate + "&enddate=" + enddate + "&choice=list"
	  
  xmlHttp=GetXmlHttpObject(stateChanged)
  xmlHttp.open("GET", url , true)
  xmlHttp.send(null)
  IntervalCall()
} 

function make_combo_list() 
{ 
  if (xmlHttp_Option.readyState==4 || xmlHttp_Option.readyState=="complete")
  { 
    var txt = xmlHttp_Option.responseText;
    var arrtxt = txt.split(",");
    var theSel = document.getElementById("ddType");
    for (var xc=0; xc < arrtxt.length; xc++)
    {
	theSel.options[theSel.length] = new Option(arrtxt[xc],arrtxt[xc]);
    }
    document.getElementById("divWait").innerHTML="";
  } 
} 

function make_list() 
{ 
  if (xmlHttp_list.readyState==4 || xmlHttp_list.readyState=="complete")
  { 
  document.getElementById("divWait").innerHTML=xmlHttp_list.responseText  
  } 
} 

function setMute() 
{ 
  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
  { 
  document.getElementById("txtHint").innerHTML=xmlHttp.responseText 
  } 
} 

function stateChanged() 
{ 
  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
  { 
    document.getElementById("txtHint").innerHTML=xmlHttp.responseText 
  } 
} 

function GetXmlHttpObject(handler)
{ 
  var objXmlHttp=null

  if (navigator.userAgent.indexOf("Opera")>=0)
  {
  // ======================== Opera Area =====================
  //alert("This thing doesn't work in Opera")
  //return

  objXmlHttp=new XMLHttpRequest()
  objXmlHttp.onload=handler
  objXmlHttp.onerror=handler 
  return objXmlHttp

  // =========================================================
  }
    if (navigator.userAgent.indexOf("MSIE")>=0)
    { 
      var strName="Msxml2.XMLHTTP"
      if (navigator.appVersion.indexOf("MSIE 6.0")>=0)
    {
    strName="Microsoft.XMLHTTP"
  } 
    try
    { 
      objXmlHttp=new ActiveXObject(strName)
      objXmlHttp.onreadystatechange=handler 
      return objXmlHttp
    } 
    catch(e)
    { 
      alert("Error. Your browser not support XMLHttpRequest or Scripting for ActiveX might be disabled! Pease use the latest browser.") 
      return 
    } 
  } 
  if (navigator.userAgent.indexOf("Mozilla")>=0)
  {
  objXmlHttp=new XMLHttpRequest()
  objXmlHttp.onload=handler
  objXmlHttp.onerror=handler 
  return objXmlHttp
  }
} 