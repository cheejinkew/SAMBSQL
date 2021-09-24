<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SIteRestSettings.aspx.vb"
    Inherits="SIteRestSettings" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Level Setings</title>
    <style type="text/css">
        /* Show only to IE PC \*/
        * html .boxhead h2
        {
            height: 1%;
        }
        /* For IE 5 PC */
        
        .sidebox
        {
            /* margin: 0 auto; /* center for now */ /* width:450px; /* ems so it will grow */ /* background: url(images/sbbody-r.gif) no-repeat bottom right;
	font-size: 100%;*/
        }
        .boxhead
        {
            background: url(images/sbhead-r.gif) no-repeat top right;
            margin: 0;
            padding: 0;
            width: 490px;
            text-align: center;
        }
        .boxhead h2
        {
            background: url(images/sbhead-l.gif) no-repeat top left;
            margin: 0;
            padding: 22px 30px 5px;
            color: white;
            font-weight: bold;
            font-size: 1.2em;
            text-shadow: rgba(0,0,0,.4) 0px 2px 5px; /* Safari-only, but cool */
        }
        .boxbody
        {
            /*background: url(images/sbbody-l.gif) no-repeat bottom left;
	margin: 0;
	padding: 5px 5px 31px;*/
        }
        .FormDropdown
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #5F7AFC;
            width: 158px;
            border: 1 solid #CBD6E4;
        }
        
        .inputStyle
        {
            border-width: 1px;
            border-style: solid;
            border-color: #5F7AFC;
            font-family: Verdana;
            font-size: 10pt;
            color: #3952F9;
            height: 20px;
        }
        a.button:hover
        {
            color: White;
            text-shadow: 0 1px 0 #fff;
            border: 1px solid #2F5BB7 !important;
            background: #3F83F1;
            background: -webkit-linear-gradient(top, #4D90FE, #357AE8);
            background: -moz-linear-gradient(top, #4D90FE, #357AE8);
            background: -ms-linear-gradient(top, #4D90FE, #357AE8);
            background: -o-linear-gradient(top, #4D90FE, #357AE8);
        }
        a.button
        {
            text-align: center;
            font: bold 11px Helvetica, Arial, sans-serif;
            cursor: pointer;
            text-decoration: none;
            text-shadow: 0 1px 0 #fff;
            display: inline-block;
            width: 74px;
            border: 1px solid #3079ED !important;
            color: White;
            height: 14px;
            background: #4B8DF8;
            background: -webkit-linear-gradient(top, #4C8FFD, #4787ED);
            background: -moz-linear-gradient(top, #4C8FFD, #4787ED);
            background: -ms-linear-gradient(top, #4C8FFD, #4787ED);
            background: #4B8DF8;
            -webkit-transition: border .20s;
            -moz-transition: border .20s;
            -o-transition: border .20s;
            transition: border .20s;
            margin: 5px;
            padding: 3px 5px 5px 3px;
        }
        
        .action
        {
            border: 1px solid #D8D8D8 !important;
            text-shadow: 0 1px 0 #fff;
            background: #4D90FE;
            background: -webkit-linear-gradient(top, #F5F5F5, #F1F1F1);
            background: -moz-linear-gradient(top, #F5F5F5, #F1F1F1);
            background: -ms-linear-gradient(top, #F5F5F5, #F1F1F1);
            background: -o-linear-gradient(top, #F5F5F5, #F1F1F1);
            -webkit-transition: border .20s;
            -moz-transition: border .20s;
            -o-transition: border .20s;
            transition: border .20s;
        }
        .blue
        {
            border: 1px solid #3079ED !important;
            color: White;
            text-shadow: 0 1px 0 #fff;
            background: #4B8DF8;
            background: -webkit-linear-gradient(top, #4C8FFD, #4787ED);
            background: -moz-linear-gradient(top, #4C8FFD, #4787ED);
            background: -ms-linear-gradient(top, #4C8FFD, #4787ED);
            background: -o-linear-gradient(top, #4C8FFD, #4787ED);
            -webkit-transition: border .20s;
            -moz-transition: border .20s;
            -o-transition: border .20s;
            transition: border .20s;
        }
        .blue:hover
        {
            border: 1px solid #2F5BB7 !important;
            background: #3F83F1;
            background: -webkit-linear-gradient(top, #4D90FE, #357AE8);
            background: -moz-linear-gradient(top, #4D90FE, #357AE8);
            background: -ms-linear-gradient(top, #4D90FE, #357AE8);
            background: -o-linear-gradient(top, #4D90FE, #357AE8);
        }
        
        
        
        .red
        {
            border: 1px solid #FF0000 !important;
            color: White;
            text-shadow: 0 1px 0 #fff;
            background: #FF0000;
            background: -webkit-linear-gradient(top, #FF0000, #FF0000);
            background: -moz-linear-gradient(top, #FF0000, #FF0000);
            background: -ms-linear-gradient(top, #4C8FFD, #FF0000);
            background: -o-linear-gradient(top, #FF0000, #FF0000);
            -webkit-transition: border .20s;
            -moz-transition: border .20s;
            -o-transition: border .20s;
            transition: border .20s;
        }
        .red:hover
        {
            border: 1px solid #FF0000 !important;
            background: #FF0000;
            background: -webkit-linear-gradient(top, #FF0000, #FF0000);
            background: -moz-linear-gradient(top, #FF0000, #FF0000);
            background: -ms-linear-gradient(top, #FF0000, #FF0000);
            background: -o-linear-gradient(top, #FF0000, #FF0000);
        }
        
        
        .td_label
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #5F7AFC;
            font-weight: bold;
            text-align: right;
        }
    </style>
    <script type="text/javascript" language="javascript" src="js/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery-ui.js"></script>
   
    <script type="text/javascript">
        function confirmation() {
            if (confirm('are you sure you want to Reset  ?')) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</head>
<body style="margin: 0 0 0 0; font-family: Verdana;">
    <form id="form1" runat="server">
    <div align="center">
        <div style="width: 100%; height: 40px; background-image: url(header_bg.gif)">
            <table style="width: 100%;" border="0">
                <tr>
                    <td align="center" style="vertical-align: middle; color: #336699; font-weight: bold;
                        font-size: 12px;">
                    </td>
                </tr>
            </table>
        </div>
        <table style="width: 1000px;" border="0">
            <tr>
                <td align="left" style="width: 500px; vertical-align: middle; color: #336699; font-weight: bold;
                    font-size: 12px;">
                    District :
                    <asp:DropDownList ID="ddlDistics" runat="server" Width="160px" AutoPostBack="True"
                        CssClass="FormDropdown" OnSelectedIndexChanged="ddlDistics_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td >
                    <div align="center">
                        <asp:GridView ID="GvAlertsSettings" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            EnableModelValidation="True" ForeColor="#333333" GridLines="None" Width="1000px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Sno" HeaderText="Sno" />
                                <asp:BoundField DataField="District" HeaderText="District" />
                                <asp:BoundField DataField="siteid" HeaderText="Site ID" />
                                <asp:BoundField DataField="Sitename" HeaderText="Site Name" />
                                <asp:BoundField DataField="Timestamp" HeaderText="TimeStamp" />
                                <asp:BoundField DataField="IsUpdate" HeaderText="Is Update" />
                                <asp:BoundField DataField="Level" HeaderText="Level" />
                                <asp:BoundField DataField="Status" HeaderText="Status" /> 
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="imgdelete" runat="server" ToolTip="Reset" Text ="Reset"
                                            Height="20px" OnClientClick="return confirmation();" OnClick="imgdelete_Click">
                                        </asp:Button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Size="11px" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" Font-Size="11px" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
