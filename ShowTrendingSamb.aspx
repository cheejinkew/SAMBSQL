<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ShowTrendingSamb.aspx.vb" Inherits="ShowTrendingSamb" %>

<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Skid Tank Analysis Report & Chart</title>

    <script type="text/javascript" language="javascript" src="jsfiles/calendar.js"></script>

    <link type="text/css" href="cssfiles/balloontip.css" rel="stylesheet" />

    <script type="text/javascript" src="jsfiles/balloontip.js"></script>

    <script type="text/javascript" language="javascript">  
var ec=<%=ec %>;
function mysubmit()
{
    var District=document.getElementById("ddlDistrict").value;
    if (District=="--Select District Name--")
    {
        alert("Please select District name");
        return false;
     }   
   
  var bigindatetime=document.getElementById("txtBeginDate").value;
    var enddatetime=document.getElementById("txtEndDate").value;
    
    
    var fdate=Date.parse(bigindatetime);
    var sdate=Date.parse(enddatetime);
    
    var diff=(sdate-fdate)*(1/(1000*60*60*24));
    var days=parseInt(diff)+1;
    if(days>1)
    {
        alert("You are not allow to select "+days+" days of data.");
        return false
    }else {
    return true;
     }
}

function CheckItem()
{
   var check=document.getElementById("chkCheckAll")
    if (check.checked)
    {
       document.getElementById("chkFirstTime").checked=true;
        document.getElementById("chkSecondTime").checked=true;
         document.getElementById("chkThirdTime").checked=true;
          document.getElementById("chkAll").checked=true;
    }  else{
     
         document.getElementById("chkFirstTime").checked=false;
        document.getElementById("chkSecondTime").checked=false;
         document.getElementById("chkThirdTime").checked=false;
          document.getElementById("chkAll").checked=false;
    } 
   
  
}
function ExcelReport()
{
    if(ec==true)
    {
        var plateno=document.getElementById("ddlpleate").value;
       
        document.getElementById("plateno").value=plateno;

        var excelformobj=document.getElementById("excelform");
        excelformobj.submit();
    }
    else
    {
        alert("First click submit button");
    }
}
function ShowCalendar(strTargetDateField, intLeft, intTop)
{
    txtTargetDateField = strTargetDateField;
    
    var divTWCalendarobj=document.getElementById("divTWCalendar");
    divTWCalendarobj.style.visibility = 'visible';
    divTWCalendarobj.style.left = intLeft+"px";
    divTWCalendarobj.style.top = intTop+"px";
       selecteddate(txtTargetDateField);  
}
function fullscreen()
{
    var colvalues=window.parent.document.getElementById("left").cols.split(",");
    var rowvalues=window.parent.document.getElementById("mainpage").rows.split(",");
    if(colvalues[0]>0)
    {
        window.parent.document.getElementById("left").cols="0,*";
	    window.parent.document.getElementById("mainpage").rows="0,*";
	    document.getElementById("fcimg").src="mapfiles/fullscreen2.gif";
    }
	else
	{
	    window.parent.document.getElementById("left").cols="230,*";
		window.parent.document.getElementById("mainpage").rows="75,*";
		document.getElementById("fcimg").src="mapfiles/fullscreen1.gif";
    }		    
}
 
function mouseover(path)
{
    document.getElementById("bigimage").src="vehiclebigimages/"+path;
}
function pmouseover(unitid,versionid,simno)
{
    document.getElementById("balloon2").innerHTML="Unit ID : "+unitid+"<br/>Version ID : "+versionid+"<br/>SIM No : "+simno;
}
function gmapmouseover(x,y)
{
    document.getElementById("mapimage").src="images/maploading.gif";
    document.getElementById("mapimage").src="GussmannMap.aspx?x="+x+"&y="+y;
}
 
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <center>
            <div>
            <script type="text/javascript" language="javascript">                DrawCalendarLayout();</script>
                <table width="95%">
                    <tr>
                        <td align="center">
                            <table style="font-family: Verdana; font-size: 11px;">
                                <tr>
                                    <td style="height: 20px; background-color: #465ae8;" align="left">
                                        <b style="color: White;">&nbsp;Show Trending Chart &nbsp;:</b></td>
                                </tr>
                                <tr>
                                    <td style="width: 420px; border: solid 1px #3952F9;">
                                        <table style="width: 483px;">
                                            <tbody>
                                                <tr>
                                                    <td align="left">
                                                        <b style="color: #5f7afc;">Begin Date</b>
                                                    </td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b>
                                                    </td>
                                                    <td align="left">
                                                        <input readonly="readonly" style="width: 70px;" type="text" value="<%=strBeginDate%>"
                                                            id="txtBeginDate" runat="server" name="txtBeginDate" enableviewstate="false" />&nbsp;<a
                                                                href="javascript:ShowCalendar('txtBeginDate', 250, 250);" style="text-decoration: none;">
                                                                <img alt="Show calendar control" title="Show calendar control" height="14" src="images/Calendar.jpg"
                                                                    width="19" style="border: solid 1px blue;" />
                                                            </a><!--<b style="color: #5f7afc;">&nbsp;Hour&nbsp;:&nbsp;</b>
                                                        <asp:DropDownList ID="ddlbh" runat="server" Width="40px" EnableViewState="False"
                                                            Font-Size="12px" Font-Names="verdana">
                                                            <asp:ListItem Value="00">00</asp:ListItem>
                                                            <asp:ListItem Value="01">01</asp:ListItem>
                                                            <asp:ListItem Value="02">02</asp:ListItem>
                                                            <asp:ListItem Value="03">03</asp:ListItem>
                                                            <asp:ListItem Value="04">04</asp:ListItem>
                                                            <asp:ListItem Value="05">05</asp:ListItem>
                                                            <asp:ListItem Value="06">06</asp:ListItem>
                                                            <asp:ListItem Value="07">07</asp:ListItem>
                                                            <asp:ListItem Value="08">08</asp:ListItem>
                                                            <asp:ListItem Value="09">09</asp:ListItem>
                                                            <asp:ListItem Value="10">10</asp:ListItem>
                                                            <asp:ListItem Value="11">11</asp:ListItem>
                                                            <asp:ListItem Value="12">12</asp:ListItem>
                                                            <asp:ListItem Value="13">13</asp:ListItem>
                                                            <asp:ListItem Value="14">14</asp:ListItem>
                                                            <asp:ListItem Value="15">15</asp:ListItem>
                                                            <asp:ListItem Value="16">16</asp:ListItem>
                                                            <asp:ListItem Value="17">17</asp:ListItem>
                                                            <asp:ListItem Value="18">18</asp:ListItem>
                                                            <asp:ListItem Value="19">19</asp:ListItem>
                                                            <asp:ListItem Value="20">20</asp:ListItem>
                                                            <asp:ListItem Value="21">21</asp:ListItem>
                                                            <asp:ListItem Value="22">22</asp:ListItem>
                                                            <asp:ListItem Value="23">23</asp:ListItem>
                                                        </asp:DropDownList><b style="color: #5f7afc;">&nbsp;Min&nbsp;:&nbsp;</b>
                                                        <asp:DropDownList ID="ddlbm" runat="server" Width="40px" EnableViewState="False"
                                                            Font-Size="12px" Font-Names="verdana">
                                                            <asp:ListItem Value="00">00</asp:ListItem>
                                                            <asp:ListItem Value="01">01</asp:ListItem>
                                                            <asp:ListItem Value="02">02</asp:ListItem>
                                                            <asp:ListItem Value="03">03</asp:ListItem>
                                                            <asp:ListItem Value="04">04</asp:ListItem>
                                                            <asp:ListItem Value="05">05</asp:ListItem>
                                                            <asp:ListItem Value="06">06</asp:ListItem>
                                                            <asp:ListItem Value="07">07</asp:ListItem>
                                                            <asp:ListItem Value="08">08</asp:ListItem>
                                                            <asp:ListItem Value="09">09</asp:ListItem>
                                                            <asp:ListItem Value="10">10</asp:ListItem>
                                                            <asp:ListItem Value="11">11</asp:ListItem>
                                                            <asp:ListItem Value="12">12</asp:ListItem>
                                                            <asp:ListItem Value="13">13</asp:ListItem>
                                                            <asp:ListItem Value="14">14</asp:ListItem>
                                                            <asp:ListItem Value="15">15</asp:ListItem>
                                                            <asp:ListItem Value="16">16</asp:ListItem>
                                                            <asp:ListItem Value="17">17</asp:ListItem>
                                                            <asp:ListItem Value="18">18</asp:ListItem>
                                                            <asp:ListItem Value="19">19</asp:ListItem>
                                                            <asp:ListItem Value="20">20</asp:ListItem>
                                                            <asp:ListItem Value="21">21</asp:ListItem>
                                                            <asp:ListItem Value="22">22</asp:ListItem>
                                                            <asp:ListItem Value="23">23</asp:ListItem>
                                                            <asp:ListItem Value="24">24</asp:ListItem>
                                                            <asp:ListItem Value="25">25</asp:ListItem>
                                                            <asp:ListItem Value="26">26</asp:ListItem>
                                                            <asp:ListItem Value="27">27</asp:ListItem>
                                                            <asp:ListItem Value="28">28</asp:ListItem>
                                                            <asp:ListItem Value="29">29</asp:ListItem>
                                                            <asp:ListItem Value="30">30</asp:ListItem>
                                                            <asp:ListItem Value="31">31</asp:ListItem>
                                                            <asp:ListItem Value="32">32</asp:ListItem>
                                                            <asp:ListItem Value="33">33</asp:ListItem>
                                                            <asp:ListItem Value="34">34</asp:ListItem>
                                                            <asp:ListItem Value="35">35</asp:ListItem>
                                                            <asp:ListItem Value="36">36</asp:ListItem>
                                                            <asp:ListItem Value="37">37</asp:ListItem>
                                                            <asp:ListItem Value="38">38</asp:ListItem>
                                                            <asp:ListItem Value="39">39</asp:ListItem>
                                                            <asp:ListItem Value="40">40</asp:ListItem>
                                                            <asp:ListItem Value="41">41</asp:ListItem>
                                                            <asp:ListItem Value="42">42</asp:ListItem>
                                                            <asp:ListItem Value="43">43</asp:ListItem>
                                                            <asp:ListItem Value="44">44</asp:ListItem>
                                                            <asp:ListItem Value="45">45</asp:ListItem>
                                                            <asp:ListItem Value="46">46</asp:ListItem>
                                                            <asp:ListItem Value="47">47</asp:ListItem>
                                                            <asp:ListItem Value="48">48</asp:ListItem>
                                                            <asp:ListItem Value="49">49</asp:ListItem>
                                                            <asp:ListItem Value="50">50</asp:ListItem>
                                                            <asp:ListItem Value="51">51</asp:ListItem>
                                                            <asp:ListItem Value="52">52</asp:ListItem>
                                                            <asp:ListItem Value="53">53</asp:ListItem>
                                                            <asp:ListItem Value="54">54</asp:ListItem>
                                                            <asp:ListItem Value="55">55</asp:ListItem>
                                                            <asp:ListItem Value="56">56</asp:ListItem>
                                                            <asp:ListItem Value="57">57</asp:ListItem>
                                                            <asp:ListItem Value="58">58</asp:ListItem>
                                                            <asp:ListItem Value="59">59</asp:ListItem>
                                                        </asp:DropDownList>-->
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <b style="color: #5f7afc;">End Date</b>
                                                    </td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b>
                                                    </td>
                                                    <td align="left">
                                                        <input style="width: 70px;" readonly="readonly" type="text" value="<%=strEndDate%>"
                                                            id="txtEndDate" runat="server" name="txtEndDate" enableviewstate="false" />&nbsp;<a
                                                                href="javascript:javascript:ShowCalendar('txtEndDate', 250, 250);" style="text-decoration: none;">
                                                                <img alt="Show calendar control" title="Show calendar control" height="14" src="images/Calendar.jpg"
                                                                    width="19" style="border: solid 1px blue;" />
                                                            </a><!--<b style="color: #5f7afc;">&nbsp;Hour&nbsp;:&nbsp;</b>
                                                        <asp:DropDownList ID="ddleh" runat="server" Width="40px" EnableViewState="False">
                                                            <asp:ListItem Value="00">00</asp:ListItem>
                                                            <asp:ListItem Value="01">01</asp:ListItem>
                                                            <asp:ListItem Value="02">02</asp:ListItem>
                                                            <asp:ListItem Value="03">03</asp:ListItem>
                                                            <asp:ListItem Value="04">04</asp:ListItem>
                                                            <asp:ListItem Value="05">05</asp:ListItem>
                                                            <asp:ListItem Value="06">06</asp:ListItem>
                                                            <asp:ListItem Value="07">07</asp:ListItem>
                                                            <asp:ListItem Value="08">08</asp:ListItem>
                                                            <asp:ListItem Value="09">09</asp:ListItem>
                                                            <asp:ListItem Value="10">10</asp:ListItem>
                                                            <asp:ListItem Value="11">11</asp:ListItem>
                                                            <asp:ListItem Value="12">12</asp:ListItem>
                                                            <asp:ListItem Value="13">13</asp:ListItem>
                                                            <asp:ListItem Value="14">14</asp:ListItem>
                                                            <asp:ListItem Value="15">15</asp:ListItem>
                                                            <asp:ListItem Value="16">16</asp:ListItem>
                                                            <asp:ListItem Value="17">17</asp:ListItem>
                                                            <asp:ListItem Value="18">18</asp:ListItem>
                                                            <asp:ListItem Value="19">19</asp:ListItem>
                                                            <asp:ListItem Value="20">20</asp:ListItem>
                                                            <asp:ListItem Value="21">21</asp:ListItem>
                                                            <asp:ListItem Value="22">22</asp:ListItem>
                                                            <asp:ListItem Value="23" Selected="True">23</asp:ListItem>
                                                        </asp:DropDownList><b style="color: #5f7afc;">&nbsp;Min&nbsp;:&nbsp;</b>
                                                        <asp:DropDownList ID="ddlem" runat="server" Width="40px" EnableViewState="False">
                                                            <asp:ListItem Value="00">00</asp:ListItem>
                                                            <asp:ListItem Value="01">01</asp:ListItem>
                                                            <asp:ListItem Value="02">02</asp:ListItem>
                                                            <asp:ListItem Value="03">03</asp:ListItem>
                                                            <asp:ListItem Value="04">04</asp:ListItem>
                                                            <asp:ListItem Value="05">05</asp:ListItem>
                                                            <asp:ListItem Value="06">06</asp:ListItem>
                                                            <asp:ListItem Value="07">07</asp:ListItem>
                                                            <asp:ListItem Value="08">08</asp:ListItem>
                                                            <asp:ListItem Value="09">09</asp:ListItem>
                                                            <asp:ListItem Value="10">10</asp:ListItem>
                                                            <asp:ListItem Value="11">11</asp:ListItem>
                                                            <asp:ListItem Value="12">12</asp:ListItem>
                                                            <asp:ListItem Value="13">13</asp:ListItem>
                                                            <asp:ListItem Value="14">14</asp:ListItem>
                                                            <asp:ListItem Value="15">15</asp:ListItem>
                                                            <asp:ListItem Value="16">16</asp:ListItem>
                                                            <asp:ListItem Value="17">17</asp:ListItem>
                                                            <asp:ListItem Value="18">18</asp:ListItem>
                                                            <asp:ListItem Value="19">19</asp:ListItem>
                                                            <asp:ListItem Value="20">20</asp:ListItem>
                                                            <asp:ListItem Value="21">21</asp:ListItem>
                                                            <asp:ListItem Value="22">22</asp:ListItem>
                                                            <asp:ListItem Value="23">23</asp:ListItem>
                                                            <asp:ListItem Value="24">24</asp:ListItem>
                                                            <asp:ListItem Value="25">25</asp:ListItem>
                                                            <asp:ListItem Value="26">26</asp:ListItem>
                                                            <asp:ListItem Value="27">27</asp:ListItem>
                                                            <asp:ListItem Value="28">28</asp:ListItem>
                                                            <asp:ListItem Value="29">29</asp:ListItem>
                                                            <asp:ListItem Value="30">30</asp:ListItem>
                                                            <asp:ListItem Value="31">31</asp:ListItem>
                                                            <asp:ListItem Value="32">32</asp:ListItem>
                                                            <asp:ListItem Value="33">33</asp:ListItem>
                                                            <asp:ListItem Value="34">34</asp:ListItem>
                                                            <asp:ListItem Value="35">35</asp:ListItem>
                                                            <asp:ListItem Value="36">36</asp:ListItem>
                                                            <asp:ListItem Value="37">37</asp:ListItem>
                                                            <asp:ListItem Value="38">38</asp:ListItem>
                                                            <asp:ListItem Value="39">39</asp:ListItem>
                                                            <asp:ListItem Value="40">40</asp:ListItem>
                                                            <asp:ListItem Value="41">41</asp:ListItem>
                                                            <asp:ListItem Value="42">42</asp:ListItem>
                                                            <asp:ListItem Value="43">43</asp:ListItem>
                                                            <asp:ListItem Value="44">44</asp:ListItem>
                                                            <asp:ListItem Value="45">45</asp:ListItem>
                                                            <asp:ListItem Value="46">46</asp:ListItem>
                                                            <asp:ListItem Value="47">47</asp:ListItem>
                                                            <asp:ListItem Value="48">48</asp:ListItem>
                                                            <asp:ListItem Value="49">49</asp:ListItem>
                                                            <asp:ListItem Value="50">50</asp:ListItem>
                                                            <asp:ListItem Value="51">51</asp:ListItem>
                                                            <asp:ListItem Value="52">52</asp:ListItem>
                                                            <asp:ListItem Value="53">53</asp:ListItem>
                                                            <asp:ListItem Value="54">54</asp:ListItem>
                                                            <asp:ListItem Value="55">55</asp:ListItem>
                                                            <asp:ListItem Value="56">56</asp:ListItem>
                                                            <asp:ListItem Value="57">57</asp:ListItem>
                                                            <asp:ListItem Value="58">58</asp:ListItem>
                                                            <asp:ListItem Value="59" Selected="True">59</asp:ListItem>
                                                        </asp:DropDownList>-->
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <b style="color: #5f7afc;">District</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlDistrict" runat="server" Width="200px" 
                                                            Font-Size="12px" Font-Names="verdana" AutoPostBack="True">
                                                            <asp:ListItem>--Select District Name--</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                  <tr>
                                                    <td align="left">
                                                        <b style="color: #5f7afc;">Site Type</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlSiteType" runat="server" Width="200px" 
                                                            Font-Size="12px" Font-Names="verdana" AutoPostBack="True">
                                                            <asp:ListItem>--Select Site Type--</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <b style="color: #5f7afc;">Site</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlSite" runat="server" Width="200px" Font-Size="12px" 
                                                            Font-Names="verdana" AutoPostBack="True">
                                                            <asp:ListItem>--Select Site Name--</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>   
                                                
                                                 <tr>
                                                    <td align="left">
                                                        <b style="color: #5f7afc;">Equipment</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                     <asp:DropDownList ID="ddlEquipment" runat="server" Width="200px" Font-Size="12px" 
                                                            Font-Names="verdana" AutoPostBack="True">
                                                            <asp:ListItem>--Select Equipment--</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;</td>
                                                </tr>   

                                                  <tr>
                                                   <td align="left">
                                                        <b style="color: #5f7afc;">Equipment Desc</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtEDesc" runat="server" Width="195px" ReadOnly="True"></asp:TextBox>
                                                    </td>
                                                </tr>


                                               <tr>
                                                   <td align="left">
                                                        <b style="color: #5f7afc;">Position</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPosition" runat="server" Width="195px" ReadOnly="True"></asp:TextBox>
                                                    </td>
                                                </tr>
                                             <!-- <tr>
                                                   <td align="left">
                                                        <b style="color: #5f7afc;">Criteria</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                            
                                                     <asp:CheckBox ID="chkFirstTime" runat="server" Font-Bold="True" 
                                                            Text="12am - 8am" />
                                                        <asp:CheckBox ID="chkSecondTime" runat="server" Font-Bold="True" 
                                                            Text="8am - 4pm" />
                                                         <asp:CheckBox ID="chkThirdTime" runat="server" Font-Bold="True" 
                                                            Text="4pm - 12am" />
                                                        <asp:CheckBox ID="chkAll" runat="server" Font-Bold="True" 
                                                            Text="All" />
                                                  </td>
                                                </tr>
                                                 <tr>
                                                   <td align="left">
                                                        <b style="color: #5f7afc;"> All Criteria</b></td>
                                                    <td>
                                                        <b style="color: #5f7afc;">:</b></td>
                                                    <td align="left">
                                                      <input type="checkbox" id="chkCheckAll" name="option3" onclick="return CheckItem()" /> 
                                                     
                                                  </td>
                                                </tr>-->
                                                <tr>
                                                    <td align="left">
                                                        <br />
                                                        <a href="http://www.g1.com.my/extension/total_monitoring/menu.aspx">
                                                            <img src="images/back.jpg" alt="Back" style="border: 0px; vertical-align: top; cursor: pointer"
                                                                title="Back" />
                                                        </a>
                                                    </td>
                                                  <td colspan="2" align="right">
                                                      
                                                        <br />
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/Submit_s.jpg"
                                                            ToolTip="Submit" style="height: 18px; margin-top: 0px;"></asp:ImageButton>
                                                        <!--  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:ExcelReport();">
                                                            <img alt="Save to Excel file" title="Save to Excel file" src="images/SaveExcel.jpg"
                                                                style="border: solid 0px blue;" /></a></td>-->
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <p style="font-family: Verdana; font-size: 11px; color: #5373a2;">
                                Copyright © 2009 Global Telematics Sdn Bhd. All rights reserved.</p>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table>
                                 <tr>
                                    <td align="center">
                                     <chart:webchartviewer id="WebChartViewer1" runat="server" visible="false" Width="80px"></chart:webchartviewer>
                                   </td>
                                  <td align="center">
                                     <chart:webchartviewer id="WebChartViewer2" runat="server" visible="false"></chart:webchartviewer>
                                   </td>
                                </tr>

                               <tr>
                                    <td align="center">
                                     <chart:webchartviewer id="WebChartViewer3" runat="server" visible="false"></chart:webchartviewer>
                                   </td>
                                     <td align="center">
                                     <chart:webchartviewer id="WebChartViewer4" runat="server" visible="false"></chart:webchartviewer>
                                   </td> 
                                </tr>
                            </table>
                        </td>
                    </tr>
                 
                </table>
            </div>
        </center>
       <!-- <div id="balloon3" class="balloonstyle" style="width: 258px; vertical-align: middle;">
            <img id="mapimage" src="images/maploading.gif" alt="" style="border: 1px solid silver;
                width: 256px; height: 256px; vertical-align: middle;" />
        </div>-->
        <input id="values" type="hidden" runat="server" value="" />
    </form>
    <form id="excelform" method="get" action="ExcelReport.aspx">
        <input type="hidden" id="title" name="title" value="Skid Tank Analysis Report" />
        <input type="hidden" id="plateno" name="plateno" value="" />
    </form>
</body>
</html>

