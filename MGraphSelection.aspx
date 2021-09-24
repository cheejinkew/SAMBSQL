<%@ Page Language="VB" %>

<% 
    Dim strBeginDate As String = Now().ToString("yyyy/MM/dd")
    Dim strEndDate As String = Now().ToString("yyyy/MM/dd")
    
    Dim begindatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("begindatetime")))
    Dim enddatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("enddatetime")))
    
    Dim begindate = begindatetime.ToString().Split(" ")(0)
    Dim bh = begindatetime.ToString().Split(" ")(1).Split(":")(0)
    Dim bm = begindatetime.ToString().Split(" ")(1).Split(":")(1)
    
    Dim enddate = enddatetime.ToString().Split(" ")(0)
    Dim eh = enddatetime.ToString().Split(" ")(1).Split(":")(0)
    Dim em = enddatetime.ToString().Split(" ")(1).Split(":")(1)
    
    
    Dim district = Request.QueryString("district")
    Dim site1 = Request.QueryString("site1")
    Dim site2 = Request.QueryString("site2")
    Dim site3 = Request.QueryString("site3")
    Dim site4 = Request.QueryString("site4")
    Dim interval = Request.QueryString("interval")
  
        
    Dim style = Request.QueryString("style")
        
    Dim y1min = Request.QueryString("y1min")
    Dim y1max = Request.QueryString("y1max")
        
    Dim y2min = Request.QueryString("y2min")
    Dim y2max = Request.QueryString("y2max")
        
    Dim y3min = Request.QueryString("y3min")
    Dim y3max = Request.QueryString("y3max")
        
    Dim y4min = Request.QueryString("y4min")
    Dim y4max = Request.QueryString("y4max")
        
    Dim operation = Request.QueryString("operation")
        
        
        
    Dim xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmin")))
    Dim xmax = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
    
    
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
    function back()
    {
        var obj=document.getElementById("trendselectionform")
        obj.target="main";
        obj.submit();
    }
    function mysubmit()
    {
   var obj=document.getElementById("mgraphselectionform")
   
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
    var obj=document.getElementById("mgraphselectionform")
        
    document.getElementById("operation").value="style";
    var intervaldropdownlistobj=window.parent.frames[2].document.getElementById("intervaldropdownlist");
    if(intervaldropdownlistobj!=null)
    {
        document.getElementById("interval").value=intervaldropdownlistobj.value;
    }
    var intervalcheckobj=window.parent.frames[2].document.getElementById("intervalcheck");
    if(intervalcheckobj!=null)
    {
        document.getElementById("xys").value=intervalcheckobj.value;
    }
          
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
            <tr>
                <td colspan="2" align="right">
                    <table border="1" style="border: solid 1px #CBD6E4;" cellspacing="3">
                        <tr>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/mtstyle1.gif" title="Line Chart" alt="Line Chart" style="width: 100px;
                                    height: 75px; cursor: hand;" onclick="styleclick(1);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/mtstyle2.gif" title="3D Line Chart" alt="3D Line Chart" style="width: 100px;
                                    height: 75px; cursor: hand;" onclick="styleclick(2);" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/mtstyle3.gif" title="Area Chart" alt="Area Chart" style="width: 100px;
                                    height: 75px; cursor: hand;" onclick="styleclick(3);" />
                            </td>
                            <td style="border: solid 1px #CBD6E4;" valign="middle" align="center" onmouseover="over(this);"
                                onmouseout="out(this);">
                                <img src="images/mtstyle4.gif" title="3D Bar Chart" alt="3D Bar Chart" style="width: 100px;
                                    height: 75px; cursor: hand;" onclick="styleclick(4);" />
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
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Site1&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="isitename" class="inputStyle" value="<%=site1 %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Site2&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="isiteid" class="inputStyle" value="<%=site2 %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Site3&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="iequipment" class="inputStyle" value="<%=site3 %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Site4&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" id="iposition" class="inputStyle" value="<%=site4 %>" readonly></td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px">Begin Date&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" name="txtBeginDate" id="txtBeginDate" class="inputdate" value="<%=begindate %>" />&nbsp;
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
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <b style="font-family: Verdana; color: #5F7AFC; font-size: 11px;">End Date&nbsp;:&nbsp;</b></td>
                <td>
                    <input type="text" name="txtEndDate" id="txtEndDate" class="inputdate" value="<%=enddate %>" />&nbsp;
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
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <a href="javascript:back();">
                        <img style="border: solid 0px white;" title="Back" alt="Back" src="images/back.jpg" /></a></td>
                <td align="right">
                    <br />
                    <a href="javascript:mysubmit();">
                        <img style="border: solid 0px white;" title="Submit" alt="Submit" src="images/Submit_s.jpg" /></a></td>
            </tr>
        </table>
    </form>
    <form id="mgraphselectionform" action="MTrendingWithZoom.aspx" method="get">
        <input type="hidden" name="begindatetime" id="begindatetime" value="<%=begindatetime %>" />
        <input type="hidden" name="enddatetime" id="enddatetime" value="<%=enddatetime  %>" />
        <input type="hidden" name="xmin" id="xmin" value="<%=xmin %>" />
        <input type="hidden" name="xmax" id="xmax" value="<%=xmax %>" />
        <input type="hidden" name="district" id="district" value="<%=district %>" />
        <input type="hidden" name="site1" id="site1" value="<%=site1%>" />
        <input type="hidden" name="site2" id="site2" value="<%=site2%>" />
        <input type="hidden" name="site3" id="site3" value="<%=site3%>" />
        <input type="hidden" name="site4" id="site4" value="<%=site4%>" />
        <input type="hidden" name="interval" id="interval" value="<%=interval %>" />
        <input type="hidden" name="style" id="style" value="<%=style %>" />
        <input type="hidden" name="y1min" id="y1min" value="<%=y1min %>" />
        <input type="hidden" name="y1max" id="y1max" value="<%=y1max %>" />
        <input type="hidden" name="y2min" id="y2min" value="<%=y2min %>" />
        <input type="hidden" name="y2max" id="y2max" value="<%=y2max %>" />
        <input type="hidden" name="y3min" id="y3min" value="<%=y3min %>" />
        <input type="hidden" name="y3max" id="y3max" value="<%=y3max %>" />
        <input type="hidden" name="y4min" id="y4min" value="<%=y4min %>" />
        <input type="hidden" name="y4max" id="y4max" value="<%=y4max %>" />
        <input type="hidden" name="operation" id="operation" value="<%=operation %>" />
        <input type="hidden" name="xys" id="xys" value="0" />
    </form>
    <form id="trendselectionform" action="TrendSelection.aspx" method="post">
        <input type="hidden" name="ddDistrict" value="<%=district %>" />
        <input type="hidden" name="ddSite1" value="<%=site1 %>" />
        <input type="hidden" name="ddSite2" value="<%=site2%>" />
        <input type="hidden" name="ddSite3" value="<%=site3%>" />
        <input type="hidden" name="ddSite4" value="<%=site4%>" />
        <input type="hidden" name="txtBeginDate" value="<%=begindatetime.ToString().Split(" ")(0) %>" />
        <input type="hidden" name="ddBeginHour" value="<%=begindatetime.ToString().Split(" ")(1).Split(":")(0) %>" />
        <input type="hidden" name="ddBeginMinute" value="<%=begindatetime.ToString().Split(" ")(1).Split(":")(1) %>" />
        <input type="hidden" name="txtEndDate" value="<%=enddatetime.ToString().Split(" ")(0) %>" />
        <input type="hidden" name="ddEndHour" value="<%=enddatetime.ToString().Split(" ")(1).Split(":")(0) %>" />
        <input type="hidden" name="ddEndMinute" value="<%=enddatetime.ToString().Split(" ")(1).Split(":")(1) %>" />
        <input type="hidden" name="back" id="back" value="true" />
    </form>

    <script type="text/javascript">
    document.getElementById("ddBeginHour").value="<%=bh %>";
    document.getElementById("ddBeginMinute").value="<%=bm %>";
    document.getElementById("ddEndHour").value="<%=eh %>";
    document.getElementById("ddEndMinute").value="<%=em %>";
    </script>

</body>
</html>
