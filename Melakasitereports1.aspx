<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Melakasitereports1.aspx.vb" Inherits="Melakasite_reports1" %>

<%
    Dim dis = Request.QueryString("root")
Dim lable1 = Request.QueryString("lab")
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Site Reports</title>

</head>
<body>
    <form id="form1" runat="server">
    <div >
    <div style="left:192px; top: 16px; position:absolute; ">
    <a href="Melakareportssummarymenu.aspx" target="contents"  >Back</a></div>
    <table border="0"><tr><td align="center" style="width: 180px">
    <font face="Verdana" size="2"><b style="left: 0px; width: 192px; position: absolute; top: 16px" > &nbsp; &nbsp;<%=Request("lab") %>  Report Menu<br />
    </b><br /><u>Select District</u>
    </font></td></tr>
    </table>
    <br />
    <br />
   
   
        <asp:TreeView ID="TreeView1" runat="server"  EnableTheming="True" ExpandDepth="0" Width="216px" style="color: #ffffff;  left: 8px; position: absolute; top: 56px; font-size: 12px; font-family: Verdana;" ImageSet="Arrows" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" BackColor="White">
            <ParentNodeStyle Font-Bold="True" 
                Font-Size="10pt" Font-Names="Verdana" ForeColor="Black" NodeSpacing="1px" VerticalPadding="1px" />
            <SelectedNodeStyle Font-Bold="True" Font-Underline="False" HorizontalPadding="0px" VerticalPadding="0px" Font-Strikeout="False" BackColor="White" />
            <HoverNodeStyle  ForeColor="#5555DD" />
            <LeafNodeStyle Font-Bold="True" Font-Size="9pt" ForeColor="#003366" />
            <NodeStyle Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" ForeColor="Black"
                HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
        </asp:TreeView>
        
      </div>
   
     </form>
    
</body>
</html>
