<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddNewDispatchSAMB.aspx.vb" Inherits="AddDispatchSamb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
  

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script src="/resources/demos/external/jquery.mousewheel.js"></script>

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
<script type="text/javascript"  language ="javascript" >
  $(function(){

         $( ".sortable" ).sortable({
            revert: true
        });
        $( ".draggable" ).draggable({
            connectToSortable: "#sortable",
            helper: "clone",
            revert: "invalid"
        });
    });

</script>
   <title>Untitled Page</title>
    <style type="text/css">
        .style3
        {
            height: 1px;
        }
        .cboAlign
        {
         width:230px;
        }
        .FontText
        {
           font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
          color:#5f7afc;
           font-size:12px;
           font-weight :bold ;
    
        }
        .FontText1
        {
           font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
 
           font-size:12px;
            
        }
        .tableAlign
        {   
             text-align:center;
             background-color:#465ae8; 
              font-size:14px; 
            font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif; color:White;
              width: 500px;
        }
        
        .style4
        {
            height: 28px;
        }
        .style6
        {
            width: 600px;
            height: 20px;
        }
        .style8
        {
            height: 28px;
            width: 118px;
        }
        .style9
        {
            width: 118px;
        }
        .style10
        {
            width: 25px;
        }
        .style11
        {
            height: 28px;
            width: 25px;
        }
        
    </style>
</head>
<body id="fuelBody" style="text-align: center" runat="server">
    <form id="form1" runat="server">
        <br />
        &nbsp;<br />
        <asp:Label ID="lblMessage" runat="server"  Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="Red" Visible="False"></asp:Label>

        <asp:Label ID="lblMessage2" runat="server" Font-Bold="True" Font-Names="Verdana"
            Font-Size="11px" ForeColor="Red" Visible="False"></asp:Label><br />
    <table align="center" style="width: 750px">
    <tr>
   <td align="center" bgcolor="#465ae8" class="style6">
       <asp:Label ID="Label1" runat="server" Text="Add New Panic Dispatch "  CssClass ="tableAlign"></asp:Label></td>
    </tr>
   <tr>
                                    <td style="padding-right:5px; padding-top:5px;padding-bottom:5px; border: solid 1px #3952F9; width: 600px;" >
                                        <table width="750">
                                            <tbody>
                                                <tr>
                                                    <td align="left" valign="top" class="style9">
                                                        &nbsp;<asp:Label ID="label2" runat="server"  CssClass ="FontText"
                                                            ForeColor="#5F7AFC" Text="Select District"></asp:Label></td>

                                                    <td valign="top" class="style10">
                                                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label></td>
                                                    <td align="left" colspan="4" valign="top">
                                                        <asp:DropDownList ID="ddlDistrict" runat="server" AutoPostBack="True"
                                                            Width="355px" CssClass ="FontText">
                                                        </asp:DropDownList></td>
                                                </tr>

                                                  <tr>
                                                    <td align="left" valign="top" class="style8">
                                                        &nbsp;<asp:Label ID="label11" runat="server" CssClass ="FontText"
                                                            ForeColor="#5F7AFC" Text="Select Site"></asp:Label></td>

                                                    <td valign="top" class="style11">
                                                        <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label></td>
                                                    <td align="left" colspan="4" valign="top" class="style4">
                                                        <asp:DropDownList ID="ddlSiteName" runat="server" AutoPostBack="True" 
                                                            Width="355px" CssClass ="FontText">
                                                        </asp:DropDownList></td>
                                                </tr>

                                                  <tr>
                                                    <td align="left" valign="top" width="110" class="style3" colspan="6">
                                                        <hr style="width: 740px; margin-top: 5px;" />
                                                      </td>

                                                </tr>
                                                 <tr>
                                                    <td align="left" valign="top" style="font-size: 11px; font-family: Verdana" 
                                                         class="style9">
                                                        &nbsp;<asp:Label ID="Label14" runat="server" Text="Contact" cssclass="FontText"></asp:Label><br />
                                                        <br />
                                                        &nbsp;select
                                                        <a id="A3" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlContact.ClientID %>',true)">All</a>|<a id="A4" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlContact.ClientID %>',false)">None</a>
                                                    </td>
                                                    <td valign="top" class="style10">
                                                        <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="top" colspan="4">
                                                        <asp:Panel ID="Panel2" runat="server" HorizontalAlign="Left" 
                                                            BorderColor="White" ScrollBars="Vertical" Height="240px" Width="100%" 
                                                            BackColor="White" Font-Strikeout="False">
                                                        <asp:CheckBoxList ID="ddlContact" runat="server" CssClass ="FontText1" RepeatColumns="2" RepeatDirection="Horizontal" Width="430px" 
                                                                TabIndex="1" style="margin-top: 4px" BackColor="White" 
                                                                BorderColor="#66CCFF" BorderStyle="Groove">
                                                        </asp:CheckBoxList></asp:Panel>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top" width="110" 
                                                        style="font-size: 11px; font-family: Verdana" colspan="6">
                                                        <hr style="width: 742px" />
                                                    </td>
                                                </tr>
                                             

                                                <tr>
                                                    <td align="left" valign="top" style="font-size: 11px; font-family: Verdana" 
                                                        class="style9">
                                                        &nbsp;<asp:Label ID="Label3" runat="server" Text="Rule"  CssClass ="FontText"></asp:Label><br />
                                                        <br />
                                                        &nbsp;select
                                                        <a id="A1" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlVehicle.ClientID %>',true)">All</a>|<a id="A2" href="#" onclick="javascript: CheckBoxListSelect ('<%= ddlVehicle.ClientID %>',false)">None</a>
                                                    </td>
                                                    <td valign="top" class="style10">
                                                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="top" colspan="4">
                                                        <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Left" BorderColor="#E0E0E0" BorderStyle="None" ScrollBars="Vertical" Height="150px" Width="100%">
                                                        <asp:CheckBoxList ID="ddlVehicle" runat="server"  CssClass ="FontText1" RepeatColumns="2" RepeatDirection="Horizontal" Width="430px" 
                                                                TabIndex="1" BorderColor="#66CCFF" BorderStyle="Groove">
                                                        </asp:CheckBoxList></asp:Panel>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                             

                                                <tr>
                                                    <td align="left" valign="top" width="110" 
                                                        style="font-size: 11px; font-family: Verdana" colspan="6">
                                                        <hr style="width: 742px" />
                                                    </td>
                                                </tr>
                                             

                                              <tr>
                                                    <td align="left" valign="top" style="font-size: 11px; font-family: Verdana" 
                                                        class="style9">
                                                        &nbsp;<asp:Label ID="lblPriority" runat="server" Text="Priority"  CssClass ="FontText"></asp:Label><br />
                                                    </td>
                                                    <td valign="top" class="style10">
                                                        <asp:Label ID="lblSymbol" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"
                                                            ForeColor="#5F7AFC" Text=":"></asp:Label>&nbsp;</td>
                                                    <td align="left" valign="top" colspan="4">
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
                                                    <td align="left" valign="middle" colspan="6">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td align="center" valign="bottom" class="style9">
                                                        <br />
                                                        </td>
                                                    <td colspan="2" align="center" valign="bottom">
                                                        <!--<asp:ImageButton ID="ibBack" runat="server" ImageUrl="~/images/Search.jpg" CausesValidation="False" />-->
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    </td>
                                                    <td align="center" colspan="1" valign="bottom" width="100">
                                                        &nbsp;</td>
                                                    <td align="center" colspan="1" valign="bottom">
                                                    </td>
                                                    <td align="center" colspan="1" valign="bottom">
                                                        <asp:ImageButton ID="ibSubmit" runat="server" ImageUrl="~/images/Submit_s.jpg" /></td>
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


