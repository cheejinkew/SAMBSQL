<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WaterQualityInput.aspx.vb" Inherits="WaterQualityInput" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
<head runat="server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script src="/resources/demos/external/jquery.mousewheel.js"></script>

    <script type="text/javascript"> 
        var ec =<%=ec %>;
        function ExcelReport() {
            if (ec == true) {
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

    <script type="text/javascript"> 
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
    </style> 
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 592px; margin-left: 711px; margin-left: 0px; margin-top: 0px; width: 1165px;">
            <table align="center" class="tableBorder" style="font-family: Verdana; font-size: 15px; color: White; height: 222px; width: 554px;">
                <td colspan="4" class="tableAlign"
                    align="center">&nbsp;Water Quality Messure </td>
                <tr> 
                    <td colspan="4" cssclass="style7" align="center" class="style91">
                        <asp:Label ID="Label1" runat="server" Text="Label" ForeColor="Red"
                            Visible="False" Font-Names="Verdana" Font-Size="Small" Font-Bold="True"></asp:Label>
                    </td> 
                </tr> 
                <tr>
                    <td class="style26"></td>
                    <td class="style92">Date
                    </td>
                    <td class="style28">:</td>
                    <td class="style29">
                        <input type="text" id="txtBeginDate" readonly="readonly" runat="server"
                            style="width: 72px; height: 23px;" class="datepicker style90 " />
                    </td>
                </tr>
                <tr>
                    <td class="style26"></td>
                    <td class="style92">District</td>
                    <td class="style28">:</td>
                    <td class="style29">
                        <asp:DropDownList ID="ddlSiteDistrict" runat="server" Width="254px"
                            CssClass="cboAlign FontText " AutoPostBack="True" Height="23px">
                            <asp:ListItem Value="0">- Select District -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="style26"></td>
                    <td class="style92">Site Name
                    </td>
                    <td class="style28">:</td>
                    <td class="style29">
                        <asp:DropDownList ID="ddlSiteName" runat="server" Height="23px" Width="254px"
                            CssClass="cboAlign FontText">
                            <asp:ListItem Value="0">- Select SiteName -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="style26"></td>
                    <td class="style92">Raw Water
                    </td>
                    <td class="style28">:</td>
                    <td class="style29">
                        <input type="text" id="txtrawwater" runat="server"
                            style="width: 72px; height: 23px;" class="  style90 " />
                    </td>
                </tr>
                <tr>
                    <td class="style26"></td>
                    <td class="style92">Traeted Water
                    </td>
                    <td class="style28">:</td>
                    <td class="style29">
                        <input type="text" id="txttreated" runat="server"
                            style="width: 72px; height: 23px;" class="  style90 " />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="style30" align="center">&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td colspan="2" class="style30">

                        <p align="center">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
                               <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass=" button-blue button-blue:active button-blue:hover buttonAlign"   />&nbsp;&nbsp;                                                  
               
                        </p>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
