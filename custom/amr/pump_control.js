//var pageheader = document.getElementById('header').innerHTML;

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

function rtu(id,title){
  sv_element(id + '_title',title);
}

function checking_cbx(id){
	var box = eval("document.getElementById('" + id + "')");	
	if (box.checked == false){
		return 0;
	}else{
		return 1;
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
  alert(result);
  //pump_controller('pump_cmd',combination);
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
  }else{
      eval("document.getElementById('pump" + id + "').className='pump_stop'");
  }
  if (trip_stat==1) {eval("document.getElementById('pump" + id + "').className='pump_off'");};
  eval("sv_element('hours" + id + "',hours);");
}

function sp_stat02(id,on_stat,off_stat,trip_stat,ctrl_stat){ // for pump status AMBS
  if (on_stat==1){eval("document.getElementById('pump" + id + "').className='pump_run'");};
  if (off_stat==1){eval("document.getElementById('pump" + id + "').className='pump_stop'");};
  if (trip_stat==1) {eval("document.getElementById('pump" + id + "').className='pump_off'");};

}

function sv_element(id,value){ // changing divs element innerHTML value
  eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
}

function meter2feet(w){
  return Math.round((w * 39.370079 / 12)*1000)/1000;
}

function r(k){//round
  return Math.round(k*1000)/1000;  
}

function twentypercent(str){
  return str.replace(' ','%20');
}

function cubic_meter_per_hour2litre_per_sec(w){
  var _value = (w * 1000)/3600;
  return Math.round(_value*1000)/1000;
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
  url = url + 'siteid=' + id + '&sitename=' + twentypercent(title) + '&district=' + dist + '&equipname=' + twentypercent(equip) + '&position=' + pos + '&ref=' + ref;
  //alert(url);
  window.location=url;
}

function c_date(strDate1,strDate2){
  datDate1= Date(strDate1);
  datDate2= Date(strDate2);
  alert(datDate2 + datDate1)
  //alert((datDate2-datDate1)/86400000)  

}