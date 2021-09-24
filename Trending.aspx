<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<Script runat="Server">

   dim strBeginDate
   dim strEndDate
   dim intUserID
   dim strBeginHour
   dim strBeginMin
   dim strEndHour 
   dim strEndMin
   dim strBeginDateTime 
   dim strEndDateTime
     
   Sub Page_Load(Source As Object, E As EventArgs) 

     strBeginDate = Request.Form("txtBeginDate")
     strEndDate =  Request.Form("txtEndDate")
     strBeginHour= request.form("ddBeginHour")
     strBeginMin = request.form("ddBeginMinute")
     strEndHour = request.form("ddEndHour")
     strEndMin = request.form("ddEndMinute")
     
     if strBeginHour ="" then
       strBeginHour ="00"
     end if

     if strBeginMin ="" then
       strBeginMin ="00"
     end if

     if strEndHour ="" then
       strEndHour ="23"
     end if

     if strEndMin ="" then
       strEndMin ="59"
     end if

     if strBeginDate ="" then
       strBeginDate = formatdatetime(Now(),DateFormat.ShortDate)
     end if
 
     if strEndDate ="" then
       strEndDate = formatdatetime(Now(),DateFormat.ShortDate)
     end if

     strBeginDateTime = strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00"
     strEndDateTime = strEndDate & " " & strEndHour & ":" & strEndMin & ":59"   
  End Sub
</Script>

<html>
<head>
<style>

.bodytxt 
   {
   font-weight: normal;
   font-size: 11px;
   color: #333333;
   line-height: normal;
   font-family: Verdana, Arial, Helvetica, sans-serif;
   }

 a {text-decoration: none;} 

.menuFrame
   {
   frameborder:1;
   width:100%;
   height:100px;
   marginwidth:0px;
   marginheight:0px;
   padding:0px;
   border-width:1px;
   border-style: solid;
   border-color:#5F7AFC;
   scrolling:no;
   }

.FormDropdown2 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 40px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }

.inputStyle
{
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  font-family: Verdana;
  font-size: 10pt;
  color: #3952F9;
  height: 20
}
</style>

</head>
<body>
<script language="JavaScript" src="TWCalendar.js?r=1"></script>
<!-- TrendDetails.aspx || AlteringInProgress.aspx || slogin.aspx || baadTrendDetails.aspx -->
<form name="formX" action="TrendDetails_sajWithTableSummary.aspx" method="POST">
<script lanaguage="javascript">DrawCalendarLayout();</script>

<%
	dim SiteID = request.querystring("siteid")
	dim SiteName = request.querystring("sitename")
	dim District = request.querystring("district")
	dim Position = request.QueryString("position")
    Dim EquipName = Request.QueryString("equipname")
    Dim version = Request.QueryString("v")
%>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="70%">
    <tr>
      <td width="100%" height="50" colspan="4">
        <p align="center"><img border="0" src="images/TrendingSelection.jpg">
      </td>
    </tr>
  </table>
</div>
<%
   	dim objConn
   	dim rsRecords
   	dim strConn
	
   	if session("login") is nothing then
   	  response.redirect ("login.aspx")
   	end if
	
	dim hreflink as string
	hreflink = "cascade.aspx?siteid=" & siteid & "&sitename=" & sitename & "&district=" & district
	if SiteID = "" then exit sub
	%>
<table width="409" border="1">
  <tr>
    <td width="200"><div align="right">District : </div></td>
    <td width="193"><input type="text" name="dddistrict" value="<%=district%>" readonly></td>
  </tr>
  <tr>
    <td><div align="right">Site ID : </div></td>
    <td><input type="text" name="siteid" value="<%=siteid%>" readonly>
		<input type="hidden" name="ddsite1" value="<%=trim(siteid)%>,<%=position%>">
		<input type="hidden" name="ddsite2" value="<%=trim(siteid)%>,<%=position%>">
        <input type ="hidden" name="v" value ="<%=version%>" />
    </td>    
  </tr>
  <tr>
    <td><div align="right">Site Name : </div></td>
    <td><input type="text" name="sitename" value="<%=sitename%>" readonly></td>
  </tr>
  <tr>
    <td><div align="right">Equipment :</div></td>
    <td><input type="text" name="equipname" value="<%=equipname%>" readonly></td>
  </tr>
  <tr>
    <td><div align="right">Position : </div></td>
    <td><input type="text" name="position" value="<%=position%>" readonly></td>
  </tr>
</table>
<table width="410" border="1">
  <tr>
    <td><div align="center"><a href="<%=hreflink%>" target="main">Cascade Diagram</a></div></td>
  </tr>
</table>


<br />

<table>
<tr>   
<td>
<font face="Verdana" size="2" color="#5F7AFC"><b>Select Trending Type :</font> 
<select id="trendingtypename" size="1" name="trendingtype" class="FormDropdown10" onchange="javascript:goGetRule();">
                   <option value="00">Graphical</option>
                   <option value="01">Tabular</option>
                   <option value="02">Summary Table</option>
                    </select>

</td>
</tr>


</table>


<br />
<table border="0" width="410">
<tr>
<td align=center>
    <a href="javascript:yesterdate();"><img src="images/last1day.jpg" border="0"></a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:twodaysdate();"><img src="images/last2days.jpg" border=0></a>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript:lastweakdate();"><img src="images/1week.jpg" border=0></a>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript:lastmonthdate();"><img src="images/1-month.jpg" border=0></a>
     </td>
 </tr>
 </table>
 <br />





<p><font face="Verdana" size="2" color="#5F7AFC"><b>Select Begin and End Date:</b></font>  <br>
  </p>

<div align="left">
  <table border="0" cellspacing="1" width="350">
    <tr>
      <td width="80"><font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font></td>
      <td width="6">
        <p align="center"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
      <td width="301" colspan="4">
        <input id="txtBeginDate" type="text" name="txtBeginDate" size="12" class="inputStyle"  
         value="<%=strBeginDate%>" readonly></font>&nbsp;
        <a href="javascript:ShowCalendar('txtBeginDate', 250, 300);">
          <img border="1" src="images/Calendar.jpg" width="19" height="14">
        </a>
     </td>
    </tr>

    <tr>
      <td width="80">
        <p align="right"><font face="Verdana" size="1" color="#5F7AFC"><b>Hour</b></font></p>
      </td>
      <td width="6">
        <p align="center"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
      <td width="54">
        <select id="ddBeginHour" size="1" name="ddBeginHour" class="FormDropdown2">
                   <option value="00">00</option>
                   <option value="01">01</option>
                   <option value="02">02</option>
                   <option value="03">03</option>
                   <option value="04">04</option>
                   <option value="05">05</option>
                   <option value="06">06</option>
                   <option value="07">07</option>
                   <option value="08">08</option>
                   <option value="09">09</option>
                   <option value="10">10</option>
                   <option value="11">11</option>
                   <option value="12">12</option>
                   <option value="13">13</option>
                   <option value="14">14</option>
                   <option value="15">15</option>
                   <option value="16">16</option>
                   <option value="17">17</option>
                   <option value="18">18</option>
                   <option value="19">19</option>
                   <option value="20">20</option>
                   <option value="21">21</option>
                   <option value="22">22</option>
                   <option value="23">23</option>
          </select> 
     </td>
      <td width="27">
        <p align="right"><font face="Verdana" size="1" color="#5F7AFC"><b>Min</b></font>
     </td>
      <td width="5">
        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
     </td>
      <td width="211">
        <select id="ddBeginMinute" size="1" name="ddBeginMinute" class="FormDropdown2">
                   <option value="00">00</option>
                   <option value="01">01</option>
                   <option value="02">02</option>
                   <option value="03">03</option>
                   <option value="04">04</option>
                   <option value="05">05</option>
                   <option value="06">06</option>
                   <option value="07">07</option>
                   <option value="08">08</option>
                   <option value="09">09</option>
                   <option value="10">10</option>
                   <option value="11">11</option>
                   <option value="12">12</option>
                   <option value="13">13</option>
                   <option value="14">14</option>
                   <option value="15">15</option>
                   <option value="16">16</option>
                   <option value="17">17</option>
                   <option value="18">18</option>
                   <option value="19">19</option>
                   <option value="20">20</option>
                   <option value="21">21</option>
                   <option value="22">22</option>
                   <option value="23">23</option>
                   <option value="24">24</option>
                   <option value="25">25</option>
                   <option value="26">26</option>
                   <option value="27">27</option>
                   <option value="28">28</option>
                   <option value="29">29</option>
                   <option value="30">30</option>
                   <option value="31">31</option>
                   <option value="32">32</option>
                   <option value="33">33</option>
                   <option value="34">34</option>
                   <option value="35">35</option>
                   <option value="36">36</option>
                   <option value="37">37</option>
                   <option value="38">38</option>
                   <option value="39">39</option>
                   <option value="40">40</option>
                   <option value="41">41</option>
                   <option value="42">42</option>
                   <option value="43">43</option>
                   <option value="44">44</option>
                   <option value="45">45</option>
                   <option value="46">46</option>
                   <option value="47">47</option>
                   <option value="48">48</option>
                   <option value="49">49</option>
                   <option value="40">50</option>
                   <option value="51">51</option>
                   <option value="52">52</option>
                   <option value="53">53</option>
                   <option value="54">54</option>
                   <option value="55">55</option>
                   <option value="56">56</option>
                   <option value="57">57</option>
                   <option value="58">58</option>
                   <option value="59">59</option>
          </select>              

     </td>
    </tr>

    <tr>
      <td width="80"><font face="Verdana" size="1" color="#5F7AFC"><b>End Date </b></font></td>
      <td width="6">
        <p align="center"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
      <td width="301" colspan="4">
        <input id="txtEndDate"  type="text" name="txtEndDate" size="12" class="inputStyle"  
          value="<%=strEndDate%>" readonly>&nbsp;
        <a href="javascript:javascript:ShowCalendar('txtEndDate', 250, 300);">
          <img border="1" src="images/Calendar.jpg" width="19" height="14">
        </a>
      </td>
    </tr>
    <tr>
      <td width="80">
        <p align="right"><font face="Verdana" size="1" color="#5F7AFC"><b>Hour</b></font></p>
      </td>
      <td width="6">
        <p align="center"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
      <td width="54">
        <select id="ddEndHour" size="1" name="ddEndHour" class="FormDropdown2">
                   <option value="00">00</option>
                   <option value="01">01</option>
                   <option value="02">02</option>
                   <option value="03">03</option>
                   <option value="04">04</option>
                   <option value="05">05</option>
                   <option value="06">06</option>
                   <option value="07">07</option>
                   <option value="08">08</option>
                   <option value="09">09</option>
                   <option value="10">10</option>
                   <option value="11">11</option>
                   <option value="12">12</option>
                   <option value="13">13</option>
                   <option value="14">14</option>
                   <option value="15">15</option>
                   <option value="16">16</option>
                   <option value="17">17</option>
                   <option value="18">18</option>
                   <option value="19">19</option>
                   <option value="20">20</option>
                   <option value="21">21</option>
                   <option value="22">22</option>
                   <option value="23">23</option>
          </select> 
     </td>
      <td width="27">
        <p align="right"><font face="Verdana" size="1" color="#5F7AFC"><b>Min</b></font>
     </td>
      <td width="5">
        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
     </td>
      <td width="211">
        <select id="ddEndMinute" size="1" name="ddEndMinute" class="FormDropdown2">
                   <option value="00">00</option>
                   <option value="01">01</option>
                   <option value="02">02</option>
                   <option value="03">03</option>
                   <option value="04">04</option>
                   <option value="05">05</option>
                   <option value="06">06</option>
                   <option value="07">07</option>
                   <option value="08">08</option>
                   <option value="09">09</option>
                   <option value="10">10</option>
                   <option value="11">11</option>
                   <option value="12">12</option>
                   <option value="13">13</option>
                   <option value="14">14</option>
                   <option value="15">15</option>
                   <option value="16">16</option>
                   <option value="17">17</option>
                   <option value="18">18</option>
                   <option value="19">19</option>
                   <option value="20">20</option>
                   <option value="21">21</option>
                   <option value="22">22</option>
                   <option value="23">23</option>
                   <option value="24">24</option>
                   <option value="25">25</option>
                   <option value="26">26</option>
                   <option value="27">27</option>
                   <option value="28">28</option>
                   <option value="29">29</option>
                   <option value="30">30</option>
                   <option value="31">31</option>
                   <option value="32">32</option>
                   <option value="33">33</option>
                   <option value="34">34</option>
                   <option value="35">35</option>
                   <option value="36">36</option>
                   <option value="37">37</option>
                   <option value="38">38</option>
                   <option value="39">39</option>
                   <option value="40">40</option>
                   <option value="41">41</option>
                   <option value="42">42</option>
                   <option value="43">43</option>
                   <option value="44">44</option>
                   <option value="45">45</option>
                   <option value="46">46</option>
                   <option value="47">47</option>
                   <option value="48">48</option>
                   <option value="49">49</option>
                   <option value="40">50</option>
                   <option value="51">51</option>
                   <option value="52">52</option>
                   <option value="53">53</option>
                   <option value="54">54</option>
                   <option value="55">55</option>
                   <option value="56">56</option>
                   <option value="57">57</option>
                   <option value="58">58</option>
                   <option value="59">59</option>
          </select>              
     </td>
    </tr>
    <tr style="visibility:hidden;display:none;">
    <td width="80"><font face="Verdana" size="1" color="#5F7AFC"><b>X Axis Scale</b></font></td>
    <td width="6">
        <p align="center"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
        <td><select size="1" id="ddXScale" name="ddXScale" class="FormDropdown2">
                   <option value="10">10</option>
                   <option value="15">15</option>
                   <option value="20">20</option>
                   <option value="25">25</option>
                   <option value="30">30</option>
                   <option value="40">40</option>
                   <option value="45">45</option>
                   <option value="50">50</option>
                   <option value="60">60</option>
                                                      
          </select>     </td>
        <td></td></tr>
  </table>

  <p>
    <a href="javascript:submit();"><img src="images/Submit_s.jpg" border=0></a>
  </p>
  <p>&nbsp; </p>
  <input type="hidden" id="HiddenField1" runat="server" name="HiddenField1" value="Graphical" />

</div>
</form>

</body>
</html>

<script language="javascript">
  
  document.getElementById("ddBeginHour").value="<%=strBeginHour%>";
  document.getElementById("ddBeginMinute").value="<%=strBeginMin%>";
  document.getElementById("ddEndHour").value="<%=strEndHour%>";
  document.getElementById("ddEndMinute").value="<%=strEndMin%>";
  document.getElementById("ddXScale").value='15';

  frmTargetForm = "formX";

  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
  }
  
  function submit()
  {
   if (document.getElementById('HiddenField1').value=="Tabular")
	{
	  var obj=document.formX;
    obj.action="TabularTrend.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }

     if (document.getElementById('HiddenField1').value == "Summary Table") {
         var obj = document.formX;
         obj.action = "TabularTrendSummaryTable.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
         obj.submit();
     }
  }
     
   function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
  }

  function yesterdate()
  {
    var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	
	document.getElementById('txtBeginDate').value = year + "-" + month + "-" + day;
	document.getElementById('ddBeginHour').value ='00';
	document.getElementById('ddBeginMinute').value ='00';
	var date=year + "-" + month + "-" + day; 
	document.getElementById('txtEndDate').value = year + "-" + month + "-" + day;
	document.getElementById('ddEndHour').value=23;
	document.getElementById('ddEndMinute').value=59;
	var date1=year + "-" + month + "-" + day; 
	if (document.getElementById('HiddenField1').value=="Tabular")
	{
   var obj=document.formX;
    obj.action="TabularTrend.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District%>";
       obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }

     if (document.getElementById('HiddenField1').value == "Summary Table") {
         var obj = document.formX;
         obj.action = "TabularTrendSummaryTable.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
         obj.submit();
     }
  }
  function twodaysdate()
  {
    var currentTime = new Date()
	currentTime.setHours(-24)
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	
	  var currentTime1 = new Date()
		var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
	
	document.getElementById('txtBeginDate').value = year + "-" + month + "-" + day;
	document.getElementById('ddBeginHour').value = '00';
	document.getElementById('ddBeginMinute').value ='00';
	
	document.getElementById('txtEndDate').value = year1 + "-" + month1 + "-" + day1;
	document.getElementById('ddEndHour').value=23;
	document.getElementById('ddEndMinute').value=59;

 if (document.getElementById('HiddenField1').value=="Tabular")
	{
	
	    var obj=document.formX;
    obj.action="TabularTrend.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }

     if (document.getElementById('HiddenField1').value == "Summary Table") {
         var obj = document.formX;
         obj.action = "TabularTrendSummaryTable.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
         obj.submit();
     }
  }
  function lastweakdate()
  {
    var currentTime = new Date()
    currentTime.setHours(-144)
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	
	
	 var currentTime1 = new Date()
	  	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
	
	document.getElementById('txtBeginDate').value = year + "-" + month + "-" + day;
	document.getElementById('ddBeginHour').value = '00';
	document.getElementById('ddBeginMinute').value ='00';
	
	document.getElementById('txtEndDate').value = year1 + "-" + month1+ "-" + day1;
	document.getElementById('ddEndHour').value=23;
	document.getElementById('ddEndMinute').value=59;

   if (document.getElementById('HiddenField1').value=="Tabular")
	{
	
	   var obj=document.formX;
    obj.action="TabularTrend.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }

     if (document.getElementById('HiddenField1').value == "Summary Table") {
         var obj = document.formX;
         obj.action = "TabularTrendSummaryTable.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
         obj.submit();
     }
  }
  function lastmonthdate()
  {
    var currentTime = new Date()
    currentTime.setHours(-700)
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate() 
	var year = currentTime.getFullYear()
	
	
	 var currentTime1 = new Date()
	var month1 = currentTime1.getMonth() + 1
	var day1 = currentTime1.getDate() 
	var year1 = currentTime1.getFullYear()
	
	document.getElementById('txtBeginDate').value = year + "-" + month + "-" + day;
	document.getElementById('ddBeginHour').value = '00';
	document.getElementById('ddBeginMinute').value ='00';
	
	document.getElementById('txtEndDate').value = year1 + "-" + month1+ "-" + day1;
	document.getElementById('ddEndHour').value=23;
	document.getElementById('ddEndMinute').value=59;
    if (document.getElementById('HiddenField1').value=="Tabular")
	{
	
	   var obj=document.formX;
    obj.action="TabularTrend.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }

     if (document.getElementById('HiddenField1').value == "Summary Table") {
         var obj = document.formX;
         obj.action = "TabularTrendSummaryTable.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>";
         obj.submit();
     }
  }
   
 function goGetRule()
{
var d=document.getElementById("trendingtypename");
var selected=d.options[d.selectedIndex].text;

document.getElementById('HiddenField1').value=selected;

}

</script>