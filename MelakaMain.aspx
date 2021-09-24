<%@ Page Language="VB" Debug="true" %>
<script language="javascript">
var strSession = '<%=session("login")%>';
if (strSession != "true")
{
    alert("Session Timeout !");
	top.location.href = "Melakalogin.aspx";
}
  
function kk(alamak){
	if (alamak=='min'){
		document.getElementById('theRows').cols="6,*";
		document.getElementById('contents').scrolling="auto"
	}else{
		document.getElementById('theRows').cols="250,*";
		document.getElementById('contents').scrolling="no"
	}
} 

function loadleft()
{
	document.getElementById('contents').src="MelakaLeft.aspx";
}
</script>
<%
  
    Dim strStatus = Request.QueryString("status")
    Dim strMenuURL
    If strStatus = "admin" Then
        strMenuURL = "MelakaAdminMenu.aspx"
    Else
        strMenuURL = "MelakaMenu.aspx"
    End If
    
 
    If Session("login") Is Nothing Then
        Response.Redirect("Melakalogin.aspx")
    End If

%>
<html>
<head><title><%=strStatus%></title></head>
<frameset framespacing="0" border="0" rows="70,*" frameborder="0">
  <frame name="top" scrolling="no" noresize target="contents" src="<%=strMenuURL%>">
  <frameset id="theRows" cols="255,*">
    <frame id="contents" name="contents" target="main" src="MelakaLeft.aspx" scrolling="auto" style="border-width: 1px; border-style: solid; border-color: #AAC6FF;" noresize>
    <frame id="main" name="main" src="MelakaSiteSummary.aspx" scrolling="auto" style="border-width: 1px; border-style: solid; border-color: #AAC6FF">
  </frameset>
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>
</html>