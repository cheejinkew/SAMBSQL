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

   
  strLogin = Request.form("txtUsername")
  strPassword = Request.form("txtPassword")
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
          if sqlRs("role").value = "Admin" then
            response.redirect ("Main.aspx?status=admin")
          else if sqlRs("role").value ="User" then
            response.redirect ("Main.aspx?status=user")
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
</head>

<body onload="javascript:goGetFocus();">
<form name="frmLogin" method="post" action="login.aspx">
<br><br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500" style="border: 5 double #5373A2">
    <tr>
      <td>
<br>
<p align="center"><img border="0" src="images/Logo.jpg"></p>

<font color="red" size="2" face="Verdana"><b> <div align="center" id="Error"><%=strError%></div></b></font>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="400" height="100" style="border: 2 dashed #CFD9E7">
    <tr>
      <td>&nbsp;
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="300" height="63">
            <tr>
              <td width="100" height="25"><img border="0" src="images/UserName.jpg" width="100" height="20"></td>
              <td width="16" height="25"><img border="0" src="images/colon.jpg" width="6" height="11"></td>
              <td width="325" height="25"><font color="#0B3D62">
                <input type="text" name="txtUsername" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border: 1 solid #CBD6E4" 
                 value="<%=strLogin%>" size="20">
              </td>
            </tr>
            <tr>
              <td width="100" height="26"><img border="0" src="images/Password.jpg" width="100" height="20"></td>
              <td width="16" height="26"><img border="0" src="images/colon.jpg" width="6" height="11"></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="password" name="txtPassword" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border: 1 solid #CBD6E4" 
                 value="<%=strPassword%>" size="20">
               </td>
            </tr>
          </table>
        </div>

        <p align="center" style="word-spacing: 0; margin-top: 00; margin-bottom: 0">&nbsp;</p>
        <p align="center" style="word-spacing: 0; margin-top: 00; margin-bottom: 0">&nbsp;</p>

        <p align="center" style="word-spacing: 0; margin-top: 00; margin-bottom: 0">
          
             <a href="javascript:gotoSubmit();"><img src="images/Submit.jpg"  style="border: 0;"></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <a><img border="0" src="Images/Cancel.jpg" width="71" height="24">
          </a>
        </p>
        <p align="center" style="word-spacing: 0; margin-top: 0; margin-bottom: 0">&nbsp;</td>
    </tr>
  </table>
</div>

<p align="center">&nbsp;</p>

<p align="center" style="margin-bottom: 15"><font size="1" face="Verdana" color="#5373A2">Copyright ©
2005 Gussmann Technologies Sdn Bhd. All rights reserved.</font></p>

      </td>
    </tr>
  </table>
  </center>
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

function goGetFocus()
{
  if (strStatus == "True")
  {
    eval("document.forms(0)." + strFocus + ".focus();");
    eval("document.forms(0)." + strFocus + ".select();");
  }
  else //first load focus on username.
  {
    document.forms(0).txtUsername.focus();
  }
}

function gotoSubmit()
{
   document.forms(0).txtStatus.value = "True";
  
  if (document.forms(0).txtUsername.value=="")
  {
     document.forms(0).txtError.value = "Please Enter Username";
     document.forms(0).txtSetFocus.value = "txtUsername";
  }
  else if (document.forms(0).txtPassword.value=="")
  {
     document.forms(0).txtError.value = "Please Enter Password";
     document.forms(0).txtSetFocus.value = "txtPassword";
  
  }
  document.forms(0).submit();

}

</script>

