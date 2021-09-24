<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" CodeFile="WebQuery.aspx.vb"
    Inherits="WebQuery" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Web Query</title>
    <style type="text/css">
    .a{background-color: #F6F6F6;}
    .b{background-color: #EBEBEB;}
    .c{text-align: center;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <center>
            <div>
                <br />
                <b style="font-family: Verdana; font-size: 18px; color: #5B7C97;">Web Query</b>
                <br />
                <br />
                <table>
                    <tr>
                        <td align="center">
                            <table style="font-family: Verdana; font-size: 11px;">
                                <tr>
                                    <td style="height: 20px; background-color: #5B7C97;" align="left">
                                        <b style="color: White;">&nbsp;Web Query :</b></td>
                                </tr>
                                <tr>
                                    <td style="width: 500px; border: solid 1px #5B7C97;">
                                        <table style="width: 500px;">
                                            <tr>
                                                <td colspan="3">
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <b style="color: #5B7C97;">Query</b>
                                                </td>
                                                <td>
                                                    <b style="color: #5B7C97;">:</b></td>
                                                <td align="left">
                                                    <asp:TextBox ID="QueryTextBox" runat="server" Rows="4" TextMode="MultiLine" Width="420"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    <br />
                                                    <asp:Button ID="Button1" runat="server" Text="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <p style="margin-bottom: 15px; font-family: Verdana; font-size: 11px; color: #5373a2;">
                                Copyright &copy; 2009 Global Telematics Sdn Bhd. All rights reserved.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <center>
                                <asp:Label ID="Label1" runat="server" Text="" Font-Bold="True" Font-Names="Verdana"
                                    Font-Size="11px" ForeColor="Green" Visible="false"></asp:Label></center>
                            <div style="font-family: Verdana; font-size: 11px;">
                                <br />
                                <asp:GridView ID="GridView1" runat="server" Width="100%" HeaderStyle-Font-Size="12px"
                                    HeaderStyle-ForeColor="#FFFFFF" HeaderStyle-BackColor="#5B7C97" HeaderStyle-Font-Bold="True"
                                    Font-Bold="False" Font-Overline="False" EnableViewState="False" HeaderStyle-Height="22px"
                                    HeaderStyle-HorizontalAlign="Center" AutoGenerateColumns="true" BorderColor="White"
                                    BorderStyle="None" CellPadding="1" CellSpacing="1" BorderWidth="0">
                                    <AlternatingRowStyle CssClass="a" />
                                    <RowStyle CssClass="b" />
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </center>
    </form>
</body>
</html>
