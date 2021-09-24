<%@ Page Language="VB"  Debug="true" CodeFile="alarmselection.aspx.vb" Inherits="alarmselection" %>
 <%--<%@ Page Language="VB" Debug="true" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">   
    <div align="center">
    <table border="1" style="border-color:Blue;position:absolute; height: 102px;top:80px; left: 151px;">
      <tr style=" border:0; top:0">
      <td bgcolor="#465AE8" height="20" style="width: 441px; border:0" align="left"><b><font color="#FFFFFF" size="1" face="Verdana">
      Alarm Report Utilities:</font></b></td>
    </tr>
    <tr>
    <td style="width: 441px; border:0; height: 46px;">
        <div align="center">
          <table border="0" cellspacing="1" width="100%">
            <tr>
              <td width="100%" colspan="4">&nbsp;</td>
            </tr>
            <tr><td style="width: 80px; height: 17px;"></td>
              <td width="16%" style="height: 17px"><font face="Verdana" size="1" color="#5F7AFC"><b>Report</b></font></td>
              <td width="3%" style="height: 17px"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td align="left" style="width: 78%; height: 17px;">&nbsp
        <asp:DropDownList ID="alarmselection" runat="server" AutoPostBack="True" Width="276px" ForeColor="#5F7AFC">       
            <asp:ListItem Selected="True">Select Alarm Report</asp:ListItem>
            <asp:ListItem Value="Alarm.spx">Alarm History</asp:ListItem>
            <asp:ListItem Value="NewAlarm.aspx">Alarm Selection</asp:ListItem>      
        </asp:DropDownList>
        </td>
        <td style="width: 110px; height: 17px;"></td>
        </tr>
        <tr>
                      <td width="110%" colspan="4">&nbsp;</td>
            </tr>

          </table>
        </div></td></tr>
                </table>
        </div>
    </form>
</body>
</html>
