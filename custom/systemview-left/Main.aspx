<%@ Page Language="VB" Debug="true" %>
<script language="javascript">
/*
  var strSession = '<%=session("login")%>';  
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }
*/
  function kk(alamak){
	if (alamak=='min'){
	document.getElementById('theRows').cols="6,*";
	document.getElementById('contents').scrolling="auto"
	}else{
	document.getElementById('theRows').cols="250,*";
	document.getElementById('contents').scrolling="no"
	}
  }
</script>
<%
  dim sqlRs,objConn,strConn,i,strControlDistrict,strDistrict

  strConn = ConfigurationSettings.AppSettings("DSNPG") 
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()
  
  dim arryControlDistrict = split(request.cookies("Telemetry")("ControlDistrict"), ",")
  if arryControlDistrict.length() > 1 then
     for i = 0 to (arryControlDistrict.length() - 1)
       if i <> (arryControlDistrict.length() - 1)
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "', "
       else
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "'"
       end if
     next i
  else
     strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
  end if
  
  dim strStatus = request.querystring("status")
  dim strMenuURL  

'  if session("login") is nothing then
'    response.redirect ("login.aspx")
'  end if

%>
<html>
<head><title><%=strStatus%></title>
<script src="http://www.g1.com.my/extension/script/active/lib/aw.js"></script>
<link href="http://www.g1.com.my/extension/script/active/styles/aqua/aw.css" rel="stylesheet"></link>
<script type="text/javascript" src="js/codes.js"></script>
<script type="text/javascript" src="js/chrome.js"></script>
<script type="text/javascript" src="js/alert.js"></script>
<link rel=StyleSheet href="main.css" title="main_style">
</head>
<body onresize="resizing_trends('trends');reposition_obj('xloading');" scroll="no">
	<div class="chromestyle" id="chromemenu">
	<ul>
	<li><a href="Summary.aspx" onclick="submission('summary.aspx');return false;">Home</a></li>
<%if strStatus = "admin" then%>	
	<li><a href="#" rel="dropmenu1">Admin Management</a></li>
<%end if%>
	<li><a href="#" rel="dropmenu2">GIS</a></li>
	<li><a href="Alarm.aspx" onclick="submission('Alarm.aspx');return false;">Alarm Notification</a></li>
	<li><a href="GraphicalAnalysis.aspx" rel="dropmenu3">Graphical Analysis</a></li>
	<li><a href="ReportsMenu.aspx" onclick="submission('Report/Reports.aspx');return false;">Report</a></li>
	<li><a href="Logout.aspx"  target="_top">Logout</a></li>
	</ul>
	</div>
	
<!--1st drop down menu -->                                                   
<div id="dropmenu1" class="dropmenudiv">
<a href="admin" onclick="submission('Admin/User.aspx');return false;">User Management</a>
<a href="admin" onclick="submission('Admin/Unit.aspx');return false;">Unit Management</a>
<a href="admin" onclick="submission('Admin/Site.aspx');return false;">Site Management</a>
<a href="admin" onclick="submission('Admin/Equipment.aspx');return false;">Equipment Management</a>
<a href="admin" onclick="submission('Admin/UnitConfig.aspx');return false;">Unit Configuration</a>
<a href="admin" onclick="submission('Admin/Rule.aspx');return false;">Rule Management</a>
<a href="admin" onclick="submission('Admin/Dispatch.aspx');return false;">Dispatch Management</a>
</div>
<!--2nd drop down menu -->                                                
<div id="dropmenu2" class="dropmenudiv" style="width: 150px;">
<%
    objConn = new ADODB.Connection()
    objConn.open(strConn)    
    if arryControlDistrict(0) <> "ALL" then
        sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ")",objConn)
    else
        sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table",objConn)
    end if
    do while not sqlRs.EOF
        strDistrict = sqlRs("sitedistrict").value
%>
<a href="ss" onclick="displaysistem('<%=strDistrict%>');return false;"><%=strDistrict%></a>
<%

        sqlRs.movenext
    Loop
    
    sqlRs.close()
    objConn.close()
    objConn = nothing
    
%>
</div>
<!--3nd drop down menu -->                                                
<div id="dropmenu3" class="dropmenudiv" style="width: 150px;">
<a href="Analysis" onclick="submission('Analysis/TrendSelection.aspx');return false;">Multiple Trends</a>
<a href="Analysis" onclick="submission('Analysis/WTAnalysis.aspx');return false;">Water Level Trending</a>
<a href="Analysis" onclick="submission('Analysis/AMBSCompareSelect.aspx');return false;">AMBS Trending</a>
</div>

<script type="text/javascript">

cssdropdown.startchrome("chromemenu")

</script>
	<div class="adisplay_island">
		<div id="adisplay_title" class="adisplay_title">ALERT:</div>
		<div id="adisplay_lines" class="adisplay_lines"></div>
		<!-- DUNGUN - 9016 - TAMAN TANJUNG MINYAK UTAMA : H -->
	</div>
	<div id="side_sdw" class="side_sdw">&nbsp;</div>
	<div id="side_island" class="side_island">		
		<div id="side_c" class="side_c">&nbsp;Site Selection</div>
		<div id="side_title" class="side_title">Site Selection</div>		
		<iframe allowtransparency="true" id="side_content" class="side_content" marginwidth="0" marginheight="0" frameborder="0">site_select</iframe>
		<div id="side_list" class="side_list"></div>
		<div id="side_search" class="side_search">dd</div>		
	</div>
	<div id="xsystem_display" class="drag">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent2">
	<table>
	<tr><th><span id="xsystem_display_title"></span></th></tr>
	<tr><td><span id="xsystem_display_content"></span></td></tr>
	</table>
	</div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>
	<div id="xloading">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><img style="position:absolute;top:5px;left:5px;" border="0" src="images/loading.gif"><span id="loading_text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Creating report...</span></div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>
	<div id="xlogo">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><img border="0" src="images/logo2.gif"></div>	
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>
	<div id="copyright">Copyright © 2007 Gussmann Technologies Sdn Bhd. All rights reserved.</div>
	<div id="beta_logo"></div>
<div id="trends"></div>
</body>
</html>
<script language="javascript">
var menu_hide = -333;
var menu_show = 0;

addEvent( document.getElementById('side_island'), 'mouseover', function(){toggle_this('show')});
addEvent( document.getElementById('side_island'), 'mouseout', function(){toggle_this('noshow')});
addEvent( document.getElementById('side_c'), 'mouseover', function(){ this.className='side_c_o'; });
addEvent( document.getElementById('side_c'), 'mouseout', function(){ this.className='side_c'; });
addEvent( document.getElementById('side_c'), 'click', function(){toggle_this('noshow')});

resizing_trends('trends');
get_siteselection();
show_alert();

	var input = new AW.UI.Input;
	input.setId("side_search");	
	input.setPosition(7, 473);
	input.setSize(324, 20);
	input.setControlText("search by sitename or siteid");
	input.setControlImage("search");
	input.setStyle("color", "red");
	input.setEvent("onkeydown", "hotKeys(event);");	
	input.refresh();	
	
/*    input.onControlTextChanging = function(text){
        if (text.match(/[^0-9.+-]/)){ 
            return "error"; // prevent non-digits 	
		}
    } */
	
function hotKeys (event) {
	event = (event) ? event : ((window.event) ? event : null);
	var charCode = (event.charCode) ? event.charCode : ((event.which) ? event.which : event.keyCode);
	var stext = document.getElementById("side_search-box-text").getAttribute("aw-value");
	if (charCode==13){
		//alert(stext);
		show_search(stext);
	}
}
</script>