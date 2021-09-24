<%@ Page Language="C#" AutoEventWireup="true" CodeFile="overflowreport.aspx.cs" Inherits="ReportManagement_overflowreport"
    EnableEventValidation="false" %>

<html>
<head runat="server">
    <title>Event Report</title>
    <style type="text/css">
        .tableAlign
        {
            text-align: center;
            background-color: #4D90FE;
            font-size: 14px;
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: White;
            width: 500px;
        }
        
        .FontText
        {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: #5f7afc;
            font-size: 13px;
        }
        .tableBorder
        {
            border: solid 1px #465ae8;
        }
        #ui-datepicker-div
        {
            font-size: 12.5px;
        }
        
        .dropdownlist
        {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            color: #5f7afc;
            font-size: 13px;
            width: 230px;
        }
        
        .button-blue
        {
            width: 65px;
            border: 1px solid #3079ED;
            text-shadow: 0 1px rgba(0, 0, 0, 0.1);
            color: White;
            text-transform: uppercase;
            background-color: #4D90FE;
            background-image: linear-gradient(top,#4d90fe  ,#4787ed  );
            height: 24px;
            margin-right: 10px;
        }
        
        .button-blue:hover
        {
            border: 1px solid #2F5BB7;
            color: white;
            text-shadow: 0 1px rgba(0, 0, 0, 0.3);
            background-color: #357AE8;
            background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe  ),to(#357ae8  ));
            background-image: -webkit-linear-gradient(top,#4d90fe  ,#357ae8  );
            background-image: -moz-linear-gradient(top,#4d90fe  ,#357ae8  );
            background-image: -ms-linear-gradient(top,#4d90fe  ,#357ae8  );
            background-image: -o-linear-gradient(top,#4d90fe  ,#357ae8  );
            background-image: linear-gradient(top,#4d90fe  ,#357ae8  );
        }
        
        .button-blue:active
        {
            border: 1px solid #992A1B;
            background-color: #2F5BB7;
            background-image: -webkit-gradient(linear,left top,left bottom,from(#4d90fe  ),to(#2F5BB7  ));
            background-image: -webkit-linear-gradient(top,#4d90fe  ,#2F5BB7  );
            background-image: -moz-linear-gradient(top,#4d90fe  ,#2F5BB7  );
            background-image: -ms-linear-gradient(top,#4d90fe  ,#2F5BB7  );
            background-image: -o-linear-gradient(top,#4d90fe  ,#2F5BB7  );
            background-image: linear-gradient(top,#4d90fe  ,#2F5BB7  );
            -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
            -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
        }
        #lblError
        {
            font-size: 10pt;
            font-family: Verdana;
            font-weight: bold;
            color: Red;
        }
        .text
        {
            font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
            font-size: 13px;
        }
        #gvReport td
        {
            padding: 5px 5px 5px 5px;
        }
      
    </style>
     <style type ="text/css" >
    .c1 {
    font-family: Verdana;
    font-size: 22px;
    color: #38678B;
    font-weight: bold;
}
    </style>
    <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <link href="../css/smoothness/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {

            $("#txtBeginDate").datepicker({
                showOn: "button",
                buttonImage: "../images/calendar.jpg",
                buttonImageOnly: true,
                //changeMonth: true,
                //changeYear: true,
                numberOfMonths: 2,
                showCurrentAtPos: 1,
                dateFormat: "dd/mm/yy"
            });

            $("#txtEndDate").datepicker({
                showOn: "button",
                buttonImage: "../images/calendar.jpg",
                buttonImageOnly: true,
                //changeMonth: true,
                //changeYear: true,
                numberOfMonths: 2,
                showCurrentAtPos: 1,
                dateFormat: "dd/mm/yy"
            });

        });

        function ExcelReport() {
                document.getElementById("fd").value = $('#txtBeginDate').val() + " 00:00:00";
                document.getElementById("td").value = $('#txtEndDate').val() + " 23:59:59";
                var sitename = $("#ddlSiteName option:selected").text();
                var dist = $("#ddlDistrict option:selected").text();
                var type = $("#ddlType option:selected").text();
                document.getElementById("District").value = dist;
                document.getElementById("type").value = type;
                document.getElementById("sitename").value = sitename;
                var excelformobj = document.getElementById("excelform");
                excelformobj.submit();
            
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center>
            <div style="margin: 25px 25px 25px 25px" class="c1">
              Reservoir Overflow Report
            </div>
            <div style="margin: 10px 10px 10px 10px">
                <div style="width: 500px">
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </div>
                <table class="tableBorder" style="width: 500px;">
                    <tr>
                        <td colspan="3" class="tableAlign">
                            Reservoir Overflow Report
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b class="FontText">Begin Date</b>
                        </td>
                        <td>
                            <b class="FontText">:</b>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtBeginDate" size="12" class="inputStyle" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="beginHour" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="beginMinute" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b class="FontText">End Date</b>
                        </td>
                        <td>
                            <b class="FontText">:</b>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtEndDate" size="12" class="inputStyle" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="endHour" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="endMinute" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b class="FontText">Site District</b>
                        </td>
                        <td>
                            <b class="FontText">:</b>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDistrict" OnSelectedIndexChanged="Fill_ddlType" AutoPostBack="true"
                                runat="server" CssClass="dropdownlist">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b class="FontText">Site Type</b>
                        </td>
                        <td>
                            <b class="FontText">:</b>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType" OnSelectedIndexChanged="Fill_ddlSiteName" AutoPostBack="true"
                                runat="server" CssClass="dropdownlist">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b class="FontText">Site Name</b>
                        </td>
                        <td>
                            <b class="FontText">:</b>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSiteName" runat="server" CssClass="dropdownlist">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="margin-top: 25px">
                                <a href="../ReportManagement.aspx">
                                    <input class="button-blue button-blue:active button-blue:hover " type="button" name="btnBack"
                                        value="Back" />
                                </a>
                            </div>
                        </td>
                        <td>
                        </td>
                        <td>
                            <div style="margin-top: 25px; text-align: right">
                                <asp:Button ID="btnSubmit" Text="Submit" CssClass="button-blue " runat="server" OnClick="btnSubmit_Click" />
                                
                                   <a id="A1"   class="button-blue" style="cursor:pointer;"  onclick="ExcelReport()"   >EXCEL</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin: 10px 10px 10px 10px; width:1000px">
                <asp:GridView ID="gvReport" CssClass="text" AutoGenerateColumns="false" HeaderStyle-Font-Bold="True"
                    Width="100%" BorderColor="White" BorderStyle="Solid" HeaderStyle-Font-Size="12px"
                    HeaderStyle-ForeColor="#FFFFFF" HeaderStyle-BackColor="#465AE8" HeaderStyle-Height="22px"
                    HeaderStyle-HorizontalAlign="Center" runat="server" ShowFooter ="true" FooterStyle-Font-Size="12px"
                    FooterStyle-ForeColor="#FFFFFF" FooterStyle-BackColor="#465AE8" FooterStyle-Height="22px"
                    FooterStyle-HorizontalAlign="Center">
                    <Columns>
                        <asp:BoundField DataField="sno" HeaderText="S No" HtmlEncode="False">
                            <ItemStyle HorizontalAlign="left" Width="4%" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="sitename" HeaderText="SiteName">
                            <ItemStyle HorizontalAlign="left" Width="36%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Fromtime" HeaderText="From Time">
                            <ItemStyle HorizontalAlign="Center" Width="36%" />
                        </asp:BoundField>
                         <asp:BoundField DataField="totime" HeaderText="To Time">
                            <ItemStyle HorizontalAlign="Center" Width="36%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="duration" HeaderText="Duration">
                            <ItemStyle HorizontalAlign="left" Width="12%" />

                        </asp:BoundField>
                         <asp:BoundField DataField="elec" HeaderText="Electricity(KW)" >
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                         <asp:BoundField DataField="electariff" HeaderText="Electricity Tariff" >
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                            <asp:BoundField DataField="elewaste" HeaderText="Electricity Wastage" >
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                           <asp:BoundField DataField="flowarte" HeaderText="Inlet Flowrate" >
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                           <asp:BoundField DataField="flowtarif" HeaderText="Inlet Flowrate Tariff" >
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                            <asp:BoundField DataField="waterwaste" HeaderText="Water Wastage">
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                            <asp:BoundField DataField="totalwaste" HeaderText="Total Wastage">
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#E7E8F8" />
                </asp:GridView>
            </div>
        </center>
    </div>
    </form>
    <form id="excelform" method="get" action="ExcelDownload.aspx">
    <input type="hidden" id="title" name="title" runat ="server" value="Reservoir Overflow Report" />
    <input type="hidden" id="District" name="District" value="" />
    <input type="hidden" id="type" name="type" value=" "    />
    <input type="hidden" id="sitename" name="sitename" value=" "    />
    <input type="hidden" id="fd" name="fd" value=" "   />
     <input type="hidden" id="td" name="td" value=" "   />
    </form>
</body>
</html>
