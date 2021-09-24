<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>

<script runat="Server">

    Dim equipname
    Dim position
    Dim strBeginDate
    Dim strEndDate
    Dim intUserID
    Dim strBeginHour
    Dim strBeginMin
    Dim strEndHour
    Dim strEndMin
    Dim strBeginDateTime
    Dim strEndDateTime
    Dim siteid
    Sub Page_Load(ByVal Source As Object, ByVal E As EventArgs)
     
        strBeginDate = Request.Form("txtBeginDate")
        strEndDate = Request.Form("txtEndDate")
        strBeginHour = Request.Form("ddBeginHour")
        strBeginMin = Request.Form("ddBeginMinute")
        strEndHour = Request.Form("ddEndHour")
        strEndMin = Request.Form("ddEndMinute")
        position = Request.QueryString("position")
        equipname = Request.QueryString("equipname")
        siteId = Request.Form("siteid")
        
        If strBeginHour = "" Then
            strBeginHour = "00"
        End If

        If strBeginMin = "" Then
            strBeginMin = "00"
        End If

        If strEndHour = "" Then
            strEndHour = "23"
        End If

        If strEndMin = "" Then
            strEndMin = "59"
        End If

        If strBeginDate = "" Then
            strBeginDate = FormatDateTime(Now(), DateFormat.ShortDate)
        End If
 
        If strEndDate = "" Then
            strEndDate = FormatDateTime(Now(), DateFormat.ShortDate)
        End If

        strBeginDateTime = strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00"
        strEndDateTime = strEndDate & " " & strEndHour & ":" & strEndMin & ":59"
    End Sub
</script>

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

    <script language="JavaScript" src="TWCalendar.js"></script>

    <!-- TrendDetails.aspx || AlteringInProgress.aspx || slogin.aspx || baadTrendDetails.aspx -->
    <form name="formX" action="CascadeTDetails.aspx" method="POST">

        <script lanaguage="javascript" type="text/javascript">DrawCalendarLayout();</script>

        <div align="center">
            <table cellpadding="4" cellspacing="0" width="90%" style="font-family: verdana; border-bottom: 2px;
                border-bottom-color: Black;">
                <tr>
                    <td width="100%" height="20" colspan="4" align="center">
                        <img src="../images/TrendingSelection.jpg" alt="" />
                    </td>
                </tr>
                <tr>
                    <td height="10">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="font-size:13px; text-align: left; margin: 0;color: black"><b>Site Name:</b>
                        <font color="#5F7AFC"><%=request("sitename")%></font>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="font-size:13px; text-align: left; margin: 0;color: black">
                        <b>Site Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </b>
                        <font color="#5F7AFC"><%=request("siteid")%></font>
                    </td>
                </tr>
            </table>
        </div>
        <br />
       
        <div align="left">
            <table border="0" cellspacing="1" cellpadding="4" width="400" style="margin-left: 35px;
                border: solid 1px #336699">
                <tr>
                    <th colspan="7" style="background-color: #336699" align="center">
                        <font face="Verdana" size="2" color="white"><b>Selection Criteria </b></font>
                    </th>
                </tr>
                <tr>
                    <td width="80" align="right">
                        <font face="Verdana" size="1" color="black"><b>Select Type</b></font></td>
                    <td width="6">
                        <p align="center">
                            <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="200" colspan="4">
                        <select id="trendingtypename" size="1" name="trendingtype" style="color: #5F7AFC" onchange="javascript:goGetRule();">
                            <option value="00">Graphical</option>
                            <option value="01">Tabular</option>
                        </select>
                    </td>
                    <td align="right">
                        <a href="javascript:yesterdate();">
                            <img src="../images/last1day.jpg" border="0" alt="" /></a></td>
                </tr>
                <tr>
                    <td width="80" align="right">
                        <font face="Verdana" size="1" color="black"><b>Begin Date</b></font></td>
                    <td width="6">
                        <p align="center">
                            <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="200" colspan="4">
                        <input type="text" name="txtBeginDate" size="12" class="inputStyle" value="<%=strBeginDate%>"
                            readonly="readonly" />
                        <a href="javascript:ShowCalendar('txtBeginDate', 250, 250);">
                            <img border="1" src="../images/Calendar.jpg" width="19" height="14">
                        </a>
                    </td>
                    <td align="right">
                        <a href="javascript:twodaysdate();">
                            <img src="../images/last2days.jpg" border="0" alt="" /></a></td>
                </tr>
                <tr>
                    <td width="80">
                        <p align="right">
                            <font face="Verdana" size="1" color="black"><b>Hour</b></font></p>
                    </td>
                    <td width="6">
                        <p align="center">
                            <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="54">
                        <select size="1" name="ddBeginHour" class="FormDropdown2">
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
                        <p align="right">
                            <font face="Verdana" size="1" color="black"><b>Min</b></font>
                    </td>
                    <td width="5">
                        <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="100">
                        <select size="1" name="ddBeginMinute" class="FormDropdown2">
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
                    <td align="right">
                        <a href="javascript:lastweakdate();">
                            <img src="../images/1week.jpg" border="0" alt="" /></a></td>
                </tr>
                <tr>
                    <td width="80" align="right">
                        <font face="Verdana" size="1" color="black"><b>End Date </b></font>
                    </td>
                    <td width="6">
                        <p align="center">
                            <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="200" colspan="4">
                        <input type="text" name="txtEndDate" size="12" class="inputStyle" value="<%=strEndDate%>"
                            readonly />&nbsp; <a href="javascript:javascript:ShowCalendar('txtEndDate', 250, 250);">
                                <img border="1" src="../images/Calendar.jpg" width="19" height="14" alt="">
                            </a>
                    </td>
                    <td align="right">
                        <a href="javascript:lastmonthdate();">
                            <img src="../images/1-month.jpg" border="0" alt="" /></a></td>
                </tr>
                <tr>
                    <td width="80" style="height: 23px">
                        <p align="right">
                            <font face="Verdana" size="1" color="black"><b>Hour</b></font></p>
                    </td>
                    <td width="6" style="height: 23px">
                        <p align="center">
                            <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="54" style="height: 23px">
                        <select size="1" name="ddEndHour" class="FormDropdown2">
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
                    <td width="27" style="height: 23px">
                        <p align="right">
                            <font face="Verdana" size="1" color="black"><b>Min</b></font>
                    </td>
                    <td width="5" style="height: 23px">
                        <font face="Verdana" size="1" color="black"><b>:</b></font>
                    </td>
                    <td width="100" style="height: 23px">
                        <select size="1" name="ddEndMinute" class="FormDropdown2">
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
                    <td>
                    </td>
                </tr>
            </table>
            <p>
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <a href="javascript:submit();">
                    <img src="../images/Submit_s.jpg" border="0" alt="" /></a>&nbsp;&nbsp&nbsp<a href="javascript:history.back();"
                        target="main"><img border="0" src="../images/Back.jpg"></a>
            </p>
            <p>
                &nbsp;
            </p>
        </div>
        <%--<div align="right">
            <table border="0" cellspacing="1" cellpadding="5" style="width: 250px; top: 130px; color: white; font-family: Verdana;
                font-style: normal; background-image: none; z-index: 100; left: 474px; position: absolute;border: solid 1px #336699">
                <tr>
                    <th style="background-color: #336699" align="center">
                        <font face="Verdana" size="2" color="white"><b>Report Selection</b></font>
                    </th>
                </tr>
               
                <tr>
                    <td style="background-color: white; height: 1px;">&nbsp;&nbsp;<font face="Verdana" size="2">&nbsp;&nbsp; <a href="dailySummary1.aspx?&lab=Daily&sitename=<%=request("sitename")%>&siteid=<%=request("siteid")%>&position=<%=request("position")%>&equipname=<%=request("equipName")%>"
                            style="text-decoration:underline; font-weight: bold; color: #5F7AFC">Daily Summary Reports</a></font>
                    </td>
                </tr>
                <tr>
                    <td style="height: 1px; background-color: white">&nbsp&nbsp&nbsp&nbsp<font face="Verdana" size="2"><a href="WeeklySummary1.aspx?&lab=Weekly&sitename=<%=request("sitename")%>&siteid=<%=request("siteid")%>&position=<%=request("position")%>&equipname=<%=request("equipName")%>"
                            style="text-decoration:underline; font-weight: bold; color: #5F7AFC">Weekly Summary Reports</a></font></td>
                </tr>
                <tr>
                    <td style="height: 1px; background-color:white">&nbsp&nbsp&nbsp&nbsp<font face="Verdana" size="2" style="vertical-align: top; text-align: left"><a
                            href="MonthlySummary1.aspx?&lab=Monthly&sitename=<%=request("sitename")%>&siteid=<%=request("siteid")%>&position=<%=request("position")%>&equipname=<%=request("equipName")%>"
                            style="text-decoration:underline; font-weight: bold; color: #5F7AFC">Monthly Summary Reports</a></font></td>
                </tr>
                <tr>
                    <td style="height: 1px; background-color: white">&nbsp&nbsp&nbsp&nbsp<font face="Verdana" size="2" style="vertical-align: top; text-align: left"><a
                            href="AnnuallySummary1.aspx?&lab=Annually&sitename=<%=request("sitename")%>&siteid=<%=request("siteid")%>&position=<%=request("position")%>&equipname=<%=request("equipName")%>"
                            style="text-decoration:underline; font-weight: bold; color: #5F7AFC">Annually Summary Reports</a></font></td>
                </tr>
            </table>
        </div>--%>
        <input type="hidden" name="ddsite1" value="<%=request("siteid")%>,<%=request("position")%>" />
        <input type="hidden" name="sitename" value="<%=request("sitename")%>" />
        <input type="hidden" name="equipname" value="<%=request("equipname")%>" />
        <input type="hidden" id="HiddenField1" runat="server" name="txt1" value="Graphical" />
        <div style="top: 50; left: 400;">
            &nbsp;</div>
    </form>
</body>
</html>

<script language="javascript">
  //alert('<%=equipname %>');
  document.getElementById("ddBeginHour").value="<%=strBeginHour%>";
  document.getElementById("ddBeginMinute").value="<%=strBeginMin%>";
  document.getElementById("ddEndHour").value="<%=strEndHour%>";
  document.getElementById("ddEndMinute").value="<%=strEndMin%>";

  frmTargetForm = "formX";


 function submit()
  {
   if (document.getElementById('HiddenField1').value=="Tabular")
	{
	  var obj=document.formX;
   
   obj.action="TabularTrend.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&position=<%=request("position")%>&equipname=<%=request("equipname")%>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
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
	
	if (month<10)
	{
	month="0"+month
	}else
	{
	month
	}
	if (day<10)
	{
	day="0"+day
	}else
	{
	day
	}
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
    obj.action="TabularTrend.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&position=<%=request("position")%>&equipname=<%=request("equipname")%>";
       obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
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
    obj.action="TabularTrend.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&position=<%=request("position")%>&equipname=<%=request("equipname")%>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }
  }
  function lastweakdate()
  {
    var currentTime = new Date()
    currentTime.setHours(-154)
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
    obj.action="TabularTrend.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&position=<%=request("position")%>&equipname=<%=request("equipname")%>"
    obj.submit();
	}	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
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
    obj.action="TabularTrend.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&position=<%=request("position")%>&equipname=<%=request("equipname")%>";
    obj.submit();
	}
	
	if (document.getElementById('HiddenField1').value=="Graphical")
	{
      document.formX.submit();
     }
  }
 function goGetRule()
{
var d=document.getElementById("trendingtypename");
var selected=d.options[d.selectedIndex].text;

document.getElementById('HiddenField1').value=selected;

}
</script>

