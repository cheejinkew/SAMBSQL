<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
  dim objConn
  dim strConn
  dim sqlRs
  
  dim strLogin 
  dim strUserName
  dim strPassword
  dim strError
  dim strSetFocusOn
  dim strStatus
  
  session("Lon")= 0
  session("Lat")= 0
  session("GetCoord") = 0
  session("login") = ""

  strConn = ConfigurationSettings.AppSettings("DSNPG") 
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

   
  strLogin = UCase(Request.form("txtUsername"))
  strPassword = UCase(Request.form("txtPassword"))
  strError = request.form("txtError")
  strSetFocusOn = request.form("txtSetFocus")
  strStatus = request.form("txtStatus")
  
  if strError = "" then
    strError = "&nbsp;"
  end if

  if strLogin <> "" and strPassword <> "" then
      objConn.open(strConn)
      sqlRs.open ("select pwd, role, userid, control_district from telemetry_user_table where username ='" & strLogin & "'", objConn)
     
      if Not sqlRs.EOF then
        if sqlRs("pwd").value  = strPassword then
          response.cookies("Telemetry")("UserID") = sqlRs("userid").value
          response.cookies("Telemetry")("UserName") = strLogin
          response.cookies("Telemetry")("ControlDistrict") = sqlRs("control_district").value
          session("login") = "true"
  Session("sound") = "true"
          if sqlRs("role").value = "Admin" then
            response.redirect ("http://www.g1.com.my/telemetrymgmt_melaka/Main.aspx?status=admin")
          else if sqlRs("role").value ="User" then
            response.redirect ("http://www.g1.com.my/telemetrymgmt_melaka/Main.aspx?status=user")
          end if
        else
          strError = "Invalid Password"
          strSetFocusOn = "txtPassword"
        end if 
      else
        strError = "Invalid Username"
        strSetFocusOn = "txtUsername"
      end if
      sqlRs.Close()
      objConn.Close()
      objConn = nothing
  end if
  
%>

<html>

<head>
<title>Gussmann Telemetry Management System</title>
<link type="text/css" href="http://www.g1.com.my/extension/total_monitoring/main.css" rel="stylesheet">

</head>
<!-- goGetFocus() -->
<body onload="javascript:document.forms[0].txtUsername.focus();">
<form name="frmLogin" method="post" action="<%= Request.ServerVariables("SCRIPT_NAME") %>">
<br><br>
<div align="center">
	<div id="outerDIV">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
		<div class="xboxcontent">
		<p align="center"><img border="0" src="http://www.g1.com.my/telemetrymgmt_melaka/images/Logo.jpg"></p>
		<font color="red" size="2" face="Verdana"><b> <div align="center" id="Error"><%=strError%></div></b></font>  

		<table cellpadding="0" cellspacing="0" width="400" height="100" class="innerTBL">
	    <tr><td>&nbsp;<div align="center"><br>
	        <table border="0" cellpadding="5" width="300" height="63">
	            <tr>
		            <td width="100" height="25"><img border="0" src="http://www.g1.com.my/telemetrymgmt_melaka/images/UserName.jpg" width="100" height="20"></td>
		            <td width="16" height="25"><img border="0" src="http://www.g1.com.my/telemetrymgmt_melaka/images/colon.jpg" width="6" height="11"></td>
		            <td width="325" height="25"><font color="#0B3D62"><input type="text" name="txtUsername" class="inputStyle" value="<%=strLogin%>" size="20"></td>
	            </tr>
	            <tr>
					<td width="100" height="26"><img border="0" src="http://www.g1.com.my/telemetrymgmt_melaka/images/Password.jpg" width="100" height="20"></td>
					<td width="16" height="26"><img border="0" src="http://www.g1.com.my/telemetrymgmt_melaka/images/colon.jpg" width="6" height="11"></td>
					<td width="325" height="26"><font color="#0B3D62"><input type="password" name="txtPassword" class="inputStyle" value="<%=strPassword%>" size="20"></td>
	            </tr>
				<tr>
			        <td colspan="3" style="text-align:right;height:20px;">
						<input type="image" src="http://www.g1.com.my/telemetrymgmt_melaka/images/Submit.jpg" name="button2" onclick="javascript:gotoSubmit()"/> &nbsp;&nbsp;
						<img border="0" src="http://www.g1.com.my/telemetrymgmt_melaka/Images/Cancel.jpg" width="71" height="24" onclick="document.frmLogin.reset();" style="cursor:pointer;">
					</td>
				</tr>
	        </table>
	        </div>
	        <p align="center" style="word-spacing: 0; margin-top: 0; margin-bottom: 0">&nbsp;</td>
	    </tr>
		</table>
		<p align="center" style="margin-bottom: 15">
		<font size="1" face="Verdana" color="#5373A2">&copy; MMVII Gussmann Technologies Sdn Bhd. All rights reserved.</font>
		</p>
		</div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
</div>
<input type="hidden" name="txtError" value="">
<input type="hidden" name="txtSetFocus" value="">
<input type="hidden" name="txtStatus" value="False">
</form>
</body>

</html>
<script language="javascript">
var strFocus = "<%=strSetFocusOn%>";
var strStatus ="<%=strStatus%>";

function alahai()
{
	document.frmLogin.txtUsername.value = "satu";
	document.frmLogin.txtPassword.value = "satu";
	document.frmLogin.submit();	
}

function goGetFocus()
{
  if (strStatus == "True")
  {
    eval("document.frmLogin." + strFocus + ".focus();");
    eval("document.frmLogin." + strFocus + ".select();");
  }
  else //first load focus on username.
  {
    document.frmLogin.txtUsername.focus();
  }
}

function gotoSubmit()
{
   document.frmLogin.txtStatus.value = "True";
  
  if (document.frmLogin.txtUsername.value=="")
  {
     document.frmLogin.txtError.value = "Please Enter Username";
     document.frmLogin.txtSetFocus.value = "txtUsername";
  }
  else if (document.frmLogin.txtPassword.value=="")
  {
     document.frmLogin.txtError.value = "Please Enter Password";
     document.frmLogin.txtSetFocus.value = "txtPassword";
  
  }
  document.frmLogin.submit();

}

</script>

