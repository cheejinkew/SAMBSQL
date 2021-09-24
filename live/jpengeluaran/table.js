// Modified For SAMB (Jabatan Pengeluaran) LIVE, May 30 2007
var pre_exclude = 2;
var r_interval = 60000;
var timingu;
var flag1=false;
var flag2=false;
var flag3=false;
  
function r(k){//round
	return Math.round(k*100)/100;
}

function load_firstDate(){
	var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate()
	var year = currentTime.getFullYear()	
	document.getElementById('SelectDate').innerHTML = month + "/" + day + "/" + year;
	showdate();
}

function showdate(){
	var nmonth
	var mikado = document.getElementById('SelectDate').innerHTML;	
	mikado = new Date(mikado)
	var month = mikado.getMonth() + 1
	var day = mikado.getDate()
	var year = mikado.getFullYear()	
	
	var dame = document.getElementById('report_type').innerHTML;
	if (dame=='Status'){		
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
		document.getElementById('ShowedDate').innerHTML = day+ " " + nmonth + " " + year;
	}else{
		document.getElementById('ShowedDate').innerHTML = year;
	}
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
	return day+ " " + nmonth + " " + year + " " + hour + ":" + minute + " " + AMPM;
}  
  
function rotate_report(opt)
{	
	var dame = document.getElementById('report_type').innerHTML;
		switch(dame)
		{
		case 'Status':
			if (opt > 0){
				dame = 'Log';
			}else{
				dame = 'Log';
			}
			break;
		case 'Log':
			if (opt > 0){
				dame = 'Status';
			}else{
				dame = 'Status';
			}
			break;
		default:
			{ 		
			dame = 'ERROR!';
			return;
			}
		}
	document.getElementById('report_type').innerHTML = dame;
	showdate();
}

function rotate_district(opt)
{	
	var dame = document.getElementById('district').innerHTML;	
		switch(dame)
		{
		case 'All':
			if (opt > 0){
				dame = 'Melaka Tengah';
			}else{
				dame = 'Jasin';
			}
			break;
		case 'Melaka Tengah':
			if (opt > 0){
				dame = 'Alor Gajah';
			}else{
				dame = 'All';
			}
			break;
		case 'Alor Gajah':
			if (opt > 0){
				dame = 'Jasin';
			}else{
				dame = 'Melaka Tengah';
			}
			break;
		case 'Jasin':
			if (opt > 0){
				dame = 'All';
			}else{
				dame = 'Alor Gajah';
			}
			break;
		default:
			{ 		
			if (opt > 0){
				dame = 'All';
			}else{
				dame = 'Jasin';
			}
			}
		}
	document.getElementById('district').innerHTML = dame;
}
  
function select_report()
{	
	var dame = document.getElementById('report_type').innerHTML;	
		switch(dame)
		{
		case 'Status':
			return 1;
			break;
		case 'Log':
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
  
function submission()
{
  stopTimer();// Stop AJAX Fetch
  flag1=false;// Reset Flags
  flag2=false;
  flag3=false;
  if(checking_field('SelectDate')==0){alert('Please select date.');return false;}
  timingu = checking_time();
  var dame = document.getElementById('SelectDate').innerHTML;
  var domo = document.getElementById('district').innerHTML;  
  var table = select_report();
  var url="datatable_jp.aspx?sid=" + Math.random() + "&uid=" + uid + "&table=" + table + "&start=" + dame + "&dist=" + domo + "&p=" + timingu;

  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<IFRAME id="frTest" name="frTest" style="width:100px;height:100px;position:absolute;top:0;left:0;display:inline;" frameborder=0 scrolling=yes marginwidth=0 src="' + url + '" marginheight=0></iframe>'); 
  document.getElementById('frTest').style.width=lebar;
  document.getElementById('frTest').style.height=tinggi;
  
  eval("document.getElementById('loading_text').innerHTML='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Creating table...';");
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

function checking_time(){
  	var currentTime = new Date()
	var hour = currentTime.getHours()
	if ((hour>=0)&&(hour<=7)){ // 12AM
		return 1;
	}
	if ((hour>=8)&&(hour<=15)){ // 8AM
		return 2;
	}
	if ((hour>=16)&&(hour<=23)){ // 4PM
		return 3;
	}	
}

function change2bit(x){
	if (x==true){
		return 1;
	}else{
		return 0;
	}
}
  
function sv_element(id,value){ // changing divs element innerHTML value
	eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
}
 
function sv_element2(frem,id,value){ // changing divs element innerHTML value in another document	
	eval("window.parent." + frem + ".document.getElementById('" + id + "').innerHTML='" + value + "'");
}

function sa_element2(frem,id,att,value){
	eval("window.parent." + frem + ".document.getElementById('" + id + "')." + att + "='" + value + "'");
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
	
	if(document.getElementById('frtest')!=null){
		resizing_frem('frtest',winW-23,winH-52) // 2more
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
////////////////////////////// Data Fetch ////////////////////////////
function startTimer() {
	running = true;
	fetch_datatable()
}

function stopTimer() {
	if (requesting){
		xmlHttpfeed_1.abort();
	}
	clearTimeout(the_fetch);
	running = false;
}

function fetch_datatable()
{	var domo,url;
	timingu = checking_time();
	switch(feed_select())
	{	
	case 'xml':
		r_interval = 60000;
		domo = document.getElementById('district').innerHTML;
		url="tablefeed.aspx?p=" + timingu + "&c=xml&d=" + domo + "&uid=" + uid + "&sid=" + Math.random();
		requesting = true;
		xmlHttpfeed_1=GetXmlHttpObject(Change_datatable);
		xmlHttpfeed_1.open("GET", url , true);
		xmlHttpfeed_1.send(null);		
		break;
	case 'xml_all':
		r_interval = 60000;
		domo = document.getElementById('district').innerHTML;
		url="tablefeed.aspx?p=" + timingu + "&c=xml_all&d=" + domo + "&uid=" + uid + "&sid=" + Math.random();
		requesting = true;
		xmlHttpfeed_1=GetXmlHttpObject(Change_datatable);
		xmlHttpfeed_1.open("GET", url , true);
		xmlHttpfeed_1.send(null);
		break;
	case 'no':
		r_interval = 120000;
		break;
	default:
		{
		submission();
		return false;
		}
	}
	eval("document.getElementById('loading_text').innerHTML='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Retrieving data...';");
	eval("document.getElementById('xloading').style.visibility='visible';");
	if (running){
	the_fetch = setTimeout('fetch_datatable()', r_interval);
	}
}

function test_test()
{	
	var test_string = "";
	var tbl_count = window.parent.frTest.document.getElementsByTagName("table").length;
	for(var i=0;i<tbl_count;i++){
		var table_id = window.parent.frTest.document.getElementsByTagName("table")[i].getAttribute("id");
		var brp_row = window.parent.frTest.document.getElementsByTagName("table")[i].getElementsByTagName("tr").length - pre_exclude;
		test_string = test_string + "table " + table_id;
		test_string = test_string + " = " + brp_row + "<br>";
		
		mark_unmark(table_id + '_pg','tdc',brp_row);
		mark_unmark(table_id + '_ptg','tdc_incoming',brp_row);
		mark_unmark(table_id + '_mlm','tdc_incoming',brp_row);		
	}
	window.parent.frTest.document.getElementById('test').innerHTML=test_string;
}

function put_datas(_obj,_str)
{	
	var test_string = "";
	var tbl_count = window.parent.frTest.document.getElementsByTagName("table").length;
	for(var i=0;i<tbl_count;i++){
		var table_id = window.parent.frTest.document.getElementsByTagName("table")[i].getAttribute("id");
		var brp_row = window.parent.frTest.document.getElementsByTagName("table")[i].getElementsByTagName("tr").length - pre_exclude;
		for(var j=0;j<brp_row;j++){
			var siteid = table_id + '_siteid' + (j+1);
			var s = eval("window.parent.frTest.document.getElementById('" + siteid + "').innerHTML;");
			var timestamp = get_values(_str,"id",s,"time");
			sv_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),get_values(_str,"id",s,"value"));
			sa_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),'title',reform_date(timestamp));
			sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'title',reform_date(timestamp));

			if (compare_timestamp(timestamp)=='N'){
				eval("flag" + timingu + "=false");
				sa_element2('frTest',table_id + '_siteid' + (j+1),'style.color','gray');
				sa_element2('frTest',table_id + '_sitename' + (j+1),'style.color','gray');
				sa_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),'style.color','gray');
				sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'style.color','gray');
				sv_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),'-');
				sv_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'-');
			}else{
				eval("flag" + timingu + "=true");
				sa_element2('frTest',table_id + '_siteid' + (j+1),'style.color','black');
				sa_element2('frTest',table_id + '_sitename' + (j+1),'style.color','black');
				sa_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),'style.color','black');				
			}

			var _stat = get_values(_str,"id",s,"textContent");
			_stat = _stat.split(",");
			
			if (_stat[0]!=undefined){
				if(_stat[0]=="NN"){					
					sa_element2('frTest',table_id + '_siteid' + (j+1),'style.fontWeight','normal');
					sa_element2('frTest',table_id + '_sitename' + (j+1),'style.fontWeight','normal');
					sa_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),'style.fontWeight','normal');
					sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'style.fontWeight','normal');
				}else{
					sa_element2('frTest',table_id + '_siteid' + (j+1),'style.fontWeight','bold');
					sa_element2('frTest',table_id + '_sitename' + (j+1),'style.fontWeight','bold');
					sa_element2('frTest',table_id + '_' + _obj + '_value' + (j+1),'style.fontWeight','bold');
					sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'style.fontWeight','bold');
				}			
				sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'innerHTML',_stat[0]);
			}
			if (_stat[1]==undefined){				
				sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'style.color','#000000');
			}else{				
				sa_element2('frTest',table_id + '_' + _obj + '_status' + (j+1),'style.color','#' + _stat[1]);
			}
		}
	}
	sv_element('loading_text','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DONE!');	
}

function get_values(_obj,_att,_number,_data){	
	for(var i=0;i<_obj.length;i++){
		if (_obj[i].getAttribute(_att) == _number)
		{
			if (_data=='textContent'){			
				if (navigator.userAgent.indexOf("Opera")>=0)
				{				
					return _obj[i].textContent;
				}
				if (navigator.userAgent.indexOf("MSIE")>=0)
				{ 
					return _obj[i].firstChild.text;
				} 
				if (navigator.userAgent.indexOf("Mozilla")>=0)
				{				
					return _obj[i].textContent;
				}
				break;
			}else{
				return _obj[i].getAttribute(_data);
			}
		}
	}
	return;
}

function Change_datatable()
{	var overall = false;
	if (xmlHttpfeed_1.readyState==4 || xmlHttpfeed_1.readyState=="complete")
	{
	requesting = false;	
	var total_feed = xmlHttpfeed_1.responseXML.documentElement;	
	
	if (total_feed.hasChildNodes()){
		var arr_data = total_feed.childNodes;		
		if (total_feed.getAttribute("feed")=="ALL"){
			overall = true;
		}else{
			overall = false;			
		}		
	} 
/* 
var test_string = "";
test_string = total_feed.getElementsByTagName("period").length;
	for(var i=0;i<test_string;i++){
		//var berbas = total_feed.getElementsByTagName("period")[i].getAttribute("no");
		//put_datas('pg',total_feed.getElementsByTagName("period")[i].getElementsByTagName("site"));
	}

return;	*/
	
	switch(timingu)
	{
	case 1:		
		highlight_incoming('mlm');
		if (overall==true){
			put_datas('pg',total_feed.getElementsByTagName("period")[1].getElementsByTagName("site"));
			put_datas('ptg',total_feed.getElementsByTagName("period")[2].getElementsByTagName("site"));
			put_datas('mlm',total_feed.getElementsByTagName("period")[0].getElementsByTagName("site"));
		}else{
			flag2=true;
			flag3=true;
			put_datas('mlm',total_feed.getElementsByTagName("period")[0].getElementsByTagName("site"));
		}
		break;
	case 2:
		highlight_incoming('pg');
		if (overall==true){
			put_datas('pg',total_feed.getElementsByTagName("period")[0].getElementsByTagName("site"));
		}else{
			put_datas('pg',total_feed.getElementsByTagName("period")[0].getElementsByTagName("site"));
		}		
		break;
	case 3:		
		highlight_incoming('ptg');
		if (overall==true){
			put_datas('pg',total_feed.getElementsByTagName("period")[0].getElementsByTagName("site"));
			put_datas('ptg',total_feed.getElementsByTagName("period")[1].getElementsByTagName("site"));
		}else{
			flag2=true;
			put_datas('ptg',total_feed.getElementsByTagName("period")[0].getElementsByTagName("site"));
		}		
		break;
	default:
		{			
		return false;
		}
	}	
	eval("document.getElementById('xloading').style.visibility='hidden';");
	load_firstDate();
	} 
}

function put_in(_obj,_str) // Original put_data() function
{	var arrdata = _str.split("|");
	var sitedata;
	var maksima;	
	maksima = arrdata[arrdata.length - 1];
	for (var x = 1; x <= maksima; x++)
    {
		sitedata = arrdata[x-1].split(",");
		
		if (sitedata[1]!=undefined){
			eval("window.parent.frTest.document.getElementById(_obj + '_value' + x).title='" + reform_date(sitedata[1]) + "';");
			eval("window.parent.frTest.document.getElementById(_obj + '_status' + x).title='" + reform_date(sitedata[1]) + "';");
		}
		if (sitedata[2]!=undefined){
			window.parent.frTest.document.getElementById(_obj + '_value' + x).innerHTML=sitedata[2];
		}
		if (sitedata[3]!=undefined){
			window.parent.frTest.document.getElementById(_obj + '_status' + x).innerHTML=sitedata[3];			
		}
		if (sitedata[4]==undefined){
			window.parent.frTest.document.getElementById(_obj + '_status' + x).style.color='#000000';			
		}else{
			window.parent.frTest.document.getElementById(_obj + '_status' + x).style.color='#' + sitedata[4];
		}
		if (compare_timestamp(sitedata[1])=='N'){
			eval("flag" + timingu + "=false");
			eval("window.parent.frTest.document.getElementById('siteid" + x + "').style.color='gray';");
			eval("window.parent.frTest.document.getElementById('sitename" + x + "').style.color='gray';");			
			eval("window.parent.frTest.document.getElementById('" + _obj + "_value" + x + "').style.color='gray';");
			eval("window.parent.frTest.document.getElementById('" + _obj + "_status" + x + "').style.color='gray';");
			eval("window.parent.frTest.document.getElementById('" + _obj + "_value" + x + "').innerHTML='-';");
			eval("window.parent.frTest.document.getElementById('" + _obj + "_status" + x + "').innerHTML='-';");
		}else{
			eval("flag" + timingu + "=true");
			eval("window.parent.frTest.document.getElementById('siteid" + x + "').style.color='black';");
			eval("window.parent.frTest.document.getElementById('sitename" + x + "').style.color='black';");			
			eval("window.parent.frTest.document.getElementById('" + _obj + "_value" + x + "').style.color='black';");
		}
		if(sitedata[3]=="NN"){
			eval("window.parent.frTest.document.getElementById('siteid" + x + "').style.fontWeight='normal';");
			eval("window.parent.frTest.document.getElementById('sitename" + x + "').style.fontWeight='normal';");			
			eval("window.parent.frTest.document.getElementById('" + _obj + "_value" + x + "').style.fontWeight='normal';");
			eval("window.parent.frTest.document.getElementById('" + _obj + "_status" + x + "').style.fontWeight='normal';");
		}else{
			eval("window.parent.frTest.document.getElementById('siteid" + x + "').style.fontWeight='bold';");
			eval("window.parent.frTest.document.getElementById('sitename" + x + "').style.fontWeight='bold';");			
			eval("window.parent.frTest.document.getElementById('" + _obj + "_value" + x + "').style.fontWeight='bold';");
			eval("window.parent.frTest.document.getElementById('" + _obj + "_status" + x + "').style.fontWeight='bold';");
		}
	}		
}

function compare_timestamp(tbcompd)
{
	if (tbcompd=="#"){return 'N'};
	timingu = checking_time();
	var dame = document.getElementById('SelectDate').innerHTML;
	tbcompd = new Date(tbcompd);
	var month = tbcompd.getMonth() + 1;
	var day = tbcompd.getDate(); // Last Night
	var year = tbcompd.getFullYear();	
	
	if (timingu==1){
		dame =  new Date(dame);
		var month2 = dame.getMonth() + 1;
		var day2 = dame.getDate() - 1; // Last Night
		var year2 = dame.getFullYear();	
		if (month2 + "/" + day2 + "/" + year2 == month + "/" + day + "/" + year){
			return 'Y';
		}else{
			return 'N';
		}
	}else{	
		if (dame == month + "/" + day + "/" + year){
			return 'Y';
		}else{
			return 'N';
		}
	}
}

function feed_select()
{	var combination = change2bit(flag1) + '|' + change2bit(flag2) + '|' + change2bit(flag3);
	switch(timingu)
	{
	case 1:		
		switch(combination)
		{		
		case '0|1|0':
			return 'xml_all';
			break;
		case '0|0|1':
			return 'xml_all';
			break;
		case '1|0|0':
			return 'xml_all';
			break;
		case '0|1|1':
			return 'xml';
			break;
		case '1|1|1':
			return 'no';
			break;
		default: // 0|0|0
			{
			return 'xml_all';			
			}
		}
		break;
	case 2:		
		switch(combination)
		{		
		case '0|1|0':
			return 'no';
			break;
		case '0|0|1':
			return 'submit';
			break;
		case '1|0|0':
			return 'submit';
			break;
		case '0|1|1':
			return 'submit';
			break;
		case '1|1|1':
			return 'submit';
			break;
		default: // 0|0|0
			{
			return 'xml';			
			}
		}
		break;
	case 3:		
		switch(combination)
		{		
		case '0|1|0':
			return 'xml';
			break;
		case '0|0|1':
			return 'xml_all';
			break;
		case '1|0|0':
			return 'submit';
			break;
		case '0|1|1':
			return 'no';
			break;
		case '1|1|1':
			return 'submit'
			break;
		default: // 0|0|0
			{
			return 'xml_all';
			}
		}
		break;
	default:
		{
		return 'submit';
		}
	}
}

function highlight_incoming(prd)
{	
	var tbl_count = window.parent.frTest.document.getElementsByTagName("table").length;
	for(var i=0;i<tbl_count;i++){
		var table_id = window.parent.frTest.document.getElementsByTagName("table")[i].getAttribute("id");
		var brp_row = window.parent.frTest.document.getElementsByTagName("table")[i].getElementsByTagName("tr").length - pre_exclude;
		switch(prd)
		{
		case 'pg':
			mark_unmark(table_id + '_pg','tdc_incoming',brp_row);
			mark_unmark(table_id + '_ptg','tdc',brp_row);
			mark_unmark(table_id + '_mlm','tdc',brp_row);
			break;
		case 'ptg':
			mark_unmark(table_id + '_pg','tdc',brp_row);
			mark_unmark(table_id + '_ptg','tdc_incoming',brp_row);
			mark_unmark(table_id + '_mlm','tdc',brp_row);
			break;
		case 'mlm':
			mark_unmark(table_id + '_pg','tdc',brp_row);
			mark_unmark(table_id + '_ptg','tdc',brp_row);
			mark_unmark(table_id + '_mlm','tdc_incoming',brp_row);
			break;
		}
	}	
}

function mark_unmark(_obj,_class,brp_row)
{
	window.parent.frTest.document.getElementById(_obj + 'head').className=_class;
	window.parent.frTest.document.getElementById(_obj + 'head_value').className=_class;
	window.parent.frTest.document.getElementById(_obj + 'head_status').className=_class;
	var rows = window.parent.frTest.rows;
	for (var x = 1; x <= brp_row; x++)
    {
		window.parent.frTest.document.getElementById(_obj + '_value' + x).className=_class;
		window.parent.frTest.document.getElementById(_obj + '_status' + x).className=_class;
		
    }
}