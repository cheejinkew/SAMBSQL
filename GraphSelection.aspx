<%@ Page Language="VB" %>

<% 
    Dim strBeginDate As String = Now().ToString("yyyy/MM/dd")
    Dim strEndDate As String = Now().ToString("yyyy/MM/dd")
    
    Dim siteid As String = Request.QueryString("siteid")
    Dim position As String = Request.QueryString("position")
    Dim district As String = Request.QueryString("district")
    Dim sitename As String = Request.QueryString("sitename")
    Dim equipment As String = Request.QueryString("equipname")
    Dim sitetype As String = Request.QueryString("sitetype")
    
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
body
{
}
.inputStyle
{
	color: #0B3D62;
	font-size: 10pt;
	font-family: Verdana;
	border-width: 1px;
	border-style: solid;
	border-color: #CBD6E4;
	width:130px;
	
}

.inputdate
{
	color: #0B3D62;
	font-size: 10pt;
	font-family: Verdana;
	border-width: 1px;
	border-style: solid;
	border-color: #CBD6E4;
	width:102px;
	
}
</style>
    <title></title>

    <script language="JavaScript" src="TWCalendar.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
function rightpageload()
{
   var obj=document.getElementById("graphselectionform");
   //var obj=document.graphselectionform;
   //obj.action="STrendingWithZoom.aspx?begindatetime=2006/07/29 14:00&enddatetime=2006/07/29 23:00&siteid=9024&position=2&interval=30&district=Kuala Terengganu&equipment=Water Level";
    //obj.action="STrendingWithZoom.aspx";
    obj.target="main";
    obj.submit();
}
function mysubmit()
{
   var obj=document.getElementById("graphselectionform")
   
   var begindatetime=document.getElementById("txtBeginDate").value;
   begindatetime+=" "+document.getElementById("ddBeginHour").value+":"+document.getElementById("ddBeginMinute").value;
   var enddatetime=document.getElementById("txtEndDate").value;
   enddatetime+=" "+document.getElementById("ddEndHour").value+":"+document.getElementById("ddEndMinute").value;
      
  
   document.getElementById("begindatetime").value=begindatetime;
   document.getElementById("enddatetime").value=enddatetime;
   
   document.getElementById("xmin").value=begindatetime;
   document.getElementById("xmax").value=enddatetime;
   document.getElementById("operation").value="submit";
      
   obj.target="main";
   obj.submit();
}
  function styleclick(style)
  {
    document.getElementById("style").value=style;
    var obj=document.getElementById("graphselectionform")
        
    document.getElementById("operation").value="style";
          
    obj.target="main";
    obj.submit();
  }
  function over(obj)
  {
    //obj.style.border="red solid 1px;";
    obj.style.border="1px solid red";
  }
  function out(obj)
  {
    obj.style.border="1px solid #CBD6E4";
  }

    </script>

</head>
<body style="font-family: Verdana; color: #5F7AFC; font-size: 9px;">
    <form name="form1" id="form1">

        <script language="javascript" type="text/javascript">
        DrawCalendarLayout();
        HideCalendar();
        frmTargetForm = "form1";
        function ShowCalendar(strTargetDateField, intLeft, intTop)
        {
            txtTargetDateField = strTargetDateField;
            var divTWCalendar=document.getElementById("divTWCalendar");
            divTWCalendar.style.visibility = 'visible';
            divTWCalendar.style.left = intLeft;
            divTWCalendar.style.top = intTop;
           
        }
        </script>

        <table cellpadding="0" cellspacing="3">
            <tr>
                <td colspan="2">
                    <img src="images/TrendingSelection.jpg" alt="TrendingSelection" />
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <b style="font-family: Verdana; font-size: 11px; color: #5F7AFC">Chart Styles&nbsp;:&nbsp;</b></td>
            </tr>
            <!-- <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: x-small">Style&nbsp;:&nbsp;</b></td>
                <td>
                    <select size="1" name="iddstyle" class="FormDropdown2" style="width: 135px" onchange="stylechange();">
                        <option value="1">Simple Bar</option>
                        <option value="2">Cylinder Bar</option>
                        <option value="3" selected="selected">Simple Line</option>
                        <option value="4">Step Line</option>
                        <option value="5">Simple Area</option>
                        <option value="6">Enhanced Area</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: x-small">3D Style :&nbsp;</b></td>
                <td>
                    <input type="radio" id="ithreed" onclick="threedclick()" />
                </td>
            </tr>-->
            <tr height="100">
                <td colspan="2" align="right">
                    <table border="1" style="border: solid 1px #CBD6E4;" cellspacing="3">
                        <tr>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style1.gif" title="Simple Bar Chart" alt="Simple Bar Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(1);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style2.gif" title="3D Bar Chart" alt="3D Bar Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(2);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style3.gif" title="Cylinder Bar Chart" alt="Cylinder Bar Chart"
                                    style="width: 40px; height: 40px; cursor: hand;" onclick="styleclick(3);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style4.gif" title="3D Cylinder Chart" alt="3D Cylinder Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(4);" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style5.gif" title="Simple Line Chart" alt="Simple Line Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(5);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style6.gif" title="3D Line Chart" alt="3D Line Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(6);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style7.gif" title="Step Line Chart" alt="Step Line Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(7);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style8.gif" title="3D Step Line Chart" alt="3D Step Line Chart"
                                    style="width: 40px; height: 40px; cursor: hand;" onclick="styleclick(8);" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style9.gif" title="Simple Area Chart" alt="Simple Area Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(9);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style10.gif" title="3D Area Chart" alt="3D Area Chart" style="width: 40px;
                                    height: 40px; cursor: hand;" onclick="styleclick(10);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style11.gif" title="Enhanced Area Chart" alt="Enhanced Area Chart"
                                    style="width: 40px; height: 40px; cursor: hand;" onclick="styleclick(11);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/style11.gif" title="3D Enhanced Area Chart" alt="3D Enhanced Area Chart"
                                    style="width: 40px; height: 40px; cursor: hand;" onclick="styleclick(12);" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px;">District&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="idistrict" class="inputStyle" value="<%=district %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Sitename&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="isitename" class="inputStyle" value="<%=sitename %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">SiteID&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="isiteid" class="inputStyle" value="<%=siteid %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Equipment&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="iequipment" class="inputStyle" value="<%=equipment %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Position&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="iposition" class="inputStyle" value="<%=position %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Begin Date&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" name="txtBeginDate" id="txtBeginDate" class="inputdate" value="<%=strBegindate %>" />&nbsp;
                    <a href="javascript:ShowCalendar('txtBeginDate', 10, 120);">
                        <img border="1" src="images/Calendar.jpg" width="19" height="14">
                    </a>
                </td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Hour&nbsp;:&nbsp;</b></td>
                <td>
                    <select size="1" name="ddBeginHour" id="ddBeginHour" class="FormDropdown2" style="width: 40px;">
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
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="font-family: Verdana; color: #5F7AFC; font-size: 11px;">Min&nbsp;:&nbsp;</b>
                    <select size="1" name="ddBeginMinute" id="ddBeginMinute" class="FormDropdown2" style="width: 40px;">
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
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px;">End Date&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" name="txtEndDate" id="txtEndDate" class="inputdate" value="<%=strEndDate %>" />&nbsp;
                    <a href="javascript:ShowCalendar('txtEndDate', 10, 120);">
                        <img border="1" src="images/Calendar.jpg" width="19" height="14" />
                    </a>
                </td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px;">Hour&nbsp;:&nbsp;</b></td>
                <td>
                    <select size="1" name="ddEndHour" id="ddEndHour" class="FormDropdown2" style="width: 40px;">
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
                        <option value="23" selected="selected">23</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="font-family: Verdana; color: #5F7AFC; font-size: 11px;">Min&nbsp;:&nbsp;</b>
                    <select size="1" name="ddEndMinute" id="ddEndMinute" class="FormDropdown2" style="width: 40px;">
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
                        <option value="59" selected="selected">59</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <a href="left.aspx?ddDistrict=Kuala Terengganu&ddType=RESERVOIR&backurl=Summary.aspx&siteid=<%=siteid %>&sitename=<%=sitename %>&district=<%=district %>&sitetype=<%=sitetype %>">
                        <img style="border: solid 0px white;" title="Back" alt="Back" src="images/back.jpg" /></a></td>
                <td align="right">
                    <br />
                    <a href="javascript:mysubmit();">
                        <img style="border: solid 0px white;" title="Submit" alt="Submit" src="images/Submit_s.jpg" /></a></td>
            </tr>
        </table>
    </form>
    <form id="graphselectionform" action="STrendingWithZoom.aspx" method="get">
        <input type="hidden" name="begindatetime" id="begindatetime" value="<%=strBeginDate %> 00:00" />
        <input type="hidden" name="enddatetime" id="enddatetime" value="<%=strEndDate %> 23:59" />
        <input type="hidden" name="siteid" id="siteid" value="<%=siteid %>" />
        <input type="hidden" name="position" id="position" value="<%=position %>" />
        <input type="hidden" name="equipment" id="equipment" value="<%=equipment%>" />
        <input type="hidden" name="district" id="district" value="<%=district %>" />
        <input type="hidden" name="interval" id="interval" value="15" />
        <input type="hidden" name="style" id="style" value="12" />
        <input type="hidden" name="xmin" id="xmin" value="<%=strBeginDate %> 00:00" />
        <input type="hidden" name="xmax" id="xmax" value="<%=strEndDate %> 23:59" />
        <input type="hidden" name="ymin" id="ymin" value="0" />
        <input type="hidden" name="ymax" id="ymax" value="0" />
        <input type="hidden" name="x1" id="x1" value="0" />
        <input type="hidden" name="y1" id="y1" value="0" />
        <input type="hidden" name="x2" id="x2" value="0" />
        <input type="hidden" name="y2" id="y2" value="0" />
        <input type="hidden" name="operation" id="operation" value="submit" />
        <input type="hidden" name="xys" id="xys" value="1" />

        <script language="javascript" type="text/javascript">
        rightpageload();
        </script>

    </form>
</body>
</html>
