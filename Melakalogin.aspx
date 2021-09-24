<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%@ Register TagPrefix="cc1" Namespace="WebControlCaptcha" Assembly="WebControlCaptcha" %>

<script runat="server">
    Dim objConn
    Dim strConn
    Dim sqlRs
  
    Dim strLogin
    Dim strUserName
    Dim strPassword
    Dim strError
    Dim strSetFocusOn
    Dim strStatus
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Lon") = 0
        Session("Lat") = 0
        Session("GetCoord") = 0
        Session("login") = ""

        strConn = ConfigurationSettings.AppSettings("DSNPG")
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()

   
        strLogin = UCase(Request.Form("txtUsername"))
        strPassword = UCase(Request.Form("txtPassword"))
        strError = Request.Form("txtError")
        strSetFocusOn = Request.Form("txtSetFocus")
        strStatus = Request.Form("txtStatus")
  
        If strError = "" Then
            strError = "&nbsp;"
        End If
        'besutadmin/admin1 and besutuser/besutuser
        If strLogin <> "" And strPassword <> "" Then
            If (strLogin = "PEMAJUADMIN" And strPassword = "ADMIN1") Then
                Session("login") = "true"
                Response.Cookies("Telemetry")("UserID") = "1"
                Response.Cookies("Telemetry")("UserName") = "PemajuAdmin"
                Response.Cookies("Telemetry")("ControlDistrict") = "Melaka"
                Response.Redirect("MelakaMain.aspx?status=admin")
            ElseIf (strLogin = "PEMAJU" And strPassword = "PEMAJU") Then
                Session("login") = "true"
                Response.Cookies("Telemetry")("UserID") = "2"
                Response.Cookies("Telemetry")("UserName") = "Pemaju"
                Response.Cookies("Telemetry")("ControlDistrict") = "Melaka"
                Response.Redirect("MelakaMain.aspx?status=user")
            Else
                strError = "Either Username or Password are incorrect!"
            End If
   
            'objConn.open(strConn)
            'sqlRs.open("select pwd, role, userid, control_district from telemetry_user_table where username ='" & strLogin & "'", objConn)
     
            
            'If Not sqlRs.EOF Then
            '    If sqlRs("pwd").value = strPassword Then
            '        Response.Cookies("Telemetry")("UserID") = sqlRs("userid").value
            '        Response.Cookies("Telemetry")("UserName") = strLogin
            '        Response.Cookies("Telemetry")("ControlDistrict") = sqlRs("control_district").value
            '        Session("login") = "true"
            '        Response.Redirect("BesutMain.aspx?status=admin")
            '    Else
            '        strError = "Invalid Password"
            '        strSetFocusOn = "txtPassword"
            '    End If
            'Else
            '    strError = "Invalid Username"
            '    strSetFocusOn = "txtUsername"
            'End If
            'sqlRs.Close()
            'objConn.Close()
            'objConn = Nothing
        
        End If
    End Sub
</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>www.g1.com.my</title>
    <meta http-equiv="Content-Language" content="en-us">
    <meta content="MSHTML 6.00.2900.2912" name="GENERATOR">
    <meta content="FrontPage.Editor.Document" name="ProgId">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style>
  a:hover {color: #000000; text-decoration: underline; font-weight: bold}
  a.newcolor:link {color: #FF0000; text-decoration: none; font-weight: bold}
  a.newcolor:visited {color: #FF0000; text-decoration: none; font-weight: bold}
  a.newcolor:active {color: #FF0000; text-decoration: none; font-weight: bold}
  a.newcolor:hover {color: #000000; font-weight: bold}
  a{text-decoration:none;}
.maintitle	{
	font-weight: bold; font-size: 22px; font-family: "Trebuchet MS",Verdana, Arial, Helvetica, sans-serif;
	text-decoration: none; line-height : 120%; color : #000000;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #EAEAEA;
}
.style10 {color: #5270C8}
.style2 {	font-size: 11px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style4 {color: #4E6ABD}
.style5 {color: #666666}
.style7 {color: #4A6DBE}
.style9 {font-size: 10px; font-family: Verdana, Arial, Helvetica, sans-serif; color: #666666; }
a:link {
	color: #4A6DBE;
}
.style11 {
	font-size: 10px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	color: #496EBE;
}
.style15 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
}
</style>
</head>
<body onload="goGetFocus();">
    <br>
    <div align="center">
        <center>
            <table width="800" height="0px" border="0" cellpadding="0" cellspacing="0" style="border-width: 1px;
                border-style: solid; border-color: #8AA2FD">
                <tr>
                    <td bgcolor="#FFFFFF">
                        <div align="center">
                            <img src="avlsimages/logo.jpg" width="800" height="72"></div>
                    </td>
                </tr>
                <tr>
                    <td width="800" height="20" bgcolor="#83C5FF">
                        <b><font color="ffffff" size="2" face="Verdana">
                            <marquee scrolldelay="10" scrollamount="1" behavior="alternate">
            <div align="center">We Integrate Wireless Solutions Into Your Life ... </div>
          </marquee>
                        </font></b>
                    </td>
                </tr>
                <tr>
                    <td height="202">
                        <table width="800" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                            <tr>
                                <td height="19" bgcolor="#E0DFE3">
                                    <div align="center">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td height="85%">
                                    <table width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td valign="top">
                                                <form id="frmLogin" name="frmLogin" method="post" action="Melakalogin.aspx" runat="server">
                                                    <font color="red" size="2" face="Verdana"><b>
                                                        <div align="center" id="Error">
                                                            <%=strError%>
                                                        </div>
                                                    </b></font>
                                                    <br>
                                                    <table width="387" height="272" border="0" align="center" cellpadding="0" cellspacing="0"
                                                        id="Table_01">
                                                        <tr>
                                                            <td colspan="8">
                                                                <img src="avlsimages/loginPage2_01.jpg" width="387" height="7" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <img src="avlsimages/loginPage2_02.jpg" width="13" height="1" alt=""></td>
                                                            <td>
                                                                <img src="avlsimages/loginPage2_03.jpg" width="1" height="1" alt=""></td>
                                                            <td height="88" colspan="5" rowspan="2">
                                                                <img src="avlsimages//loginPage2_04.jpg" width="360" height="88" alt=""></td>
                                                            <td rowspan="7">
                                                                <img src="avlsimages//loginPage2_05.jpg" width="13" height="225" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="6">
                                                                <img src="avlsimages/loginPage2_06.jpg" width="13" height="224" alt=""></td>
                                                            <td>
                                                                <img src="avlsimages//loginPage2_07.jpg" width="1" height="87" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6">
                                                                <img src="avlsimages/loginPage2_08.jpg" width="361" height="55" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <img src="avlsimages/loginPage2_09.jpg" width="97" height="31" alt=""></td>
                                                            <td colspan="3" bgcolor="#E0DFE4">
                                                                <div align="center">
                                                                    <input type="text" name="txtUsername" class="inputStyle" value="<%=strLogin%>" style="width: 145px;
                                                                        height: 22px">
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <img src="avlsimages//loginPage2_11.jpg" width="3" height="31" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <img src="avlsimages/loginPage2_12.jpg" width="160" height="2" alt=""></td>
                                                            <td>
                                                                <img src="avlsimages/loginPage2_13.jpg" width="101" height="2" alt=""></td>
                                                            <td colspan="2">
                                                                <img src="avlsimages/loginPage2_14.jpg" width="100" height="2" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <img src="avlsimages/loginPage2_15.jpg" width="97" height="31" alt=""></td>
                                                            <td colspan="3" bgcolor="#E0DFE4">
                                                                <div align="center">
                                                                    <input type="password" name="txtPassword" class="inputStyle" value="<%=strPassword%>"
                                                                        style="width: 145px">
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <img src="avlsimages/loginPage2_17.jpg" width="3" height="31" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6">
                                                                <img src="avlsimages/loginPage2_18.jpg" width="361" height="18" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <img src="avlsimages/loginPage2_06.jpg" width="13" alt="" style="height: 60px"></td>
                                                            <td colspan="6" align="center">
                                                                <cc1:CaptchaControl ID="CaptchaControl1" runat="server" Height="15px" Width="352px"
                                                                    Font-Names="Verdana" Font-Size="Smaller" CaptchaBackgroundNoise="High"></cc1:CaptchaControl>
                                                            </td>
                                                            <td>
                                                                <img src="avlsimages//loginPage2_05.jpg" width="13" alt="" style="height: 60px"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="8">
                                                                <img src="avlsimages/loginPage2_19.jpg" width="387" height="13" alt=""></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" style="height: 26px">
                                                                <img src="avlsimages/loginPage2_20.jpg" width="173" height="26" alt=""></td>
                                                            <td style="height: 26px">
                                                                <%--<INPUT TYPE="IMAGE" src="avlsimages/loginPage2_21.jpg" width="101" height="26" border="0" NAME="button2" VALUE="No, I did not like it." onclick="gotoSubmit()">--%>
                                                                <asp:ImageButton ID="ImageButton1" ImageUrl="avlsimages/loginPage2_21.jpg" runat="server"
                                                                    Width="101" Height="26" OnClientClick="return gotoSubmit();" /></td>
                                                            <td colspan="2" style="height: 26px">
                                                                <img src="avlsimages/loginPage2_22.jpg" width="100" height="26" border="0" onclick="document.frmLogin.reset();"
                                                                    style="cursor: pointer"></td>
                                                            <td style="height: 26px">
                                                                <img src="avlsimages/loginPage2_23.jpg" width="13" height="26"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <img src="images/spacer.gif" width="13" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="1" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="96" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="63" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="101" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="97" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="3" height="1" alt=""></td>
                                                            <td>
                                                                <img src="images/spacer.gif" width="13" height="1" alt=""></td>
                                                        </tr>
                                                    </table>
                                                    <input type="hidden" name="txtError" value="">
                                                    <input type="hidden" name="txtSetFocus" value="">
                                                    <input type="hidden" name="txtStatus" value="False">
                                                </form>
                                                <div align="center">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <table align="center" cellpadding="5" cellspacing="0">
                                                    <tr>
                                                        <td colspan="2">
                                                            <div align="center">
                                                                <span class="style11">OUR HIGHLIGHTS</span><span class="style7"><br>
                                                                    ............................................................................................................</span></div>
                                                            <div align="center">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div align="right">
                                                                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
                                                                    width="174" height="151">
                                                                    <param name="movie" value="avlsimages/product.swf">
                                                                    <param name="quality" value="high">
                                                                    <param name="wmode" value="transparent">
                                                                    <embed src="avlsimages/product.swf" width="174" height="151" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
                                                                        type="application/x-shockwave-flash" wmode="transparent"></embed>
                                                                </object>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <img src="avlsimages/product.gif" width="174" height="151"></td>
                                                    </tr>
                                                </table>
                                                <br>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </center>
    </div>
    <table width="100%" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <div align="center">
                    <p>
                        &nbsp;</p>
                    <p>
                        &nbsp;</p>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div align="center" class="style2">
                    <span class="style4">24 Hour</span> <span class="style5">Help Line Center :</span>
                    <span class="style7">019 - 2117 703</span> <span class="style5">/ <a href="mailto:info@g1.com.my">
                        info@g1.com.my</a></span></div>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <div align="center">
                    <span class="style7">..................................................................................................................................................</span></div>
            </td>
        </tr>
    </table>
    <p align="center" class="style9">
        <strong>www.g1.com.my</strong><br />
        Copyright &copy; <%=Now.ToString("yyyy") %> <span class="style10">Global Telematics Sdn Bhd</span>. All
        rights reserved<br />
        Powered by Integra &reg;</p>
</body>
</html>

<script language="javascript">
var strFocus = "<%=strSetFocusOn%>";
var strStatus ="<%=strStatus%>";



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
  
    document.getElementById("Error").innerHTML = "Please Enter Username";
    document.frmLogin.txtUsername.focus();
  
     //document.frmLogin.txtSetFocus.value = "txtUsername";
     return false;
  }
  else if (document.frmLogin.txtPassword.value=="")
  {
     document.getElementById("Error").innerHTML = "Please Enter Password";
      document.frmLogin.txtPassword.focus();
 
     //document.frmLogin.txtSetFocus.value = "txtPassword";
     return false;
  
  }
  else if (document.frmLogin.CaptchaControl1.value=="")
  {
    document.getElementById("Error").innerHTML = "Please Enter the code";
    document.frmLogin.CaptchaControl1.focus();
 
    //document.frmLogin.txtSetFocus.value = "CaptchaControl1";
    return false;
  
  }
  return true;
  
}

</script>

