<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlRs
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
      width: 80%;
      border-width: 1px;
      border-style: solid;
      border-color: #CBD6E4;
}
a { text-decoration: none;}
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>
<body>
  <form name="frmEquip" method="post" action="UpdateEquipment.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="98%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/EquipMgmt.jpg">
            
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
                    sqlRs.Open("SELECT siteid, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                            "from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") " & _
                            "and siteid NOT IN (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
               else
                    sqlRs.Open("SELECT siteid, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                            "from telemetry_site_list_table where siteid NOT IN (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
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
            <p align="right"><b><font size="1" face="Verdana"><a href="AddEquipment.aspx">Add New Equipment</a></font></b></td>
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="98%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%">
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmEquip')">
            </th>
            <th width="32%">Equipment</th>
            <th width="15%">Version:Unit</th>
            <th width="35%">Multiplier</th>
            <th width="10%">Measure</th>
            <th width="8%">Max</th>

            
          </tr>
      
          <%
              
             dim intNum = 0
             dim intIndex
             dim intPosition
             dim strEquipName
             dim strUnit
             dim strMultiplier
             dim intMeasure 
             dim intMax 
                            
             objConn = new ADODB.Connection()  
             objConn.open(strConn)
             
              sqlRs.Open("select Iindex , position, sdesc as equip, " & _
                        "versionid + ' : ' + unitid as unit, multiplier, measurement, max " & _
                        "from telemetry_equip_list_table where siteid ='" & intSelectedSiteID & "'", objConn)
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             do while not sqlRs.EOF
               intIndex = sqlRs("Iindex").value
               intPosition = sqlRs("position").value
               strEquipName = sqlRs("equip").value
               if strEquipName ="-" then
                 strEquipName ="N/A"
               end if
               
               strUnit = sqlRs("unit").value
               strMultiplier = sqlRs("multiplier").value
               intMeasure = sqlRs("measurement").value
               intMax = sqlRs("max").value

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
            <input type="checkbox" name="chkDelete" value="<%=intIndex%>|<%=intPosition%>">
          </td>
          <td style="margin-left: 5"><b>
            <a href="javascript:gotoUpdate('frmEquip', 'txtEquipID','<%=intIndex%>,<%=intPosition%>')">
               <%=strEquipName%>
            </a></b>
          </td>
          <td style="margin-left: 5"><%=strUnit%></td>
          <td style="margin-left: 5"><%=strMultiplier%></td>
          <td style="margin-left: 5"><%=intMeasure%></td>
          <td style="margin-left: 5"><%=intMax%></td>
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
           <a href="javascript:gotoDelete('frmEquip','HelperPages/DeleteEquipment.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtEquipID" value="">
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
  document.frmEquip.ddSite.value="<%=intSelectedSiteID%>";
  
  if (strDisabled =="true")
  {
    document.frmEquip.chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.frmEquip.chkAllDelete.disabled = false;
  }


  function goSubmit()
  {
    document.frmEquip.action="Equipment.aspx";
    document.frmEquip.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>