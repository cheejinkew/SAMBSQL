<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlRs
   dim strConn
   dim intUserID
   dim strError
   dim strErrorColor
   dim strUsername
   dim strDisabled = "true"
   dim strCltDis
   dim strUIDCltDistr = request.form("ddUser")
   dim arryUIDCltDistr
   dim intGetUserID
   dim strSelectedCltDis
   
   if strUIDCltDistr <> "" then
     arryUIDCltDistr = split(strUIDCltDistr, ",")
     intGetUserID = arryUIDCltDistr(0)
     strSelectedCltDis = arryUIDCltDistr(1)
   else
     strUIDCltDistr ="0,0"
     intGetUserID = "0"
     strSelectedCltDis = "0"
   end if

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
  <form name="frmUnit" method="post" action="UpdateUnit.aspx">
    <input type="hidden" name="txtUserID" value="">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/UnitMgmt.jpg">
          </td>
        </tr>
        <tr>
          <td width="9%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>User</b></font></td>
          <td width="2%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="39%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddUser" class="FormDropdown" onchange="goSubmit();">
            <option value="0,0" > - Select User -</option>
            <%
               objConn.open(strConn)

               if arryControlDistrict(0) <> "ALL" then
               sqlRs.Open("SELECT username, userid, control_district from telemetry_user_table " & _
                          " where control_district in ('" & strFullControlDistrict & "'," & strControlDistrict & ")" & _
                          " order by username", objConn)
               else
               sqlRs.Open("SELECT username, userid, control_district from telemetry_user_table " & _
                          " order by username", objConn)
               end if

               do while not sqlRs.EOF
                 strUsername = sqlRs("username").value
                 intUserID = sqlRs("userid").value
                 strCltDis = sqlRs("control_district").value
            %>
            <option value="<%=intUserID%>,<%=strCltDis%>"><%=strUsername%></option>
            <%

                 sqlRs.movenext
               Loop
                
               sqlRs.close()
               objConn.close()
               objConn = nothing
               
            %>
            </select>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
           </font></td>

          <td width="50%" height="30">
            <p align="right"><b><font size="1" face="Verdana"><a href="AddUnit.aspx?user=<%=strUIDCltDistr%>">Add New Unit</a></font></b></td>
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="70%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%">
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmUnit')">
            </th>
            <th width="40%">Unit</th>
            <th width="30%">SIM No</th>
            <th width="30%">Password</th>

            
          </tr>
      
          <%
             dim strPassword
             dim strSIMNo
             dim intVersionID
             dim intUnitID
             dim intVID
             dim intNum = 0
               
             objConn = new ADODB.Connection()
             objConn.open(strConn)

             if strSelectedCltDis <> "ALL" then
                  sqlRs.Open("select pwd, simno, unitid, versionid, unitid + ', ' + versionid as vid " & _
                        " from unit_list " & _
                        " where userid = '" & intGetUserID & "' order by unitid, versionid", objConn)
             else
                  sqlRs.Open("select pwd, simno, unitid, versionid, unitid + ', ' + versionid as vid " & _
                        " from unit_list " & _
                        " order by unitid, versionid", objConn)
             end if
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
             do while not sqlRs.EOF
               
               strPassword = sqlRs("pwd").value
               strSIMNo = sqlRs("simno").value
               intVersionID = sqlRs("versionid").value
               intUnitID = sqlRs("unitid").value
               intVID = sqlRs("vid").value
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
            <input type="checkbox" name="chkDelete" value="<%=intVID%>">
          </td>
          <td style="margin-left: 5"><b><a href="javascript:gotoUpdate('frmUnit', 'txtVehicleID','<%=intVID%>');"><%=intUnitID%> : <%=intVersionID%></a><b></td>
          <td style="margin-left: 5"><%=strSIMNo%></td>
          <td style="margin-left: 5"><%=strPassword%></td>
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
           <a href="javascript:gotoDelete('frmUnit','HelperPages/DeleteUnit.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtVehicleID" value="">
     <p align="center" style="margin-bottom: 15">
       <font size="1" face="Verdana" color="#5373A2">
         Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
       </font>
     </p>

  </form>
</body>
</html>
<script language="javascript">
  var strDisabled ="<%=strDisabled%>";
  document.onkeypress = checkCR;
  document.frmUnit.ddUser.value="<%=strUIDCltDistr%>";
  

  
  if (strDisabled =="true")
  {
    document.frmUnit.chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.frmUnit.chkAllDelete.disabled = false;
  }


  function goSubmit()
  {
    document.frmUnit.action="Unit.aspx";
    document.frmUnit.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>