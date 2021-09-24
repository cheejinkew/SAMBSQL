<%@ Page Language="VB" Debug="true" %>
<%  
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim strControlDistrict, i
    Dim strDistrict
    Dim strBeginDate
    Dim strEndDate
    Dim strBeginHour
    Dim strBeginMin
    Dim strEndHour
    Dim strEndMin
    Dim strBeginDateTime
    Dim strEndDateTime
    
    Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1) Then
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
            Else
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
    End If
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
       
 %>
 
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Untitled Page</title>
</head>
<body>
    <form name="alrm" id="alrmid"  method="post" action="NewAlarm.aspx"    >    
  <div align="center" style="color:#465AE8;">
  <p align="center"><img border="0" src="images/AlarmNotification.jpg" alt="" style="z-index: 104; left: 301px; position: absolute; top: 16px" /></p></div>
  <table>
   
        <b><asp:Label ID="Label1" runat="server" Style="z-index: 100; left: 466px; position: absolute; top: 55px; color:#465AE8; font-size:x-small; font-family:Verdana; size:2" Text="Select Districts" Width="110px"></asp:Label></b>
  <table border="0" style="z-index: 103; left: 150px; position: absolute; top: 53px">
    <tr style="border:0">
      <td style="height: 30px; width: 279px; font-size:medium" align="center"><b><font color="#465AE8" size="2" face="Verdana">
        &nbsp;Show Alerts For Last :</font></b></td>
    </tr>
      <tr style="border:0;"  >
       <td style="height: 36px" >
       <a href="javascript:yesterdate();"><img src="images/last1day.jpg" alt="" border="0"/></a>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript:lastweakdate();"><img src="images/1week.jpg" alt="" border="0"/></a>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript:lastmonthdate();"><img src="images/1-month.jpg" alt="" border="0"/></a>
   </td>
            </tr>
         </table>   
         <div>  &nbsp;&nbsp;
         <select style="border-color:Black; color:#465AE8; position: absolute; left: 470px; top: 75px; height: 59px;" id="ddDistrict"  scrolling="no" onchange="javascript:submission();"   multiple >
        <% objConn = new ADODB.Connection()
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
  
           <div>
               &nbsp;</div>           
            </div>
                          
        <div id="trends"></div><IFRAME id="_excel" name="_excel" style="width:100px;height:1000px;position:absolute;top:222px;left:439px;display:none; z-index: 102;" frameborder="1" src=""  ></iframe>   
        
            
          </table>
    </form>
</body>
</html>
<script type="text/javascript">
  function listHeight() 
   {
  if(document.getElementById && !(document.all)) 
 {
   h = document.getElementById('ddDistrict').contentDocument.body.scrollHeight;
   document.getElementById('ddDistrict').style.height = h;
 }
 else if(document.all) 
 {
   h = document.frames('ddDistrict').document.body.scrollHeight;
   document.all['ddDistrict'].style.height=h;
 }
} 



   function iFrameHeight() 
   {
  if(document.getElementById && !(document.all)) 
 {
   h = document.getElementById('frTest').contentDocument.body.scrollHeight;
   document.getElementById('frTest').style.height = h;
 }
 else if(document.all) 
 {
   h = document.frames('frTest').document.body.scrollHeight;
   document.all['frTest'].style.height=h;
 }
}    
 function yesterdate()
  {
   var path1 = document.getElementById('ddDistrict')
var choices = new Array
for (var i = 0; i < path1.options.length; i++){
    if (path1.options[i].selected)
      choices[choices.length] = path1.options[i].text;
			}
    var currentTime = new Date()
//	currentTime.setHours()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	var currentTime1 = new Date()
// currentTime1.setHours(-24)
	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
	 var start = year + "-" + month + "-" + day + " " + "00" + ":" + "00";
	var end = year1 + "-" + month1 + "-" + day1 + " " + "23" + ":" + "59";
	
  var dist=document.getElementById('ddDistrict').value;
  var table = 'aaa';
  var hr='ccc';
  var url="Alarmreportretv.aspx?start=" + start + "&dist="+ choices + "&end=" + end;  
  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<div id="preload" style="border=0px;position:absolute;left:15px;top:8px;background-color:transparent;"></div><IFRAME onLoad="iFrameHeight();" id="frTest" name="frTest" style="width:100px;height:1000px;position:absolute;top:100;left:0;" frameborder=0 src="about:blank" marginheight=0 marginwidth=0 scrolling="no"></iframe>');
  document.getElementById('frTest').src=url;
  document.getElementById('frTest').style.width=lebar;
   document.getElementById('frTest').style.top=150;
   document.getElementById('frTest').style.left=15; 
 }
   function lastweakdate()
  {
    var path1 = document.getElementById('ddDistrict')
var choices = new Array
for (var i = 0; i < path1.options.length; i++){
    if (path1.options[i].selected)
      choices[choices.length] = path1.options[i].text;
			}
    var currentTime = new Date()
    currentTime.setHours(-168)
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
    var currentTime1 = new Date()
//  	 currentTime1.setHours()
  	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
	
    var start = year + "-" + month + "-" + day + " " + "00" + ":" + "00";
	var end = year1 + "-" + month1 + "-" + day1 + " " + "23" + ":" + "59";
	
  var dist=document.getElementById('ddDistrict').value;
  var table = 'aaa';
  var hr='ccc';
  var url="Alarmreportretv.aspx?start=" + start + "&dist="+ choices + "&end=" + end;  
  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<div id="preload" style="border=0px;position:absolute;left:15px;top:8px;background-color:transparent;"></div><IFRAME onLoad="iFrameHeight();" id="frTest" name="frTest" style="width:100px;height:1000px;position:absolute;top:0;left:0;display:inline;" frameborder=0 marginwidth=0 src="about:blank" marginheight=0 scrolling="no"></iframe>');
  document.getElementById('frTest').src=url;
  document.getElementById('frTest').style.width=lebar;
   document.getElementById('frTest').style.top=150;
   document.getElementById('frTest').style.left=15; 
      }
      
   function lastmonthdate()
  {
    var path1 = document.getElementById('ddDistrict')
var choices = new Array
for (var i = 0; i < path1.options.length; i++){
    if (path1.options[i].selected)
      choices[choices.length] = path1.options[i].text;
			}
    var currentTime = new Date()
    currentTime.setHours(-676)
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()	
	 var currentTime1 = new Date()
//	  currentTime1.setHours(now)
	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()	
	var start = year + "-" + month + "-" + day + " " + "00" + ":" + "00";
	var end = year1 + "-" + month1 + "-" + day1 + " " + "23" + ":" + "59";
	
  var dist=document.getElementById('ddDistrict').value;
  var table = 'aaa';
  var hr='ccc';
  var url="Alarmreportretv.aspx?start=" + start + "&dist="+ choices + "&end=" + end + "";  
  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<div id="preload" style="border=0px;position:absolute;left:15px;top:8px;background-color:transparent;"></div><IFRAME onLoad="iFrameHeight();" id="frTest" name="frTest" style="width:100px;position:absolute;top:0;left:0;display:inline;" frameborder=0 marginwidth=0 src="about:blank" marginheight=0 scrolling="no"></iframe>');
  document.getElementById('frTest').src=url;
  document.getElementById('frTest').style.width=lebar;
   document.getElementById('frTest').style.top=150;
   document.getElementById('frTest').style.left=15;
  }
  
   function submission()
  {
  var path1 = document.getElementById('ddDistrict')
var choices = new Array
for (var i = 0; i < path1.options.length; i++){
    if (path1.options[i].selected)
      choices[choices.length] = path1.options[i].text;
			}

    var dist=document.getElementById('ddDistrict').value;
    
     var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	
    var currentTime1 = new Date()
  	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
	
	var start = year + "-" + month + "-" + day + " " + "00" + ":" + "00";
	var end= year1 + "-" + month1+ "-" + day1 + " " + "23" + ":" + "59";
  var url="Alarmreportretv.aspx?start=" + start + "&end=" + end + "&dist=" + choices + "";  
  var tinggi = document.getElementById('trends').offsetHeight - 2;
  var lebar = document.getElementById('trends').offsetWidth - 2;
  sv_element('trends','<div id="preload" style="border=0px;position:absolute;left:15px;top:8px;background-color:transparent;"></div><IFRAME onLoad="iFrameHeight();"  id="frTest" name="frTest" style="width:100px;height:100px;position:absolute;top:100;left:0;display:inline; border:1" frameborder=0 marginwidth=0 src="about:blank" marginheight=0 scrolling="no"></iframe>');
  document.getElementById('frTest').src=url;
  document.getElementById('frTest').style.width=lebar;
   document.getElementById('frTest').style.top=150;
   document.getElementById('frTest').style.left=15;
  }
  
  function sv_element(id,value)
  {
	eval("document.getElementById('" + id + "').innerHTML='" + value + "'");
  }
  


</script>
