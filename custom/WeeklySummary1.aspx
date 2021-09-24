<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WeeklySummary1.aspx.vb" Inherits="WeeklySummary1" %>

<%
    Dim lab = Request.QueryString("lab")
    Dim dis = Request.QueryString("root")
  
    StrSitename = Request.QueryString("sitename")
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Weekly Summary</title>
    <script type="text/javascript" language="javascript">
   function fun()
   {
     window.setInterval("fun1()",2000);
   }
   function fun1()
   {
   document.getElementById("Map").innerHTML="";
    document.getElementById("cont").style.visibility="visible";
   }
   </script>
</head>
<body onload="fun()">
    <form id="form1" runat="server">
    
    <div id="cont" style="visibility:hidden;">
    
    <img src="../images\wekkly_sum_report.jpg" style="left: 136px; position: absolute; top: 16px; width: 440px; height: 40px;" />
    
        <div style="left: 8px; width: 720px; position: absolute; top: 72px; height: 192px">
            &nbsp; &nbsp; &nbsp;
            <table border="0" style="left:8px; position: absolute; top: 16px;" id="tb1">
            <tr><td style="left:16px"><b>SiteName :</b></td>
            <td  style="width: 350px"><%=StrSiteName %></td>
            <td style="left:16px"><b>SiteID :</b></td>
            <td  style="width: 165px"><%=StrSiteId%></td>
            </tr>
            </table><br /><br /><br />
            
            <asp:GridView ID="GridView1" BackColor="#aab9fd" EnableViewState="False"   runat="server" ForeColor="Black" AutoGenerateColumns=False 
                    Width="728px" DataMember="DefaultView" CellSpacing="1" GridLines="None" >
                    <RowStyle Font-Names="Verdana" Font-Size="10pt" BackColor="white" HorizontalAlign="Center" />
                       
                    <PagerStyle VerticalAlign="Middle" />
                    <HeaderStyle Font-Names="Tahoma" BackColor="white" Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"  >
                            <ItemStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Min Flow Rate (m3 /h)" HeaderText="Min Flow Rate (m3 /h)" SortExpression="Min Flow Rate (m3 /h)" />
                        <asp:BoundField DataField="Max Flow Rate (m3 /h)" HeaderText="Max Flow Rate (m3 /h)" SortExpression="Max Flow Rate (m3 /h)"  />
                        <asp:BoundField DataField="Total Inflow (m3)" HeaderText="Totalizer  (m3)" SortExpression="Total Inflow (m3)"  />
                        <%--<asp:BoundField DataField="Min pressure(bar)" HeaderText="Min pressure(bar)" SortExpression="Min pressure(bar)"  />
                        <asp:BoundField DataField="Max pressure(bar)" HeaderText="Max pressure(bar)" SortExpression="Max pressure(bar)"  />--%>
                         <asp:BoundField DataField="Trending" HtmlEncode="False"  HeaderText="Trending"  >
                             <HeaderStyle Width="130px" />
                             <ItemStyle Width="130px" />
                         </asp:BoundField>
                    </Columns>
                    
                </asp:GridView>
            
            <asp:Image Id="imgdata" runat="server" ImageUrl="~/images/NoDataWide.jpg" Visible="False" Height="120px" Width="300px" />
           <div><p><asp:Label ID="Label2" runat="server" 
                Text="* Recent 10 Weeks Report" Width="200px"></asp:Label></p><p align="center"><a href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p></div>
        </div>
        
        </div> 
       
    <div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="../images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
            </div>
    </form>
</body>
</html>
