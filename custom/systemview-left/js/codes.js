// SATU Codes Repository , last updated on March 16, 2007

function addEvent( obj, type, fn ) {
	if ( obj.attachEvent ) {
		obj['e'+type+fn] = fn;
        obj[type+fn] = function(){obj['e'+type+fn]( window.event );}
        obj.attachEvent( 'on'+type, obj[type+fn] );
	} else
        obj.addEventListener( type, fn, false );
}

function removeEvent( obj, type, fn ) {
	if ( obj.detachEvent ) {
		obj.detachEvent( 'on'+type, obj[type+fn] );
		obj[type+fn] = null;
	} else
       obj.removeEventListener( type, fn, false );
}

function reform_date(nvidia){
	if (nvidia=="#"){return '-'};
	var nmonth	
	var mikado = new Date(nvidia)
	var month = mikado.getMonth() + 1
	var day = mikado.getDate()
	var year = mikado.getFullYear()
	var hour = mikado.getHours()
	var minute = mikado.getMinutes()
	var AMPM;
	
		switch(month)
		{
		case 1:
			nmonth = 'January'
			break;
		case 2:
			nmonth = 'February'
			break;
		case 3:
			nmonth = 'March'
			break;
		case 4:
			nmonth = 'April'
			break;
		case 5:
			nmonth = 'May'
			break;
		case 6:
			nmonth = 'June'
			break;
		case 7:
			nmonth = 'July'
			break;
		case 8:
			nmonth = 'August'
			break;
		case 9:
			nmonth = 'September'
			break;
		case 10:
			nmonth = 'October'
			break;
		case 11:
			nmonth = 'November'
			break;
		case 12:
			nmonth = 'December'
			break;
		}
		
		if ((hour>=0)&&(hour<=11)){ // 12AM
			AMPM = "AM";
		}
		if ((hour>=12)&&(hour<=23)){ // 8AM
			AMPM = "PM";
		}
		
		if (minute<10){
			minute = "0" + minute;
		}		
		
	return day+ " " + nmonth + " " + year + " " + hour + ":" + minute + " " + AMPM;
}  

function r(k){//round
	return Math.round(k*100)/100;
}
  
function load_firstDate(){
	var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate()
	var year = currentTime.getFullYear()	
	document.getElementById('SelectDate').innerHTML = month + "/" + day + "/" + year;
}
  
function rotate_report(opt)
{	
	var dame = document.getElementById('report_type').innerHTML;
		switch(dame)
		{
		case 'Daily':
			if (opt > 0){
				dame = 'Weekly';
			}else{
				dame = 'Monthly';
			}
			break;
		case 'Weekly':
			if (opt > 0){
				dame = 'Monthly';
			}else{
				dame = 'Daily';
			}
			break;
		case 'Monthly':
			if (opt > 0){
				dame = 'Daily';
			}else{
				dame = 'Weekly';
			}
			break;
		default:
			{ 		
			dame = 'ERROR!';
			return;
			}
		}
	document.getElementById('report_type').innerHTML = dame;
}
  
function select_report()
{	
	var dame = document.getElementById('report_type').innerHTML;	
		switch(dame)
		{
		case 'Daily':
			return 1;
			break;
		case 'Weekly':
			return 2;
			break;
		case 'Monthly':
			return 3;
			break;
		default:
			{			
			return;
			}
		}	
}
  
function submission(url)
{
  url = url + "?sid" + Math.random();
  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<IFRAME id="frTest" name="frTest" style="width:100px;height:100px;position:absolute;top:0;left:0;display:inline;" frameborder=0 scrolling=yes marginwidth=0 src="' + url + '" marginheight=0></iframe>');  
  document.getElementById('frTest').style.width=lebar;
  document.getElementById('frTest').style.height=tinggi;
  sv_element('loading_text','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Loading...');  
  eval("document.getElementById('xloading').style.visibility='visible';");
}
  
function print_the_frame(){ // Predefined function
	var hyaku = document.getElementById('trends').innerHTML;
	if (hyaku.length>1){
		window.parent.frTest.focus();
		window.print();
	}	
}
  
function checking_field(id){
	var dame = document.getElementById(id).innerHTML;
	if (dame == ''){
		return 0;
	}else{
		return 1;
	}
}
  
function sv_element(id,value){ // changing divs element innerHTML value
	eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
}
  
function ShowCalendar(strTargetDateField, intLeft, intTop)
{
    txtTargetDateField = strTargetDateField;
    document.getElementById('divTWCalendar').style.visibility = 'visible';
    document.getElementById('divTWCalendar').style.left = intLeft;
    document.getElementById('divTWCalendar').style.top = intTop;
}
  
function resizing_trends(_object)
{
	var winW = get_size('width');
	var winH = get_size('height');
	document.getElementById(_object).style.width=winW-18;
	document.getElementById(_object).style.height=winH-55;	
	document.getElementById(_object).style.left=8;	
	
	var xLeft = document.getElementById(_object).offsetLeft;
	reposition_menu('chromemenu',winW-18,xLeft);
	if(document.getElementById('frtest')!=null){
		resizing_frem('frtest',winW-20,winH-47) // 2more
	}
}
  
function resizing_frem(_object,_w,_h)
{
  	document.getElementById(_object).style.width=_w;
	document.getElementById(_object).style.height=_h;
}
  
function reposition_obj(_object)
{
	var winW = get_size('width');
	var winH = get_size('height');
	var objW = document.getElementById(_object).offsetWidth;
	var objH = document.getElementById(_object).offsetHeight;
	document.getElementById(_object).style.left=(winW/2)-(objW/2);
	document.getElementById(_object).style.top=(winH/2)-(objH/2);	
}
  
function reposition_menu(_object,_width,_left)
{
	document.getElementById(_object).style.left=_left;
	document.getElementById(_object).style.width=_width;	
}
  
function get_size(para)
{
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
	if (navigator.userAgent.indexOf("Opera")>=0)
	{
	winW = document.body.offsetWidth;
	winH = document.body.offsetHeight;
	}
	if (para=='height'){
		return winH;
	}else{
		return winW;
	}
}
  
function GetXmlHttpObject(handler)
{ 
  var objXmlHttp=null;

  if (navigator.userAgent.indexOf("Opera")>=0)
  {
  // ======================== Opera Area =====================

  objXmlHttp=new XMLHttpRequest();
  objXmlHttp.onload=handler;
  objXmlHttp.onerror=handler; 
  return objXmlHttp;

  // =========================================================
  }
    if (navigator.userAgent.indexOf("MSIE")>=0)
    { 
      var strName="Msxml2.XMLHTTP";
      if (navigator.appVersion.indexOf("MSIE 6.0")>=0)
    {
    strName="Microsoft.XMLHTTP";
  } 
    try
    { 
      objXmlHttp=new ActiveXObject(strName);
      objXmlHttp.onreadystatechange=handler;
      return objXmlHttp;
    } 
    catch(e)
    { 
      alert("Error. Your browser not support XMLHttpRequest or Scripting for ActiveX might be disabled! Please use the latest browser.");
      return;
    } 
  } 
  if (navigator.userAgent.indexOf("Mozilla")>=0)
  {
  objXmlHttp=new XMLHttpRequest();
  objXmlHttp.onload=handler;
  objXmlHttp.onerror=handler; 
  return objXmlHttp;
  }
}
  
function gettingpath() // example url.js functions
{
	var url=new URL('http://joe:pwd@server/ix.html?arg=value#ref');
	alert('url:'+url.toString());
	alert('port:'+url.getPort());
	alert('query:'+url.getQuery());
	alert('protocol:'+url.getProtocol());
	alert('host:'+url.getHost());
	alert('user:'+url.getUserName());
	alert('password:'+url.getPassword());
	alert('port:'+url.getPort());
	alert('file:'+url.getFile());
	alert('reference:'+url.getReference());
	alert('path:'+url.getPath());
	alert('argumentvalue:'+url.getArgumentValue('arg'));
	alert('all arguments:'+url.getArgumentValues());
}

function getFrameURL(victim){	
	return window.parent.frTest.get_me();
}

function CloseMe()
{
    test.close();
}
  
function save2excel()
{ 
  	var hyaku = document.getElementById('trends').innerHTML;
	if (hyaku.length>1){
		var kk = getFrameURL('frtest');
		var destination = new URL(kk);	
		destination = destination.getPath();	
		// refine destination filename
		destination = destination.split("\/");
		destination = destination[destination.length-1];
		destination = destination.replace('aspx','xls');
		document.getElementById("_excel").src = kk + "&ekspot=yes&wtf=" + destination;
		setTimeout('document.getElementById("_excel").src = "about:blank";',20000);
	}
}
  
function displaysistem(selectedDistrict)
{	
	var t_trends = document.getElementById('trends').offsetHeight-2;
	var l_trends = document.getElementById('trends').offsetWidth-2;
	switch(selectedDistrict)
	{
	case 'Dungun':
		sv_element('xsystem_display_title',selectedDistrict);
		sv_element('xsystem_display_content','Sistem Pembekalan Air Dungun');
		//document.getElementById('xsystem_display').style.visibility = 'visible';
		//document.getElementById('trends').style.background = '#1C61AD';
		//sv_element('trends','<embed width="' + l_trends + '" height="' + t_trends + '" src="Dungun.svgz">');
		submission('mimics/Dungun/Dungun.aspx');
		break;
	default:
		{
		return;
		}
	}
}
  
function get_siteselection()
{

var url ="siteselect.aspx?sid" + Math.random();
//var tinggi = document.getElementById('side_content').offsetHeight - 2;
//var lebar = document.getElementById('side_content').offsetWidth - 2;
//sv_element('side_content','<IFRAME id="frTest" name="frTest" style="width:100px;height:100px;position:absolute;top:0;left:0;display:inline;" frameborder=0 scrolling=yes marginwidth=0 src="' + url + '" marginheight=0></iframe>');  
//document.getElementById('frTest').style.width=lebar;
//document.getElementById('frTest').style.height=tinggi;
document.getElementById('side_content').src=url;
sv_element('loading_text','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Loading...');  
//eval("document.getElementById('xloading').style.visibility='visible';");
}

function showList(dist,typ)
{ 
  var url="ajx/siteleft.aspx?sid=" + Math.random() + "&ddDistrict=" + dist + "&ddType=" + typ + "&choice=list"
  xmlHttp=GetXmlHttpObject(make_list)
  xmlHttp.open("GET", url , true)
  xmlHttp.send(null)
}

function make_list() 
{ 
  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
  { 
  document.getElementById("side_list").innerHTML=xmlHttp.responseText   
  } 
} 

function show_search(str)
{ 
  var url="ajx/sitesearch.aspx?sid=" + Math.random() + "&mystr=" + str + "&choice=list"
  xmlHttp=GetXmlHttpObject(search_list)
  xmlHttp.open("GET", url , true)
  xmlHttp.send(null)
}

function search_list() 
{ 
  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
  { 
  document.getElementById("side_list").innerHTML=xmlHttp.responseText
  } 
} 

function showKey(e) {
  alert("You pressed: " + String.fromCharCode(e.which) + ".");
}

function toggle_this(x){
	if (x=="show"){
		reposition_menu('side_island',350,menu_show);
		reposition_menu('side_sdw',360,menu_show + "px");
	}else{
		reposition_menu('side_island',350,menu_hide);
		reposition_menu('side_sdw',360,menu_hide + "px");
	}	
}