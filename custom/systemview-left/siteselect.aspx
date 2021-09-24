<%@ Page Language="VB" AutoEventWireup="false" CodeFile="siteselect.aspx.vb" Inherits="siteselect" %>
<%
    Dim dis = Request.QueryString("root")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server"><title>System View List</title>
<style>
body{
	background-color:transparent;
	margin: 0;
	padding: 0;
	SCROLLBAR-FACE-COLOR: #ffffff;
	SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
	SCROLLBAR-SHADOW-COLOR: #CBD6E4;
	SCROLLBAR-3DLIGHT-COLOR: #CBD6E4;
	SCROLLBAR-ARROW-COLOR: #CBD6E4;
	SCROLLBAR-TRACK-COLOR: #ffffff;
	SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
	}
a#_switch {text-decoration: none;} 
a#_switch:hover { text-decoration: underline;}
#_tree{float:top; margin: 1px 2px 0px 2px; width: 192px; top: 40px;font:bold 13px verdana;}
#_title{float:top; margin: 2px 2px 0px 2px; font:bold 14px verdana; color:RoyalBlue}
#_switch{float:top; margin: 1px 2px 0px 2px; font:bold 9px verdana; color:Gray}
#_hijab{position: absolute; left: 0px; width: 99%; top: 0px; height:99%; z-index:5; background-color:white; font:bold 13px verdana; color:red; margin: 2px 2px 2px 2px}
div#txtHint
  {
  border-width:1px;
  overflow:hidden;
  font-family: Verdana; 
  font-size: 8pt;
  font-weight: bold;
  color: red;
  }
</style>
</head>
<body>
<div id="_hijab">loading...</div>
<div id="wraps">
<a href="../../left.aspx" id="_switch">Switch to Normal View</a>
<div id="_title">System View</div>
<div id="_tree">
<form id="form1" runat="server">
	<asp:TreeView ID="TreeView1" runat="server"  EnableTheming="True" ExpandDepth="0" Width="216px" style="color: #c0c0c0; font-size: 12px; font-family: Verdana;" ImageSet="Msdn" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" BackColor="transparent">
		<ParentNodeStyle Font-Bold="True" Font-Size="10pt" Font-Names="Verdana" ForeColor="SteelBlue" NodeSpacing="1px" VerticalPadding="1px" />
		<SelectedNodeStyle Font-Bold="True" Font-Underline="False" HorizontalPadding="0px" VerticalPadding="0px" Font-Strikeout="False" BackColor="Blue" />
		<HoverNodeStyle ForeColor="MediumBlue" />
		<LeafNodeStyle Font-Bold="True" Font-Size="9pt" ForeColor="DodgerBlue" />
		<NodeStyle Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" ForeColor="SteelBlue" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
	</asp:TreeView>
</form>
</div>
<div style="float:top;margin-top:2px;" id="txtHint">Alerts :</div> 
<div style="float:top;margin-right: 0px;overflow: auto; overflow-x: hidden;">
	<iframe id="alertframe" width="220" height=330 marginheight="0" marginwidth="0"  scrolling=auto style="left:0;" frameborder="0" ></iframe>
</div>
</div>
</body>
</html>
<script>
function pageloaded(){
	document.getElementById('_hijab').style.visibility='hidden';
	alertframe5();
}

function alertframe5()
{
   applying();
   set1();
}

function set1()
{
	var refreshInterval =2;
	refreshInterval = refreshInterval * 60000;
	setTimeout('alertframe5()', refreshInterval);
}

function applying()
{
     document.getElementById('alertframe').src="../../alert1.aspx"
}

window.onload = pageloaded;
</script>