<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddContactSamb.aspx.vb" Inherits="AddContactSamb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Add User</title>
    <link type="text/css" href="cssfiles/balloontip.css" rel="stylesheet" />

    <script type="text/javascript" src="jsfiles/balloontip.js"></script>

    <script type="text/javascript">
        function mysubmit() {
            if (document.getElementById("userid").value == "") {
                alert("Please enter user ID");
                return false;
            }
            else if (document.getElementById("username").value == "") {
                alert("Please enter user name");
                return false;
            }
            else if (document.getElementById("password").value == "") {
                alert("Please enter password");
                return false;
            }
            else if (document.getElementById("password").value != document.getElementById("confirmpassword").value) {
                alert("password,confirm password are not equal");
                return false;
            }
            else if (document.getElementById("companyname").value == "") {
                alert("Please enter company name");
                return false;
            }
            else if (document.getElementById("mobilenumber").value == "") {
                alert("Please enter mobile number");
                return false;
            }
            else if (document.getElementById("phonenumber").value == "") {
                alert("Please enter phone number");
                return false;
            }
            else if (document.getElementById("faxnumber").value == "") {
                alert("Please enter fax number");
                return false;
            }
            else if (document.getElementById("emailid").value == "") {
                alert("Please enter email id");
                return false;
            }
            else if (document.getElementById("streetname").value == "") {
                alert("Please enter street name");
                return false;
            }
            else if (document.getElementById("postalcode").value == "") {
                alert("Please enter postal code number");
                return false;
            }
            else if (document.getElementById("ddlstate").value == "--Select State--") {
                alert("Please select state name");
                return false;
            }
            else if (document.getElementById("ddlrole").value == "--Select Role--") {
                alert("Please select user role");
                return false;
            }
            //        else if(document.getElementById("emailid").value!="")
            //        {
            //            var emailvalue=document.getElementById("emailid").value;
            //            var emailRegEx = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            //            if(emailvalue.match(emailRegEx))
            //            {
            //                return true;
            //            }
            //            else
            //            {
            //                alert('Please enter a valid email address.');
            //                return false;
            //            }
            //        }
        }
        function cancel() {
            var formobj = document.getElementById("adduserform");
            formobj.reset();
        }
    </script>

</head>
<body style="margin-left: 5px; margin-top: 0px; margin-bottom: 0px; margin-right: 5px;">
    <form id="adduserform" method="post" runat="server">
        <center>
            <div>
                <br />
                <img alt="Add User" src="images/AddUser.jpg" />
                <br />
                <br />
                <table>
                    <tr>
                        <td align="center">
                            <table style="font-family: Verdana; font-size: 11px;">
                                <tr>
                                    <td style="height: 20px; background-color: #465ae8;" align="left">
                                        <b style="color: White;">&nbsp;Add New Contact Details :</b></td>
                                </tr>


                                <tr>
                                    <td style="width: 350px; border: solid 1px #3952F9; color: #5f7afc;">
                                        <table style="width: 350px;">
                                               
                                          <tr align="left">
                                                <td>
                                                    <b>Control ID</b></td>
                                                <td>
                                                    <b>:</b></td>
                                                <td>
                                                    <asp:TextBox ID="txtID" runat="Server" Style="border-right: #cbd6e4 1px solid;
                                                        border-top: #cbd6e4 1px solid; font-size: 10pt; border-left: #cbd6e4 1px solid;
                                                        color: #0b3d62; border-bottom: #cbd6e4 1px solid; font-family: Verdana" 
                                                        Width="180px" ReadOnly="True" />
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td style="width: 130px;">
                                                    <b>Contact Name</b></td>
                                                <td style="width: 10px;">
                                                    <b>:</b></td>
                                                <td style="width: 210px;">
                                                    <asp:TextBox ID="txtContact" runat="Server" Style="border-right: #cbd6e4 1px solid;
                                                        border-top: #cbd6e4 1px solid; font-size: 10pt; border-left: #cbd6e4 1px solid;
                                                        color: #0b3d62; border-bottom: #cbd6e4 1px solid; font-family: Verdana" Width="180px" />
                                                </td>
                                            </tr>

                                         
                                            <tr align="left">
                                                <td>
                                                    <b>Sim no</b></td>
                                                <td>
                                                    <b>:</b></td>
                                                <td>
                                                    <asp:TextBox ID="txtSimno" runat="Server" Style="border-right: #cbd6e4 1px solid;
                                                        border-top: #cbd6e4 1px solid; font-size: 10pt; border-left: #cbd6e4 1px solid;
                                                        color: #0b3d62; border-bottom: #cbd6e4 1px solid; font-family: Verdana" 
                                                        Width="180px" />
                                                </td>
                                            </tr>

                                                <tr align="left">
                                                <td style="width: 130px;">
                                                    <b>Post</b></td>
                                                <td style="width: 10px;">
                                                    <b>:</b></td>
                                                <td style="width: 210px;">
                                                    <a rel="balloon1">
                                                        <asp:TextBox ID="txtPost" runat="Server" Style="border-right: #cbd6e4 1px solid; border-top: #cbd6e4 1px solid;
                                                            font-size: 10pt; border-left: #cbd6e4 1px solid; color: #0b3d62; border-bottom: #cbd6e4 1px solid;
                                                            font-family: Verdana" Width="180px" /></a>
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td>
                                                    <b>Control District</b></td>
                                                <td>
                                                    <b>:</b></td>
                                                <td>
                                                    <asp:TextBox ID="txtControl" runat="Server" Style="border-right: #cbd6e4 1px solid;
                                                        border-top: #cbd6e4 1px solid; font-size: 10pt; border-left: #cbd6e4 1px solid;
                                                        color: #0b3d62; border-bottom: #cbd6e4 1px solid; font-family: Verdana" 
                                                        Width="180px" />
                                                </td>
                                            </tr>
                                       
                                            <tr>
                                                <td align="center">
                                                    <br />
                                                    <!--<a href="UserManagement.aspx">
                                                        <img src="images/back.jpg" alt="Back" style="border: 0px; vertical-align: top; cursor: pointer"
                                                            title="Back" /></a>-->
                                                </td>
                                                <td colspan="2" align="center" valign="middle">
                                                    <br />
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/submit_s.jpg"
                                                        ToolTip="Submit"></asp:ImageButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--<img src="images/cancel_s.jpg"
                                                            alt="Cancel" style="border: 0px; vertical-align: top; cursor: pointer" title="Cancel"
                                                            onclick="javascript:cancel();" />-->
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <p style="margin-bottom: 15px; font-family: Verdana; font-size: 11px; color: #5373a2;">
                                Copyright © 2008 Global Telematics Sdn Bhd. All rights reserved.
                            </p>
                        </td>
                    </tr>
                </table>
            </div>
        </center>
         
    </form>
</body>
</html>
