// SYABAS version 2.0.3

var pageheader = document.getElementById('header').innerHTML;
var formthing;

function get_values(_obj,_att,_number,_data){	
	for(var i=0;i<_obj.length;i++){
		if (_obj[i].getAttribute(_att) == _number)
		{
			if (_data=='textContent'){		
				if (navigator.userAgent.indexOf("Opera")>=0)
				{				
					return _obj[i].textContent;
				}
				else if (navigator.userAgent.indexOf("MSIE")>=0)
				{ 
					return _obj[i].firstChild.text;
				} 
				else if (navigator.userAgent.indexOf("Mozilla")>=0)
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

function show_site_status(_obj){
	
	switch(_obj)
	{
	case 'None':
	  sv_element('site_status','');
	  break;
	case 'NONE':
	  sv_element('site_status','');
	  break;
	case '':
	  sv_element('site_status','');
	  break;
	default:
	  { 
		sv_element('site_status','Status: ' + _obj);
        return (false);
      }
	}
	return;
}

function accuracy_checker(_obj,_subject){	
	switch(_subject.toUpperCase())
	{
	case 'EVENT':
	  sv_element(_obj,'');
	  break;
	case 'OK':
	  sv_element(_obj,'OK');
	  break;
	case 'FAIL':
	  sv_element(_obj,'FAIL');
	  break;
	default:
	  { 
		sv_element(_obj,'??');
        return (false);
      }
	}
	return;
}

function wt_level(id,maxsize,value,max){
  var _height = (value/max) * maxsize;
  if (_height>maxsize){
	eval("document.getElementById('" + id + "').height=" + maxsize );
	//eval("document.getElementById('" + id + "color').className='overflowlevel'" );
  }else{
	eval("document.getElementById('" + id + "').height=" + _height );
	//eval("document.getElementById('" + id + "color').className='waterlevel'" );
  }  
}

function rtu(id,title){
  var myarray = title.split("-");
  sv_element(id + 'no1',myarray[0]);
  sv_element(id + 'no2',myarray[1]);
  sv_element(id + 'no3',myarray[2]);
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

function checking_passx(op,id){
	formthing = get_passwd('inputPass');
    if (formthing == 'NONE'){
		formthing = '';
		alert('Please enter the password!');
		return false;		
	}
	if (op=='pump'){
		xmlform_ctrl=GetXmlHttpObject(cp2_pump);
		xmlform_ctrl.open('GET','pump_dialog.aspx?c=pass&id=' + id + '&seq=' + Math.random(),true);
	}else{
		xmlform_ctrl=GetXmlHttpObject(cp2_poll);
		xmlform_ctrl.open('GET','pump_dialog.aspx?c=pass&id=' + id + '&seq=' + Math.random(),true);
	}		
	xmlform_ctrl.send(null);
}

function cp2_pump()
{  
  var something;
  if (xmlform_ctrl.readyState==4 || xmlform_ctrl.readyState=="complete")
  { 
    something = xmlform_ctrl.responseText;    
	
    if (something == formthing){
		alert(ambs_pam(checking_radx('p1_1','p1_2'),checking_radx('p2_1','p2_2'),checking_radx('p3_1','p3_2')));
	}else{
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
  var selection = m1 + "|" + m2 + "|" + m3;
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
        return (false);
      }
  }  
  pump_controller('pump_ctrl',result);
}

function rtu_s(id,title,pwr,batt){
  var power,battery;
  if (pwr==0){document.getElementById(id + '_power').className='ok';pwr='OK';}else{document.getElementById(id + '_power').className='fail';pwr='FAIL';};
  if (batt==0){document.getElementById(id + '_batt').className='ok';batt='OK';}else{document.getElementById(id + '_batt').className='fail';batt='FAIL';};
  sv_element(id + '_title',title);
  sv_element(id + '_power', pwr);
  sv_element(id + '_batt', batt);
}

function loader_dia(){
  document.getElementById('header').innerHTML='loading data...';
}

function lvl_stat(id,status){ // for level status
  if (status==1){      
      sv_element(id,'YES')
//		if (str.match("Over")){alert("YES");}
//      if (id like 'Over%'){
		//eval("document.getElementById('" + id + "color').className='overflowlevel'" );
//		alert(id);
//      }
  }else{      
      sv_element(id,'NO')
  }
}

function lvl_stat_2(id,L_status1,H_status2){ // for level status
  var status_pilihan = '';
  if (L_status1==1){ // L
      status_pilihan = 'L';
  }
  if (H_status2==1){ // H
	  status_pilihan = 'H';
  }
  sv_element(id,status_pilihan)
}

function sp_stat(id,status,trip_stat,hours){ // for pump status	
  if (status==1){
      eval("document.getElementById('pump" + id + "').className='pump_run'");
      //eval("document.getElementById('p" + id + "_1').checked == true");      
  }else{
      eval("document.getElementById('pump" + id + "').className='pump_stop'");
      //eval("document.getElementById('p" + id + "_2').checked == true");
  }
  if (trip_stat==1) {eval("document.getElementById('pump" + id + "').className='pump_off'");};
  //eval("document.getElementById('p" + id + "_1').checked == false");
  //eval("document.getElementById('p" + id + "_2').checked == true");
  eval("sv_element('hours" + id + "',hours);");
}

function sp_stat02(id,on_stat,off_stat,trip_stat,ctrl_stat){ // for pump status AMBS
  if (on_stat==1){
	eval("document.getElementById('pump" + id + "').className='pump_run'");
	eval("document._pump.p" + id + "_1.checked=true;");
  }
  if (off_stat==1){
	eval("document.getElementById('pump" + id + "').className='pump_stop'");
	eval("document._pump.p" + id + "_2.checked=true;");
  }
  if (trip_stat==1) {eval("document.getElementById('pump" + id + "').className='pump_off'");};
  eval("sv_element('pump" + id + "constat',constatus(ctrl_stat))")
}

function sv_element(id,value){ // changing divs element innerHTML value
  eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
}

// ===== Formulas

function meter2feet(w){
  return Math.round((w * 39.370079 / 12)*100)/100;
}

function r(k){//round
  return Math.round(k*100)/100;
}

function cubic_meter_per_hour2litre_per_sec(w){
  var _value = (w * 1000)/3600;
  return Math.round(_value*100)/100;
}

function bph_ps(x_factor){ // bph puchong suction tank
  var _pi = 22/7;
  var _radius = 12.092;
  var _value = _pi * _radius * _radius * x_factor;
  return Math.round(_value*100)/100;
}

function bph_pr(x_factor){ // bph puchong reservoir tank
  var _pi = 22/7;
  var _radius = 18.6917;
  var _value = _pi * _radius * _radius * x_factor;
  return Math.round(_value*100)/100;
}

function fa(x){ // flow_adjustment
  if (x < 0){
	return 0;
  }else{
	return r(x);
  }  
}

function fix_total(x,option){	
	switch(option)
	{
		case 'r': // some interpreter just concat the values instead of add			
			return r(x) + 1472;
			break;
		case 's':			
			return r(x) - 717;
			break;
		default:
		{ 
			alert("Sorry, wrong top and base combination.");
			return (false);
		}
	} 	
}

function ltrim(str) { 
	for(var k = 0; k < str.length && isWhitespace(str.charAt(k)); k++);
	return str.substring(k, str.length);
}
function rtrim(str) {
	for(var j=str.length-1; j>=0 && isWhitespace(str.charAt(j)) ; j--) ;
	return str.substring(0,j+1);
}
function trim(str) {
	return ltrim(rtrim(str));
}
function isWhitespace(charToCheck) {
	var whitespaceChars = " \t\n\r\f";
	return (whitespaceChars.indexOf(charToCheck) != -1);
}

function twentypercent(str){
  return str.replace(' ','%20');
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
  var url='Trending.aspx?';  
  //url = url + 'siteid=' + id + '&sitename=' + twentypercent(title) + '&district=' + dist + '&equipname=' + twentypercent(equip) + '&position=' + pos + '&ref=' + ref;
  url = url + 'siteid=' + id + '&sitename=' + twentypercent(title) + '&district=' + dist + '&equipname=' + twentypercent(equip) + '&position=' + pos;
  //alert(url);
  window.location=url;
}

function c_date(strDate1,strDate2){
  datDate1= Date(strDate1);
  datDate2= Date(strDate2);
  alert(datDate2 + datDate1)
  //alert((datDate2-datDate1)/86400000)
}

// TAB Function
function re_active(){
document.body.style.overflow="visible";
//	if (browser == 'Internet Explorer'){
//				this.getScroll();
//				this.prepareIE('100%', 'hidden');
//				this.setScroll(0,0);
//				this.hideSelects('hidden');
//	}
}

function de_active(){
document.body.style.overflow="hidden";
document.body.scroll="no";
//	if (browser == "Internet Explorer"){
//		this.setScroll(0,this.yPos);
//		this.prepareIE("auto", "auto");
//		this.hideSelects("visible");
//	}
}

function show_xboxes(xpos,ypos){
  window.document.body.scroll = 'no';
  eval("document.getElementById('inputPass').value=''");
  eval("document.getElementById('hijab').style.width='1024px'");
  eval("document.getElementById('hijab').style.height='700px'");
  eval("document.getElementById('hijab').style.visibility='visible'");
  eval("document.getElementById('xbox').style.visibility='visible'");
  eval("document.getElementById('xbox').style.top='" + ypos + "px'");
  eval("document.getElementById('xbox_butt').style.visibility='visible'");
  eval("document.getElementById('xbox_butt').style.top='" + ypos + "px'");
  document.getElementById('inputPass').focus();
}

function hide_xboxes(){
  window.document.body.scroll = 'auto';
  eval("document.getElementById('hijab').style.width='100%'");
  eval("document.getElementById('hijab').style.height='100%'");
  eval("document.getElementById('xstatus').style.visibility='hidden'");
  eval("document.getElementById('hijab').style.visibility='hidden'");
  eval("document.getElementById('xbox').style.visibility='hidden'");
  eval("document.getElementById('xbox_butt').style.visibility='hidden'");
}

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

function key_in(e){
var unicode=e.keyCode? e.keyCode : e.charCode
switch(unicode)
{
	case 13:
		sms_outbox(selectedsiteid);
		break;
	case 27:
		hide_xboxes();
		break;	
}
}