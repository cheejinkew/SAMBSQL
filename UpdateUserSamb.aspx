<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UpdateUserSamb.aspx.vb" Inherits="UPDATEUSERR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style4
        {
            width: 490px;
            height: 466px;
        }
        .style65
        {
            width: 111px;
            height: 34px;
        }
        .style67
        {
            height: 34px;
            width: 122px;
        }
        .style72
        {
            width: 111px;
            height: 83px;
        }
        .style75
        {
            height: 83px;
            width: 122px;
        }
        .style77
        {
            height: 14px;
        }
        .style83
        {
            width: 122px;
        }
        .style84
        {
            width: 12px;
            height: 34px;
        }
        .style85
        {
            width: 1px;
            height: 83px;
        }
        .style86
        {
            width: 1px;
        }
        .style87
        {
            width: 19px;
            height: 34px;
        }
        .style88
        {
            width: 19px;
        }
        .style89
        {
            width: 19px;
            height: 83px;
        }
        .style90
        {
            width: 111px;
        }
        .style91
        {
            width: 1px;
            height: 34px;
        }
        </style>
    </head>

<body>
  
    <form id="form1" runat="server">
    <div align="center" >
    <asp:Panel ID="Panel1" runat="server" align="center" BorderWidth = "2px" Height="509px" 
        Width="492px" ForeColor="#CCCCFF" Direction="LeftToRight" 
        style="margin-left: 0px; margin-right: 3px;" >
        <div align="center" >
        <table class="style4" align="center" >
            <tr>
                <td class="style77" colspan="4">
                    <asp:Label ID="lblNotMatch" runat="server" Font-Names="Verdana" 
                        Font-Size="Smaller" ForeColor="Red"></asp:Label>
                    </td>
            </tr>
            <tr>
                <td class="style87" align="center">
                </td>
                <td class="style65">
                    <asp:Label ID="lblUsername" runat="server" Font-Bold="True" 
                        Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#336699" Text="Username"></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style67">
                    <asp:Label ID="OutUsername" runat="server" Font-Bold="true" 
                        Font-Names="verdana" Font-Size="Medium" forecolor="#336699" Height="14px" 
                        style="margin-top: 0px" Text="-" Width="170px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                     <asp:Label ID="lblPassword" runat="server" Text="Old Password" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtOldPass" runat="server" Height="14px" Width="170px" 
                        Font-Names="verdana" Font-Size="Small" style="margin-top: 0px" 
                        forecolor="#336699" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="lblNewPassword" runat="server" Text="New Password" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtNewPass" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" 
                        style="margin-top: 0px" forecolor="#336699" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label4" runat="server" Text="Confirm Password" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtConfirmPass" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" 
                        style="margin-top: 0px" forecolor="#336699" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label5" runat="server" Text="Phone Number" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtPhoneno" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" style="margin-top: 0px" forecolor="#336699"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label6" runat="server" Text="Fax Number" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtFaxNo" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" style="margin-top: 0px" forecolor="#336699"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label22" runat="server" Text="Street" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtStreet" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" style="margin-top: 0px" forecolor="#336699"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label7" runat="server" Text="Post Code" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                    <asp:TextBox ID="txtPostCode" runat="server" Height="14px" Width="170px" 
                                        Font-Names="verdana" Font-Size="Small" style="margin-top: 0px" forecolor="#336699"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label8" runat="server" Text="State" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
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
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    <asp:Label ID="Label9" runat="server" Text="Role" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style91">
                    <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style83">
                <asp:DropDownList ID="ddLRole" runat="server" Height="22px" Width="140px" ForeColor ="#336699">
                                        <asp:ListItem>-Select Role-</asp:ListItem>
                                        <asp:ListItem>Admin</asp:ListItem>
                                        <asp:ListItem>User</asp:ListItem>
                                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style89">
                    </td>
                <td class="style72">
                    <asp:Label ID="Label10" runat="server" Text="Accessible District" Font-Bold ="true"  ForeColor="#336699" Font-Names ="verdana" font-size="XX-Small" ></asp:Label>
                </td>
                <td class="style85">
                    <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Size="Medium" 
                        ForeColor="#336699" Text=":"></asp:Label>
                </td>
                <td class="style75">
                    <asp:ListBox ID="lstAccessible" runat="server" Width="140px" forecolor="#336699">
                                        <asp:ListItem>All</asp:ListItem>
                                        <asp:ListItem> Alor Gajah</asp:ListItem>
                                        <asp:ListItem> Jasin</asp:ListItem>
                                        <asp:ListItem>Melaka Tengah</asp:ListItem>
                                    </asp:ListBox>
                </td>
            </tr>
            <tr>
                <td class="style88">
                    &nbsp;</td>
                <td class="style90">
                    &nbsp;</td>
                <td class="style86">
                    &nbsp;</td>
                <td class="style83">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
                </td>
            </tr>
        </table></div>
    </asp:Panel></div>
    </form>
 
    </body>
</html>
