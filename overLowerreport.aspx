<%@ Page Language="VB" AutoEventWireup="false" CodeFile="overLowerreport.aspx.vb" Inherits="overLowerreport" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css" media="screen">
        @import "css/themes/redmond/jquery-ui-1.8.4.custom.css";
        @import "css/jquery-ui.css";
    </style>
    <script type="text/javascript" language="javascript" src="js/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery-ui.js"></script>
    <link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
    <style type="text/css">
        .FormDropdown
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #5F7AFC;
            width: 180px;
            border: 1 solid #CBD6E4;
        }
        .textbox1
        {
            border: 1 solid #5F7AFC;
            font-family: Verdana;
            font-size: 10pt;
            color: #3952F9;
            height: 20;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtfromdate").datepicker({ dateFormat: 'yy/mm/dd', minDate: -180, maxDate: +0, changeMonth: true, changeYear: true, numberOfMonths: 2
            });

            $("#txtEnddate").datepicker({ dateFormat: 'yy/mm/dd', minDate: -180, maxDate: +0, changeMonth: true, changeYear: true, numberOfMonths: 2

            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <center>
        <div>
            <div style="color: #5F7AFC; font-size: large; font-family: Verdana;">
                 Reservoir Lowlevel Report</div>
            <br />
            <br />
            <table style="border: solid 1px #5F7AFC; text-align: left;" cellpadding="0" cellspacing="1"
                width="60%">
                <tr bgcolor="#465AE8">
                    <td align="left" colspan="3" style="font-family: Verdana; font-size: 9px; font-weight: bold;
                        color: white" height="20px">
                        Report Selection&nbsp;
                    </td>
                </tr>
                <tr>
                    <td width="16%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font>
                    </td>
                    <td width="3%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
                    </td>
                    <td width="87%">
                        <asp:TextBox ID="txtfromdate" runat="server" CssClass="textbox1"></asp:TextBox>
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
                        <asp:DropDownList size="1" ID="ddBeginHour" CssClass="FormDropdown2" runat="server">
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
                        </asp:DropDownList>
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Min:</b></font>
                        <asp:DropDownList size="1" ID="ddBeginMinute" CssClass="FormDropdown2" runat="server">
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
                            <asp:ListItem Value="40">50</asp:ListItem>
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
                    <td width="16%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>End Date</b></font>
                    </td>
                    <td width="3%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
                    </td>
                    <td width="87%">
                        <asp:TextBox ID="txtEnddate" runat="server" CssClass="textbox1"></asp:TextBox>
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
                        <asp:DropDownList size="1" ID="ddendHour" CssClass="FormDropdown2" runat="server">
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
                        </asp:DropDownList>
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Min:</b></font>
                        <asp:DropDownList size="1" ID="ddendMinute" CssClass="FormDropdown2" runat="server">
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
                            <asp:ListItem Value="40">50</asp:ListItem>
                            <asp:ListItem Value="51">51</asp:ListItem>
                            <asp:ListItem Value="52">52</asp:ListItem>
                            <asp:ListItem Value="53">53</asp:ListItem>
                            <asp:ListItem Value="54">54</asp:ListItem>
                            <asp:ListItem Value="55">55</asp:ListItem>
                            <asp:ListItem Value="56">56</asp:ListItem>
                            <asp:ListItem Value="57">57</asp:ListItem>
                            <asp:ListItem Value="58">58</asp:ListItem>
                            <asp:ListItem Value="59" Selected="True">59</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td width="16%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>District</b></font>
                    </td>
                    <td width="3%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
                    </td>
                    <td width="87%">
                        <asp:DropDownList ID="ddldistrict" runat="server" CssClass="FormDropdown" 
                            AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td width="16%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Type</b></font>
                    </td>
                    <td width="3%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
                    </td>
                    <td width="87%">
                        <asp:DropDownList ID="ddltype" runat="server" AutoPostBack="True" CssClass="FormDropdown">
                            <asp:ListItem>Select Type</asp:ListItem>
                            <asp:ListItem>RESERVOIR</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td width="16%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>Site Name</b></font>
                    </td>
                    <td width="3%">
                        <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font>
                    </td>
                    <td width="87%">
                        <asp:DropDownList ID="ddlsitename" runat="server" CssClass="FormDropdown" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <a href="ReportsMenu.aspx">
                            <img border="0" src="images/Back.jpg" title="Back to Reports Menu" align="absbottom"></a>
                    </td>
                    <td colspan="2" align="right">
                        <asp:ImageButton ID="btnSubmit" runat="server" src="images/Submit_s.jpg" align="absbottom" />
                        <asp:ImageButton ID="btnSaveexel" runat="server" src="images/SaveExcel.jpg" align="absbottom" />
                        <asp:ImageButton ID="btnprint" runat="server" src="images/print.jpg" align="absbottom"
                            OnClientClick="print()" />
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table width="80%">
                <tr>
                    <td>
                       <asp:GridView ID="gvReport" CssClass="text" AutoGenerateColumns="false" HeaderStyle-Font-Bold="True"
                    Width="100%" BorderColor="White" BorderStyle="Solid" HeaderStyle-Font-Size="12px"
                    HeaderStyle-ForeColor="#FFFFFF" HeaderStyle-BackColor="#465AE8" HeaderStyle-Height="22px"
                    HeaderStyle-HorizontalAlign="Center" runat="server" ShowFooter ="true" FooterStyle-Font-Size="12px"
                    FooterStyle-ForeColor="#FFFFFF" FooterStyle-BackColor="#465AE8" FooterStyle-Height="22px"
                    FooterStyle-HorizontalAlign="Center">
                    <Columns>
                        <asp:BoundField DataField="sno" HeaderText="S No" HtmlEncode="False">
                            <ItemStyle HorizontalAlign="left" Width="4%" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="sitename" HeaderText="SiteName">
                            <ItemStyle HorizontalAlign="left" Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Fromtime" HeaderText="From Time">
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:BoundField>
                         <asp:BoundField DataField="totime" HeaderText="To Time">
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="duration" HeaderText="Duration">
                            <ItemStyle HorizontalAlign="left" Width="15%" />
                        </asp:BoundField>
                          <asp:BoundField DataField="flowarte" HeaderText="Outlet Flow">
                            <ItemStyle HorizontalAlign="left" Width="15%" />
                        </asp:BoundField>
                          <asp:BoundField DataField="flowtarif" HeaderText="Outlet Flow Tariff">
                            <ItemStyle HorizontalAlign="left" Width="15%" />
                        </asp:BoundField>
                          <asp:BoundField DataField="Waterloss" HeaderText="Water loss">
                            <ItemStyle HorizontalAlign="left" Width="10%" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#E7E8F8" />
                </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </center>
    </form>
</body>
</html>
