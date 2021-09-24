<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim strConn
   dim sqlRs
   dim strError
   dim strErrorColor
   dim strUsername = request.form("txtUsername")
   dim strPassword = request.form("txtPassword")
   dim strPhone = request.form("txtPhone")
   dim strFax = request.form("txtFax")
   dim strStreet = request.form("txtStreet")
   dim strPostCode = request.form("txtPostCode")
   dim strState = request.form("ddState")
   dim strRole = request.form("ddRole")
   dim strAccessDistrict = request.form("ddAccessDistrict")
   
   dim i
   dim strControlDistrict
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
  
   if strState ="" then 
     strState ="0"
   end if
 
   if strRole ="" then 
     strRole ="0"
   end if

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()

   strError = request.form("txtError")
   strErrorColor = request.form("txtErrorColor")
    
%>

<html>

<head>
<title>Gussmann  Telemetry Management System</title>
<style>
.FormDropdown 
  {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    width: 130px;
    border-width: 1px;
    border-style: solid;
    border-color: #CBD6E4;
    color:#5373A2;
  }

</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>

<body>
<form name="frmAddUser" method="post" action="AddUser.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/AddUser.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="430" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="80%">
            <tr>
              <td width="35%" height="25"><b><font size="1" face="Verdana" color="#5373A2">Username</font></b></td>
              <td width="5%" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="25">
                <input type="text" name="txtUsername" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strUsername%>">
              </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Password</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26">
                <input type="text" name="txtPassword" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strPassword%>">
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2"> Phone Number</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26">
                <input type="text" name="txtPhone" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strPhone%>">
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Fax Number</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26">
                <input type="text" name="txtFax" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strFax%>">
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Street</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26">
                <input type="text" name="txtStreet" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strStreet%>">
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Post Code</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26">
                <input type="text" name="txtPostCode" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" size="10" value="<%=strPostCode%>">
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">State</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26"><font color="#0B3D62">
                <select name="ddState" class="FormDropdown">
                  <option value="0" > - Select State -</option>
                  <option value="Johor"> Johor</option>
                  <option value="Kedah"> Kedah</option>
                  <option value="Kelantan"> Kelantan</option>
                  <option value="Melaka"> Melaka</option>
                  <option value="N.Sembilan"> N.Sembilan</option>
                  <option value="Pahang"> Pahang</option>
                  <option value="Penang"> Penang</option>
                  <option value="Perak"> Perak</option>
                  <option value="Perlis"> Perlis</option>
                  <option value="Sabah"> Sabah</option>
                  <option value="Sarawak"> Sarawak</option>
                  <option value="Selangor"> Selangor</option>
                  <option value="Terengganu"> Terengganu</option>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Role</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26"><font color="#0B3D62">
                <select name="ddRole" class="FormDropdown">
                  <option value="0" > - Select Role -</option>
                  <option value="Admin"> Admin</option>
                  <option value="User"> User</option>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Accessible District</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="60%" height="26"><font color="#0B3D62">
                <select name="ddAccessDistrict" class="FormDropdown"  multiple>
                  <option value="ALL">ALL</option>
                  <%
                     dim strSiteDistrict
               
                     objConn.open(strConn)
   
                     if arryControlDistrict(0) <> "ALL" then
                       sqlRs.Open("SELECT distinct sitedistrict from telemetry_site_list_table " & _
                                  "where sitedistrict in (" & strControlDistrict & ")",objConn)
                     else
                       sqlRs.Open("SELECT distinct sitedistrict from telemetry_site_list_table",objConn)
                     end if
               
                     do while not sqlRs.EOF
                       strSiteDistrict = sqlRs("sitedistrict").value
                  %>
                  <option value="<%=strSiteDistrict%>"><%=strSiteDistrict%></option>
                  <%
 
                       sqlRs.movenext
                     Loop
                
                     sqlRs.close()
                     objConn.close()
                     objConn = nothing
               
                  %>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="35%" height="26"></td>
              <td width="5%" height="26"></td>
              <td width="60%" height="26">
                <p align="right">
          
                <a href="javascript:goAddUser()"><img src="images/Submit_s.jpg" border=0></a>
              
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
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
</body>

</html>
<script language="javascript">

  document.frmAddUser.ddState.value = '<%=strState%>';
  document.frmAddUser.ddRole.value = '<%=strRole%>';

  var strTmp ='<%=strAccessDistrict%>';

  //********************* Reset selected value to control district combobox ***********************
  if (strTmp != "")
  {
    var arryTmp = new Array();
    arryTmp = strTmp.split(",");
    for (var j=0;j<arryTmp.length ; j++)
    {
      for (var i=0; i < document.frmAddUser.ddAccessDistrict.options.length; i++) 
      {
        if (document.frmAddUser.ddAccessDistrict.options[i].value == arryTmp[j]) 
        {
          document.frmAddUser.ddAccessDistrict.options[i].selected = true;
        }
      }
    }
  }
  

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goAddUser()
  {
    if (document.frmAddUser.txtUsername.value=="")
    {
      document.frmAddUser.txtError.value = "Please Enter Username !";
      document.frmAddUser.txtErrorColor.value = "red";
    }
     else if (document.frmAddUser.txtPassword.value=="")
    {
      document.frmAddUser.txtError.value = "Please Enter Password !";
      document.frmAddUser.txtErrorColor.value = "red";
    }
    else if (document.frmAddUser.txtPhone.value=="")
    {
      document.frmAddUser.txtError.value = "Please Enter Phone Number !";
      document.frmAddUser.txtErrorColor.value = "red";
    }
    else if (document.frmAddUser.txtStreet.value=="")
    {
      document.frmAddUser.txtError.value = "Please Enter Street !";
      document.frmAddUser.txtErrorColor.value = "red";
    }
    else if (document.frmAddUser.txtPostCode.value=="")
    {
      document.frmAddUser.txtError.value = "Please Enter Post Code !";
      document.frmAddUser.txtErrorColor.value = "red";
    }

    else if (document.frmAddUser.ddState.value=="0")
    {
      document.frmAddUser.txtError.value = "Please Select State !";
      document.frmAddUser.txtErrorColor.value = "red";
    }

    else if (document.frmAddUser.ddRole.value=="0")
    {
      document.frmAddUser.txtError.value = "Please Select Role !";
      document.frmAddUser.txtErrorColor.value = "red";
    }
    else if (document.frmAddUser.ddAccessDistrict.value=="")
    {
      document.frmAddUser.txtError.value = "Please Select Accessible District !";
      document.frmAddUser.txtErrorColor.value = "red";
    }
    else
    {
      document.frmAddUser.action="HelperPages/AddUser.aspx";
      document.frmAddUser.submit();
      return;
    }
   document.frmAddUser.submit();
  }
</script>

