// SATU version 2.1.1

var pageheader = document.getElementById('header').innerHTML;
var formthing;
var pump_check = 0;

function wt_level(id,maxsize,value,max){
  var _height = (value/max) * maxsize;
   
  
 
  if (_height>maxsize){

	eval("document.getElementById('" + id + "').height=" + maxsize );
	eval("document.getElementById('" + id + "color').className='overflowlevel'" );
  }else{

	eval("document.getElementById('" + id + "').height=" + _height );
	
	eval("document.getElementById('" + id + "color').className='waterlevel'" );
  }  
}

function wt_levelpam(id,maxsize,value,max){
maxsize=118
  var _height = (value/max) * maxsize;
   
  
 
  if (_height>maxsize){
  
	eval("document.getElementById('" + id + "').height=" + maxsize );
	eval("document.getElementById('" + id + "').className='overflowlevel'" );
  }else{

	//eval("document.getElementById('" + id + "').height=" + _height );
	//	eval("document.getElementById('" + id + "').style.height=80" );
//eval("document.getElementById('Div2').style.height=" + _height );


eval("document.getElementById('show_level1').height=" + _height );


			//eval("document.getElementById('" + id + "').style.height=0" );
	//eval("document.getElementById('show_level1').className='waterlevel'" );
  }  
}


function rtu(id,title){
  var myarray = title.split("*");
  sv_element(id + 'no1',myarray[0]);
  sv_element(id + 'no2',myarray[1]);
  sv_element(id + 'no3',myarray[2]);
}

function checking_passx(op,id){
	formthing = get_passwd('inputPass');
    if (formthing == 'NONE'){
		formthing = '';
		alert('Please enter the password!');
		return false;		
	}
	if (op=='pump'){
		show_progress('sending pumps command...');
		xmlform_ctrl=GetXmlHttpObject(cp2_pump);
		xmlform_ctrl.open('GET','pump_dialog.aspx?c=pass&id=' + id + '&seq=' + Math.random(),true);
	}else{
		show_progress('polling in progress...');
		xmlform_ctrl=GetXmlHttpObject(cp2_poll);
		xmlform_ctrl.open('GET','pump_dialog.aspx?c=pass&id=' + id + '&seq=' + Math.random(),true);
	}		
	xmlform_ctrl.send(null);
}

function checking_passx2(id){
	formthing = get_passwd('inputPass');
    if (formthing == 'NONE'){
		formthing = '';
		alert('Please enter the password!');
		return 'NO';
	}else{
		if (formthing == '0123456789'){
			return 'YES';
		}else{
			alert('Invalid password!');
			return 'NO';
		}
	}
}

function cp2_pump()
{  
  var something;
  if (xmlform_ctrl.readyState==4 || xmlform_ctrl.readyState=="complete")
  { 
    something = xmlform_ctrl.responseText;    
	
    if (something == formthing){
		ambs_pam(checking_radx('p1_1','p1_2'),checking_radx('p2_1','p2_2'),checking_radx('p3_1','p3_2'));
	}else{
		hide_legend();
		formthing = '';
		alert('invalid password!');
	}
  } 
}

function cp2_poll()
{  
  var something;  
  if (xmlform_ctrl.readyState==4 || xmlform_ctrl.readyState=="complete")
  { 
    something = xmlform_ctrl.responseText; 
    
    if (something == formthing){
		//polling command		
		pump_controller('pump_poll','');
	}else{
		hide_legend();
		formthing = '';
		alert('invalid password!');
	}
  } 
}

function get_passwd(id){
	var xy = eval("document.getElementById('" + id + "').value;");
	if ( xy == ''){
		return 'NONE';
	}else{
		return xy;
	}
}

function checking_radx(id1,id2){
	var box = eval("document.getElementById('" + id1 + "')");
	if (box.checked == false){
		return 0;
	}else{
		return 1;
	}
}

function checking_cbx(id){
	var box = eval("document.getElementById('" + id + "')");	
	if (box.checked == false){
		return 0;
	}else{
		return 1;
	}
}

function constatus(x){	
	if (x == 1){
		return 'L';
	}else{
		return 'R';
	}
}

function ambs_pam(m1,m2,m3){
  //var selection = m1 + "|" + m2 + "|" + m3;
  var selection = m3 + "|" + m2 + "|" + m1;
  var result;
    
  switch(selection)
  {
	case '0|0|0':
	  result = '38'//"111000"
	  break;
	case '0|0|1':
	  result = '31'//"110001"
	  break;
	case '0|1|0':
	  result = '2A'//"101010"
	  break;
	case '0|1|1':
	  result = '23'//"100011"
	  break;
	case '1|0|0':
	  result = '1C'//"011100"
	  break;
	case '1|0|1':
	  result = '15'//"010101"
	  break;
	case '1|1|0':
	  result = '0E'//"001110"
	  break;
	case '1|1|1':
	  result = '07'//"000111"
	  break;
	default:
	  { alert("Sorry, wrong top and base combination.");
        return;
      }
  }  
  pump_controller('pump_ctrl',result);
  //alert(result)
}

function bphkemudu_poll_select(m1,m2,m3){
  return m1 + "|" + m2 + "|" + m3;
}

function rtu_s(id,title,pwr,batt){
  var power,battery;
  if (pwr==0){document.getElementById(id + '_power').className='ok';pwr='OK';}else{document.getElementById(id + '_power').className='fail';pwr='FAILED';};
  if (batt==0){document.getElementById(id + '_batt').className='ok';batt='OK';}else{document.getElementById(id + '_batt').className='fail';batt='FAILED';};
  sv_element(id + '_title',title);
  sv_element(id + '_power', pwr);
  sv_element(id + '_batt', batt);
}

function loader_dia(){
  document.getElementById('header').innerHTML='loading data...';
}

function sp_stat(id,status,trip_stat,hours){ // for pump status	
  if (status==1){
      eval("document.getElementById('pump" + id + "').className='pump_run'");
      eval("document.getElementById('p" + id + "_1').checked == true");
  }else{
      eval("document.getElementById('pump" + id + "').className='pump_stop'");
      eval("document.getElementById('p" + id + "_2').checked == true");
  }
  if (trip_stat==1) {eval("document.getElementById('pump" + id + "').className='pump_off'");};  
  eval("document.getElementById('p" + id + "_2').checked == true");
  eval("sv_element('hours" + id + "',hours);");
}

function sp_stat02(id,on_stat,off_stat,trip_stat,ctrl_stat){ // uniquely coded for AMBS pumps
  if (on_stat==0){
	eval("document.getElementById('pump" + id + "').className='pump_run'");
	eval("document._pump.p" + id + "_1.checked=true;");
    eval("document.getElementById('pipe" + id + "').style.visibility = 'visible'");
	pump_check = pump_check + 1;
//	setFCNewData('')
  }
  if (off_stat==0){
	eval("document.getElementById('pump" + id + "').className='pump_stop'");
	eval("document._pump.p" + id + "_2.checked=true;");
    eval("document.getElementById('pipe" + id + "').style.visibility = 'hidden'");
    pump_check = pump_check - 1;
  }
  if (trip_stat==0) {
	eval("document.getElementById('trip" + id + "').className='pump_trip'");
	//eval("document._pump.p" + id + "_2.checked=true;");
    //eval("document.getElementById('pipe" + id + "').style.visibility = 'hidden'");
    //pump_check = pump_check - 1;
  }
  eval("sv_element('pump" + id + "constat',constatus(ctrl_stat))")
}

function sp_ext02()
{
  if (pump_check < -2){
        eval("document.getElementById('suction_pipe').style.visibility = 'hidden'");
        eval("document.getElementById('reservoir_pipe').style.visibility = 'hidden'");
  }else{
        eval("document.getElementById('suction_pipe').style.visibility = 'visible'");
        eval("document.getElementById('reservoir_pipe').style.visibility = 'visible'");
  }
}

function setFCNewData(objFlash, strXML)
{
      //This function updates the data of a FusionCharts present on the page
      //Get a reference to the movie
      var FCObject = getObject(objFlash);      
      //Set the data
      //Set dataURL to null
      FCObject.SetVariable('_root.dataURL',"");
      //Set the flag
      FCObject.SetVariable('_root.isNewData',"1");
      //Set the actual data
      FCObject.SetVariable('_root.newData',strXML);
      //Go to the required frame
      FCObject.TGotoLabel('/', 'JavaScriptHandler');
      //FCObject.Play();
}

function getObject(movieName) // get the flash object
{
  if (window.document[movieName]) 
  {
      return window.document[movieName];
  }
  if (navigator.appName.indexOf("Microsoft Internet")==-1)
  {
    if (document.embeds && document.embeds[movieName])
      return document.embeds[movieName]; 
  }
  else // if (navigator.appName.indexOf("Microsoft Internet")!=-1)
  {
    return document.getElementById(movieName);
  }
}

function sv_element(id,value){ // changing divs element innerHTML value
  if (value==undefined){		
		eval("document.getElementById('" + id + "').innerHTML='???'");
		return;
  }else{
		eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
  }
}

function meter2feet(w){
  return Math.round((w * 39.370079 / 12)*100)/100;
}

function r(k){//round
  return Math.round(k*1000)/1000;
}

function twentypercent(str){
  return str.replace(' ','%20');
}

function cubic_meter_per_hour2litre_per_sec(w){
  var _value = (w * 1000)/3600;
  return Math.round(_value*100)/100;
}

function mA2A(w){
  var _value = w/1000;
  return Math.round(_value*100)/100 + ' A';
}

function fixVolt(w){
  var _value = w/1.2;
  return r(Math.round(_value*1)/1);
}

function fixAmp(w){
  var _value = (w/10)*1.2;
  return Math.round(_value*1)/1;
}

function x10(w){
  var _value = w*10;
  return _value;
}

function per10(w){
  var _value = w/10;
  return _value;
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
      alert("Error. Your browser not support XMLHttpRequest or Scripting for ActiveX might be disabled! Please use the latest browser.") 
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

function s_trend(id,title,dist,equip,pos,ref){

  var url='../GraphSelection.aspx?'; 
alert(url); 
  url = url + 'siteid=' + id + '&sitename=' + twentypercent(title) + '&district=' + dist + '&equipname=' + twentypercent(equip) + '&position=' + pos + '&ref=' + ref;
 alert(window.name);
 window.name="contents";
 alert(window.name);
  window.location=url;
}

function c_date(strDate1,strDate2){
  datDate1= Date(strDate1);
  datDate2= Date(strDate2);
  alert(datDate2 + datDate1)
  //alert((datDate2-datDate1)/86400000)
}

// TAB Function

function show_cpanel(){  
  document.getElementById('panel_title1').className='tab_panel0';
  document.getElementById('panel_title2').className='tab_panel1';
  eval("document.getElementById('legend_sect').style.visibility='hidden'");
  eval("document.getElementById('pump_sect').style.visibility='visible'");
  eval("document.getElementById('poll_sect').style.visibility='visible'");
  eval("document.getElementById('pass_sect').style.visibility='visible'");
}

function show_legend(){
  document.getElementById('panel_title1').className='tab_panel1';
  document.getElementById('panel_title2').className='tab_panel0';
  eval("document.getElementById('legend_sect').style.visibility='visible'");
  eval("document.getElementById('pump_sect').style.visibility='hidden'");
  eval("document.getElementById('poll_sect').style.visibility='hidden'");
  eval("document.getElementById('pass_sect').style.visibility='hidden'");
}

function show_progress(status){
  sv_element('cmd_status',status);
  eval("document.getElementById('pump_sect').style.visibility='hidden'");
  eval("document.getElementById('poll_sect').style.visibility='hidden'");
  eval("document.getElementById('pass_sect').style.visibility='hidden'");
  eval("document.getElementById('progress_sect').style.visibility='visible'");
}

function hide_legend(){  
  eval("document.getElementById('pump_sect').style.visibility='visible'");
  eval("document.getElementById('poll_sect').style.visibility='visible'");
  eval("document.getElementById('pass_sect').style.visibility='visible'");
  eval("document.getElementById('progress_sect').style.visibility='hidden'");
}