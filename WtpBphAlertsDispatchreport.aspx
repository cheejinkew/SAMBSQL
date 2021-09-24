<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WtpBphAlertsDispatchreport.aspx.vb" Inherits="WtpBphAlertsDispatchreport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <style type="text/css" media="screen">
      
        @import "css/themes/redmond/jquery-ui-1.8.4.custom.css";
        @import "css/jquery-ui.css";
        
    </style>
     <script type="text/javascript" language="javascript" src="js/jquery.js"></script>
     <script type="text/javascript" language="javascript" src="js/jquery-ui.js"></script>
     <link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
    <style type ="text/css" >
    .FormDropdown 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 180px;
  border: 1 solid #CBD6E4;
  }
  .textbox1
  {border: 1 solid #5F7AFC;
   font-family: Verdana; 
   font-size: 10pt; 
   color: #3952F9; 
   height: 20;
      }
    </style>
    <script type="text/javascript" >
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
     <div style="color:#5F7AFC;font-size :large; font-family :Verdana ;" >Alerts Dispatch Report</div>
     <br />
     <br />
     <table style="border: solid 1px #5F7AFC;text-align :left ;" cellpadding="0" cellspacing="1" width="60%" >
         <tr bgcolor="#465AE8">
           <td align="left" colspan="3" style="font-family: Verdana; font-size: 9px; font-weight: bold;
            color: white" height="20px">
             Report Selection&nbsp;</td>
         </tr>     
      <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
                <asp:TextBox ID="txtfromdate" runat="server"  CssClass="textbox1"></asp:TextBox>
                <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
                                                <asp:DropDownList size="1" ID ="ddBeginHour" CssClass="FormDropdown2" runat="server" >
                                                   <asp:ListItem value="00">00</asp:ListItem>
                                                    <asp:ListItem value="01">01</asp:ListItem>
                                                    <asp:ListItem value="02">02</asp:ListItem>
                                                    <asp:ListItem value="03">03</asp:ListItem>
                                                    <asp:ListItem value="04">04</asp:ListItem>
                                                    <asp:ListItem value="05">05</asp:ListItem>
                                                    <asp:ListItem value="06">06</asp:ListItem>
                                                    <asp:ListItem value="07">07</asp:ListItem>
                                                    <asp:ListItem value="08">08</asp:ListItem>
                                                    <asp:ListItem value="09">09</asp:ListItem>
                                                    <asp:ListItem value="10">10</asp:ListItem>
                                                    <asp:ListItem value="11">11</asp:ListItem>
                                                    <asp:ListItem value="12">12</asp:ListItem>
                                                    <asp:ListItem value="13">13</asp:ListItem>
                                                    <asp:ListItem value="14">14</asp:ListItem>
                                                    <asp:ListItem value="15">15</asp:ListItem>
                                                    <asp:ListItem value="16">16</asp:ListItem>
                                                    <asp:ListItem value="17">17</asp:ListItem>
                                                    <asp:ListItem value="18">18</asp:ListItem>
                                                    <asp:ListItem value="19">19</asp:ListItem>
                                                    <asp:ListItem value="20">20</asp:ListItem>
                                                    <asp:ListItem value="21">21</asp:ListItem>
                                                    <asp:ListItem value="22">22</asp:ListItem>
                                                    <asp:ListItem value="23">23</asp:ListItem>
                                                </asp:DropDownList>
                                                <font face="Verdana" size="1" color="#5F7AFC"><b>Min:</b></font>
                                                <asp:DropDownList size="1" ID="ddBeginMinute" CssClass="FormDropdown2"  runat="server">
                                                    <asp:ListItem value="00">00</asp:ListItem>
                                                    <asp:ListItem value="01">01</asp:ListItem>
                                                    <asp:ListItem value="02">02</asp:ListItem>
                                                    <asp:ListItem value="03">03</asp:ListItem>
                                                    <asp:ListItem value="04">04</asp:ListItem>
                                                    <asp:ListItem value="05">05</asp:ListItem>
                                                    <asp:ListItem value="06">06</asp:ListItem>
                                                    <asp:ListItem value="07">07</asp:ListItem>
                                                    <asp:ListItem value="08">08</asp:ListItem>
                                                    <asp:ListItem value="09">09</asp:ListItem>
                                                    <asp:ListItem value="10">10</asp:ListItem>
                                                    <asp:ListItem value="11">11</asp:ListItem>
                                                    <asp:ListItem value="12">12</asp:ListItem>
                                                    <asp:ListItem value="13">13</asp:ListItem>
                                                    <asp:ListItem value="14">14</asp:ListItem>
                                                    <asp:ListItem value="15">15</asp:ListItem>
                                                    <asp:ListItem value="16">16</asp:ListItem>
                                                    <asp:ListItem value="17">17</asp:ListItem>
                                                    <asp:ListItem value="18">18</asp:ListItem>
                                                    <asp:ListItem value="19">19</asp:ListItem>
                                                    <asp:ListItem value="20">20</asp:ListItem>
                                                    <asp:ListItem value="21">21</asp:ListItem>
                                                    <asp:ListItem value="22">22</asp:ListItem>
                                                    <asp:ListItem value="23">23</asp:ListItem>
                                                    <asp:ListItem value="24">24</asp:ListItem>
                                                    <asp:ListItem value="25">25</asp:ListItem>
                                                    <asp:ListItem value="26">26</asp:ListItem>
                                                    <asp:ListItem value="27">27</asp:ListItem>
                                                    <asp:ListItem value="28">28</asp:ListItem>
                                                    <asp:ListItem value="29">29</asp:ListItem>
                                                    <asp:ListItem value="30">30</asp:ListItem>
                                                    <asp:ListItem value="31">31</asp:ListItem>
                                                    <asp:ListItem value="32">32</asp:ListItem>
                                                    <asp:ListItem value="33">33</asp:ListItem>
                                                    <asp:ListItem value="34">34</asp:ListItem>
                                                    <asp:ListItem value="35">35</asp:ListItem>
                                                    <asp:ListItem value="36">36</asp:ListItem>
                                                    <asp:ListItem value="37">37</asp:ListItem>
                                                    <asp:ListItem value="38">38</asp:ListItem>
                                                    <asp:ListItem value="39">39</asp:ListItem>
                                                    <asp:ListItem value="40">40</asp:ListItem>
                                                    <asp:ListItem value="41">41</asp:ListItem>
                                                    <asp:ListItem value="42">42</asp:ListItem>
                                                    <asp:ListItem value="43">43</asp:ListItem>
                                                    <asp:ListItem value="44">44</asp:ListItem>
                                                    <asp:ListItem value="45">45</asp:ListItem>
                                                    <asp:ListItem value="46">46</asp:ListItem>
                                                    <asp:ListItem value="47">47</asp:ListItem>
                                                    <asp:ListItem value="48">48</asp:ListItem>
                                                    <asp:ListItem value="49">49</asp:ListItem>
                                                    <asp:ListItem value="40">50</asp:ListItem>
                                                    <asp:ListItem value="51">51</asp:ListItem>
                                                    <asp:ListItem value="52">52</asp:ListItem>
                                                    <asp:ListItem value="53">53</asp:ListItem>
                                                    <asp:ListItem value="54">54</asp:ListItem>
                                                    <asp:ListItem value="55">55</asp:ListItem>
                                                    <asp:ListItem value="56">56</asp:ListItem>
                                                    <asp:ListItem value="57">57</asp:ListItem>
                                                    <asp:ListItem value="58">58</asp:ListItem>
                                                    <asp:ListItem value="59">59</asp:ListItem>
                                                </asp:DropDownList>
            </td>
           </tr>  
            <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>End Date</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
              <asp:TextBox ID="txtEnddate" runat="server" CssClass="textbox1"></asp:TextBox>
              <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
                                                <asp:DropDownList size="1" ID="ddendHour" CssClass="FormDropdown2"  runat="server">
                                                    <asp:ListItem value="00">00</asp:ListItem>
                                                    <asp:ListItem value="01">01</asp:ListItem>
                                                    <asp:ListItem value="02">02</asp:ListItem>
                                                    <asp:ListItem value="03">03</asp:ListItem>
                                                    <asp:ListItem value="04">04</asp:ListItem>
                                                    <asp:ListItem value="05">05</asp:ListItem>
                                                    <asp:ListItem value="06">06</asp:ListItem>
                                                    <asp:ListItem value="07">07</asp:ListItem>
                                                    <asp:ListItem value="08">08</asp:ListItem>
                                                    <asp:ListItem value="09">09</asp:ListItem>
                                                    <asp:ListItem value="10">10</asp:ListItem>
                                                    <asp:ListItem value="11">11</asp:ListItem>
                                                    <asp:ListItem value="12">12</asp:ListItem>
                                                    <asp:ListItem value="13">13</asp:ListItem>
                                                    <asp:ListItem value="14">14</asp:ListItem>
                                                    <asp:ListItem value="15">15</asp:ListItem>
                                                    <asp:ListItem value="16">16</asp:ListItem>
                                                    <asp:ListItem value="17">17</asp:ListItem>
                                                    <asp:ListItem value="18">18</asp:ListItem>
                                                    <asp:ListItem value="19">19</asp:ListItem>
                                                    <asp:ListItem value="20">20</asp:ListItem>
                                                    <asp:ListItem value="21">21</asp:ListItem>
                                                    <asp:ListItem value="22">22</asp:ListItem>
                                                    <asp:ListItem value="23" Selected="True">23</asp:ListItem>
                                                </asp:DropDownList>
                                                <font face="Verdana" size="1" color="#5F7AFC"><b>Min:</b></font>
                                                <asp:DropDownList size="1" ID="ddendMinute" CssClass="FormDropdown2"  runat="server">
                                                    <asp:ListItem value="00">00</asp:ListItem>
                                                    <asp:ListItem value="01">01</asp:ListItem>
                                                    <asp:ListItem value="02">02</asp:ListItem>
                                                    <asp:ListItem value="03">03</asp:ListItem>
                                                    <asp:ListItem value="04">04</asp:ListItem>
                                                    <asp:ListItem value="05">05</asp:ListItem>
                                                    <asp:ListItem value="06">06</asp:ListItem>
                                                    <asp:ListItem value="07">07</asp:ListItem>
                                                    <asp:ListItem value="08">08</asp:ListItem>
                                                    <asp:ListItem value="09">09</asp:ListItem>
                                                    <asp:ListItem value="10">10</asp:ListItem>
                                                    <asp:ListItem value="11">11</asp:ListItem>
                                                    <asp:ListItem value="12">12</asp:ListItem>
                                                    <asp:ListItem value="13">13</asp:ListItem>
                                                    <asp:ListItem value="14">14</asp:ListItem>
                                                    <asp:ListItem value="15">15</asp:ListItem>
                                                    <asp:ListItem value="16">16</asp:ListItem>
                                                    <asp:ListItem value="17">17</asp:ListItem>
                                                    <asp:ListItem value="18">18</asp:ListItem>
                                                    <asp:ListItem value="19">19</asp:ListItem>
                                                    <asp:ListItem value="20">20</asp:ListItem>
                                                    <asp:ListItem value="21">21</asp:ListItem>
                                                    <asp:ListItem value="22">22</asp:ListItem>
                                                    <asp:ListItem value="23">23</asp:ListItem>
                                                    <asp:ListItem value="24">24</asp:ListItem>
                                                    <asp:ListItem value="25">25</asp:ListItem>
                                                    <asp:ListItem value="26">26</asp:ListItem>
                                                    <asp:ListItem value="27">27</asp:ListItem>
                                                    <asp:ListItem value="28">28</asp:ListItem>
                                                    <asp:ListItem value="29">29</asp:ListItem>
                                                    <asp:ListItem value="30">30</asp:ListItem>
                                                    <asp:ListItem value="31">31</asp:ListItem>
                                                    <asp:ListItem value="32">32</asp:ListItem>
                                                    <asp:ListItem value="33">33</asp:ListItem>
                                                    <asp:ListItem value="34">34</asp:ListItem>
                                                    <asp:ListItem value="35">35</asp:ListItem>
                                                    <asp:ListItem value="36">36</asp:ListItem>
                                                    <asp:ListItem value="37">37</asp:ListItem>
                                                    <asp:ListItem value="38">38</asp:ListItem>
                                                    <asp:ListItem value="39">39</asp:ListItem>
                                                    <asp:ListItem value="40">40</asp:ListItem>
                                                    <asp:ListItem value="41">41</asp:ListItem>
                                                    <asp:ListItem value="42">42</asp:ListItem>
                                                    <asp:ListItem value="43">43</asp:ListItem>
                                                    <asp:ListItem value="44">44</asp:ListItem>
                                                    <asp:ListItem value="45">45</asp:ListItem>
                                                    <asp:ListItem value="46">46</asp:ListItem>
                                                    <asp:ListItem value="47">47</asp:ListItem>
                                                    <asp:ListItem value="48">48</asp:ListItem>
                                                    <asp:ListItem value="49">49</asp:ListItem>
                                                    <asp:ListItem value="40">50</asp:ListItem>
                                                    <asp:ListItem value="51">51</asp:ListItem>
                                                    <asp:ListItem value="52">52</asp:ListItem>
                                                    <asp:ListItem value="53">53</asp:ListItem>
                                                    <asp:ListItem value="54">54</asp:ListItem>
                                                    <asp:ListItem value="55">55</asp:ListItem>
                                                    <asp:ListItem value="56">56</asp:ListItem>
                                                    <asp:ListItem value="57">57</asp:ListItem>
                                                    <asp:ListItem value="58">58</asp:ListItem>
                                                    <asp:ListItem value="59" Selected="True">59</asp:ListItem>
                                                </asp:DropDownList>
            </td>
           </tr>  
            <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>District</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
                <asp:DropDownList ID="ddldistrict" runat="server" CssClass="FormDropdown" >
                </asp:DropDownList>
            </td>
           </tr> 
            <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>Type</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
             <asp:DropDownList ID="ddltype" runat="server" AutoPostBack="True" CssClass="FormDropdown" >
             <asp:ListItem >Select Type</asp:ListItem>
             <asp:ListItem Selected="True"  >ALL</asp:ListItem>
            <asp:ListItem >WTP</asp:ListItem>
             <asp:ListItem >BPH</asp:ListItem>
                </asp:DropDownList>

            </td>
           </tr>       
            <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>Site Name</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
             <asp:DropDownList ID="ddlsitename" runat="server" CssClass="FormDropdown" 
                    AutoPostBack="True" >
                    <asp:ListItem >ALL</asp:ListItem>
                </asp:DropDownList>
            </td>
           </tr>    
            <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>Technician</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
             <asp:DropDownList ID="ddlEquipment" runat="server" CssClass="FormDropdown" >
               <asp:ListItem >ALL</asp:ListItem>
             </asp:DropDownList>
            </td>
           </tr>    
           <%-- <tr>
         <td width="16%">
          <font face="Verdana" size="1" color="#5F7AFC"><b>Event Type</b></font></td>
           <td width="3%">
            <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
            <td width="87%">
             <asp:DropDownList ID="ddlEvent" runat="server" CssClass="FormDropdown" >
             </asp:DropDownList>
            </td>
           </tr>    --%>
               <tr>
                                            <td align="left">
                                                <a href="ReportsMenu.aspx">
                                                    <img border="0" src="images/Back.jpg" title="Back to Reports Menu" align="absbottom"></a></td>
                                            <td colspan="2" align="right">
                                                    <asp:ImageButton ID="btnSubmit" runat="server" src="images/Submit_s.jpg"  align="absbottom"/>
                                                  <asp:ImageButton ID="btnSaveexel" runat="server" src="images/SaveExcel.jpg"  align="absbottom"/>
                                                 <asp:ImageButton ID="btnprint" runat="server" src="images/print.jpg"  align="absbottom" OnClientClick="print()"/>
                                                    
                                            </td>
                                        </tr>                    
     </table>
     <br />
     <br />
     <table  width="80%" ><tr><td>
     <asp:GridView ID="gvreport" runat="server" CellPadding="4"  
             EnableModelValidation="True" ForeColor="#333333" GridLines="None" 
             Width ="100%" AutoGenerateColumns="False">
       <AlternatingRowStyle BackColor="White" />
         <Columns >
             <asp:BoundField DataField="sno" HeaderText="Sno" />
             <asp:BoundField DataField="timestamp" HeaderText="Date Time" />
             <asp:BoundField DataField="sitename" HeaderText="Site Name" />
              <asp:BoundField DataField="name" HeaderText="Name" />
             <asp:BoundField DataField="equiptype" HeaderText="Equipment" />
              <asp:BoundField DataField="alertevent" HeaderText="Alert/Event" />
             <asp:BoundField DataField="value" HeaderText="Value" />
            
         </Columns>
       <EditRowStyle BackColor="#2461BF" />
       <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
       <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
       <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Left" />
       <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"  />
       <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:GridView>
     </td></tr></table>
   
     </div>
    </center>
   
    </form>
  
</body>
</html>
