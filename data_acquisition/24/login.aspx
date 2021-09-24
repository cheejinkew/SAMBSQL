<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="System.IO" %>


<%
          
    Dim status
  dim objConn
  dim strConn
  dim sqlRs
    Dim strLogin
  dim strUserName
  dim strPassword
  dim strError
  dim strSetFocusOn
  dim strStatus
  
  session("Lon")= 0
  session("Lat")= 0
  session("GetCoord") = 0
  session("login") = ""

    strConn = ConfigurationSettings.AppSettings("DSNPG3")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

   
    strLogin = Request.Form("txtUsername")
    strPassword = Request.Form("txtPassword")
  strError = request.form("txtError")
  strSetFocusOn = request.form("txtSetFocus")
  strStatus = request.form("txtStatus")
  
    If strLogin <> "" And strPassword <> "" Then
        If strLogin = "guss" And strPassword = "guss" Then
            Response.Cookies("userinfo")("userid") = strLogin
            Session("login") = "true"
            Response.Redirect("http://203.223.159.170/extension/total_monitoring/menu.aspx")
            status = "Admin"
          
                    
        Else
            strError = "Invalid Username"
        End If
        End If
    
    
    
    'if strError = "" then
    '  strError = "&nbsp;"
    'end if

    'if strLogin <> "" and strPassword <> "" then
    '    objConn.open(strConn)
    '    sqlRs.open ("select user_pwd, user_role, user_id from user_table where user_name ='" & strLogin & "'", objConn)
       
    '      If Not sqlRs.EOF Then
    '          status = sqlRs("user_role").value
    '          If sqlRs("user_pwd").value = strPassword Then
    '              Response.Cookies("Telemetry")("UserID") = sqlRs("user_id").value
    '              Response.Cookies("Telemetry")("Username") = strLogin
    '              'response.cookies("Telemetry")("ControlDistrict") = sqlRs("control_district").value
    '              Session("login") = "true"
                
    '              Dim date1 As Date = System.DateTime.Now()
    '              Dim str As String
    '              str = Format(date1, "yyyy/MM/dd HH:mm:ss")
                
               
    '              Dim fp As IO.StreamWriter
    '              'fp = File.AppendText("D:\ASHOK-SATU\Telemetry_extension\Logdata/log.txt")
    '              fp = File.AppendText("D:\wwwroot\extension\Logdata\log.txt")
    '              fp.WriteLine("Loginname:" & strLogin & " " & "status=" & status & " " & "Logintime:" & str)
    '              fp.Close()
            
                
    '              If status = "admin" Then
                   
    '                  Server.Transfer("menu.html?status=admin")
                    
    '              ElseIf status = "user" Then
                   
    '                  Server.Transfer("menu.html?status=user")
    '              End If
    '          Else
    '              strError = "Invalid Password"
    '              strSetFocusOn = "txtPassword"
    '          End If
    '      Else
        
    '          strError = "Invalid Username"
    '          strSetFocusOn = "txtUsername"
   
    '      End If
    '      sqlRs.Close()
    '      objConn.Close()
    '      objConn = Nothing
  
    '  End If
    
  %>

<html>

<head>
<title>Gussmann Telemetry Monitoring System</title>
<link type="text/css" href="main.css" rel="stylesheet">
</head>
<!-- goGetFocus() -->
<body onload="javascript:document.forms[0].txtUsername.focus();">
<form name="frmLogin1" method="post" action="login.aspx">
<br><br>
<div align="center">
	<div id="outerDIV">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
		<div class="xboxcontent">
		<p align="center"><img border="0" src="../images/logogussmann.jpg"></p>
		<font color="red" size="2" face="Verdana"><b> <div align="center" id="Error"><%=strError%></div></b></font>		
		<table cellpadding="0" cellspacing="0" class="innerTBL">
	    <tr>
	      <td>
				<table style="margin-top: 15" border="0" cellpadding="5" width="300" height="63" align="center">
		            <tr>
		              <td width="100" height="25"><img border="0" src="../images/UserName.jpg" width="100" height="20"></td>
		              <td width="16" height="25"><img border="0" src="../images/colon.jpg" width="6" height="11"></td>
		              <td width="325" height="25"><font color="#0B3D62"><input type="text" name="txtUsername" class="inputStyle" value="<%=strLogin%>" size="20"></td>
		            </tr>
		            <tr>
		              <td width="100" height="26"><img border="0" src="../images/Password.jpg" width="100" height="20"></td>
		              <td width="16" height="26"><img border="0" src="../images/colon.jpg" width="6" height="11"></td>
		              <td width="325" height="26"><font color="#0B3D62"><input type="password" name="txtPassword" class="inputStyle" value="<%=strPassword%>" size="20"></td>
		            </tr>
					<tr>
		              <td colspan="3" style="text-align:right;height:20px;">
							<input type="image" src="../images/Submit.jpg" name="button2" onclick="javascript:gotoSubmit1()"/> &nbsp;&nbsp;
							<img border="0" src="../Images/Cancel.jpg" width="71" height="24" onclick="document.frmLogin.reset()" style="cursor:pointer;">
					  </td>
		            </tr>
				</table>	
 		  </td>
	    </tr>
		</table>		
		<p align="center" style="margin-bottom: 15"><font size="1" face="Verdana" color="#5373A2">©
		MMVII Gussmann Technologies Sdn Bhd. All rights reserved.</font></p>
		</div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>
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

//function goGetFocus()
//{
//  if (strStatus == "True")
//  {
//    eval("document.frmLogin." + strFocus + ".focus();");
//    eval("document.frmLogin." + strFocus + ".select();");
//  }
//  else //first load focus on username.
//  {
//    document.frmLogin.txtUsername.focus();
//  }
//}

function gotoSubmit1()
{
   document.frmLogin1.txtStatus.value = "True";
  
  if (document.frmLogin1.txtUsername.value=="")
  {
     document.frmLogin1.txtError.value = "Please Enter Username";
     document.frmLogin1.txtSetFocus.value = "txtUsername";
  }
  else if (document.frmLogin1.txtPassword.value=="")
  {
     document.frmLogin1txtError.value = "Please Enter Password";
     document.frmLogin1.txtSetFocus.value = "txtPassword";
  }
  }

</script>

