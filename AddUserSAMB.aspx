﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddUserSAMB.aspx.vb" Inherits="AddUserR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 433px;
            height: 493px;
            margin-bottom: 0px;
        }
        .style2
        {
            width: 100%;
            height: 452px;
        }
        .style7
        {
            width: 48px;
        }
        .style14
        {
            width: 197px;
        }
        .style18
        {
            width: 19px;
        }
        .style20
        {
            width: 133px;
        }
        .style22
        {
            width: 48px;
            height: 13px;
        }
        .style23
        {
            width: 133px;
            height: 13px;
        }
        .style24
        {
            width: 19px;
            height: 13px;
        }
        .style25
        {
            width: 197px;
            height: 13px;
        }
        .style31
        {
            width: 55px;
        }
        .style52
        {
            width: 48px;
            height: 34px;
        }
        .style55
        {
            width: 197px;
            height: 34px;
        }
        .style57
        {
            width: 48px;
            height: 83px;
        }
        .style58
        {
            width: 133px;
            height: 83px;
        }
        .style59
        {
            width: 19px;
            height: 83px;
        }
        .style60
        {
            width: 197px;
            height: 83px;
        }
        .style62
        {
            height: 509px;
            width: 495px;
        }
        .style63
        {
            width: 133px;
            height: 34px;
        }
        .style64
        {
            width: 19px;
            height: 34px;
        }
        .style65
        {
            width: 48px;
            height: 17px;
        }
        .style66
        {
            width: 133px;
            height: 17px;
        }
        .style67
        {
            width: 19px;
            height: 17px;
        }
        .style68
        {
            width: 55px;
            height: 17px;
        }
        .style69
        {
            width: 197px;
            height: 17px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table class="style1" align="center" >
            <tr>
                <td class="style62">
                    <asp:Panel ID="Panel1" runat="server" BorderWidth="2px" ForeColor="#CCCCFF" 
                        Height="453px" Width="434px">
                        <table class="style2">
                            <tr>
                                <td class="style22">
                                    </td>
                                <td class="style23">
                                    </td>
                                <td class="style24">
                                    </td>
                                <td class="style25" colspan="2">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblUsername" runat="server" Text="Username" Font-Names="Verdana" 
                                        Font-Size="XX-Small" Font-Bold ="True" ForeColor="#336699"></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label10" runat="server" Text=":" Font-Bold="True" 
                                        Font-Size="Medium" ForeColor="#336699"  ></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:TextBox ID="txtUsername" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" style="margin-top: 0px" forecolor="#336699" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblPassword" runat="server" Text="Password" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:TextBox ID="txtPassword" runat="server" Height ="14px" Width="170px" 
                                        Font-Size ="Small" ForeColor ="#336699" Font-Names ="verdana" 
                                        TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblPhoneno" runat="server" Text="Phone Number" ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" Font-Bold ="true" ></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:TextBox ID="txtPhoneno" runat="server" height ="14px" Width ="170px" Font-size="Small" ForeColor ="#336699" Font-Names ="verdana"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblFax" runat="server" Text="Fax Number" ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" Font-Bold ="true" ></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:TextBox ID="txtFaxNo" runat="server" Width = "170px" height ="14px" Font-size="Small" Font-Names="verdana" ForeColor ="#336699"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblStreet" runat="server" Text="Street" ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" Font-Bold ="true"></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:TextBox ID="txtStreet" runat="server" Width = "170px" height ="14px" Font-size="Small" Font-Names="verdana" ForeColor ="#336699"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblPostCode" runat="server" Text="Post Code" ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" Font-Bold ="true" ></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:TextBox ID="txtPostcode" runat="server" Height ="14px" Width ="100px" Font-size="small" Font-Names="verdana" ForeColor="#336699"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblState" runat="server" Text="State" ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" Font-Bold ="true" ></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:DropDownList ID="dLState" runat="server" Height="21px" Width="140px" ForeColor ="#336699">
                                        <asp:ListItem>-Select State-</asp:ListItem>
                                        <asp:ListItem>Johor</asp:ListItem>
                                        <asp:ListItem>Kedah</asp:ListItem>
                                        <asp:ListItem>Kelantan</asp:ListItem>
                                        <asp:ListItem>Melaka</asp:ListItem>
                                        <asp:ListItem>N.Sembilan</asp:ListItem>
                                        <asp:ListItem>Pahang</asp:ListItem>
                                        <asp:ListItem>Penang</asp:ListItem>
                                        <asp:ListItem>Perak</asp:ListItem>
                                        <asp:ListItem>Perlis</asp:ListItem>
                                        <asp:ListItem>Sabah</asp:ListItem>
                                        <asp:ListItem>Serawak</asp:ListItem>
                                        <asp:ListItem>Selangor</asp:ListItem>
                                        <asp:ListItem>Terengganu</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="style52">
                                    </td>
                                <td class="style63">
                                    <asp:Label ID="lblRole" runat="server" Text="Role" ForeColor="#336699"  
                                        Font-Names ="verdana" font-size="XX-Small" Font-Bold ="True" ></asp:Label>
                                </td>
                                <td class="style64">
                                    <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style55" colspan="2">
                                    <asp:DropDownList ID="ddLRole" runat="server" Height="22px" Width="140px" ForeColor ="#336699">
                                        <asp:ListItem>-Select Role-</asp:ListItem>
                                        <asp:ListItem>Admin</asp:ListItem>
                                        <asp:ListItem>User</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="style57">
                                    </td>
                                <td class="style58">
                                    <asp:Label ID="lblAccessible" runat="server" Text="Accessible District" 
                                        ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" 
                                        Font-Bold ="True" ></asp:Label>
                                </td>
                                <td class="style59">
                                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Medium" 
                                        ForeColor="#336699" Text=":"></asp:Label>
                                </td>
                                <td class="style60" colspan="2">
                                    <asp:ListBox ID="lstAccessible" runat="server" Width="140px" forecolor="#336699">
                                        <asp:ListItem>All</asp:ListItem>
                                        <asp:ListItem> Alor Gajah</asp:ListItem>
                                        <asp:ListItem> Jasin</asp:ListItem>
                                        <asp:ListItem>Melaka Tengah</asp:ListItem>
                                    </asp:ListBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style65">
                                    </td>
                                <td class="style66">
                                    </td>
                                <td class="style67">
                                    </td>
                                <td class="style68">
                                    </td>
                                <td class="style69">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                                        style="margin-left: 80px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="style7">
                                    &nbsp;</td>
                                <td class="style20">
                                    &nbsp;</td>
                                <td class="style18">
                                    &nbsp;</td>
                                <td class="style31">
                                    &nbsp;</td>
                                <td class="style14">
                                    &nbsp;</td>
                            </tr>
                        </table>
                       
                    </asp:Panel>
                    
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
