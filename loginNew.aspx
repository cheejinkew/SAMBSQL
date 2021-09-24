<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<script runat="server">
    Dim objConn
    Dim strConn
    Dim sqlRs

    Dim strLogin
    Dim strUserName
    Dim strPassword
    Dim strError
    Dim strError1
    Dim strSetFocusOn
    Dim strStatus
    Dim hostaddress
    Dim strcode
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Lon") = 0
        Session("Lat") = 0
        Session("GetCoord") = 0
        ' Session("login") = ""

        strConn = ConfigurationSettings.AppSettings("DSNPG") 
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()

        hostaddress = Request.UserHostAddress
        Dim browser As String = Request.Browser.Browser & " " & Request.Browser.Version
        strLogin = UCase(Request.Form("txtUsername"))
        strPassword = UCase(Request.Form("txtPassword"))
        strError = Request.Form("txtError")
        strSetFocusOn = Request.Form("txtSetFocus")
        strStatus = Request.Form("txtStatus")
        strcode = UCase(Request.Form("txtcode"))


        If strError = "" Then
            strError = "&nbsp;"
        End If

        If strLogin <> "" And strPassword <> "" Then
            If Session("randomStr").ToString() = strcode Then
                objConn.open(strConn)
                sqlRs.open("select pwd, srole, userid, control_district from telemetry_user_table where username ='" & strLogin & "'", objConn)

                If Not sqlRs.EOF Then

                    If sqlRs("pwd").value = strPassword Then
                        Response.Cookies("Telemetry")("UserID") = sqlRs("userid").value
                        Session("userid") = sqlRs("userid").value
                        Response.Cookies("Telemetry")("UserName") = strLogin
                        Response.Cookies("Telemetry")("ControlDistrict") = sqlRs("control_district").value
                        Session("login") = "true"
                        Response.Cookies("authenticate")("status") = "true"
                        Response.Cookies("authenticate").Expires = DateTime.Now.AddDays(1)
                        Dim sqlSp = "insert into dbo.telemetry_users_log_table (userid,logintime,hostaddress,browser,action) values ('" & sqlRs("userid").value & "','" & DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") & "','" & hostaddress & "','" & browser & "','Login')"
                        objConn.Execute(sqlSp)
                        If sqlRs("srole").value = "Admin" Then
                            Response.Redirect("Main.aspx?status=admin")
                        ElseIf sqlRs("srole").value = "User" Then
                            Response.Redirect("Main.aspx?status=user")
                        End If
                    Else
                        strError = "Invalid Password"
                        strSetFocusOn = "txtPassword"
                    End If
                Else
                    strError = "Invalid Username"
                    strSetFocusOn = "txtUsername"
                End If
                sqlRs.Close()
                objConn.Close()
                objConn = Nothing
            Else
                strError = "Invalid code"
                strSetFocusOn = "txtcaptcha"

            End If
        End If
    End Sub
</script>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>www.g1.com.my</title>
    <link rel="shortcut icon" href="assets/images/fav.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">
    <link rel="shortcut icon" href="assets/images/fav.jpg">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/all.min.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="assets/plugins/slider/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/plugins/slider/css/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" />
    <style type="text/css">
        .auto-style1 {
            font-size: 12pt;
            vertical-align: middle;
            background-color: #FA607E;
        }
        .auto-style2 {
            vertical-align: middle;
        }
        .auto-style5 {
            height: 30px;
            width: 34px;
        }
      .auto-style6 {
            width: 108px;
            height: 42px;
        }
        .auto-style7 {
            width: 355px;
            height: 60px;
        }
        </style>
</head>
    <body class="form-login-body"> 
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto login-desk">
                       <div class="row">
                            <div class="col-md-5 detail-box">
                                 <center>
                                <td><span class="auto-style2"></span></td>
                                <div class="detailsh">
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                      
                                         <center>
                                                  <img src="assets/images/integralogo.png" class="auto-style6" >  
                                           </center>
                                           <br />
                                           <br />
                                          <div align ="center"><h1 style="font-size:70%;">We Integrate Wireless Solutions Into Your Life</h1> </div> 

                                    <br />
                                    <br />
                                 
                                   <h1 style="font-size:85%">WELCOME BACK</h1>
                                </div>
                          
                                    <br />
                                    <br />
                                    <br />
                                    <br />
         
                                                 <center>
                                                  <img src="assets/images/gusslogo.png" class="auto-style5">
                                                 
                                           </center>

                                  <h1 style="font-size:65%">version 2.0</h1>
                                   <h1 style="font-size:65%;">All Right Reserved Powered By Gussmann</h1>
                                <h1 style="font-size:65%;">Copyright &copy;2021 Global Telematics Sdn Bhd</h1> 
                            </div>

                            <div class="col-md-5 loginform" style="left: 0px; top: 0px">
                                <form id="frmLogin" name="frmLogin" onsubmit="return samb()" method="post" action="loginNew.aspx" runat="server">
                                  <font color="red" size="2" face="Verdana"><b> <div align="center" id="Error"><%=strError%></div></b></font>

                                  <height="100" colspan="50" rowspan="2" align="center"><img src="assets/images/samb1.png?r=<%=DateTime.Now.ToString()%>" class="auto-style7">
                                    <h4>User Login</h4>                   
                              
                                 <div class="login-det">
                                    <div class="form-row">
                                         <label for="">Username</label>&nbsp;&nbsp;<font color="red" size="2" face="Verdana"><b> <div align="center" id="Error0"><%=strError1%></div></b></font>
                                        
                                             <div class="input-group mb-3">
                                              <div class="input-group-prepend">
                                                <span class="input-group-text" id="username">
                                                    <i class="far fa-user"></i>
                                                </span>
                                              </div>
                                              <input type="text" class="form-control" size="100" placeholder="Enter Username" aria-label="Username" aria-describedby="basic-addon1" name="txtUsername" value="<%=strLogin%>">
                                         </div>
                                    </div>
                                     <div class="form-row">
                                         <label for="">Password</label>&nbsp;&nbsp;<font color="red" size="2" face="Verdana"><b> <div align="center" id="Error1"><%=strError1%></div></b></font>
                                             <div class="input-group mb-3">
                                              <div class="input-group-prepend">
                                                <span class="input-group-text" id="password">
                                                    <i class="fas fa-lock"></i>
                                                </span>
                                              </div>
                                              <input type="password" class="form-control" placeholder="Enter Password" aria-label="password" aria-describedby="basic-addon1" name="txtPassword" value="<%=strPassword%>" >
                                         </div>
                                    </div>
                                    <div class="form-row">
                                        <br /> <label for="">Security Code</label><font color="red" size="2" face="Verdana"><b> <div align="center" id="Error2"><%=strError1%></div></b></font>
                                
                                           <img id="captcha" style="WIDTH: 110px; HEIGHT: 20px" alt="" src="Captcha.aspx" />
                                          
                                             <div class="input-group mb-3">
                                              <div class="input-group-prepend">
                                                <span class="input-group-text" id="code">
                                                    <i class="fas fa-lock"></i>
                                                </span>
                                              </div>
                                               <input type="text" class="form-control" placeholder="Enter Security Code" aria-label="Username" aria-describedby="basic-addon1" name="txtcode" value="<%=strcode%>">
                                           
                                             
                                         </div>
                                         <button class="btn btn-sm btn-danger" type="submit" runat="server">Login</button>
                                    </div>
                                  <span class="auto-style1"></span></div>
                                <input type="hidden" name="txtError" value="">
                                <input type="hidden" name="txtError1" value="">
					            <input type="hidden" name="txtSetFocus" value="">
					            <input type="hidden" name="txtStatus" value="False">
                            </form>
                            </div>
                       </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/plugins/scroll-fixed/jquery-scrolltofixed-min.js"></script>
    <script src="assets/plugins/slider/js/owl.carousel.min.js"></script>
    <script src="assets/js/script.js"></script>
</html>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="assets/images/fav.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">
    <link rel="shortcut icon" href="assets/images/fav.jpg">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/all.min.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="assets/plugins/slider/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/plugins/slider/css/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" />
</head>
    <body>      
    </body>
    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/plugins/scroll-fixed/jquery-scrolltofixed-min.js"></script>
    <script src="assets/plugins/slider/js/owl.carousel.min.js"></script>
    <script src="assets/js/script.js"></script>
</html>

<script language="javascript">
    var strFocus = "<%=strSetFocusOn%>";
    var strStatus = "<%=strStatus%>";

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
    function samb() {
        var username = document.forms["frmLogin"]["txtUsername"];
        var password = document.forms["frmLogin"]["txtPassword"];
        var code = document.forms["frmLogin"]["txtcaptcha"];
    

        if (username.value == "") {
            document.getElementById("Error0").innerHTML = "*Please Enter Username";
            username.focus();
            return false;
        }

        if (password.value == "") {
            document.getElementById("Error1").innerHTML = "*Please Enter Password";
            password.focus();
            return false;
        }

        if (code.value == "") {
            document.getElementById("Error2").innerHTML = "*Please Enter Code";
            code.focus();
            return false;
        }
        return true;
    } 
    function gotoSubmit() {
        document.frmLogin.txtStatus.value = "True";

        if (document.frmLogin.txtUsername.value == "") {

            document.getElementById("Error").innerHTML = "Please Enter Username";
            document.frmLogin.txtUsername.focus();

            //document.frmLogin.txtSetFocus.value = "txtUsername";
            return false;
        }
        else if (document.frmLogin.txtPassword.value == "") {
            document.getElementById("Error").innerHTML = "Please Enter Password";
            document.frmLogin.txtPassword.focus();

            //document.frmLogin.txtSetFocus.value = "txtPassword";
            return false;

        }
        else if (document.frmLogin.txtcode.value == "") {
            document.getElementById("Error").innerHTML = "Please Enter the code";
            document.frmLogin.txtcode.focus();

            document.frmLogin.txtSetFocus.value = "txtcode";
            return false;
        }
        return true;
    }
</script>