<%@ Page Language="VB" AutoEventWireup="false" CodeFile="localdatabase.aspx.vb" Inherits="localdatabase" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<link rel="Stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.24.custom.css"/>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.24.custom.min.js"></script>

 

<script type="text/javascript" language="javascript">
    $(function () {
//     $(".datepick").datepicker({ dateFormat: "yy-mm-dd" });
//     $(".datepick").datepicker("option", "showAnim", "slide");
    });

    function aaa() {
     $(".datepick").datepicker();
     $(".datepick").datepicker("option", "showAnim", "slide");
    }

    function mysubmit() {
     
        var site = document.getElementById("txtSiteid").value;
      
        if (site == "") {
            alert("Please Key In Site ID");
            return false;
        }
        var bigindatetime = document.getElementById("txtBeginDate").value + " " + document.getElementById("ddlbh").value + ":" + document.getElementById("ddlbm").value;
        var enddatetime = document.getElementById("txtEndDate").value + " " + document.getElementById("ddleh").value + ":" + document.getElementById("ddlem").value;

        var fdate = Date.parse(bigindatetime);
        var sdate = Date.parse(enddatetime);

        var diff = (sdate - fdate) * (1 / (1000 * 60 * 60 * 24));
        var days = parseInt(diff) + 1;
        if (days > 7) {
            return confirm("You selected " + days + " days of data.So it will take more time to execute.\nAre you sure you want to proceed ? ");
        }
        return true;

    }

}
</script>
<body onload="aaa();">
    <form id="form1" runat="server">
    <center>
    <div>
    <table>
     <tr>
     <td align="center">
     <table>
       <tr>
        <td class="tableAlign">Local Data Report</td>
       </tr>
       <tr>
        <td class="tableBorder">
          <table style="width: 500px;">
              <tr>
                <td align="left">
                    <b class="FontText">Begin Date</b>
                </td>
                <td>
                    <b class="FontText">:</b>
                </td>
                <td align="left">                              
                    <input type="text" id="txtBeginDate" readonly="readonly" runat="server"  style="width: 70px;" class="datepick"/>                         
                    &nbsp;
                    <b class="FontText">Hour&nbsp;:&nbsp;</b>
                    <asp:DropDownList ID="ddlbh" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                    </asp:DropDownList><b class="FontText">&nbsp;Min&nbsp;:&nbsp;</b>
                    <asp:DropDownList ID="ddlbm" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                <td align="left">
                    <b class="FontText">End Date</b>
                </td>
                <td>
                    <b class="FontText">:</b>
                </td>
                <td align="left">                              
                    <input type="text" id="txtEndDate" readonly="readonly" runat="server"  style="width: 70px;" class="datepick"/>                         
                    &nbsp;
                    <b class="FontText">Hour&nbsp;:&nbsp;</b>
                    <asp:DropDownList ID="ddleh" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                    </asp:DropDownList><b class="FontText">&nbsp;Min&nbsp;:&nbsp;</b>
                    <asp:DropDownList ID="ddlem" runat="server" class="cboHourMinAlign" EnableViewState="False"
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
                </td>
            </tr>
            <tr>
            <td align="left">
            <b class="FontText">Site ID</b>
            </td>
            <td>
            <b class="FontText">:</b>
            </td>
            <td align="left">
                <asp:TextBox ID="txtSiteId" runat="server" CssClass="FontText"></asp:TextBox> 
            </td>
            </tr>
          

              <tr>
            <td align="left">
            <b class="FontText">Records</b>
            </td>
            <td>
            <b class="FontText">:</b>
            </td>
            <td align="left">
                <asp:DropDownList ID="cboRecords" runat="server" CssClass="cboRecordsAlign FontText">
                    <asp:ListItem Value="All">All</asp:ListItem>
                    <asp:ListItem Value="50">50</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                    <asp:ListItem Value="500">500</asp:ListItem>
                    <asp:ListItem Value="1000">1000</asp:ListItem>
                </asp:DropDownList>
            </td>
            </tr>
            <tr>
            <td align="center">
                <br />
                <div>
                 <a href="alertmanagement.aspx?t=r">
                 <input  class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnBack" value="Back"/>
                 </a>
               </div > 
                
            </td>
            <td colspan="2" align="right">
                <br />
              
                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button-blue button-blue:active button-blue:hover buttonAlign" />&nbsp;&nbsp;                                                 
               <!-- <a href="javascript:ExcelReport();"><input  class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnExcel" value="Excel"/></a> -->
                                                                                              
            </td>
          </tr>
          </table>
        </td>
       </tr>
     </table>
     </td>
     </tr>
    
    <tr>
      <td>
        <br />
        </td>
    </tr>
   <tr align="left">
    <td>
     <table>
     <tr>                  
     <td align="center" colspan="2">                 
        <br />
                <asp:GridView ID="GridView1" runat="server"
             Width="500px" CssClass="GridText"
                    AutoGenerateColumns="False" HeaderStyle-Font-Size="12px" HeaderStyle-ForeColor="#FFFFFF"
                    HeaderStyle-BackColor="#4D90FE" HeaderStyle-Font-Bold="True" Font-Bold="False"
                    Font-Overline="False" EnableViewState="False" 
             HeaderStyle-Height="22px" HeaderStyle-HorizontalAlign="Center"
                    BorderColor="#F0F0F0" >
                 
                    <PagerStyle Font-Bold="True" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                        VerticalAlign="Middle" BackColor="White" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" />
                    <Columns>
                        <asp:BoundField DataField="No" HeaderText="No">
                            <ItemStyle Width="35px" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="timestamp" HeaderText="Date Time" HtmlEncode="False">
                            <ItemStyle Width="130px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="userid" HeaderText="userid" />
                        <asp:BoundField DataField="siteid" HeaderText="Site Id" Visible="false">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="rfidtag" HeaderText="RFID Tag" />
                        <asp:BoundField DataField="rfidtag1" HeaderText="RFID Tag 1" HtmlEncode="False" />
                        <asp:BoundField DataField="weight" HeaderText="Weight" HtmlEncode="False" />
                        <asp:BoundField DataField="weight1" HeaderText="Weight 1" HtmlEncode="False" />
                       <asp:BoundField DataField="orderNumber" HeaderText="Order No" HtmlEncode="False" />
                        <asp:BoundField DataField="producttype" HeaderText="Product Type" HtmlEncode="False" />
                       <asp:BoundField DataField="inoutstatus" HeaderText="IN/OUT Status" HtmlEncode="False" />
                        <asp:BoundField DataField="DI1" HeaderText="DI1" />
                        <asp:BoundField DataField="DI2" HeaderText="DI2" HtmlEncode="False" />
                        <asp:BoundField DataField="DO1" HeaderText="DO1" HtmlEncode="False" />
                        <asp:BoundField DataField="DO2" HeaderText="DO2" HtmlEncode="False" />
                       <asp:BoundField DataField="LastEditDate" HeaderText="Last Edit Date" HtmlEncode="False" />
                        <asp:BoundField DataField="CreationDate" HeaderText="CreationDate" HtmlEncode="False" />
                       <asp:BoundField DataField="image_name" HeaderText="image_name" HtmlEncode="False" />

  
                    </Columns>
                    <AlternatingRowStyle BackColor="Lavender" />
                </asp:GridView>
         <br />
         </td>
    </tr>
    </table>
    </td>
                    </tr>
   </table>
     <p class="FontText">
     Copyright © 2012 Global Telematics Sdn Bhd. All rights reserved.
     </p>

    </div>
     </center>
    </form>
     <form id="excelform" method="get" action="ExcelReport.aspx">
        <input type="hidden" id="title" name="title" value="Telemetry Events Report" />
        <input type="hidden" id="plateno" name="plateno" value="" />
    </form>
</body>
</html>
<style type="text/css">
.tableAlign
{
     text-align:center;
     background-color:#4D90FE; 
     font-size:14px; 
     font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif; color:White;
     width: 500px;
}

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

.GridText
{
    font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
    color:Black;
    font-size:13px;
    
}

.cboAlign
{
    width:230px;
}

.cboRecordsAlign
{
    width:80px;
}

.cboHourMinAlign
{
    width:45px;
}
.buttonAlign
{
    width:65px;
}
.button-blue {
    border: 1px solid #3079ED;
    text-shadow: 0 1px rgba(0, 0, 0, 0.1);
    color:White;
    text-transform: uppercase;
    background-color: #4D90FE;
    background-image: linear-gradient(top,#4d90fe  ,#4787ed  );
        height: 24px;
    }

.button-blue:hover {
    border: 1px solid #2F5BB7  ;
    color: white  ;
    text-shadow: 0 1px rgba(0, 0, 0, 0.3)  ;
    background-color: #357AE8  ;
    background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe  ),to(#357ae8  ));
    background-image: -webkit-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: -moz-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: -ms-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: -o-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: linear-gradient(top,#4d90fe  ,#357ae8  );
}

.button-blue:active 
{
    border: 1px solid #992A1B  ;
    background-color: #2F5BB7  ;
    background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe  ),to(#2F5BB7  ));
    background-image: -webkit-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: -moz-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: -ms-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: -o-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: linear-gradient(top,#4d90fe  ,#2F5BB7  );
    -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3)  ;
    -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3)  ;
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.3)  ;

}

.ui-widget-header 
{ 
  border : 1px solid #465ae8; 
  background: #4D90FE;
  
}

.ui-widget
{
    font-size:14px;   
}

.help 
{
    display: none;
}  
</style>
