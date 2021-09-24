<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SiteEventRulesReport.aspx.vb" Inherits="SiteEventRulesReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<link rel="Stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.24.custom.css" />
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.24.custom.min.js"></script>
<script type="text/javascript" language="javascript">


    var ec =<%=ec %>;
    function ExcelReport() {
        if (ec == true) {
            var event = document.getElementById("cboEvents").value;
            document.getElementById("event").value = event;
            var excelformobj = document.getElementById("excelform");
            excelformobj.submit();
        }
        else {
            alert("First click submit button");
        }
    }
</script>
<body>
    <form id="form1" runat="server">
        <center>
            <div>
                <table>
                    <tr>
                        <td align="center">
                            <table>
                                <tr>
                                    <td class="tableAlign">Site  Event Rules Report</td>
                                </tr>
                                <tr>
                                    <td class="tableBorder">
                                        <table style="width: 500px;">
                                            <tr>
                                                <td align="left">
                                                    <b class="FontText">Events</b>
                                                </td>
                                                <td>
                                                    <b class="FontText">:</b>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="cboEvents" runat="server" CssClass="cboAlign FontText">
                                                        <asp:ListItem Value="All">All Types</asp:ListItem>
                                                        <asp:ListItem Value="HH">HH</asp:ListItem>
                                                        <asp:ListItem Value="H">H</asp:ListItem>
                                                        <asp:ListItem Value="NN">NN</asp:ListItem>
                                                        <asp:ListItem Value="L">L</asp:ListItem>
                                                        <asp:ListItem Value="LL">LL</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <br />
                                                    <div>
                                                        <a href="alertmanagement.aspx?t=r">
                                                            <input class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnBack" value="Back" />
                                                        </a>
                                                    </div>

                                                </td>
                                                <td colspan="2" align="right">
                                                    <br />

                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button-blue button-blue:active button-blue:hover buttonAlign" />&nbsp;&nbsp;                                                 
                                                     <a href="javascript:ExcelReport();">
                                                         <input class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnExcel" value="Excel" /></a>

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
                                            Width="800px" CssClass="GridText"
                                            AutoGenerateColumns="False" HeaderStyle-Font-Size="12px" HeaderStyle-ForeColor="#FFFFFF"
                                            HeaderStyle-BackColor="#4D90FE" HeaderStyle-Font-Bold="True" Font-Bold="False"
                                            Font-Overline="False" EnableViewState="False"
                                            HeaderStyle-Height="22px" HeaderStyle-HorizontalAlign="Center"
                                            BorderColor="#F0F0F0">

                                            <PagerStyle Font-Bold="True" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                                                VerticalAlign="Middle" BackColor="White" Font-Italic="False" Font-Overline="False"
                                                Font-Strikeout="False" />
                                            <Columns>
                                                <asp:BoundField DataField="No" HeaderText="No">
                                                    <ItemStyle Width="35px" HorizontalAlign="center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="sitename" HeaderText="Site Name" >
                                                       <ItemStyle Width="100px" />
                                                    </asp:BoundField>
                                                <asp:BoundField DataField="siteid" HeaderText="Site Id" Visible="false">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="sitedistrict" HeaderText="Site District" HtmlEncode="False">
                                                    <ItemStyle Width="130px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Equipment" HeaderText="Equipment" />
                                                <asp:BoundField DataField="event" HeaderText="Events" HtmlEncode="False" />
                                                <asp:BoundField DataField="multiplier" HeaderText="Event Range" />
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
        <input type="hidden" id="title" name="title" value="Site Event Rules Report" />
        <input type="hidden" id="event" name="event" value="" />
    </form>
</body>
</html>
<style type="text/css">
    .tableAlign {
        text-align: center;
        background-color: #4D90FE;
        font-size: 14px;
        font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
        color: White;
        width: 500px;
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

    .GridText {
        font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
        color: Black;
        font-size: 13px;
    }

    .cboAlign {
        width: 230px;
    }

    .cboHourMinAlign {
        width: 45px;
    }

    .buttonAlign {
        width: 65px;
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

    .ui-widget-header {
        border: 1px solid #465ae8;
        background: #4D90FE;
    }

    .ui-widget {
        font-size: 14px;
    }

    .help {
        display: none;
    }
</style>
