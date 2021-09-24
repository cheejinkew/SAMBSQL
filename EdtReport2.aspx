<%@ Page Language="vb" AutoEventWireup="false" CodeFile="EdtReport2.aspx.vb" Inherits="EdtReport2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
 <script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
 <script type="text/javascript" src="https://code.jquery.com/jquery-1.8.2.js"></script>
<head runat="server">
    <style type="text/css">
body
{
font-family:Calibri;
}
.MASUK
{
background: #ffff99;
font-weight:bold;
color:White;
}
.KELUAR
{
background:#ff5c33;
font-weight:bold;
color:White;
}
</style>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script src="/resources/demos/external/jquery.mousewheel.js"></script>
   
   <script type="text/javascript" >

       var ec =<%=ec %>;
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
           $(".datepicker").datepicker("option", "showAnim", "slide");
       
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
        });


        function yesterdate() {
            var currentTime = new Date()
            var month = currentTime.getMonth() + 1
            var day = currentTime.getDate()
            var year = currentTime.getFullYear()

           

            document.getElementById('txtBeginDate').value = year + "-" + month + "-" + day;
            document.getElementById('ddBeginHour').value = '00';
            document.getElementById('ddBeginMinute').value = '00';
            var date = year + "-" + month + "-" + day.ToString("yyyy-MM-dd");
            document.getElementById('txtEndDate').value = year + "-" + month + "-" + day;
            document.getElementById('ddEndHour').value = 23;
            document.getElementById('ddEndMinute').value = 59;
            var date1 = year + "-" + month + "-" + day;
            if (document.getElementById('HiddenField1').value == "Submit") {
                var obj = document.formX;
                obj.action ="EdtReport2.aspx";
                obj.submit();
            }

            if (document.getElementById('HiddenField1').value == "Graphical") {
                document.formX.submit();
            }
        }
        function twodaysdate() {
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
            document.getElementById('ddBeginMinute').value = '00';

            document.getElementById('txtEndDate').value = year1 + "-" + month1 + "-" + day1;
            document.getElementById('ddEndHour').value = 23;
            document.getElementById('ddEndMinute').value = 59;

            if (document.getElementById('HiddenField1').value == "Submit") {

                var obj = document.formX;
                obj.action ="EdtReport2.aspx";
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
	
      document.getElementById('txtEndDate').value = year1 + "-" + month1 + "-" + day1;
	document.getElementById('ddEndHour').value=23;
	document.getElementById('ddEndMinute').value=59;

   if (document.getElementById('HiddenField1').value=="Submit")
	{
	
	   var obj=document.formX;
    obj.action="EdtReport2.aspx";
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
	
      document.getElementById('txtEndDate').value = year1 + "-" + month1 + "-" + day1;
	document.getElementById('ddEndHour').value=23;
	document.getElementById('ddEndMinute').value=59;
    if (document.getElementById('HiddenField1').value=="Submit")
	{
	
	   var obj=document.formX;
          obj.action = "EdtReport2.aspx";
          obj.submit();
      }

      if (document.getElementById('HiddenField1').value == "Graphical") {
          document.formX.submit();
      }
  }

    </script>

    <title></title>
    <style type="text/css">
        .ui-widget-header {
            border: 1px solid #465ae8;
            background: #4D90FE;
        }

        .ui-widget {
            font-size: 14px;
        }

        .button-blue {
            border: 1px solid #3079ED;
            text-shadow: 0 1px rgba(0, 0, 0, 0.1);
            color: White;
            text-transform: uppercase;
            background-color: #4D90FE;
            background-image: linear-gradient(top,#4d90fe,#4787ed );
            height: 24px;
        }

            .button-blue:hover {
                border: 1px solid #2F5BB7;
                color: white;
                text-shadow: 0 1px rgba(0, 0, 0, 0.3);
                background-color: #357AE8;
                background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe ),to(#357ae8 ));
                background-image: -webkit-linear-gradient(top,#4d90fe,#357ae8 );
                background-image: -moz-linear-gradient(top,#4d90fe,#357ae8 );
                background-image: -ms-linear-gradient(top,#4d90fe,#357ae8 );
                background-image: -o-linear-gradient(top,#4d90fe,#357ae8 );
                background-image: linear-gradient(top,#4d90fe,#357ae8 );
            }

            .button-blue:active {
                border: 1px solid #992A1B;
                background-color: #2F5BB7;
                background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe ),to(#2F5BB7 ));
                background-image: -webkit-linear-gradient(top,#4d90fe,#2F5BB7 );
                background-image: -moz-linear-gradient(top,#4d90fe,#2F5BB7 );
                background-image: -ms-linear-gradient(top,#4d90fe,#2F5BB7 );
                background-image: -o-linear-gradient(top,#4d90fe,#2F5BB7 );
                background-image: linear-gradient(top,#4d90fe,#2F5BB7 );
                -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
                -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
            }

        .tableBorder {
            width: 420px;
            border: solid 1px #465ae8;
        }

        .FontText {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: #5f7afc;
            font-size: 13px;
        }

        .ui-datepicker {
            font-family: verdana;
            font-size: 13px;
            margin-left: 14px
        }

        .txtDisplay {
            font-family: Verdana;
            font-size: 10px;
            color: #5F7AFC;
            width: 85px;
            font-weight: bold;
        }

        .FormDropdown2 {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #5F7AFC;
            width: 50px;
            border-width: 1px;
            border-style: solid;
            border-color: #CBD6E4;
        }

        .ui-spinner {
            font-family: verdana;
            font-size: 13px;
            margin-left: 14px;
            width: 46px;
            height: 20px;
        }

        #spinMin {
            width: 35px;
        }

        #spinner {
            width: 35px;
        }

        #spinHour2 {
            width: 33px;
        }

        #spinMin2 {
            width: 34px;
        }

        #spinHour {
            width: 31px;
        }

        .Error {
            font-family: Verdana;
            font-size: x-small;
            color: Red;
            font-weight: bold;
        }

        .cboHourMinAlign {
            width: 45px;
        }

        .FontType {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: #5f7afc;
            font-size: 13px;
        }

        .cboAlign {
        }

        #txtEndDate {
            width: 72px;
            height: 23px;
        }

        .style24 {
            width: 853px;
        }

        .GridText {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: Black;
            font-size: 13px;
        }

        .style26 {
            height: 23px;
            width: 42px;
        }

        .style28 {
            font-size: 15px;
            font-weight: bold;
            color: #5F7AFC;
            width: 16px;
            height: 23px;
        }

        .style29 {
            height: 23px;
            width: 452px;
        }

        .style30 {
            height: 26px;
        }

        .style90 {
            font-family: verdane;
            font-size: 13px;
        }

        .style91 {
            height: 24px;
        }

        .tableAlign {
            text-align: center;
            background-color: #4D90FE;
            font-size: 14px;
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: White;
            width: 500px;
            height: 23px;
        }

        .style92 {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: #5f7afc;
            font-size: 13px;
            width: 105px;
        }
        .auto-style1 {
            width: 954px;
            height: 153px;
        }
        .auto-style4 {
            height: 23px;
            width: 155px;
        }
        .auto-style5 {
            height: 23px;
            width: 2070px;
        }
        .auto-style6 {
            width: 487px;
            border: solid 1px #465ae8;
            height: 222px;
        }
    </style>

</head>
<body style="height: 492px; width: 1089px; margin-top: 28px; margin-left: 15px">

    <form id="form1" runat="server">

        <div style="height: 592px; margin-left: 711px; margin-left: 0px; margin-top: 0px; width: 1165px;">
            <table align="center" class="auto-style6" style="font-family: Verdana; font-size: 15px; color: White; ">

                <td colspan="4" class="tableAlign"
                    align="center">EDT&nbsp;Daily Report </td>

                <tr>

                    <td colspan="4" cssclass="style7" align="center" class="style91">
                        <asp:Label ID="Label1" runat="server" Text="Label" ForeColor="Red"
                            Visible="False" Font-Names="Verdana" Font-Size="Small" Font-Bold="True"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style4"></td>
                    <td class="style92">Begin Date</td>
                    <td class="style28">:</td>
                    <td class="auto-style5">
                    <input type="text" id="txtBeginDate" readonly="readonly" runat="server" 
                        style="width: 72px; height: 23px;" class="datepicker style90 "/>

                        &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblHour" runat="server"  Visible="false"   Text="Hour  :" class="FontType "></asp:Label>
                        &nbsp; 

                    <asp:DropDownList ID="ddlH1" runat="server" Visible="false" CssClass="cboHourMinAlign style90" EnableViewState="False"
                        Font-Size="12px" Font-Names="verdana" Height="23px">
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

                    <asp:Label ID="lblMin1" runat="server" Visible="false"  Text="Min :" class="FontType "></asp:Label>

                        &nbsp;
                    <asp:DropDownList ID="ddlM1" runat="server"  Visible="false" CssClass="cboHourMinAlign style90" EnableViewState="False"
                        Font-Size="12px" Font-Names="verdana" Height="23px">
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
                    <td class="auto-style4"></td>
                    <td class="style92">End Date
                    </td>
                    <td class="style28">:</td>
                    <td class="auto-style5">
                          <input type="text" id="txtEndDate" runat ="server" readonly="readonly" class ="datepicker style90 " />&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblHour0" runat="server"  Visible="false" Text="Hour  :" class="FontType "></asp:Label>
                        &nbsp;
                    <asp:DropDownList ID="ddlH2" runat="server" Visible="false" CssClass="cboHourMinAlign style90" EnableViewState="False"
                        Font-Size="12px" Font-Names="verdana" Height="23px">
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
                    </asp:DropDownList>&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMin0" runat="server"  Visible="false" Text="Min :" class="FontType "></asp:Label>

                        &nbsp; 
                    <asp:DropDownList ID="ddlM2" runat="server" Visible="false" CssClass="cboHourMinAlign style90" EnableViewState="False"
                        Font-Size="12px" Font-Names="verdana" Height="23px">
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
                    </asp:DropDownList>
                        &nbsp;</td>
                </tr>
                 <td class="auto-style4"></a></td>
                <td class="auto-style4"><a href="javascript:yesterdate();"><img src="images/today2.png" border="0"></a></td>
                 <td class="auto-style4"><a href="javascript:twodaysdate();"><img src="images/last2days1.png" border=0></a></a></td>
                 <td class="auto-style5"><a href="javascript:lastweakdate();"><img src="images/1week1.png" border=0></a><a href="javascript:lastmonthdate();"><img src="images/1month1.png"></a></td>
                 <td class="auto-style4">&nbsp;</td>
             
                <tr>
                    <td colspan="2" class="style30" align="center">
                
                 <a href="Report.aspx?t=r">
                     <input class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnBack" value="Back" /></a>&nbsp;&nbsp;&nbsp;&nbsp;
                
                 </td>
                    <td colspan="2" class="style30">

                        <p align="center">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:ExcelReport();"><input class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnExcel" value="Excel" /></a>&nbsp;&nbsp;&nbsp;&nbsp;
               
                 &nbsp;</a><asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass=" button-blue button-blue:active button-blue:hover buttonAlign" />&nbsp;&nbsp;&nbsp;
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
                    <table align="center" class="auto-style1">
                        <tr>
                            <td align="center" class="g">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center" class="style24">
                                <asp:GridView ID="gvLogReport" runat="server" AutoGenerateColumns="False"
                                    CellPadding="4" class="GridText" ForeColor="#333333"
                                    GridLines="None" Width="1108px" BorderWidth="1px" BorderColor="#F0F0F0">
                                    <AlternatingRowStyle BackColor="white" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Date" DataField="DateTime">
                                            <HeaderStyle BackColor="#4D90FE" />
                                            <ItemStyle ForeColor="Black" HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="DA1M" DataField="DA1M">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ffff33" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>
                                          <asp:BoundField HeaderText="DA2M" DataField="DA2M">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ffff33" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>

                                          <asp:BoundField HeaderText="DA5M" DataField="DA5M">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ffff33" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>

                                          <asp:BoundField HeaderText="DA8M" DataField="DA8M">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ffff33" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>


                                        <asp:BoundField HeaderText="DA4M" DataField="DA4M">
                                        <FooterStyle BorderColor="Yellow" />
                                        <HeaderStyle BackColor="#ff471a" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>

                                              <asp:BoundField HeaderText="DA9M" DataField="DA9M">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ff471a" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>


                                              <asp:BoundField HeaderText="DA10" DataField="DA10">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ff471a" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>


                                              <asp:BoundField HeaderText="DA11" DataField="DA11">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ff471a" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>

                                              <asp:BoundField HeaderText="DA12" DataField="DA12">
                                            <FooterStyle BorderColor="Yellow" />
                                            <HeaderStyle BackColor="#ff471a" BorderColor="Yellow" />
                                            <ItemStyle ForeColor="Black " HorizontalAlign="Center" />
                                        </asp:BoundField>


                                        
                                         <asp:BoundField HeaderText=" Total Totaliser Masuk  /m" DataField="TotaliserMasuk">
                                            <HeaderStyle BackColor="#ffff33" />
                                            <ItemStyle ForeColor="Black" HorizontalAlign="Center" />
                                        </asp:BoundField> 


                                         
                                         <asp:BoundField HeaderText=" Total Totaliser Keluar  /m" DataField="TotaliserKeluar">
                                            <HeaderStyle BackColor="#ff471a" />
                                            <ItemStyle ForeColor="Black" HorizontalAlign="Center" />
                                        </asp:BoundField> 


                                          <asp:BoundField HeaderText="Lebihan A-B" DataField="Lebihan A-B">
                                            <HeaderStyle BackColor="#4D90FE" />
                                            <ItemStyle ForeColor="Black" HorizontalAlign="Center" />
                                        </asp:BoundField> 


                                    </Columns>
                                    <EditRowStyle BackColor="#2461BF" />
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="Black" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
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
    <form id="excelform" method="get" action="ExcelReport.aspx">
        <input type="hidden" id="title" name="title" value="EDT Daily Report" />
        <input type="hidden" id="plateno" name="plateno" value="" />
    </form>
</body>
</html>


