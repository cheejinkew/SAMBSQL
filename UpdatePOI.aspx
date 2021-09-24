<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
 dim objConn
 dim strConn
 dim sqlRs
 dim strError
 dim strErrorColor
    Dim intSiteID = Request.QueryString("SiteID")
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
<form name="frmUpdatePOI" method="post" action="UpdatePOI.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdatePOI.jpg">
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
                <input type="text" name="ddUnit" class="inputStyleX" value="<%=intSelectedUnitID%>" readonly="readonly">
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Associate</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="ddAssociate" class="inputStyleX" value="<%=intSelectedAsscID%>" readonly="readonly">
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site ID</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteID" class="inputStyleX" value="<%=intSiteID%>" readonly=readonly>
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site Type</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteType" class="inputStyleX" value="<%=strSiteType%>" readonly=readonly>
                </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site Name</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSiteName" class="inputStyleX" value="<%=strSiteName%>" readonly=readonly>
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
                <input type="text" name="txtComment" class="inputStyleX" value="<%=strComment%>" readonly=readonly>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Address</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <textarea name="txtAddress" rows=3 class="inputStyleX" readonly=readonly></textarea>
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

  //document.frmUpdatePOI.ddUnit.value = "<%=intSelectedUnitID%>"; 
  //document.frmUpdatePOI.ddAssociate.value = "<%=intSelectedAsscID%>"; 
  //document.frmUpdatePOI.txtAddress.value = '<%=strAddress%>';

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goAddSite()
  {
    var submit=0;
   if (document.frmUpdatePOI.txtLat.value=="")
    {
      document.frmUpdatePOI.txtError.value = "Please Enter Latitude !";
      document.frmUpdatePOI.txtErrorColor.value = "red";
    }
    else if (document.frmUpdatePOI.txtLon.value=="")
    {
      document.frmUpdatePOI.txtError.value = "Please Enter Longitude !";
      document.frmUpdatePOI.txtErrorColor.value = "red";
    }
    else
    {
    submit=1;
     document.frmUpdatePOI.action="HelperPages/UpdatePOI.aspx";
     document.frmUpdatePOI.submit();
    }
    if(submit==0)
    {
   document.frmUpdatePOI.action="UpdatePOI.aspx?SiteID=<%=intSiteID %>";
   document.frmUpdatePOI.submit();
   }
  }

  function goShowUpload()
  {
    document.getElementById("divUploadImage").style.visibility= "visible";  
  }

</script>

