function rtu_s(id,title,pwr,batt){
  var power,battery;
  if (pwr==1){document.getElementById(id + '_power').className='ok';pwr='OK';}else{document.getElementById(id + '_power').className='fail';pwr='FAILED';};
  if (batt==1){document.getElementById(id + '_batt').className='ok';batt='OK';}else{document.getElementById(id + '_batt').className='fail';batt='FAILED';};
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

function sv_element(id,value){ // changing divs element innerHTML value
  eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
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