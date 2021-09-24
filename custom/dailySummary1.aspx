<%@ Page Language="VB" AutoEventWireup="false" CodeFile="dailySummary1.aspx.vb" Inherits="dailySummary1" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Daily Summary</title>
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
<body onload="fun();">
  <form id="form1" runat="server">
   
    <div id="cont" style="visibility:hidden;">
        <img src="..\images\daily_sum_report.jpg" style="left: 152px; position: absolute; top: 8px; width: 400px; height: 40px;" />
        
            <div style="left: 8px; width: 720px; position: absolute; top: 56px; height: 184px" >
                &nbsp; &nbsp; &nbsp;
            <table border="0" style="left:0px; position: absolute; top: 0px;" id="tb1">
            <tr><td style="left:16px"><b>SiteName :</b></td>
            <td  style="width: 350px"><%=StrSiteName %></td>
            <td style="left:16px"><b>SiteID :</b></td>
            <td  style="width: 165px"><%=StrSiteId%></td>
            <td   style="width: 40px; "></td><td style="width: 200px"><b style="color:blue"><%=Text1.Text%></b></td></tr>
            </table>
                <br />
                <br />
                <br />
                <br />
           
            <div   style="position: absolute; top: 40px; background:#ffffff; left: 0px; width: 100%; height: 24px;  font-family: arial; font-size: 12px; color: #FFFFFF; font-weight: bold; border-right: #aab9fd thin solid; border-top: #aab9fd thin solid; border-left: #aab9fd thin solid; border-bottom: #aab9fd thin solid;" >
               <input type="checkbox"  runat="server" name="opt1" id="opt1" onclick="javascript:toggleFilter()"/>
               <label for="opt1" style="color: black" >Display records from&nbsp;&nbsp;:&nbsp;&nbsp;</label>
                <asp:DropDownList ID="dd1" runat="server" Width="80px" Enabled="false">
                </asp:DropDownList>
                <asp:DropDownList ID="dd2" runat="server" Style="left: 248px; position: absolute;
                    top: 0px" Width="48px" Enabled="false">
                </asp:DropDownList>
                <asp:DropDownList ID="dd3" runat="server" Style="left: 304px; position: absolute;
                    top: 0px" Width="48px" Enabled="false">
                </asp:DropDownList>
                 <asp:Label ID="Label1" runat="server" Height="16px" Style="left: 392px; position: absolute;
                    top: 7px; color: black;" Text=" To :" Width="40px"></asp:Label>
                <asp:DropDownList ID="dd4" runat="server" Style="left: 456px; position: absolute;
                    top: 0px" Width="72px" Enabled="false">
                </asp:DropDownList>
                <asp:DropDownList ID="dd5" runat="server" Style="left: 536px; position: absolute;
                    top: 0px" Width="48px" Enabled="false">
                </asp:DropDownList>
                &nbsp;
                <asp:DropDownList ID="dd6" runat="server" Style="left: 592px; position: absolute;
                    top: 0px" Width="48px" Enabled="false">
                </asp:DropDownList>
                 <asp:Button ID="Button1" runat="server" Style="left: 673px; position: absolute; top: 0px"
                    Text="View" Width="46px"  />
               </div>
            <br />
            
            
            <asp:GridView ID="GridView1" CellSpacing="1"  BackColor="#aab9fd" runat="server" ForeColor="Black" AutoGenerateColumns="False" 
                    Width="722px" DataMember="DefaultView"  EnableTheming="True" CellPadding="1" GridLines="None">
                    <HeaderStyle BackColor="White" Font-Names="Tahoma" Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <RowStyle BackColor="White"  BorderWidth="1px" Font-Names="Verdana" Font-Size="10pt" HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"  >
                            <ItemStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Min Flow Rate (m3 /h)" HeaderText="Min Flow Rate (m3 /h)" SortExpression="Min Flow Rate (m3 /h)" />
                        <asp:BoundField DataField="Max Flow Rate (m3 /h)" HeaderText="Max Flow Rate (m3 /h)" SortExpression="Max Flow Rate (m3 /h)"  />
                        <asp:BoundField DataField="Total Inflow (m3)" HeaderText="Totalizer (m3)" SortExpression="Total Inflow (m3)"  />
                        <%--<asp:BoundField DataField="Min pressure(bar)" HeaderText="Min pressure(bar)" SortExpression="Min pressure(bar)"  />
                        <asp:BoundField DataField="Max pressure(bar)" HeaderText="Max pressure(bar)" SortExpression="Max pressure(bar)"  />--%>
                         <asp:BoundField DataField="Trending" HtmlEncode="False"  HeaderText="Trending"  >
                             <HeaderStyle Width="130px" />
                             <ItemStyle Width="130px" />
                         </asp:BoundField>
                    </Columns>
                <FooterStyle Wrap="True" />
                <PagerStyle BorderStyle="None" />
                    
                </asp:GridView>
                     
                <asp:Image Id="imgdata" runat="server" ImageUrl="~/images/NoDataWide.jpg" Visible="False" Height="120px" Width="368px" />
              <div><p><asp:Label ID="Label2" runat="server" 
                Text="* Recent 15 days Report" Width="160px"></asp:Label><p align="center"><a href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p>    </p></div>
              
              
                </div>
                 
    
            </div>
            
            <div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="../images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
            </div>
      <asp:Label ID="Text1" runat="server" Style="left: 8px; position: absolute; top: 424px"
          Visible="False" Width="208px"></asp:Label>
         
    </form>
    
</body>

</html>
<script type="text/javascript">
 function toggleFilter()
 {
 
  if(document.getElementById("opt1").checked)
   {
   document.getElementById("dd1").disabled=false;
   document.getElementById("dd2").disabled=false;
   document.getElementById("dd3").disabled=false;
   document.getElementById("dd4").disabled=false;
   document.getElementById("dd5").disabled=false;
   document.getElementById("dd6").disabled=false;
   }
   else
   {
   document.getElementById("dd1").disabled=true;
   document.getElementById("dd2").disabled=true;
   document.getElementById("dd3").disabled=true;
   document.getElementById("dd4").disabled=true;
   document.getElementById("dd5").disabled=true;
   document.getElementById("dd6").disabled=true;
   }
 }
</script>
 



