<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlRs
   dim strConn
   dim strError
   dim strErrorColor
   dim strDisabled = "true"

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
 
   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   
   strError = request.form("txtError")
   strErrorColor = request.form("txtErrorColor")

%>

<html>
<head>
<style>
.bodytxt {font-weight: normal;
          font-size: 11px;
          color: #333333;
          line-height: normal;
          font-family: Verdana, Arial, Helvetica, sans-serif;}
.FormDropdown 
{
      font-family: Verdana, Arial, Helvetica, sans-serif;
      font-size: 12px;
      color:#5F7AFC;
      width: 158px;
      border-width: 1px;
      border-style: solid;
      border-color: #CBD6E4;
}
a { text-decoration: none;}
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>
<body>
  <form name="frmUser" method="post" action="UpdateUser.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="90%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/UserMgmt.jpg">
            
          </td>
        </tr>
        <tr>
          <td colspan ="3" height="30">
           </td>
          <td width="50%" height="30">
            <p align="right"><b><font size="1" face="Verdana"><a href="AddUser.aspx">Add New User</a></font></b></td>
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="90%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%">
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmUser')">
            </th>
            <th width="16%">Username</th>
            <th width="16%">Password</th>
            <th width="16%">Phone #</th>
            <th width="40%">Address</th>
            <th width="10%">Role</th>
          </tr>
      
          <%
             dim intNum = 0
             dim intUserID
             dim strUserName
             dim strPassword
             dim strPhone
             dim strAddress
             dim strRole
               
             objConn = new ADODB.Connection()  
             objConn.open(strConn)

             if arryControlDistrict(0) <> "ALL" then
               sqlRs.Open("select userid, username, pwd, phoneno, streetname || ', ' " & _
                          "|| postcode || ', ' || state as address, role" & _
                          " from telemetry_user_table " & _
                          " where control_district in ('" & strFullControlDistrict & "'," & strControlDistrict & ")" & _
                          " order by username", objConn)
             else
               sqlRs.Open("select userid, username, pwd, phoneno, streetname || ', ' " & _
                          "|| postcode || ', ' || state as address, role" & _
                          " from telemetry_user_table " & _
                          " order by username", objConn)
             end if
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
             do while not sqlRs.EOF
               intUserID = sqlRs("userid").value
               strUserName = sqlRs("username").value
               strPassword = sqlRs("pwd").value
               strPhone = sqlRs("phoneno").value
               strAddress = sqlRs("address").value
               strRole = sqlRs("role").value
               
               if intNum = 0 then
	         intNum = 1

           %>

	<tr bgcolor="#FFFFFF">
          <%
	       elseif intNum = 1 then
	         intNum = 0
	  %>
	<tr bgcolor="#E7E8F8">
	  <%
	       end if
          %>
          <td width="1%">
            <input type="checkbox" name="chkDelete" value="<%=intUserID%>">
          </td>
          <td style="margin-left: 5"><b>
            <a href="javascript:gotoUpdate('frmUser', 'txtUserID','<%=intUserID%>');">
               <%=strUserName%>
            </a></b>
          </td>
          <td style="margin-left: 5"><%=strPassword%></td>
          <td style="margin-left: 5"><%=strPhone%></td>
          <td style="margin-left: 5"><%=strAddress%></td>
          <td style="margin-left: 5"><%=strRole%></td>
         </tr>
         <%
               
               sqlRs.movenext
             Loop
                
             sqlRs.close()
             objConn.close()
             
             sqlRs = nothing
             objConn = nothing
          %>

       <tr>
         <td colspan="6">
           <br>
           <br>
           <%if strDisabled ="false" then%>
           <a href="javascript:gotoDelete('frmUser','HelperPages/DeleteUser.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtUserID" value="">
  </form>
  <p align="center" style="margin-bottom: 15">
    <font size="1" face="Verdana" color="#5373A2">
      Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
    </font>
  </p>

</body>
</html>
<script language="javascript">
  var strDisabled ="<%=strDisabled%>";
  document.onkeypress = checkCR;
  
  if (strDisabled =="true")
  {
    document.frmUser.chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.frmUser.chkAllDelete.disabled = false;
  }


  function goSubmit()
  {
    document.frmUser.action="User.aspx";
    document.frmUser.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>