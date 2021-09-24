<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim strDistrict
    Dim strSelectedDistrict
    Dim strType
    Dim strSelectedType
    Dim strSiteName
    Dim intSiteID
    Dim intUnitID
    Dim intNum
    Dim strError
    Dim strErrorColor

    Dim i
    Dim strControlDistrict
   
    Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1) Then
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
            Else
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
    End If

    'strSelectedDistrict = Request.Form("ddDistrict")
    'strSelectedType = Request.Form("ddType")
   
    'If strSelectedDistrict = "" Then
    '    strSelectedDistrict = "0"
    'End If
   
    'If strSelectedType = "" Then
    '    strSelectedType = "0"
    'End If

    strError = Request.Form("txtError")
    strErrorColor = Request.Form("txtErrorColor")
   
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
   
%>
<html>
<head>
    <style type="text/css">
.bodytxt 
  {
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  } 
  
.FormDropdown 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 158px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }
  
a { text-decoration: none;}

div#divWait
  {
  font-family:Verdana; font-size:8pt; color:red;
  vertical-align:middle;
  }

.divStyle 
  {
  border-width:1px;
  overflow:hidden;
  font-family: Verdana; 
  font-size: 8pt;
  font-weight: bold;
  color: red;
  }
 
div#txtHint
  {
  border-width:1px;
  overflow:hidden;
  font-family: Verdana; 
  font-size: 8pt;
  font-weight: bold;
  color: red;
  }
div#resizer
  {
  position:absolute;
  /*background:#AAB9FD;*/
  vertical-align:text-top;
  top:2px;
  left:0px;
  width:6px;
  height:10px;
  z-index:2;
  border-width:0px;
  font-family: Verdana; 
  font-size: 9px;
  font-weight: bold;
  color: #AAB9FD;
  }
img#black_arrow
  {
  cursor:pointer;
  }
</style>

    <script language="JavaScript" src="ajx/get_left.js"></script>

</head>
<body topmargin="5" leftmargin="5" onload="alertframe5();">
    <div id="resizer" align="right">
        minimize left &nbsp;<img id="black_arrow" onclick="resize_mainframe()" src="images/leftwhite.gif"
            border="0"></div>
    <form name="frmSite" method="post" action="UpdateVehicle.aspx">
        <input type="hidden" name="txtUserID" value="">
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="100%" height="60">
                        <p align="center">
                            <img border="0" src="images/SiteSelection.jpg" align="left"></p>
                    </td>
                </tr>
            </table>
        </div>
        <div align="left" id="divWait" style="margin-left: 0;">
        </div>
        <br />
        <br />
        <div id="txtHint">
            Alerts :
        </div>
        <div style="margin-left: 0px; overflow: auto; overflow-x: hidden;">
            <iframe id="alertframe" width="200" height="250" marginheight="0" marginwidth="0"
                scrolling="auto" style="margin-left: 0;" frameborder="0"></iframe>
        </div>
    </form>
</body>
</html>

<script language="javascript">
function MelakashowList(dist,typ)
{ 
  var url="ajx/Melakaleft.aspx?sid=" + Math.random() + "&ddDistrict=" + dist + "&ddType=" + typ + "&choice=list"
  xmlHttp=GetXmlHttpObject(make_list)
  xmlHttp.open("GET", url , true)
  xmlHttp.send(null)
}

function make_list() 
{ 
  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
  { 
  document.getElementById("divWait").innerHTML=xmlHttp.responseText 
  //alert(xmlHttp.responseText);
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

  //document.frmSite.ddDistrict.value='<%=strSelectedDistrict%>';
  //document.frmSite.ddType.value='<%=strSelectedType%>';
  
//  function kosek_ddType()
//  {
//	if(document.getElementById('ddType').selectedIndex != 0){
//	document.getElementById("divWait").innerHTML='<img border="0" src="images/loading.gif"><b>Loading...</b>';
//	var dist = document.getElementById('ddDistrict').value;
//	var typ = document.getElementById('ddType').value;	
//	showList(dist,typ);
//	if (typ=="WTP")
//    {
//    var url="SiteSummarywtp.aspx?district=" + dist + "&Type="+ typ ;
//    window.parent.document.getElementById('main').src=url;
//    }
//	if (typ=="F1 FLOWMETER")
//	{
//	   var url="SiteSummaryflow.aspx?district=" + dist + "&Type="+ typ ;
//       window.parent.document.getElementById('main').src=url; 
//	}
//	if (typ=="F2 FLOWMETER")
//	{
//	   var url="SiteSummaryflow2.aspx?district=" + dist + "&Type="+ typ ;
//       window.parent.document.getElementById('main').src=url; 
//	}
//	if (typ=="BPH")
//	{
//	   var url="SiteSummarybph.aspx?district=" + dist + "&Type="+ typ ;
//       window.parent.document.getElementById('main').src=url; 
//	}
//	if (typ=="RESERVOIR")
//	{
//	    var url="SiteSummary.aspx?district=" + dist + "&Type="+ typ;
//        window.parent.document.getElementById('main').src=url; 
//	}
//	}
//	else{
//	document.getElementById("divWait").innerHTML="";
//	}
//  }

 
  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>

<script>
var frameLeft = ''
var widthomine
  function resize_mainframe()
  { 
    if (frameLeft==''){
		frameLeft='scrolled';
		document.getElementById('resizer').style.width=6;
		document.getElementById('resizer').style.background='white';
		document.getElementById('resizer').innerHTML='<img id="black_arrow" onclick="resize_mainframe()" src="images/rightwhite.gif" border="0">';
		//remember_ddType = document.getElementById('ddType').selectedIndex;
		remember_divWait = document.getElementById('divWait').innerHTML;
		//document.getElementById('ddType').selectedIndex = 0;		
		document.getElementById('divWait').innerHTML='';		
		window.parent.kk('min');
    }else{
		frameLeft='';
		document.getElementById('resizer').style.width=widthomine;		
		document.getElementById('resizer').innerHTML='minimize left &nbsp;<img id="black_arrow" onclick="resize_mainframe()" src="images/leftwhite.gif" border="0">';
		//document.getElementById('ddType').selectedIndex = remember_ddType;		
		document.getElementById('divWait').innerHTML = remember_divWait;		
		window.parent.kk('max');
    }
  }

var winW = 630, winH = 460;

if (parseInt(navigator.appVersion)>3) {
 if (navigator.appName=="Netscape") {
  winW = window.innerWidth;
  winH = window.innerHeight;
 }
 if (navigator.appName.indexOf("Microsoft")!=-1) {
  winW = document.body.offsetWidth;
  winH = document.body.offsetHeight;
 }
}

if (parseInt(navigator.appVersion)>3) {
 if (navigator.appName=="Netscape") {
  winW = window.innerWidth-16;
  winH = window.innerHeight-16;
 }
 if (navigator.appName.indexOf("Microsoft")!=-1) {
  winW = document.body.offsetWidth-20;
  winH = document.body.offsetHeight-20;
 }
}

if (navigator.userAgent.indexOf("Opera")>=0)
{
  winW = document.body.offsetWidth;
  winH = document.body.offsetHeight;
}

widthomine = winW;
document.getElementById('resizer').style.width=widthomine;

function alertframe5()
{
   MelakashowList('Besut','type');
   applying();
   set1();
}

function set1()
{
  
 var refreshInterval =2;
  refreshInterval = refreshInterval * 60000; 
  setTimeout('alertframe5()', refreshInterval);
  
}

function applying()
{
     document.getElementById('alertframe').src="Melakaalert1.aspx"
}
</script>

