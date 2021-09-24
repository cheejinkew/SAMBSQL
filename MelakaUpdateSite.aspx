<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
 dim objConn
 dim strConn
 dim sqlRs
 dim strError
 dim strErrorColor
 dim intSiteID  = request.form("txtSiteID")
 dim intSelectedUnitID 
 dim intSelectedAsscID
 dim strSiteDistrict
 dim strSiteType
 dim strSiteName
 dim intLat
 dim intLon
 dim strComment
 dim strAddress



 strConn = ConfigurationSettings.AppSettings("DSNPG") 
 objConn = new ADODB.Connection()
 sqlRs = new ADODB.Recordset()

 objConn.open(strConn)
 sqlRs.Open("SELECT unitid, siteid, sitetype, sitename, sitedistrict, associate , lat, lon, comment, address from telemetry_site_list_table " & _
            "where siteid = '" & intSiteID & "'", objConn)
                    
  if not sqlRs.EOF then
   strSiteDistrict = sqlRs("sitedistrict").value
   intSelectedUnitID = sqlRs("unitid").value 
   intSelectedAsscID = sqlRs("associate").value 
   strSiteType = sqlRs("sitetype").value
   strSiteName = sqlRs("sitename").value
   intLat = sqlRs("lat").value
   intLon = sqlRs("lon").value
   strComment = sqlRs("comment").value
   strAddress = sqlRs("address").value
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
.inputStyleX
{
	color: #0B3D62;
	font-size: 10pt;
	font-family: Verdana;
	border: 0;
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
<form name="frmUpdateSite" method="post" action="UpdateSite.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdateSite.jpg">
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
                <input type="text" name="txtDistrict" class="inputStyleX" value="<%=strSiteDistrict%>" readonly>
              </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Unit
                ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <select name="ddUnit" class="FormDropdown">
                  <option value="0" >- Select Unit -</option>
                  <option value="<%=intSelectedUnitID%>"><%=intSelectedUnitID%></option>
                  <%
                    dim intUnitID
                    
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
 
                    sqlRs.Open("SELECT unitid from unit_list where unitid not in(" & _
                               "select unitid from telemetry_site_list_table) order by unitid", objConn)
                    
                    do while not sqlRs.EOF
                      intUnitID = sqlRs("unitid").value
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
                  <option value="0" >- Select Associate -</option>
                  
                    <option value="None" > None</option>
                  
                  <%
                    dim intAsscID
                    
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
 
                    sqlRs.Open("SELECT distinct (siteid), sitetype, sitetype || ' : ' || sitename as sites " & _
                               " from telemetry_site_list_table where sitedistrict='" & strSiteDistrict & "'" & _
                               " order by sitetype", objConn)
                    
                    do while not sqlRs.EOF
                      intAsscID = sqlRs("siteid").value
                   %>
                   <option value="<%=intAsscID%>"><%=sqlRs("sites").value%></option>
                   <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    sqlRs =nothing
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
                <input type="text" name="txtSiteID" class="inputStyleX" value="<%=intSiteID%>" ReadOnly>
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site Type</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteType" class="inputStyleX" value="<%=strSiteType%>" ReadOnly>
                </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site Name</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteName" class="inputStyle" value="<%=strSiteName%>">
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
  </center>
              <td width="325" height="26">
                <p align="right">
                <a href="javascript:goAddSite()"><img src="images/Submit_s.jpg" border=0></a>&nbsp;&nbsp;
                <a href="javascript:goShowUpload()"><img src="images/LoadImage.jpg" border=0></a>
              
              &nbsp;&nbsp;&nbsp;
               </td>
            </tr>
          </table>
        </div>


      </td>
    </tr>
  </table>
</div>
<div align="center" id="divUploadImage" style="visibility:hidden;">
  <iframe ID="Upload" SRC="Upload.aspx?test=<%=intSiteID%>"  style="width: 410; height:130" allowautotransparency="true" frameborder=0 scrolling="no">
  </iframe>
</div>

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

  document.frmUpdateSite.ddUnit.value = "<%=intSelectedUnitID%>"; 
  document.frmUpdateSite.ddAssociate.value = "<%=intSelectedAsscID%>"; 
  document.frmUpdateSite.txtAddress.value = '<%=strAddress%>';

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goAddSite()
  {
    if (document.frmUpdateSite.ddUnit.value=="0")
    {
      document.frmUpdateSite.txtError.value = "Please Select Unit !";
      document.frmUpdateSite.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateSite.ddAssociate.value=="0")
    {
      document.frmUpdateSite.txtError.value = "Please Select Associate !";
      document.frmUpdateSite.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateSite.txtSiteName.value=="")
    {
      document.frmUpdateSite.txtError.value = "Please Enter Site Name !";
      document.frmUpdateSite.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateSite.txtLat.value=="")
    {
      document.frmUpdateSite.txtError.value = "Please Enter Latitude !";
      document.frmUpdateSite.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateSite.txtLon.value=="")
    {
      document.frmUpdateSite.txtError.value = "Please Enter Longitude !";
      document.frmUpdateSite.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateSite.txtAddress.value=="")
    {
      document.frmUpdateSite.txtError.value = "Please Enter Site Addrress !";
      document.frmUpdateSite.txtErrorColor.value = "red";
    }
    else
    {
      document.frmUpdateSite.action="HelperPages/UpdateSite.aspx";
      document.frmUpdateSite.submit();
    }
   document.frmUpdateSite.submit();
  }

  function goShowUpload()
  {
    document.getElementById("divUploadImage").style.visibility= "visible";  
  }

</script>

