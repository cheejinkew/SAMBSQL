<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlRs
   dim sqlRs1
   dim strConn
   dim intUserID
   dim intGetUserID
   dim strError
   dim strErrorColor
   dim strUsername
   dim strDisabled = "true"
   dim intSelectedSiteID = request.form("ddSite")

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

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   sqlRs1 = new ADODB.Recordset()
   
   if intSelectedSiteID = "" then
     intSelectedSiteID ="0"
   end if
   
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
      width: 280px;
      border: 1 solid #CBD6E4;
}
a { text-decoration: none;}
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>
<body>
  <form name="frmRule" method="post" action="UpdateRule.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="98%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/RuleMgmt.jpg">
            
          </td>
        </tr>
        <tr>
          <td width="9%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>Site</b></font></td>
          <td width="2%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="69%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddSite" class="FormDropdown" onchange="goSubmit();">
            <option value="0" > - Select Site -</option>
            <%
               dim strSite
               dim intSiteID
               
               objConn.open(strConn)
      
               if arryControlDistrict(0) <> "ALL" then
                 sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                            "from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") " & _
                            "order by sitedistrict, sitetype, sitename",objConn)
               else
                 sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                            "from telemetry_site_list_table order by sitedistrict, sitetype, sitename",objConn)
               end if
               
               do while not sqlRs.EOF
                 strSite = sqlRs("sites").value
                 intSiteID = sqlRs("siteid").value
            %>
            <option value="<%=intSiteID%>"><%=strSite%></option>
            <%

                 sqlRs.movenext
               Loop
                
               sqlRs.close()
               objConn.close()
               objConn = nothing
               
            %>
            </select>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            </font>
          </td>
          <td width="20%" height="30">
            <p align="right"><b><font size="1" face="Verdana"><a href="AddRule.aspx">Add New Rule</a></font></b></td>
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="98%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%">
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmRule')">
            </th>
            <th width="14%">Alarm</th>
            <th width="17%">Formula</th>
            <th width="7%">Mode</th>
            <th width="26%">Equipment</th>
            <th width="12%">Version:Unit</th>
            <th width="8%">Dispatch</th>
            <th width="6%">Color</th>

            
          </tr>
      
          <%
              
             dim intNum = 0
             dim strAlarmtype
             dim strMultiplier
             dim strDispatch
             dim strAlarmMode
             dim intPosition
             dim intVersionID
             dim intUnitID
             dim strEquipType
             dim intRuleID
             dim strColorCode
             
             objConn = new ADODB.Connection()
             objConn.open(strConn)
             
             sqlRs.Open("Select * from telemetry_rule_list_table where siteid ='" & intSelectedSiteID & "'",objConn)
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
             do while not sqlRs.EOF
               intRuleID =  sqlRs("ruleid").value
               strAlarmtype = sqlRs("alarmtype").value
               strMultiplier = sqlRs("multiplier").value
               
               if sqlRs("dispatch").value = 0 then
                 strDispatch = "FALSE"
               else
                 strDispatch = "TRUE"
               end if
               
               
               strAlarmMode = sqlRs("alarmmode").value
               intPosition = sqlRs("position").value
               intVersionID = sqlRs("versionid").value
               intUnitID = sqlRs("unitid").value
               strColorCode = sqlRs("colorcode").value

               select case strColorCode
                 case  "FFFFFF"
                 strColorCode = "White"
                 case  "FF0000"
                 strColorCode = "Red"
                 case  "FF7636"
                 strColorCode = "Orange"
                 case  "FFFF00"
                 strColorCode = "Yellow"
                 case  "00FF00"
                 strColorCode = "Green"
                 case  "0000FF"
                 strColorCode = "Blue"
                 case  "C0C0C0"
                 strColorCode = "Grey"
               end select

               sqlRs1.Open("select ""desc"" from telemetry_equip_list_table" & _
                           " where siteid ='" & intSelectedSiteID & _
                           "' and position=" & intPosition, objConn)
               if not sqlRs1.EOF then
                 strEquipType =  sqlRs1("desc").value
               end if
               sqlRs1.close()

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
            <input type="checkbox" name="chkDelete" value="<%=intRuleID%>">
          </td>
          <td style="margin-left: 5"><%=strAlarmtype%></td>
          <td style="margin-left: 5"><%=strMultiplier%></td>
          <td style="margin-left: 5"><%=strAlarmMode%></td>
          <td style="margin-left: 5"><%=strEquipType%></td>
          <td style="margin-left: 5"><%=intVersionID%> : <%=intUnitID%></td>
          <td style="margin-left: 5"><%=strDispatch%></td>
          <td style="margin-left: 5"><%=strColorCode%></td>
         </tr>
         <%
               
               sqlRs.movenext
             Loop
             sqlRs.close()
             objConn.close()
             sqlRs = nothing
             sqlRs1 = nothing
             objConn = nothing
          %>

       <tr>
         <td colspan="6">
           <br>
           <br>
           <%if strDisabled ="false" then%>
           <a href="javascript:gotoDelete('frmRule','HelperPages/DeleteRule.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtRule" value="">
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
  document.forms(0).ddSite.value="<%=intSelectedSiteID%>";
  
  if (strDisabled =="true")
  {
    document.forms(0).chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.forms(0).chkAllDelete.disabled = false;
  }


  function goSubmit()
  {
    document.forms(0).action="Rule.aspx";
    document.forms(0).submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Time Up");
    top.location.href = "login.aspx";
  }

</script>