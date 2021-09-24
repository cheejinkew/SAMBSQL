<%@ Page Language="VB" Debug="true" %>
<script language="javascript">

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

  function kk(alamak){
	if (alamak=='min')
	{
	document.getElementById('theRows').cols="6,*";
	document.getElementById('contents').scrolling="auto"
	}else{
	document.getElementById('theRows').cols="250,*";
	document.getElementById('contents').scrolling="no"
	}
  }
</script>
<%
Response.Cookies("a1").Expires = DateTime.Now.AddYears(-30)
Response.Cookies("a").Expires = DateTime.Now.AddYears(-30)
  
  dim strStatus = request.querystring("status")
  dim strMenuURL
  
  if strStatus = "admin" then
     strMenuURL = "AdminMenu_demo.aspx"
  else
     strMenuURL = "Menu_demo.aspx"
  end if

  if session("login") is nothing then
    response.redirect ("login.aspx")
  end if

%>
<html>

<head>
<title><%=strStatus%></title>
</head>

<frameset framespacing="1" border="0" rows="70,*" frameborder="0">
  <frame name="top" scrolling="no" noresize target="contents" src="<%=strMenuURL%>">
  <frameset id="theRows" cols="250,*">
    <frame id="contents" name="contents" target="main" src="left.aspx" scrolling="auto" style="border-width: 1px; border-style: solid; border-color: #AAC6FF" noresize>
    <frame id="main" name="main"  target="main"  src="DisplayMap.aspx?command=map" scrolling="auto" style="border-width: 1px; border-style: solid; border-color: #AAC6FF"> 

  <!-- <frame id="main" name="Gis" target="main" src="displaymap.aspx" scrolling="auto" style="border-width: 1px; border-style: solid; border-color: #AAC6FF">-->
  </frameset>
  <noframes>
  <body>

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>

</html>

