<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim strConn
   dim sqlRs
   dim strError
   dim strErrorColor
   dim intUserID = request.form("txtUserID")
   
   dim strUsername
   dim strPassword
   dim strNewPassword = request.form("txtNewPassword")
   dim strConfPassword= request.form("txtConfPassword")
   dim strPhone
   dim strFax
   dim strStreet
   dim strPostCode
   dim strState
   dim strRole
   dim strAccessDistrict
  
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

   objConn.open(strConn)
   sqlRs.Open("SELECT * from telemetry_user_table where userid= " & intUserID, objConn)
                    
   if not sqlRs.EOF then
     strUsername = sqlRs("username").value
     strPassword = sqlRs("pwd").value
     strPhone = sqlRs("phoneno").value
     strFax = sqlRs("faxno").value
     strStreet = sqlRs("streetname").value
     strPostCode = sqlRs("postcode").value
     strState = sqlRs("state").value
     strRole = sqlRs("role").value
     strAccessDistrict = sqlRs("control_district").value
   end if
   sqlRs.close()
   objConn.close()
   objConn = nothing

   strError = request.form("txtError")
   strErrorColor = request.form("txtErrorColor")
        
%>

<html>

<head>
<title>Gussmann Telemetry Management System</title>
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

.FormMultiDropdown
  {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    width: 130px;
    height: 50px;
    border-width: 1px;
    border-style: solid;
    border-color: #CBD6E4;
    color:#5373A2;
  }

</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>

<body>
<form name="frmUpdateUser" method="post" action="UpdateUser.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdateUser.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="400" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="350" height="63">
            <tr>
              <td width="150" height="23"><b><font size="1" face="Verdana" color="#5373A2">Username</font></b></td>
              <td width="20" height="23"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="23">
                <input type="text" name="txtUsername" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 0; font-weight:bold" readonly value="<%=strUsername%>">
              </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Old Password</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtPassword" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strPassword%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">New Password</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtNewPassword" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strNewPassword%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Confirm Password</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtConfPassword" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strConfPassword%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2"> Phone Number</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtPhone" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strPhone%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Fax Number</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtFax" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strFax%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Street</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtStreet" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" value="<%=strStreet%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Post Code</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25">
                <input type="text" name="txtPostCode" style="color: #0B3D62; font-size: 10pt;font-family: Verdana; border-width: 1px; border-style: solid; border-color: #CBD6E4" size="10" value="<%=strPostCode%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">State</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25"><font color="#0B3D62">
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
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Role</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25"><font color="#0B3D62">
                <select name="ddRole" class="FormDropdown">
                  <option value="0" > - Select Role -</option>
                  <option value="Admin"> Admin</option>
                  <option value="User"> User</option>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td height="25"><b><font size="1" face="Verdana" color="#5373A2">Accessible District</font></b></td>
              <td height="25"><b><font color="#5373A2">:</font></b></td>
              <td height="25"><font color="#0B3D62">
                <select name="ddAccessDistrict" class="FormMultiDropdown"  multiple>
                  <option value="ALL">ALL</option>
                  <%
                     dim strSiteDistrict
                  
                     objConn = new ADODB.Connection()
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
              <td width="150" height="25"></td>
              <td width="20" height="25"></td>
              <td width="180" height="25">
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
<input type="hidden" name="txtUserID" value="<%=intUserID%>">
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
</body>

</html>
<script language="javascript">

  document.forms[0].ddState.value = '<%=strState%>';
  document.forms[0].ddRole.value = '<%=strRole%>';

  var strTmp ='<%=strAccessDistrict%>';

  //********************* Reset selected value to control district combobox ***********************
  if (strTmp != "")
  {
    var arryTmp = new Array();
    arryTmp = strTmp.split(",");
    for (var j=0;j<arryTmp.length ; j++)
    {
      for (var i=0; i < document.forms[0].ddAccessDistrict.options.length; i++) 
      {
        if (document.forms[0].ddAccessDistrict.options[i].value == arryTmp[j]) 
        {
          document.forms[0].ddAccessDistrict.options[i].selected = true;
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
    if (document.forms[0].txtPassword.value=="")
    {
      document.forms[0].txtError.value = "Please Enter Old Password !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].txtNewPassword.value=="")
    {
      document.forms[0].txtError.value = "Please Enter New Password !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].txtConfPassword.value != document.forms[0].txtNewPassword.value)
    {
      document.forms[0].txtError.value = "New Password and Confirm Password NOT Match !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].txtConfPassword.value=="")
    {
      document.forms[0].txtError.value = "Please Enter Confirm Password !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].txtPhone.value=="")
    {
      document.forms[0].txtError.value = "Please Enter Phone Number !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].txtStreet.value=="")
    {
      document.forms[0].txtError.value = "Please Enter Street !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].ddState.value=="0")
    {
      document.forms[0].txtError.value = "Please Select State !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else if (document.forms[0].ddRole.value=="0")
    {
      document.forms[0].txtError.value = "Please Select Role !";
      document.forms[0].txtErrorColor.value = "red";
    }
    else
    {
      document.forms[0].action="HelperPages/UpdateUser.aspx";
      document.forms[0].submit();
    }
   document.forms[0].submit();
  }
</script>

