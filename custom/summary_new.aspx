

<%  
    Dim SiteID = Request.QueryString("siteid")
    Dim SiteName = Request.QueryString("sitename")
    Dim District = Request.QueryString("district")
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <script language="JavaScript" type="text/JavaScript"></script>
<style type="text/css">
.waterlevel12 {position:absolute;bottom:0px;background-color:#00ced1;z-index:2;filter:alpha(opacity=75);-moz-opacity:.75;opacity:.75;}
  

</style>
    <link rel="StyleSheet" href="_objects.css" title="Contemporary">
</head>
<body bgcolor="#0071bb">
    <div id="site" style="z-index: 1; left: 0px; position: absolute; top: 0px; width: 0px;
        height: 0px; ">
        <img src="../images/Malacca_site.gif" 
            id="IMG1" alt="site" language="javascript" onclick="return IMG1_onclick()" />
       
       
        <div id="header" style="left: 0px; top: 0px; width: 470px;">
            Loading Data ...</div>
            
        <!-- level -->
        <div id="level12" title="Pressure" style="z-index: 3; left: 683px; position: absolute;
            top: 248px; width: 88px; height: 91px;">
             <div id="siteid" style="position: absolute; top: -37px; left: -122px; width: 80px;"
                class="indicator">
               <%=SiteID %>
            </div>
            <div id="leveldate" style="position: absolute; top: -17px; left: -123px; width: 80px;"
                class="indicator">
                
            </div>
            <div id="leveltime" style="position: absolute; top: 2px; left: -124px; width: 84px;"
                class="indicator">
                
            </div>
            <div onclick="s_trend('<%=SiteID %>','<%=SiteName %>','<%=District %>','Pressure',1,window.location);" id="pressurebar" style="position: absolute; top: 210px; left: -134217728px; width: 80px;cursor: pointer;"
                class="indicator">
             <%=SiteID %>
            </div>
            <a target="contents" href="../GraphSelection.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=Pressure&position=2">
          <div  id="pressuremeter" style="position: absolute; top: 28px; left: -123px; width: 80px;cursor: pointer;"
                class="indicator">
              
            </div></a>
             <!-- <div onclick="s_trend('<%=SiteID %>','<%=SiteName %>','<%=District %>','Pressure',1,window.location);" id="Div3" style="position: absolute; top: 28px; left: -123px; width: 80px;cursor: pointer;"
                class="indicator">
              
            </div>-->
        </div>
        
        
        <div id="Div5" title="Pressure" style="z-index: 3; left: 683px; position: absolute;
            top: 348px; width: 88px; height: 91px;">
            <div id="Div6" style="position: absolute; top: 63px; left: -539px; width: 80px;"
                class="indicator">
               <select name="pollmethod" id="pollmethod" style="width: 107px; height: 9px">
      <option value="SMS">SMS</option>
      <option value="GPRS">GPRS</option>
    </select>
            </div>
            <div id="Div7" style="position: absolute; top: 94px; left: -536px; width: 93px; height: 30px;"
                class="indicator">
               <input name="password" type="password" id="password2" maxlength="10" style="width: 146px">&nbsp;
             
 
         
            </div>
        </div>
         <div id="Div10" title="Pressure" style="z-index: 3; left: 192px; position: absolute;
            top: 471px; width: 88px; height: 23px;">
             <input type="submit" name="Submit1" value="Poll" id="Submit1" language="javascript" onclick="return Submit1_onclick()" style="width: 68px"></div>
            </div> 
        <!-- level -->
        <!-- Flow -->
        <!-- Flow -->
        <!--<div id="show_level1color" title="Pressure" style="z-index: 3; left: 77px; position: absolute;
            top: 219px; width: 376px; height: 118px;">-->
            <!--<div id="Div2" style="Z-INDEX:2;BACKGROUND:none transparent scroll repeat 0% 0%;LEFT:81px;WIDTH:376px;POSITION:absolute;TOP:214px;HEIGHT:118px">-->
        <div id="Div1" style="position:absolute;z-index:2;top:110px;left:412px;width:377px;height:116px;background:transparent" language="javascript" onclick="return Div1_onclick()">
	

             <div id="water_level1"  class="waterlevel12"   >
	

            
  </div>
            <div id="Div2" language="javascript" onclick="return water_level1_onclick()" style="z-index: 2;
                background: none transparent scroll repeat 0% 0%; left: -341px; width: 378px;
                position: absolute; top: 68px; height: 118px">
                <div id="show_level1color" class="waterlevel">
                    <img id="show_level1" height="10" 
                        src="../images/blank.gif" style="width: 377px" /></div>
            </div>
 
	

           
</div>
</body>
<script language="JavaScript" src="pump_control.js"></script>
<script language="JavaScript" src="ajx/get_left.js"></script>





<script>


var xmlHttpfeed;
var HTTP_commission;
var xmlHttp

function pump_controller(id,suis)
{
	HTTP_commission=GetXmlHttpObject(pump_commission_status);	
	HTTP_commission.open('POST','pump_control.aspx?siteid=9012&c=' + id + '&o=' + suis,false);
	HTTP_commission.setRequestHeader('Content-Type','application/x-www-form-urlencoded');	
	HTTP_commission.send(null);
}
function pump_commission_status()
{
  if (HTTP_commission.readyState==4 || HTTP_commission.readyState=="complete")
  { 
    alert(HTTP_commission.responseText);    
  } 
}

function postdata(siteid,type1,pwd)
{ 
var url="../ajx/postform.aspx?sid=" + siteid + "&type1=" + type1 + "&pwd=" + pwd


xmlHttp=GetXmlHttpObject(postdata_fun)
xmlHttp.open("POST", url ,true)
xmlHttp.send(null)
}
function postdata_fun() 
{ 
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{ 
var tes=xmlHttp.responseText;
alert("Request has been submitted successfully");

} 
} 
function show_indicator()
{ 

var url="../ajx/realtimefeed.aspx?siteid=<%=SiteID %>&c=feed&sid=" + Math.random()

xmlHttpfeed=GetXmlHttpObject(ChangingState)
xmlHttpfeed.open("GET", url , true)
xmlHttpfeed.send(null)
setTimeout('show_indicator()', 60000);
//setTimeout('show_indicator()',1800000);
}

function ChangingState() 
{
if (xmlHttpfeed.readyState==4 || xmlHttpfeed.readyState=="complete")
{
var total_feed = xmlHttpfeed.responseText;


var arrdata = total_feed.split("|");
document.getElementById('header').innerHTML="<%=SiteName%>"
	
	if (arrdata[2]==undefined){		
		return;
	};	

	
	sv_element('pressuremeter',arrdata[2])
	//sv_element('pressurebar',meter2bar(arrdata[2]))
		
//	sv_element('flowl',arrdata[3])
//	sv_element('flowm',liter_per_sec2cubic_meter_per_hour(arrdata[3]))
		
	var data = arrdata[0].split(";");
	
	var datesp=data[1].split(" ");
	

	var date1=datesp[0];
	var time1=datesp[1];
//	var date2=data[3];
//	var time2=data[4];
//	
//	m=arrdata[2];
	
	//document.getElementById('reading').title=arrdata[2]+" m";
	document.getElementById('leveldate').innerHTML=date1;
	document.getElementById('leveltime').innerHTML=time1;
	
	//var tinggi = document.getElementById('water_level1').offsetHeight;
	var tinggi = 118;
wt_levelpam('water_level1',tinggi,arrdata[2],8);
	
	//var tinggi = document.getElementById('show_level1color').offsetHeight;

	//alert("1");
	//wt_level('show_level1',tinggi,arrdata[2],15);
	//wt_levelpam('show_level1color',tinggi,1,1);
//	document.getElementById('leveldate').innerHTML=date1;
//	document.getElementById('leveltime').innerHTML=time1;
			
	//rtu_s('rtu_stat1',date[1]+"&nbsp;"+date[2],0,0)
} 
}

function init_the_show(){
	loader_dia();
	show_indicator();	
}
window.onload = init_the_show;


function Submit1_onclick() {

var da =document.getElementById("pollmethod").value;
var ids='<%=SiteID%>';
var pwd=document.getElementById("password").value;

document.getElementById("password").value="";

postdata(ids,da,pwd);
}





</script>

</html> 


