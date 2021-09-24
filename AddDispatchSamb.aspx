<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddDispatchSamb.aspx.vb" Inherits="AddDispatchSamb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
<script type="text/javascript" language="javascript">

    function CheckBoxListSelect(cbControl, state) {
        var chkBoxList = document.getElementById(cbControl);
        var chkBoxCount = chkBoxList.getElementsByTagName("input");
        for (var i = 0; i < chkBoxCount.length; i++) {
            chkBoxCount[i].checked = state;
        }

        return false;
    }

    function setHide() {
        document.getElementById("rowHeight").style.display = 'none';
        document.getElementById("rowValue").style.display = 'none';
        document.getElementById("rowCal").style.display = 'none';
        document.getElementById("rowV1").style.display = 'none';
    }

    function showhide() {
        showFormula();
        document.getElementById("rowHeight").style.display = document.getElementById("checkbox1").checked ? '' : 'inline';
        document.getElementById("rowHeight").style.display = document.getElementById("checkbox1").checked ? '' : 'none';
        document.getElementById("rowValue").style.display = document.getElementById("checkbox1").checked ? '' : 'inline';
        document.getElementById("rowValue").style.display = document.getElementById("checkbox1").checked ? '' : 'none';
        document.getElementById("rowFormula").style.display = document.getElementById("checkbox1").checked ? '' : 'inline';
        document.getElementById("rowFormula").style.display = document.getElementById("checkbox1").checked ? '' : 'none';
    }

    function showFormula() {
        if (document.getElementById("checkbox1").checked) {
            document.getElementById("rowFormula").style.display = 'none';
            document.getElementById("rowType").style.display = 'none';
            document.getElementById("rowOffset").style.display = 'none';
            document.getElementById("rowCal").style.display = 'inline';
            document.getElementById("rowV0").style.display = 'inline';
            document.getElementById("rowV1").style.display = 'inline';
            document.getElementById("rowV2").style.display = 'inline';
            document.getElementById("rowV3").style.display = 'inline';
            document.getElementById("rowV4").style.display = 'inline';
            document.getElementById("rowV5").style.display = 'inline';
            document.getElementById("rowV6").style.display = 'inline';
            document.getElementById("rowV7").style.display = 'inline';
        }
        else {
            document.getElementById("rowFormula").style.display = 'inline';
            document.getElementById("rowType").style.display = 'inline';
            document.getElementById("rowOffset").style.display = 'inline';
            document.getElementById("rowCal").style.display = 'none';
            document.getElementById("rowV0").style.display = 'none';
            document.getElementById("rowV1").style.display = 'none';
            document.getElementById("rowV2").style.display = 'none';
            document.getElementById("rowV3").style.display = 'none';
            document.getElementById("rowV4").style.display = 'none';
            document.getElementById("rowV5").style.display = 'none';
            document.getElementById("rowV6").style.display = 'none';
            document.getElementById("rowV7").style.display = 'none';
        }
    }

</script>
</head>
<body id="fuelBody" style="text-align: center" runat="server">
    <form id="form1" runat="server">
        <br />
        <img alt="Add SMS Panic Dispatch" src="images/addsmspanicdispatch.gif" />
        <br />
        <asp:Label ID="lblMessage" runat="server"  Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="Red" Visible="False"></asp:Label>

        <asp:Label ID="lblMessage2" runat="server" Font-Bold="True" Font-Names="Verdana"
            Font-Size="11px" ForeColor="Red" Visible="False"></asp:Label><br />
    <table align="center" style="width: 750px">
    <tr>
   <td align="left" bgcolor="#465ae8" height="20px" style="width: 600px">
       <asp:Label ID="Label1" runat="server" Text="Add New Panic Dispatch :" Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="White"></asp:Label></td>
    </tr>
   <tr>
                                    <td style="padding-right:5px; padding-top:5px;padding-bottom:5px; border: solid 1px #3952F9; width: 600px;" >
                                        <table width="750">
                                            <tbody>
                                                <tr>
                                                    <td align="left" valign="top" width="110">
                                                        &nbsp;<asp:Label ID="label2" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text="Select District"></asp:Label></td>

                                                    <td style="width: 5px" valign="top">
                                                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label></td>
                                                    <td align="left" colspan="7" valign="top">
                                                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True"
                                                            Width="355px">
                                                        </asp:DropDownList></td>
                                                </tr>

                                                  <tr>
                                                    <td align="left" valign="top" width="110">
                                                        &nbsp;<asp:Label ID="label11" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text="Select Site"></asp:Label></td>

                                                    <td style="width: 5px" valign="top">
                                                        <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label></td>
                                                    <td align="left" colspan="7" valign="top">
                                                        <asp:DropDownList ID="ddlSiteName" runat="server" AutoPostBack="True" 
                                                            Width="355px">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                 <tr>
                                                    <td align="left" valign="top" width="110" style="font-size: 11px; font-family: Verdana">
                                                        &nbsp;<asp:Label ID="Label14" runat="server" Text="Contact" Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#5F7AFC" Width="60px"></asp:Label><br />
                                                        <br />
                                                        &nbsp;select
                                                        <a id="A3" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlContact.ClientID %>',true)">All</a>|<a id="A4" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlContact.ClientID %>',false)">None</a>
                                                    </td>
                                                    <td style="width: 5px;" valign="top">
                                                        <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="top" colspan="7">
                                                        <asp:Panel ID="Panel2" runat="server" HorizontalAlign="Left" BorderColor="#E0E0E0" BorderStyle="None" ScrollBars="Vertical" Height="240px" Width="100%">
                                                        <asp:CheckBoxList ID="ddlContact" runat="server" Font-Names="Verdana" Font-Size="11px" RepeatColumns="2" RepeatDirection="Horizontal" Width="430px" TabIndex="1">
                                                        </asp:CheckBoxList></asp:Panel>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top" width="110" style="font-size: 11px; font-family: Verdana">
                                                        &nbsp;<asp:Label ID="Label3" runat="server" Text="Rule" Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#5F7AFC" Width="60px"></asp:Label><br />
                                                        <br />
                                                        &nbsp;select
                                                        <a id="A1" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlVehicle.ClientID %>',true)">All</a>|<a id="A2" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlVehicle.ClientID %>',false)">None</a>
                                                    </td>
                                                    <td style="width: 5px;" valign="top">
                                                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="top" colspan="7">
                                                        <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Left" BorderColor="#E0E0E0" BorderStyle="None" ScrollBars="Vertical" Height="150px" Width="100%">
                                                        <asp:CheckBoxList ID="ddlVehicle" runat="server" Font-Names="Verdana" Font-Size="11px" RepeatColumns="2" RepeatDirection="Horizontal" Width="430px" TabIndex="1">
                                                        </asp:CheckBoxList></asp:Panel>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                             

                                              <tr>
                                                    <td align="left" valign="top" width="110" style="font-size: 11px; font-family: Verdana">
                                                        &nbsp;<asp:Label ID="lblPriority" runat="server" Text="Priority" Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#5F7AFC" Width="60px"></asp:Label><br />
                                                    </td>
                                                    <td style="width: 5px;" valign="top">
                                                        <asp:Label ID="lblSymbol" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="top" colspan="7">
                                                        <asp:TextBox ID="txtPriority" runat="server" Width="49px"></asp:TextBox>
                                                     </td>
                                                </tr>
                                                <!--<tr id="rowType">
                                                    <td align="left" valign="middle" width="110">
                                                        <b style="color: #5f7afc; vertical-align: top;">&nbsp;<asp:Label ID="lblOffset" runat="server" Text="Destination" Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#5F7AFC"></asp:Label></b></td>
                                                    <td align="left" valign="middle">
                                                            <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                                ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="middle" width="200">
                                                        <asp:TextBox ID="txtDestination" runat="server" Width="130px" Font-Names="Verdana" Font-Size="Small" TabIndex="3"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtDestination"
                                                            ErrorMessage="**" Font-Names="Verdana" Font-Size="X-Small" ValidationExpression="\+\d{11}"></asp:RegularExpressionValidator>&nbsp;
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="**" ControlToValidate="txtDestination" Font-Names="Verdana" Font-Size="10px"></asp:RequiredFieldValidator>
                                                        </td>
                                                    <td align="left" valign="middle" width="100">
                                                        <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text="Name"></asp:Label></td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label></td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtContact" runat="server" Width="130px" TabIndex="4"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="**" ControlToValidate="txtContact" Font-Names="Verdana" Font-Size="10px"></asp:RequiredFieldValidator>&nbsp;</td>

                                                        <td align="left" valign="middle" width="100">
                                                        <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text="Priority"></asp:Label></td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label></td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtPriority1" runat="server" Width="130px" TabIndex="4"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" ControlToValidate="txtContact" Font-Names="Verdana" Font-Size="10px"></asp:RequiredFieldValidator>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="middle" width="110">
                                                        <asp:Label ID="Label8" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="10px"
                                                            ForeColor="#5F7AFC" Text="(eg:+60123456789)"></asp:Label></td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle" width="200">
                                                        <asp:TextBox ID="txtDestination2" runat="server" Font-Names="Verdana" Font-Size="Small"
                                                            Width="130px" TabIndex="5"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDestination2"
                                                            ErrorMessage="**" Font-Names="Verdana" Font-Size="X-Small" ValidationExpression="\+\d{11}"></asp:RegularExpressionValidator></td>
                                                    <td align="left" valign="middle" width="100">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtContact2" runat="server" TabIndex="6" Width="130px"></asp:TextBox></td>
                                                         <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtPriority2" runat="server" TabIndex="6" Width="130px"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="middle" width="110">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle" width="200">
                                                        <asp:TextBox ID="txtDestination3" runat="server" Font-Names="Verdana" Font-Size="Small"
                                                            Width="130px" TabIndex="7"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDestination3"
                                                            ErrorMessage="**" Font-Names="Verdana" Font-Size="X-Small" ValidationExpression="\+\d{11}"></asp:RegularExpressionValidator></td>
                                                    <td align="left" valign="middle" width="100">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtContact3" runat="server" TabIndex="8" Width="130px"></asp:TextBox></td>
                                                        <td align="left" valign="middle" width="100">
                                                    </td>
                                                         <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtPriority3" runat="server" TabIndex="6" Width="130px"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="middle" width="110">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle" width="200">
                                                        <asp:TextBox ID="txtDestination4" runat="server" Font-Names="Verdana" Font-Size="Small"
                                                            Width="130px" TabIndex="9"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDestination4"
                                                            ErrorMessage="**" Font-Names="Verdana" Font-Size="X-Small" ValidationExpression="\+\d{11}"></asp:RegularExpressionValidator></td>
                                                    <td align="left" valign="middle" width="100">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtContact4" runat="server" TabIndex="10" Width="130px"></asp:TextBox></td>
                                                             <td align="left" valign="middle" width="100">
                                                    </td>
                                                         <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtPriority4" runat="server" TabIndex="6" Width="130px"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="middle" width="110">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle" width="200">
                                                        <asp:TextBox ID="txtDestination5" runat="server" Font-Names="Verdana" Font-Size="Small"
                                                            Width="130px" TabIndex="11"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDestination5"
                                                            ErrorMessage="**" Font-Names="Verdana" Font-Size="X-Small" ValidationExpression="\+\d{11}"></asp:RegularExpressionValidator></td>
                                                    <td align="left" valign="middle" width="100">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtContact5" runat="server" TabIndex="12" Width="130px"></asp:TextBox></td>

                                                                 <td align="left" valign="middle" width="100">
                                                    </td>
                                                         <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:TextBox ID="txtPriority5" runat="server" TabIndex="6" Width="130px"></asp:TextBox></td>
                                                </tr>-->
                                                <tr  id="rowCal">
                                                    <td align="left" valign="middle" width="110">
                                                        &nbsp;</td>
                                                    <td align="left" valign="middle">
                                                        &nbsp;</td>
                                                    <td align="left" valign="middle" width="200">
                                                        &nbsp;</td>
                                                    <td align="left" valign="middle" width="100">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                    <td align="left" valign="middle">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" valign="bottom" width="110">
                                                        <br />
                                                        </td>
                                                    <td colspan="2" align="center" valign="bottom">
                                                        <!--<asp:ImageButton ID="ibBack" runat="server" ImageUrl="~/images/Search.jpg" CausesValidation="False" />-->
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    </td>
                                                    <td align="center" colspan="1" valign="bottom" width="100">
                                                        <asp:ImageButton ID="ibSubmit" runat="server" ImageUrl="~/images/Submit_s.jpg" /></td>
                                                    <td align="center" colspan="1" valign="bottom">
                                                    </td>
                                                    <td align="center" colspan="1" valign="bottom">
                                                    <asp:ImageButton ID="ibCancel" runat="server" ImageUrl="~/images/cancel_s.jpg" CausesValidation="False" /></td>
                                                </tr>
                                                </tbody> 
    </table>
</td> 
   </tr>
   </table>
        <br />
     <p style="margin-bottom: 15px; font-family: Verdana; font-size: 10px; color: #5373a2;">
                    Copyright © 2008 Gussmann Technologies Sdn Bhd. All rights reserved.</p>
        <p>
            &nbsp;&nbsp;</p>
    </form>
</body>
</html>


