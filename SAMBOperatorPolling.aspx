<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SAMBOperatorPolling.aspx.vb"
    Inherits="operatorPolling" aspcompat=true %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Polling Page</title>
    <style type="text/css">
     .body{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px; background-color:Transparent;}
 .button  {cursor: pointer;} 
.FormDropdown{font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color:#5F7AFC;width: 180px;border: 1px solid #CBD6E4;
            margin-bottom: 0px;
        }
    </style>
</head>
<body class="body" style="margin: 30px;">
    <center>
        <form id="form1" runat="server">
            <div align="center" style="color: #336699; font-size: 15px; font-weight: bold;">
                SAMB Site Polling(RESERVOIR)
            </div>
            <br />
            <br />
            <table width="800px" height="400px" border="0" cellpadding="0" cellspacing="0">
       
                <tr>
                    <td align="left" colspan="2" style="color: Blue; font-weight: bold; width: 800px;
                        height: 30px; background-color: Silver">
                         &nbsp;&nbsp;Select State&nbsp;&nbsp;&nbsp;&nbsp; :
                        <asp:DropDownList ID="ddlState" runat="server" CssClass="FormDropdown" AutoPostBack="true">
                        <asp:ListItem Selected="True" Value="Melaka">Melaka</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        &nbsp;&nbsp;Select District&nbsp;&nbsp;:
                        <asp:DropDownList ID="ddDistrict" runat="server" CssClass="FormDropdown" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 430px; vertical-align: top; border: solid 1px gray;">
                        <div style="overflow: auto; width: 430px; height: 400px">
                            <br />
                            <asp:CheckBoxList ID="chkSite" runat="server" ForeColor="#004040">
                            </asp:CheckBoxList></div>
                    </td>
                    <td align="Left" style="width: 370px; vertical-align: top; background-color: Silver">
                        &nbsp;&nbsp;<u style="font-weight: bold; color: Blue;">Request Log Data</u>
                        <table width="370px">
                            <tr>
                                <td align="left" width="250px" colspan="2">
                                   Center No:<asp:DropDownList ID="ddCenter" runat="server" CssClass="FormDropdown"
                                        Width="150px">
                                        <asp:ListItem Value="+60162070626">+60162070626</asp:ListItem>
                                        <asp:ListItem Value="+60196238231">+60196238231</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RadioButtonList ID="rdOption" runat="server">
                                        <asp:ListItem Value="0">Yesterday 4 pm to 11:59:59 pm</asp:ListItem>
                                        <asp:ListItem Value="1">Yesterday 8 am - 4 pm</asp:ListItem>
                                        <asp:ListItem Value="2">Yesterday 12 am - 8 pm</asp:ListItem>
                                        <asp:ListItem Value="3">Today 4 pm - 11:59:59 pm</asp:ListItem>
                                        <asp:ListItem Value="4">Today 8 am - 4 pm</asp:ListItem>
                                        <asp:ListItem Value="5">Today 12 am - 8 am</asp:ListItem>
                                        <asp:ListItem Value="6" Selected="true">Poll current data</asp:ListItem>
                                        <asp:ListItem Value="7">Set Center Number</asp:ListItem>
                                        <asp:ListItem Value="8">Set Current Date Time</asp:ListItem>
                                    </asp:RadioButtonList><br />
                                </td>
                               
                            </tr>
                             <tr>
                                <td align="left" width="120px" style="vertical-align: top;">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Set/Poll" ToolTip="Polling" 
                                        CssClass="button" Width="141px" Height="33px" /><br />
                                    <br />                         
                                </td>        
                                <td>                   
                                    <asp:Button ID="btnReset" runat="server" Text="Reset WebPage" 
                                        ToolTip="Reset WebPage" CssClass="button" Width="141px" Height="33px" /><br />
                                    <br />  
                                </td>                                  
                            </tr>
                            <tr>
                            <td colspan="2">
                              Status: 
                                <asp:Label ID="lblMessage" runat="server" Font-Bold="True" Font-Size="9pt" 
                                    ForeColor="Green" BorderStyle="Solid" Text="Idle" BorderColor="Black" ></asp:Label>
                            </td>      
                           </tr>
                        </table>
                    </td>
                </tr>
               
            </table>=
            <br />
            <div align="left" style="width: 800px; color: Brown; font-weight: bold; vertical-align: text-top;">
                <input type="checkbox" id="chkh" runat="server" title="Select/Deselect All" onclick="javascript:CheckAllDataGridCheckBoxes(this);" />
                Select/Deselect All&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font>Total
                    :&nbsp;</font><label runat="server" id="lblTotal" style="color: Blue;">0</label></div>
        </form>
    </center>
</body>
</html>

<script type="text/javascript">

 function CheckAllDataGridCheckBoxes(checkVal)
 {
	    document.getElementById("lblTotal").innerHTML="0";
	    for(i = 0; i < document.forms[0].elements.length-1; i++) 
        {
            elm = document.forms[0].elements[i];
            if (elm.type == 'checkbox') 
            {
                document.forms[0].elements[i].checked =checkVal.checked;
                chekLength(document.forms[0].elements[i]);
                
            }
        }
 }
 
 
 
 function chekLength(spanChk)
 {
   var IsChecked = spanChk.checked;
   if (IsChecked) 
   {
     document.getElementById("lblTotal").innerHTML= parseInt(document.getElementById("lblTotal").innerHTML) + 1;       
   }   
 }
 
 function CheckBoxListSelect(cbControl)
 {   
        var chkBoxList = document.getElementById(cbControl);
        var chkBoxCount= chkBoxList.getElementsByTagName("input");
        var n=0;
        for(var i=0;i<chkBoxCount.length;i++)
        { 
         if (chkBoxCount[i].checked==true)
         {           
          n= parseInt(n) + 1;  
         }                  
        }
       
       if(parseInt(n)== chkBoxCount.length)
       {
         document.getElementById("chkh").checked=true;
       }
       else
       {
         document.getElementById("chkh").checked=false;
       }
       document.getElementById("lblTotal").innerHTML=n;
        return false; 
 }
  
 function clearList()
 {
   document.getElementById("lblTotal").innerHTML="0";
   document.getElementById("chkh").checked=false;
 } 
</script>

