<%@ Page Language="VB" AutoEventWireup="false" CodeFile="sambNewLivelogReport.aspx.vb" Inherits="sambNewLivelogReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<link rel="Stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.24.custom.css"/>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.24.custom.min.js"></script>
<script type="text/javascript" language="javascript">
   

    function mysubmit() {
     
  
        var district = document.getElementById("cboDistrict").value;
        var site = document.getElementById("cboSiteName").value;
        if (district == "Select District") {
            alert("Please select District and Site");
            return false;
        }
        if (site == "Select Site") {
            alert("Please select site");
            return false;
        }
        var bigindatetime = document.getElementById("txtBeginDate").value + " " + document.getElementById("ddlbh").value + ":" + document.getElementById("ddlbm").value;
        var enddatetime = document.getElementById("txtEndDate").value + " " + document.getElementById("ddleh").value + ":" + document.getElementById("ddlem").value;

        var fdate = Date.parse(bigindatetime);
        var sdate = Date.parse(enddatetime);

        var diff = (sdate - fdate) * (1 / (1000 * 60 * 60 * 24));
        var days = parseInt(diff) + 1;
        if (days > 7) {
            return confirm("You selected " + days + " days of data.So it will take more time to execute.\nAre you sure you want to proceed ? ");
        }
        return true;

    }

 
</script>
<body>
    <form id="form1" runat="server">
    <center>
    <div>
    <table>
     <tr>
     <td align="center">
     <table>
       <tr>
        <td class="tableAlign">SAMB LIVE Data Report</td>
       </tr>
       <tr>
        <td class="tableBorder">
          <table style="width: 500px;">
              <tr>
                <td align="left">
                    <b class="FontText">Date</b>
                </td>
                <td>
                    <b class="FontText">:</b>
                </td>
                <td align="left">                              
                    <input type="text" id="txtBeginDate" readonly="readonly" runat="server"  style="width: 70px;" class="datepick"/>                         
                    &nbsp;
                   
              
                </td>
            </tr>
            
            <tr>
            <td align="left">
            <b class="FontText">District</b>
            </td>
            <td>
            <b class="FontText">:</b>
            </td>
            <td align="left">
                <asp:DropDownList ID="cboDistrict" runat="server" CssClass="cboAlign FontText" 
                    AutoPostBack="True">
                </asp:DropDownList>
            </td>
            </tr>
           

      
            <tr>
            <td align="center">
                <br />
                <div>
                 <a href="alertmanagement.aspx?t=r">
                 <input  class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnBack" value="Back"/>
                 </a>
               </div > 
                
            </td>
            <td colspan="2" align="right">
                <br />
              
                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button-blue button-blue:active button-blue:hover buttonAlign" />&nbsp;&nbsp;                                                 
                <a href="javascript:ExcelReport();"><input  class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnExcel" value="Excel"/></a> 
                                                                                              
            </td>
          </tr>
          </table>
        </td>
       </tr>
     </table>
     </td>
     </tr>
    
    <tr>
      <td>
        <br />
        </td>
    </tr>
   <tr align="left">
    <td>
     <table>
     <tr>                  
     <td align="center" colspan="2">                 
       
        <br />
                <asp:GridView ID="GridView1" runat="server" OnRowCreated="GridView1_RowCreated"
             Width="1000px" CssClass="GridText"
                    AutoGenerateColumns="False" HeaderStyle-Font-Size="12px" HeaderStyle-ForeColor="#FFFFFF"
                    HeaderStyle-BackColor="#4D90FE" HeaderStyle-Font-Bold="True" Font-Bold="False"
                    Font-Overline="False" EnableViewState="False" 
             HeaderStyle-Height="22px" HeaderStyle-HorizontalAlign="Center"
                    BorderColor="#F0F0F0" >
                 
                    <PagerStyle Font-Bold="True" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                        VerticalAlign="Middle" BackColor="White" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" />
                    <Columns>
                        <asp:BoundField DataField="No" HeaderText="No">
                            <ItemStyle Width="35px" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SiteNo" HeaderText="Site No" HtmlEncode="False">
                            <ItemStyle Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sitename" HeaderText="Site Name" />
                        <asp:BoundField DataField="Sim No" HeaderText="Sim No" Visible="true">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="Read1(M)" HeaderText="Read(M)" />
                        <asp:BoundField DataField="Status1" HeaderText="Status" HtmlEncode="False" />
                        <asp:BoundField DataField="Time1" HeaderText="Time" HtmlEncode="False"> 
                        <ItemStyle HorizontalAlign="right" Width="150px" />
                          </asp:BoundField>
                         <asp:BoundField DataField="Read2(M)" HeaderText="Read(M)" />
                        <asp:BoundField DataField="Status2" HeaderText="Status" HtmlEncode="False" />
                         <asp:BoundField DataField="Time2" HeaderText="Time" HtmlEncode="False">
                          <ItemStyle HorizontalAlign="right" Width="150px" />
                          </asp:BoundField>
                         <asp:BoundField DataField="Read3(M)" HeaderText="Read(M)" />
                        <asp:BoundField DataField="Status3" HeaderText="Status" HtmlEncode="False" />
                         <asp:BoundField DataField="Time3" HeaderText="Time" HtmlEncode="False" > 
                         <ItemStyle HorizontalAlign="right" Width="150px" />
                          </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="Lavender" />
                </asp:GridView>
         <br />
         </td>
    </tr>
    </table>
    </td>
                    </tr>
   </table>
     <p class="FontText">
     Copyright © 2013 Global Telematics Sdn Bhd. All rights reserved. 
     </p>

    </div>
     </center>
    </form>
     <form id="excelform" method="get" action="ExcelReport.aspx">
        <input type="hidden" id="title" name="title" value="Telemetry Events Report" />
        <input type="hidden" id="plateno" name="plateno" value="" />
    </form>
</body>
</html>
<style type="text/css">
.tableAlign
{
     text-align:center;
     background-color:#4D90FE; 
     font-size:14px; 
     font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif; color:White;
     width: 500px;
}

.tableBorder
{
    width: 420px;
    border: solid 1px #465ae8;
}

.FontText
{
    font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
    color:#5f7afc;
    font-size:13px;
    
}

.GridText
{
    font-family:Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
    color:Black;
    font-size:13px;
    
}

.cboAlign
{
    width:230px;
}

.cboHourMinAlign
{
    width:45px;
}
.buttonAlign
{
    width:65px;
}
.button-blue {
    border: 1px solid #3079ED;
    text-shadow: 0 1px rgba(0, 0, 0, 0.1);
    color:White;
    text-transform: uppercase;
    background-color: #4D90FE;
    background-image: linear-gradient(top,#4d90fe  ,#4787ed  );
        height: 24px;
    }

.button-blue:hover {
    border: 1px solid #2F5BB7  ;
    color: white  ;
    text-shadow: 0 1px rgba(0, 0, 0, 0.3)  ;
    background-color: #357AE8  ;
    background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe  ),to(#357ae8  ));
    background-image: -webkit-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: -moz-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: -ms-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: -o-linear-gradient(top,#4d90fe  ,#357ae8  );
    background-image: linear-gradient(top,#4d90fe  ,#357ae8  );
}

.button-blue:active 
{
    border: 1px solid #992A1B  ;
    background-color: #2F5BB7  ;
    background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe  ),to(#2F5BB7  ));
    background-image: -webkit-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: -moz-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: -ms-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: -o-linear-gradient(top,#4d90fe  ,#2F5BB7  );
    background-image: linear-gradient(top,#4d90fe  ,#2F5BB7  );
    -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3)  ;
    -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3)  ;
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.3)  ;

}

.ui-widget-header 
{ 
  border : 1px solid #465ae8; 
  background: #4D90FE;
  
}

.ui-widget
{
    font-size:14px;   
}

.help 
{
    display: none;
}  
</style>