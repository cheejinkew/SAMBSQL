// SAMB version 0.1
//var pageheader = document.getElementById('header').innerHTML;

function rtu(id,title){
  var myarray = title.split("*");
  sv_element(id + 'no1',myarray[0]);
  sv_element(id + 'no2',myarray[1]);
  sv_element(id + 'no3',myarray[2]);
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