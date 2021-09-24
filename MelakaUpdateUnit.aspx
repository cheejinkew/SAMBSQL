<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<script runat="Server">

 dim objConn
 dim strConn
 dim sqlRs
 
 dim strError
 dim strErrorColor
 dim intUnitID
 dim intVersionID
 dim intUserID
 dim strUsername
 dim strTmp
 dim strTmp2
 dim arryTmp2
 
 dim strPassword
 dim strSIMNo



  Sub Page_Load(Source As Object, E As EventArgs) 
  
    strConn = ConfigurationSettings.AppSettings("DSNPG") 
    objConn = new ADODB.Connection()
    sqlRs = new ADODB.Recordset()
    strError = request.form("txtError")
    strErrorColor = request.form("txtErrorColor")
    
    strTmp2 = request.form("ddUser")
    arryTmp2 = split(strTmp2, ",")
    intUserID = arryTmp2(0)
   
    strTmp = split(request.form("txtVehicleID"), ",")
   
    if not page.IsPostBack then
      intVersionID = ltrim(strTmp(1))
      intUnitID = ltrim(strTmp(0))
   
      objConn.open(strConn)

      sqlRs.Open("SELECT username from telemetry_user_table where userid='" & intUserID & "'",objConn)
      if not sqlRs.EOF
        strUsername = sqlRs("username").value
      end if       

      sqlRs.close()
    

      sqlRs.Open("select pwd, simno from unit_list " & _
                 " where versionid = '" & intVersionID & "' and unitid='" & intUnitID & "'", objConn)

      if not sqlRs.EOF
        strPassword = sqlRs("pwd").value
        strSIMNo = sqlRs("simno").value
      end if       
    
      sqlRs.close()
      objConn.close()
      objConn = nothing
    end if

    txtUser.text = strUsername
    txtVersionID.text = intVersionID
    txtUnitID.text = intUnitID
    txtPassword.text = strPassword
    txtSIMNo.text = strSIMNo
    txtUserID.value = intUserID



 end sub
 
 
 Sub goUpdateUnit (s As Object, e As System.Web.UI.ImageClickEventArgs)
   Server.transfer("Helperpages/UpdateUnit.aspx")
 end Sub
 
 </script>


<html>

<head>
<title>Gussmann Vehicle Tracking System</title>
<style>
.FormDropdown 
  {
   font-family: Verdana, Arial, Helvetica, sans-serif;
   font-size: 12px;
   width: 158px;
   border-width: 1px;
   border-style: solid;
   border-color: #CBD6E4;
  }

.SimulatedLabelBold
  {
   color: #0B3D62; 
   font-size: 10pt;
   font-family: Verdana; 
   border-width: 0; 
   font-weight:bold;
  }

.SimulatedLabel
  {
   color: #0B3D62; 
   font-size: 10pt;
   font-family: Verdana; 
   border-width: 0;
  }

.FormTextBox
  {
   color: #0B3D62; 
   font-size: 10pt;
   font-family: Verdana; 
   border-width: 1px;
   border-style: solid;
   border-color: #CBD6E4;
  }
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>

<body>
<form name="frmUpdateUnit" method="post" runat="Server">
<input type="hidden" id="txtUserID" runat="Server" value="">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdateUnit.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="400" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="350" height="63">
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">User</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25"><font color="#0B3D62">
                <asp:TextBox 
                  id="txtUser" 
                  ReadOnly ="true"
                  runat="server"
                  class="SimulatedLabelBold"/>
                 </font>
                </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Unit
                ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <asp:TextBox
                  id="txtUnitID"
                  Column="30"
                  ReadOnly ="true"
                  Runat="Server"
                  class="SimulatedLabelBold"/>
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Version
                ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <asp:TextBox
                  id="txtVersionID"
                  Column="30"
                  ReadOnly ="true"
                  Runat="Server"
                  class="SimulatedLabelBold"/>
                </font>
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Password</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <asp:TextBox
                  id="txtPassword"
                  Column="30"
                  Runat="Server"
                  class="FormTextBox"/>
                </font>
                </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">SIM
                No</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <asp:TextBox
                  id="txtSIMNo"
                  Column="30"
                  Runat="Server"
                  class="FormTextBox"/>
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"></td>
              <td width="16" height="26"></td>
  </center>
              <td width="325" height="26">
                <p align="right">
          
             <input type="image" 
              src="images/Submit_s.jpg" 
              name="btnSubmit" 
              runat="Server" 
              OnServerClick="goUpdateUnit">
              
              &nbsp;&nbsp;&nbsp;
               </td>
            </tr>
          </table>
        </div>

  <center>

      </center>

      </td>
    </tr>
  </table>
</div>

<p align="center" style="margin-bottom: 15"><font size="1" face="Verdana" color="#5373A2"></font></p>

      </td>
    </tr>
  </table>
</div>
<input type="hidden" name="ddUser" value="<%=strTmp2%>">
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
</body>

</html>
<script language="javascript">

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }

  document.onkeypress = checkCR;
</script>

