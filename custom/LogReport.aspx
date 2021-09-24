<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LogReport.aspx.vb" Inherits="samb_SambSql_LogReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
 <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
 <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
<head runat="server">

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script src="/resources/demos/external/jquery.mousewheel.js"></script>
   
   <script type="text/javascript" >

       var ec=<%=ec %>;
    function ExcelReport() 
    {
        if (ec == true) 
        {
     
            var excelformobj = document.getElementById("excelform");
            excelformobj.submit();
        }
        else {
            alert("First click submit button");
        }
    }

       $(function () {
           $(".datepicker").datepicker({ dateFormat: "yy-mm-dd" });
           $(".datepicker").datepicker({ showAnim: 'slide' });
       
       });

       
    </script>

    <script type ="text/javascript">

        $(function () {
            var spinner = $("#spinMin2").spinner();

            spinner.spinner("value", 59);

            $("#spinMin2").spinner(
            {
                spin: function (event, ui) {
                    if (ui.value > 59) {
                        $(this).spinner("value", 59);
                        return false;
                    }
                    else if (ui.value <= 0) {
                        $(this).spinner("value", 0);
                        return false;
                    }
                }
            });
            $("#btnSummit").click(function () {
                var i = spinner.spinner("value")
                document.getElementById('Min2').innerHTML = i;

            });
        });

        $(function () {
            var spinner = $("#spinHour").spinner();

            spinner.spinner("value", 23);

            $("#spinHour").spinner(
            {
                spin: function (event, ui) {
                    if (ui.value > 23) {
                        $(this).spinner("value", 23);
                        return false;
                    }
                    else if (ui.value <= 0) {
                        $(this).spinner("value", 0);
                        return false;
                    }
                }
            });
            $("#btnSummit").click(function () {
                var i = spinner.spinner("value")
                document.getElementById('Hour2').innerHTML = i;

            });
        });


        $(function () {
            var spinner = $("#spinHour2").spinner();

            spinner.spinner("value", 0);

            $("#spinHour2").spinner(
            {
                spin: function (event, ui) {
                    if (ui.value > 23) {
                        $(this).spinner("value", 23);
                        return false;
                    }
                    else if (ui.value <= 0) {
                        $(this).spinner("value", 0);
                        return false;
                    }
                }

            });
            $("#btnSummit").click(function () 
            {
                var i = spinner.spinner("value")
                document.getElementById('Hour1').innerHTML = i;
     
             });
            //            document.getelementbyid('Label1').value = spinner.spinner("value");
        });

    </script>

    <title></title>
    <style type="text/css">
        .tableBorder
        {
            width: 420px;
            border: solid 1px #465ae8;
        }
         .FontText
         {
            font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color:#5f7afc;
            font-size:13px;
         }
        .ui-datepicker 
        {
        font-family:verdana;
        font-size: 13px;
        margin-left:14px
        }
        .txtDisplay
        {
            font-family: Verdana;
            font-size: 10px;
            color : #5F7AFC;
            width: 85px;
            font-weight: bold;
        }
        .style7
        {
            height: 21px;
        }
        .FormDropdown2 
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color:#5F7AFC;
            width: 50px;
            border-width: 1px;
            border-style: solid;
            border-color: #CBD6E4;
        }
        .ui-spinner
        {
            font-family:verdana;
            font-size: 13px;
            margin-left:14px;
            width:46px;
            height :20px;
        }
        
        #spinMin
        {
            width: 35px;
        }
        
        #spinner
        {
            width: 35px;
        }
        #spinHour2
        {
            width: 33px;
        }
        
        #spinMin2
        {
            width: 34px;
        }
        
        #spinHour
        {
            width: 31px;
        }
        
        .Error
        {
            font-family:Verdana;
            font-size:x-small ;
            color:Red;
            font-weight :bold;
            
        }
        
        .cboHourMinAlign
        {
            width:45px;
        }
        .FontType
        {
              font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color:#5f7afc;
             font-size:13px;
        }
        .cboAlign
        {
            width:230px;
        }
        #txtEndDate
        {
            width: 94px;
        }
        .style24
        {
            width: 853px;
        }
        .GridText
        {
            margin-left: 0px;
        }
        .style26
        {
            width: 20px;
            height: 23px;
        }
        .style27
        {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: #5f7afc;
            font-size: 13px;
            width: 213px;
            height: 23px;
        }
        .style28
        {
            font-size : 15px;
            font-weight : bold;
            color: #5F7AFC;
            width: 6px;
            height: 23px;
        }
        .style29
        {
            height: 23px;
            width: 955px;
        }
        .style30
        {
            height: 26px;
        }
        </style>

</head>
<body style="height: 69px; width: 644px; margin-top: 28px; margin-left: 77px">

    <form id="form1" runat="server" >
    
    <div style="height: 592px; margin-left: 711px; margin-left: 0px; margin-top: 0px; width: 1165px;">
    <div align="center" style="width: 550px; margin-left: 308px" >
    <br />
           <img border="0" src="images/TelemetryHistoryReport.jpg" alt="" style="margin-top: 0px" />
    <br />
       
    <br />

    </div>
        <table align="center" class="tableBorder" 
            
            style=" font-family :Verdana;font-size:15px; font-weight :bold; color:White; height: 222px; width: 554px;" >
            
                 <td colspan="4" style="background-color :#465AE8;" class="style7" align="center">&nbsp;Log Report :</td>    
            
            <tr>
                <td class="style26">
                    </td>
                <td class="style27">
                    Begin Date
                </td>
                <td class="style28">
                    :</td>
                <td class="style29">
                    <input type="text" id="txtBeginDate" readonly="readonly" runat="server" style="width: 94px;" class="datepicker"/>                         

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblHour" runat ="server" Text="Hour  :" class="FontType "></asp:Label>
                    &nbsp; 

                    <asp:DropDownList ID="ddlH1" runat="server" cssclass="cboHourMinAlign" EnableViewState="False"
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
                    </asp:DropDownList>&nbsp;&nbsp;

                    <asp:Label ID="lblMin1" runat ="server" Text="Min :" class ="FontType "></asp:Label>

                    &nbsp;
                    <asp:DropDownList ID="ddlM1" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                    </asp:DropDownList>
                    </td>
            </tr>
            <tr>
                <td class="style26">
                    </td>
                <td class="style27">
                    End Date
                </td>
                <td class="style28">
                    :</td>
                    <td class="style29">
                    <input type="text" id="txtEndDate" runat ="server" readonly="readonly" class ="datepicker" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblHour0" runat ="server" Text="Hour  :" class="FontType "></asp:Label>
                    &nbsp;
                    <asp:DropDownList ID="ddlH2" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                        <asp:ListItem Value="23"  Selected="True">23</asp:ListItem>
                    </asp:DropDownList>&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMin0" runat ="server" Text="Min :" class ="FontType "></asp:Label>

                    &nbsp; 
                    <asp:DropDownList ID="ddlM2" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                        <asp:ListItem Value="59"  Selected="True">59</asp:ListItem>
                    </asp:DropDownList>
                &nbsp;</td>
            </tr>
            <tr>
                <td class="style26">
                    </td>
                <td class="style27">
                    District</td>
                <td class="style28">
                    :</td>
                    <td class="style29">
                        <asp:DropDownList ID="ddlSiteDistrict" runat="server" Width="169px" 
                            cssclass="cboAlign FontText " AutoPostBack="True">
                            <asp:ListItem Value ="0" >- Select District -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
            </tr>
           <tr>
                <td class="style26">
                    </td>
                <td class="style27">
                    Site Name
                </td>
                <td class="style28">
                    :</td>
                <td class="style29">
                    <asp:DropDownList ID="ddlSiteName" runat="server" Height="16px" Width="168px" 
                        cssclass="cboAlign FontText">
                        <asp:ListItem Value ="0" >- Select SiteName -</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="style30">
                
                <p align="center">
                   <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button-blue button-blue:active button-blue:hover buttonAlign"  />&nbsp;&nbsp;                                                  
                <a href="javascript:ExcelReport();"><input  class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnExcel" value="Excel"/></a>
                </p>
                    </td>
            </tr>
             </table>
    <tr>
      <td>
        <br />
        </td>
    </tr>
   <tr align="left">
    <td>
     <table style="width: 550px; height: 153px;" align="center">
     <tr>                  
     <td align="center" class="style24">                 
        <br />
                    
                    <asp:GridView ID="gvLogReport" runat="server"  
                        Width="501px" CssClass="GridText"
                        AutoGenerateColumns="False" HeaderStyle-Font-Size="12px" HeaderStyle-ForeColor="#FFFFFF"
                        HeaderStyle-BackColor="#4D90FE" HeaderStyle-Font-Bold="True" Font-Bold="False"
                        Font-Overline="False" EnableViewState="False" 
                        HeaderStyle-Height="22px" HeaderStyle-HorizontalAlign="Center"
                        BorderColor="#F0F0F0" EnableModelValidation="True" 
             Height="126px">
                       
                        <Columns>
                            <asp:BoundField DataField="Date" HeaderText="Date" >
                            <ItemStyle Font-Names="Verdana" Font-Size="X-Small" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Time" HeaderText="Time" >
                             <ItemStyle Font-Names="Verdana" Font-Size="X-Small" />
                              </asp:BoundField>
                            <asp:BoundField DataField="Equipment" HeaderText="Equipment" >
                            <ItemStyle Font-Names="Verdana" Font-Size="X-Small" />
                              </asp:BoundField>
                            <asp:BoundField DataField="Value" HeaderText="Value" >
                            <ItemStyle Font-Names="Verdana" Font-Size="X-Small" />
                              </asp:BoundField>
                            <asp:BoundField DataField="Rule" HeaderText="Rule" >
                            <ItemStyle Font-Names="Verdana" Font-Size="X-Small" />
                              </asp:BoundField>
                        </Columns>

                        <HeaderStyle HorizontalAlign="Center" BackColor="#4D90FE" Font-Bold="True" Font-Size="12px" ForeColor="White" Height="22px"></HeaderStyle>
                    </asp:GridView>
                    
                    
                </td>
            </tr> 
     <tr>                  
     <td align="center" class="style24">                 
         <p class="FontText">
             Copyright © 2012 Global Telematics Sdn Bhd. All rights reserved. 
         </p>
         </td>
            </tr> 
            </table> 
            </td> 
            </tr>
            <tr>
            </tr>
           
    
    </div>
    </form>
     <form id="excelform" method="get" action="ExcelLogReport.aspx">
        <input type="hidden" id="title" name="title" value="Telemetry Events Report" />
        <input type="hidden" id="plateno" name="plateno" value="" />
    </form>
</body>


</html>
