<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%
   dim objConn
   dim sqlRs
   dim strConn
   dim strDistrict
   dim strSelectedDistrict
   dim strType
   dim strSelectedType
   dim strSiteName
   dim intSiteID
   dim intUnitID
   dim intNum
   dim strError
   dim strErrorColor

   dim i
   dim strControlDistrict
   
   dim arryControlDistrict = split(request.cookies("Telemetry")("ControlDistrict"), ",")
   if arryControlDistrict.length() > 1 then
     for i = 0 to (arryControlDistrict.length() - 1)
       if i <> (arryControlDistrict.length() - 1)
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "', "
       else
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "'"
       end if
     next i
   else
     strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
   end if
   
    strSelectedDistrict = Request.QueryString("ddDistrict")
    strSelectedType = Request.QueryString("ddType")
    Dim backurl As String = Request.QueryString("backurl")
    Dim siteid As String = Request.QueryString("siteid")
    Dim district As String = Request.QueryString("district")
    Dim sitename As String = Request.QueryString("sitename")
    Dim sitetype As String = Request.QueryString("ddType")
   
   if strSelectedDistrict ="" then
     strSelectedDistrict= "0"
   end if
   
   if strSelectedType ="" then
     strSelectedType= "0"
   end if

   strError = request.form("txtError")
   strErrorColor = request.form("txtErrorColor")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   
%>
<html>
<head>

</head>
<body topmargin=5 leftmargin=5 onload="alertframe5();"><!-- Switch to System View-->
<!--
<a href="custom/systemview-left/siteselect.aspx" id="_switch" style="font:bold 9px verdana; color:Gray;">Switch to System View</a> -->
<div id="resizer" align="right">minimize left &nbsp;<img id="black_arrow" onclick="resize_mainframe()" src="images/leftwhite.gif" border="0"></div>

  <form onload="top.frames[0].location.reload();" name="frmSite"  action="DisplayMap.aspx" method="post">
    <input type="hidden" name="txtUserID" value="">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td width="100%" height="60" colspan="3">
            <p align="center"><img border="0" src="images/SiteSelection.jpg" align="left">
            
          </td>
        </tr>
        <tr>
          <td width="15%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>District</b></font></td>
          <td width="10%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="75%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddDistrict" id="ddDistrict" class="FormDropdown" onchange="kosek_ddDistrict()">
            <option value="0" > - Select Site District -</option>
            
            <%
               objConn = new ADODB.Connection()
               objConn.open(strConn)
               
               if arryControlDistrict(0) <> "ALL" then
                 sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ")",objConn)
               else
                 sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table",objConn)
               end if
               do while not sqlRs.EOF
                 strDistrict = sqlRs("sitedistrict").value
            %>
            <option value="<%=strDistrict%>"><%=strDistrict%></option>
            <%

                 sqlRs.movenext
               Loop
                
               sqlRs.close()
               objConn.close()
               objConn = nothing
               
            %>
               
            </select>
            
            
           </font></td>

        </tr>
        <tr>
          <td width="15%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>Type</b></font></td>
          <td width="10%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="75%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddType" id="ddType" class="FormDropdown" onchange="kosek_ddType();">
            <option value="0" > - Select Site Type -</option>  
            </select>
            
            
           </font></td>

        </tr>
        <tr>
          <td width="15%" height="30">
          </td>
          <td width="10%" height="30">
          </td>
          <td width="75%" height="30">
          </td>

        </tr>
      </table>
      
    </div>
<div align="center" id="divWait"></div>  
  
   <div id="txtHint">Alerts :
   </div> 
 <div  style=" margin-right: 0px;overflow: auto; overflow-x: hidden;">
  <iframe id="alertframe" width="220" height=330 marginheight="0" marginwidth="0"  scrolling=auto style="left:0;" frameborder="0" ></iframe>
  
  </div> 
  </form>
  </body>
<%--<p>&nbsp;</p>
<div id="txtHint"><img border="0" src="images/loading.gif" style="visibility:hidden"><b>Loading...</b></div>--%>
</html>
<script language="JavaScript" src="ajx/get_left.js"></script>
<script language="javascript">  
  document.frmSite.ddDistrict.value='<%=strSelectedDistrict%>';
  document.frmSite.ddType.value='<%=strSelectedType%>';

  function kosek_ddType()
  {
	if(document.getElementById('ddType').selectedIndex != 0){
	document.getElementById("divWait").innerHTML='<img border="0" src="images/loading.gif"><b>Loading...</b>';
	var dist = document.getElementById('ddDistrict').value;
	var typ = document.getElementById('ddType').value;	
	showList(dist,typ);


var url="Displaymap.aspx?strSelectedDistrict=" + dist + "&strSelectedType="+ typ ;

//	top.main.location = 'Displaymap.aspx?command=map'; 

top.main.location = url;


	}
	else{
	document.getElementById("divWait").innerHTML="";
	

	}
  }

  function kosek_ddDistrict()
  {
  	if(document.getElementById('ddDistrict').selectedIndex != 0){
	document.getElementById("divWait").innerHTML='<img border="0" src="images/loading.gif"><b>Loading...</b>';
	var dist = document.getElementById('ddDistrict').value;
	var typ = document.getElementById('ddType').value;	
	removeOption('ddType');
	refillOption(dist,typ);
	}
	else{
	removeOption('ddType');
	document.getElementById("divWait").innerHTML="";
	}	
  }

  function removeOption(id)
  {
  var elSel = eval("document.getElementById('" + id + "')");
  if (elSel.length > 1)
    {
    for (var xc=elSel.length; xc > 1; xc--)
		elSel.remove(elSel.length-1);    
    }
  }

  var strSession = "true";
  if (strSession != "true")
  {
   // top.location.href = "login.aspx";
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
		remember_ddType = document.getElementById('ddType').selectedIndex;
		remember_divWait = document.getElementById('divWait').innerHTML;
		document.getElementById('ddType').selectedIndex = 0;		
		document.getElementById('divWait').innerHTML='';		
		window.parent.kk('min');
    }else{
		frameLeft='';
		document.getElementById('resizer').style.width=widthomine;		
		document.getElementById('resizer').innerHTML='minimize left &nbsp;<img id="black_arrow" onclick="resize_mainframe()" src="images/leftwhite.gif" border="0">';
		document.getElementById('ddType').selectedIndex = remember_ddType;		
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
//resize_mainframe();
<%if not backurl="" then %>
  document.frmSite.ddDistrict.value='<%=district %>';
  refillOption1('<%=district %>',0);
  document.getElementById('ddType').value='<%=sitetype%>';	
  showList1('<%=district %>','<%=sitetype%>');
  rightpageload();
   <%end if %>
   function rightpageload()
    {
    var obj=document.frmSite;
    obj.action="<%=backurl%>?siteid=<%=siteid %>&sitename=<%=sitename %>&district=<%=district %>&sitetype=<%=sitetype%>";
    obj.target="main";
    obj.submit();
    }
    
    function alertframe5()
{
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
     document.getElementById('alertframe').src="alert1.aspx"
}

</script>


<style type="text/css">
a {text-decoration: none;} 
a#_switch:hover { text-decoration: underline;}
a#_switch {float:top; margin: 1px 2px 0px 2px; }
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
  visibility:hidden;
  }
img#black_arrow
  {
  cursor:pointer;
  }
</style>
