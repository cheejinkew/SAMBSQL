<%@ Page Language="VB" AutoEventWireup="false" EnableViewState="false" EnableEventValidation="false"
    CodeFile="Reports.aspx.vb" Inherits="Reports" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Reports</title>

    <script language="javascript" type="text/javascript">  
function mysubmit(obj)
{
    var reportsformobj=document.getElementById("reportsform");
    reportsformobj.action=obj.value;
    reportsformobj.submit();
}
    </script>

</head>
<body style="margin: 0px;">
    <form id="reportsform" method="get" action="Reports.aspx">
    </form>
    <form id="form" method="get" action="Reports.aspx" runat="server">
        <center>
        <br />
            <div style="font-size: 10pt; font-family: 'Microsoft Sans Serif'">
                <table>
                    <tr>
                        <td align="center">
                            <table style="font-family: Verdana; font-size: 11px;">
                                <tr>
                                    <td style="height: 20px; background-color: #4D90FE;" align="left">
                                        <b style="color: White;">&nbsp;Select Report Type :</b></td>
                                </tr>
                                <tr>
                                    <td style="width: 450px; border: solid 1px #3952F9;">
                                        <table style="width: 450px;">
                                            <tr>
                                                <td colspan="3">
                                                    <br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <b style="color: #5f7afc;">Report Type</b>
                                                </td>
                                                <td>
                                                    <b style="color: #5f7afc;">:</b></td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlreport" runat="server" Width="300" EnableViewState="False">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <br />
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <p style="margin-bottom: 15px; font-family: Verdana; font-size: 11px; color: #5373a2;">
                                Copyright © 2012 Global Telematics Sdn Bhd. All rights reserved.
                            </p>
                        </td>
                    </tr>
                </table>
            </div>
        </center>
    </form>
</body>
</html>
