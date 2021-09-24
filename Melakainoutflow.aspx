<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Melakainoutflow.aspx.vb"
    Inherits="Melakainoutflow" %>
<!--#include file="../kont_id.aspx"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Flow</title>

    <script language="JavaScript" src="TWCalendar.js"></script>

    <style type="text/css">
.GridView{background-color:#ffffff; border-width:1px; border-style:solid; border-color:Gray;}
.Header{background-color:#465AE8; font-weight:bold; color:White; font-size:11px; text-align:center;}	
.Alternate{background-color :#e6e6fa;}
</style>
</head>
<body style="font-family: Verdana; font-size: 11px; margin-top: 30px;">
    <form id="form1" runat="server">

        <script language="javascript">DrawCalendarLayout();</script>

        <center>
            <div style="font-size: 15px; color: #336699; font-weight: bold;">
                Site In-Out Flow</div>
            <br />
            <br />
            <table border="0" cellspacing="3" cellpadding="3">
                <tr style="font-weight: bold;">
                    <td style="color:#465AE8">
                        Select Site</td>
                    <td>
                        :</td>
                    <td align="left">
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" ForeColor="#336699">
                            <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                            <asp:ListItem Value="8511" Text="ANGKASA NURI"></asp:ListItem>
                            <asp:ListItem Value="8620" Text="BANDAR BARU SG UDANG"></asp:ListItem>
                            <asp:ListItem Value="8619" Text="MITC INDUSTRI 2"></asp:ListItem>
                            <asp:ListItem Value="8621" Text="TAMAN INDAH"></asp:ListItem>
                            <asp:ListItem Value="8643" Text="TAMAN KRUBONG PERDANA"></asp:ListItem>
                            <asp:ListItem Value="8512" Text="TAMAN TANJUNG MINYAK UTAMA"></asp:ListItem>
                            <asp:ListItem Value="8663" Text="TAMAN DESA IDAMAN"></asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                </tr>
                <tr style="font-weight: bold;">
                    <td style="color:#465AE8">
                        Select Date</td>
                    <td>
                        :</td>
                    <td align="left">
                        <input style="height: 15px; color: #336699; border-right: #5b7c97 1px solid; border-top: #5b7c97 1px solid;
                            border-left: #5b7c97 1px solid; border-bottom: #5b7c97 1px solid;" readonly="readonly"
                            type="text" size="12" value="" id="txtBeginDate" runat="server" name="txtBeginDate" />&nbsp;<a
                                href="javascript:ShowCalendar('txtBeginDate',550, 150);" style="text-decoration: none;">
                                <img alt="Show calendar control" title="Show calendar control" height="14" src="images/Calendar.jpg"
                                    width="19" style="border: solid 1px; border-color: #5B7C97; vertical-align: middle;" />
                            </a>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Submit_s.jpg" />
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="GridView" HorizontalAlign="center"
                CellPadding="3" AutoGenerateColumns="false">
                <AlternatingRowStyle CssClass="Alternate" />
                <HeaderStyle CssClass="Header" />
                <Columns>
                    <asp:BoundField DataField="Sno" HeaderText="S.No.">
                        <ItemStyle HorizontalAlign="center" Font-Bold="true" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Sequence" HeaderText="Date Time">
                        <ItemStyle HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="In" HeaderText="InFlow m*3/h">
                        <ItemStyle HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Out" HeaderText="OutFlow m*3/h">
                        <ItemStyle HorizontalAlign="center" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    <strong>No data available!!</strong>
                </EmptyDataTemplate>
            </asp:GridView>
        </center>
    </form>
</body>
</html>

<script type="text/javascript">
document.getElementById("divTWCalendar").style.visibility = 'hidden';
function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    var divTWCalendarobj=document.getElementById("divTWCalendar");
    txtTargetDateField = strTargetDateField;
    divTWCalendarobj.style.visibility = 'visible';
    divTWCalendarobj.style.left = findPosX(document.getElementById(strTargetDateField))+'px';
    divTWCalendarobj.style.top = findPosY(document.getElementById(strTargetDateField))+'px';
  }
  
  function findPosX(obj)
  {
    var curleft = 0;
    if(obj.offsetParent)
        while(1) 
        {
          curleft += obj.offsetLeft;
          if(!obj.offsetParent)
            break;
          obj = obj.offsetParent;
        }
    else if(obj.x)
        curleft += obj.x;
    return curleft;
  }

  function findPosY(obj)
  {
    var curtop = 0;
    if(obj.offsetParent)
        while(1)
        {
          curtop += obj.offsetTop;
          if(!obj.offsetParent)
            break;
          obj = obj.offsetParent;
        }
    else if(obj.y)
        curtop += obj.y;
    return curtop;
  }
   
</script>

