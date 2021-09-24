<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%

  dim ArryPlateNo = New SortedList
  dim ArryUser = New SortedList
  dim objConn
  dim strConn
  dim sqlRs
  dim strError
  dim strErrorColor
  dim intUserID
  dim strUsername
  dim intUnitID = request.form("txtUnitID")
  dim intVersionID = request.form("txtVersionID")
  dim strPassword = request.form("txtPassword")
    Dim strSIMNo = Request.Form("txtSIMNo")
    Dim strIMEI = Request.Form("txtIMEINo")
  dim intSelectedUserID = request.form("ddUser")
  dim strUnitPageddUser = request.querystring("user")

  dim i
  dim strControlDistrict
  dim strFullControlDistrict = request.cookies("Telemetry")("ControlDistrict")
  dim arryControlDistrict = split(strFullControlDistrict, ",")
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

  if intSelectedUserID ="" then
    intSelectedUserID ="0"
  end if
  
  strConn = ConfigurationSettings.AppSettings("DSNPG") 
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()
  strError = request.form("txtError")
  strErrorColor = request.form("txtErrorColor")

%>


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
    color:#5373A2;
  }
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>

<body>
<form name="frmAddUnit" method="post" action="AddUnit.aspx?user=<%=strUnitPageddUser%>">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/AddUnit.jpg">
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
                <select name="ddUser" class="FormDropdown">
                  <option value="0" > - Select User -</option>
                  <%
                    objConn.open(strConn)
 
                    if arryControlDistrict(0) <> "ALL" then
                      sqlRs.Open("SELECT username, userid from telemetry_user_table " & _
                                 " where control_district in ('" & strFullControlDistrict & "'," & strControlDistrict & ")" & _
                                 " order by username", objConn)
                    else
                      sqlRs.Open("SELECT username, userid from telemetry_user_table " & _
                                 " order by username", objConn)
                    end if
                    do while not sqlRs.EOF
                          strUsername = sqlRs("username").value
                          intUserID = sqlRs("userid").value
                           %>
                           <option value="<%=intUserID%>"><%=strUsername%></option>
                           <%

                      sqlRs.movenext
                           Loop
                
                    sqlRs.close()
                    objConn.close()
                    sqlRs = nothing
                    objConn = nothing
                  %>
                </select>
                </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Unit
                ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtUnitID" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=intUnitID%>">
              </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Version
                ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtVersionID" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=intVersionID%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Password</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtPassword" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strPassword%>">
              </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">SIM
                No</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSIMNo" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strSIMNo%>">
              </td>
            </tr>
             <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">IMEI
                No</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtIMEINo" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strIMEI%>">
              </td>
            </tr>
            <tr>
              <td width="100" height="26"></td>
              <td width="16" height="26"></td>
  </center>
              <td width="325" height="26">
                <p align="right">
          
                <a href="javascript:goAddUnit()"><img src="images/Submit_s.jpg" border=0></a>
              
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
<input type="hidden" name="txtError" value="">
<input type="hidden" name="txtErrorColor" value="">
<input type="hidden" name="txtUnitddUser" value="<%=strUnitPageddUser%>">
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright ?2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
</body>

</html>
<script language="javascript">

  document.frmAddUnit.ddUser.value = '<%=intSelectedUserID%>';

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;

  function goAddUnit()
  {
    if (document.frmAddUnit.ddUser.value=="0")
    {
      document.frmAddUnit.txtError.value = "Please Select User !";
      document.frmAddUnit.txtErrorColor.value = "red";
    }
    else if (document.frmAddUnit.txtUnitID.value=="")
    {
      document.frmAddUnit.txtError.value = "Please Enter Unit ID !";
      document.frmAddUnit.txtErrorColor.value = "red";
    }
    else if (document.frmAddUnit.txtVersionID.value=="")
    {
      document.frmAddUnit.txtError.value = "Please Enter Version ID !";
      document.frmAddUnit.txtErrorColor.value = "red";
    }
    else if (document.frmAddUnit.txtPassword.value=="")
    {
      document.frmAddUnit.txtError.value = "Please Enter Password !";
      document.frmAddUnit.txtErrorColor.value = "red";
    }
    else if (document.frmAddUnit.txtSIMNo.value=="")
    {
      document.frmAddUnit.txtError.value = "Please Enter SIM No !";
      document.frmAddUnit.txtErrorColor.value = "red";
    }
    else
    {
      document.frmAddUnit.action="HelperPages/AddUnit.aspx";
      document.frmAddUnit.submit();
      return;
    }
   document.frmAddUnit.submit();
  }
</script>

