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
    Dim strDisabled = "true"
   dim strSelectedSiteDistrict = request.form("ddDistrict")

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
   
   if strSelectedSiteDistrict = "" then
     strSelectedSiteDistrict ="0"
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
  <form name="frmSite" method="post" action="UpdateSite.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/SiteMgmt.jpg">
            
          </td>
        </tr>
        <tr>
          <td width="9%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>District</b></font></td>
          <td width="2%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="39%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddDistrict" class="FormDropdown" onchange="goSubmit();">
            <option value="0" > - Select District -</option>
            <%
                Dim strSiteDistrict = "Besut"
               
               
                'objConn.open(strConn)

                'if arryControlDistrict(0) <> "ALL" then
                '  sqlRs.Open("SELECT distinct sitedistrict from telemetry_site_list_table " & _
                '             "where sitedistrict in (" & strControlDistrict & ")",objConn)
                'else
                '  sqlRs.Open("SELECT distinct sitedistrict from telemetry_site_list_table",objConn)
                'end if
               
                ' Do While Not sqlRs.EOF
                    
                   
                    
                '     strSiteDistrict = sqlRs("sitedistrict").value
            %>
            <option value="<%=strSiteDistrict%>"><%=strSiteDistrict%></option>
            <%

                '  sqlRs.movenext
                'Loop
                
            
            
                'sqlRs.close()
                'objConn.close()
                'objConn = nothing
               
            %>
            </select>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            </font>
          </td>
          <td width="50%" height="30"><p align="right"><b><font size="1" face="Verdana"><a href="MelakaAddSite.aspx">Add New Site</a></font></b></p></td> 
         </tr>
      </table>
    </div>
    <center>
        <table border="0" width="70%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%">
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmSite')">
            </th>
            <th width="50%">Site</th>
            <th width="15%">Unit ID</th>
            <th width="35%">Associate</th>

            
          </tr>
      
          <%
             dim intSiteID
             dim intUnitID
             dim strSiteName
             dim strSiteType
             dim intNum = 0
             dim intAsscID
              Dim strAsscSite
              
              Dim arr1 As New ArrayList
              Dim s As New Integer
               
             objConn = new ADODB.Connection()  
             objConn.open(strConn)
              sqlRs.Open("select siteid, unitid, sitename, sitetype, associate ,site_tele" & _
                        " from telemetry_site_list_table " & _
                        " where sitedistrict ='" & strSelectedSiteDistrict & "'" & _
                        " and siteid in ('STEF','STF1','STF0','F330') order by sitetype, sitename", objConn)
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
              Do While Not sqlRs.EOF
                  arr1.Add(sqlRs("site_tele").value)
               
                  intSiteID = sqlRs("siteid").value
                  intUnitID = sqlRs("unitid").value
                  strSiteName = sqlRs("sitename").value
                  strSiteType = sqlRs("sitetype").value
                  intAsscID = sqlRs("associate").value
                  If intAsscID <> "None" Then
                      strAsscSite = sqlRs1.Open("select sitetype || ' : ' || sitename as sites " & _
                                  "from telemetry_site_list_table where siteid ='" & _
                                   intAsscID & "'", objConn)
                      If Not sqlRs1.EOF Then
                          strAsscSite = sqlRs1("sites").value
                      End If
                      For s = 0 To arr1.Count - 1
                          If sqlRs("site_tele").Value = "True" Then
                              
                          
                              Do While (arr1.Item(s)).EOF
                                  strAsscSite.Items(s + 1).Attributes.Add("style", "color:blue")
                                  'Else
                                  '        ddDistrict.Items(s + 1).Attributes.Add("style", "color:red")
                              Loop
                          End If
                      Next
              sqlRs1.close()
                  Else
              strAsscSite = "None"
                  End If
               
              If intNum = 0 Then
                  intNum = 1

           %>

	<tr bgcolor="#FFFFFF">
          <%
	       elseif intNum = 1 then
	         intNum = 0
	  %>
	<tr bgcolor="#E7E8F8">
	  <%
	  End If
	  
          %>
          <td width="1%">
            <input type="checkbox" name="chkDelete" value="<%=intSiteID%>">
          </td>
          <td style="margin-left: 5"><b>
            <a href="javascript:gotoUpdate('frmSite', 'txtSiteID','<%=intSiteID%>');">
               <%=strSiteType%> : <%=strSiteName%>
            </a></b>
          </td>
          <td style="margin-left: 5"><%=intUnitID%></td>
          <td style="margin-left: 5"><%=strAsscSite%></td>
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
           <a href="javascript:gotoDelete('frmSite','HelperPages/DeleteSite.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtSiteID" value=""/>
     </center> 
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
  document.frmSite.ddDistrict.value="<%=strSelectedSiteDistrict%>";
  
  if (strDisabled =="true")
  {
    document.frmSite.chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.frmSite.chkAllDelete.disabled = false;
  }


  function goSubmit()
  {
    document.frmSite.action="MelakaSite.aspx";
    document.frmSite.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }

</script>