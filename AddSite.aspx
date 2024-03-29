<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<script language="javascript">

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

</script>
<%
   dim objConn
   dim strConn
   dim sqlRs
   dim strError
   dim strErrorColor
   dim intUnitID
   dim intAsscID
   dim intSelectedUnitID = request.form("ddUnit")
   dim intSelectedAsscID = request.form("ddAssociate")
   dim strSelectedSite = request.form("ddDistrict")
   dim strSelectedSiteID = request.form("txtSiteID")
   dim strSelectedSiteType = request.form("txtSiteType")
   dim strSelectedSiteName = request.form("txtSiteName")
   dim intLat = session("Lat")
   dim intLon = session("Lon")
   dim strComment = request.form("txtComment")
   dim strAddress = request.form("txtAddress")
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

   if intLat = 0 then
     intLat = request.form("txtLat")
   end if
  
   if intLon = 0 then
     intLon = request.form("txtLon")
   end if
  
   if intSelectedUnitID ="" then 
     intSelectedUnitID ="0"
   end if
 
   if strSelectedSite ="" then 
     strSelectedSite ="0"
   end if

   if intSelectedAsscID ="" then 
     intSelectedAsscID ="0"
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
    width: 158px;
    border-width: 1px;
    border-style: solid;
    border-color: #CBD6E4;
    color:#5373A2;
  }

.FormDropdown1 
  {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    width: 200px;
    border-width: 1px;
    border-style: solid;
    border-color: #CBD6E4;
    color:#5373A2;
  }
.inputStyle
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
<form name="frmAddSite" method="post" action="AddSite.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/AddSite.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="400" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="350" height="63">
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">District</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25"><font color="#0B3D62">
                <select name="ddDistrict" class="FormDropdown" onchange="javascript:document.frmAddSite.submit();">
                  <option value="0" > - Select District -</option>
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
              </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Unit ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                
                <select name="ddUnit" class="FormDropdown">
                  <option value="0" > - Select Unit -</option>
                  <%
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
 
                      sqlRs.Open("SELECT unitid as unit from unit_list where unitid not in( select unitid from telemetry_site_list_table) order by unitid", objConn)
                    
                    do while not sqlRs.EOF
                          intUnitID = sqlRs("unit").value
                          
                   %>
                   <option value="<%=intUnitID%>"><%=intUnitID%></option>
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
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Associate</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <select name="ddAssociate" class="FormDropdown1">
                  <option value="0" > - Select Associate -</option>
                  <option value="None" > None</option>
                  <%
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                      
                      sqlRs.Open("SELECT distinct (siteid) as site, sitetype,sitename" & _
                               " from telemetry_site_list_table where sitedistrict='" & strSelectedSite & "' and siteid not in (" & strKontID & ") order by siteid,sitename,sitetype", objConn)
                    
                      Do While Not sqlRs.EOF
                          Dim strCom As String = sqlRs("sitetype").value & " : " & sqlRs("sitename").value
                          intAsscID = sqlRs("site").value
                   %>
                   <option value="<%=intAsscID%>"><%=strCom%></option>
                   <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    sqlRs = nothing
                    objConn = nothing
                  %>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteID" class="inputStyle" value="<%=strSelectedSiteID%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site Type</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteType" class="inputStyle" value="<%=strSelectedSiteType%>">
                </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site Name</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteName" class="inputStyle" value="<%=strSelectedSiteName%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Latitude</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtLat" class="inputStyle" value="<%=intLat%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Longitute</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtLon" class="inputStyle" value="<%=intLon%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Comment</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtComment" class="inputStyle" value="<%=strComment%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Address</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <textarea name="txtAddress" rows=3 class="inputStyle"></textarea>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"></td>
              <td width="16" height="26"></td>
              <td width="325" height="26">
                <p align="right">
          
                <a href="javascript:goAddSite()"><img src="images/Submit_s.jpg" border=0></a>
              
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
    Copyright � 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
</body>

</html>
<script language="javascript">

 document.frmAddSite.ddUnit.value = '<%=intSelectedUnitID%>';
 document.frmAddSite.ddDistrict.value = '<%=strSelectedSite%>';
 document.frmAddSite.ddAssociate.value = '<%=intSelectedAsscID%>';
 document.frmAddSite.txtAddress.value = '<%=strAddress%>';

  document.onkeypress = checkCR;
  
  
  function goAddSite()
  {
    if (document.frmAddSite.ddDistrict.value=="0")
    {
      document.frmAddSite.txtError.value = "Please Select District !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else if (document.frmAddSite.ddUnit.value=="0")
    {
      document.frmAddSite.txtError.value = "Please Select Unit !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else if (document.frmAddSite.ddAssociate.value=="0")
    {
      document.frmAddSite.txtError.value = "Please Select Associate !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else if (document.frmAddSite.txtSiteID.value=="")
    {
      document.frmAddSite.txtError.value = "Please Enter Site ID !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else if (document.frmAddSite.txtSiteType.value=="")
    {
      document.frmAddSite.txtError.value = "Please Enter Site Type !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else if (document.frmAddSite.txtSiteName.value=="")
    {
      document.frmAddSite.txtError.value = "Please Enter Site Name !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else if (document.frmAddSite.txtAddress.value=="")
    {
      document.frmAddSite.txtError.value = "Please Enter Site Addrress !";
      document.frmAddSite.txtErrorColor.value = "red";
    }
    else
    {
      document.frmAddSite.action="HelperPages/AddSite.aspx";
      document.frmAddSite.submit();
      return;
    }
   document.frmAddSite.submit();
  }
</script>

