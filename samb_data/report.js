  // JPS Report Events
  
  function r(k){//round
	return Math.round(k*100)/100;
  }
  
  function rotate_report(opt)
  {	
	var dame = document.getElementById('report_type').innerHTML;	
		switch(dame)
		{
		case '12:00AM-8:00AM':
			if (opt > 0){
				dame = '8:00AM-4:00PM';
			}else{
				dame = '4:00PM-12:00AM';
			}
			break;
		case '8:00AM-4:00PM':
			if (opt > 0){
				dame = '4:00PM-12:00AM';
			}else{
				dame = '12:00AM-8:00AM';
			}
			break;
		case '4:00PM-12:00AM':
			if (opt > 0){
				dame = '12:00AM-8:00AM';
			}else{
				dame = '8:00AM-4:00PM';
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
	return document.getElementById('time').value;

  }
  
  function submission()
  {
  if(checking_field('SelectDate')==0){alert('Please select date.');return false;}
  var dist=document.getElementById('DropDownList1').value;
  var dame = document.getElementById('SelectDate').innerHTML;
  var table = select_report();
  var hr=document.getElementById('time').value;
  var min=document.getElementById('Min').value;
  var url="datatable_main.aspx?sid=" + r(Math.random()) + "&table=" + table + "&start=" + dame+ "&dist="+ dist+ "&time="+ hr+ "&Min="+min;  

  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<div id="preload" style="position:absolute;left:8px;top:8px;background-color:transparent;"></div><IFRAME id="frTest" name="frTest" style="width:100px;height:100px;position:absolute;top:0;left:0;display:inline;" frameborder=0 scrolling=yes marginwidth=0 src="about:blank" marginheight=0></iframe>');
  document.getElementById('frTest').src=url;
  document.getElementById('frTest').style.width=lebar;
  document.getElementById('frTest').style.height=tinggi;
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
	document.getElementById(_object).style.width=winW-20;
	document.getElementById(_object).style.height=winH-50;
	document.getElementById(_object).style.left=10;
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
		//alert(destination)
		// refine destination filename
		destination = destination.split("\/");
		destination = destination[destination.length-1];
		destination = destination.replace('aspx','xls');
		document.getElementById("_excel").src = kk + "&ekspot=yes&wtf=" + destination;
		setTimeout('document.getElementById("_excel").src = "about:blank";',20000);
	}
  }
  
  function query_string_adaptor(freak)
  {
	freak = freak.replace(' ','%20');
	freak = freak.replace('','%20');
  }