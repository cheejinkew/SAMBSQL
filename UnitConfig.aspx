<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
  dim objConn
  dim strConn
  dim sqlRs
 
  dim strError
  dim strErrorColor
  dim strSiteVersionID = request.form("ddSite")
  dim intSelectedSiteID
  dim intSelectedVID
  dim strMode = request.form("ddMode")
  dim intSelectedDBPwd
  dim strSelectedPwd = request.form("txtPassword")

  dim strChkCenterNo = request.form("chkCenterNo")
  dim strCenterNo = request.form("txtCenterNo")
 
  dim strChkNewPass = request.form("chkNewPass")
  dim strNewPass = request.form("txtNewPass")

  dim strChkDateTime = request.form("chkDateTime")
  dim strDateTime = request.form("txtDateTime")
  dim strHr = request.form("txtHr")
  dim strMin = request.form("txtMin")
  dim strSec = request.form("txtSec")
 
  dim strChkHH = request.form("chkHH")
  dim strHH = request.form("txtHH")
  dim strChkH = request.form("chkH")
  dim strH = request.form("txtH")
  dim strChkL = request.form("chkL")
  dim strL = request.form("txtL")
  dim strChkLL = request.form("chkLL")
  dim strLL = request.form("txtLL")

  dim strLog = request.form("ddLog")
  dim strChkLog12am = request.form("chkLog12am")
  dim strChkLog8am = request.form("chkLog8am")
  dim strChkLog345pm = request.form("chkLog345pm")

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


  if strSiteVersionID <> "" and strSiteVersionID <> "0,0" then
    dim arrySiteVersionID = split(strSiteVersionID, ",")
    intSelectedSiteID = arrySiteVersionID(0)
    intSelectedVID = arrySiteVersionID(1)
    intSelectedDBPwd = arrySiteVersionID(3)
  else
    strSiteVersionID ="0,0"
    intSelectedSiteID = "0"
    intSelectedVID = "0"
  end if

  if strMode = "" then
    strMode ="0"
  end if

  if strLog = "" then
    strLog ="0"
  end if
 
  strConn = ConfigurationSettings.AppSettings("DSNPG") 
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  strError = request.form("txtError")
  strErrorColor = request.form("txtErrorColor")
%>
<html>

<head>
<title>Gussmann Vehicle Tracking System</title>
<script language="javascript" src="JavaScriptFunctions.js"></script>
<style>
.FormDropdown 
  {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    width: 98%;
    border-width: 1px;
    border-style: solid;
    border-color: #CBD6E4;
    color:#5F7AFC;
  }
.FormDropdown1
  {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    width: 130px;
    border-width: 1px;
    border-style: solid;
    border-color: #CBD6E4;
    color:#5F7AFC;
  }
.inputStyleX
{
	color: #0B3D62;
	font-size: 10pt;
	font-family: Verdana;
	font-weight: bolder;
	border-width: 0px;
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

.fontStyle 
  {
   font-family: Verdana, Arial;
   font-size: 11px;
   color: #4960F8
  }
</style>
</head>

<body>
<script language="JavaScript" src="TWCalendar.js"></script>

<form method="post" name="frmUnitConfig" action="UnitConfig.aspx">
<script language="javascript">DrawCalendarLayout();</script>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="26">
    <tr>
      <td width="100%" valign="top" height="6" colspan="2">
        <center><br><img border="0" src="images/UnitConfig.jpg"></center>
        <div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font>
          <table border="0" cellpadding="0" cellspacing="0" width="60%" style="border-width: 1px; border-style: solid; border-color: #9BA7FB">
            <tr>
              <td width="100%">
                <div align="center">
                  <table border="0" width="100%" cellpadding="2">
                    <tr>
                      <td width="100%" height="25" bgcolor="#9BA7FB" colspan="6">
                        <p align="center"><b><font face="Verdana" color="#000000" size="2">Site Selection</font></b>
                      </td>
                    </tr>
                    <tr>
                      <td width="10%" height="25"><b><font class="fontStyle">Site</font></b></td>
                      <td width="1%" height="25"><b>:</b></td>
                      <td width="89%" height="25" colspan="4">
                        <select name="ddSite" class="FormDropdown" onchange="javascript:setSelectedSite(this.value);">
                          <option value="0,0" > - Select Site -</option>
                          <%
                             dim intSiteID
                             dim strSite
                             dim intSimNo
                             dim strDBPwd
                             dim intVersionID
                             dim strSiteVersion
                             dim intUnitID
                     
                             objConn.open(strConn)
  
                             if arryControlDistrict(0) <> "ALL" then
                                  sqlRs.Open("SELECT simno, pwd, versionid, s.siteid, u.unitid, s.sitedistrict + ' : ' + " & _
                                          "s.sitetype + ' : ' + s.sitename as sites " & _
                                          "from telemetry_site_list_table s, unit_list u " & _
                                          "where s.sitedistrict in (" & strControlDistrict & ") " & _
                                          " and s.siteid NOT IN (" & strKontID & ") and s.unitid = u.unitid order by sitedistrict, sitetype, sitename", objConn)
                             else
                                  sqlRs.Open("SELECT simno, pwd, versionid, s.siteid, u.unitid, s.sitedistrict + ' : ' + " & _
                                          "s.sitetype + ' : ' + s.sitename as sites " & _
                                          "from telemetry_site_list_table s, unit_list u " & _
                                          "where s.unitid = u.unitid and s.siteid NOT IN (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                             end if
                             
                             do while not sqlRs.EOF
                               intSiteID = sqlRs("siteid").value
                               strSite = sqlRs("sites").value
                               intSimNo = sqlRs("simno").value
                               strDBPwd = sqlRs("pwd").value
                               intUnitID = sqlRs("unitid").value
                               intVersionID = sqlRs("versionid").value
                               strSiteVersion = intSiteID & "," & intVersionID & "," & intSimNo & "," & strDBPwd & "," & intUnitID
                          %>
                          <option value="<%=strSiteVersion%>"><%=strSite%></option>
                          <%

                               sqlRs.movenext
                             Loop
                
                             sqlRs.close()
                             objConn.close()
             
                          %>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <td width="10%" height="25"><b><font class="fontStyle">Mode</font></b></td>
                      <td width="1%" height="25"><b>:</b></td>
                      <td width="35%" height="25">
                        <select name="ddMode" class="FormDropdown1">
	                  <option value="0">- Select Mode -</option>
                          <option value="SMS">SMS</option>
                        </select>
                      </td>
                      <td width="20%" height="25" align="right"><b><font class="fontStyle">Password</font></b></td>
                      <td width="1%" height="25"><b>:</b></td>
                      <td width="33%" height="25"><font size="2">
                        <input name="txtPassword" value="<%=strSelectedPwd%>" type="text" size="15" class="inputStyle">
                        </font>
                      </td>
                    </tr>
                  </table>
                </div>
              </td>
            </tr>
          </table>
        </div>
        <br></td>
    </tr>

    <tr>
      <td width="100%" valign="top" height="25" colspan="2">
        <div align="center">
          <table border="0" cellpadding="0" cellspacing="0" width="60%" style="border-width: 1px; border-style: solid; border-color: #9BA7FB;">
            <tr>
              <td width="100%">
                <div align="center">
                  <table border="0" cellpadding="2" width="100%">
                    <tr>
                      <td width="100%" height="25" colspan="4" bgcolor="#9BA7FB">
                        <p align="center"><b><font  style="font-family: Verdana; font-size: 11px; color: #000000; size:2">SETTINGS</font></b>
                      </td>
                    </tr>
                    <tr>
                      <td width="10%" height="25" align="center">
                        <input id="chkCenterNo" type="checkbox" name="chkCenterNo" onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle">Center No</font></td>
                      <td width="60%" height="25" colspan="2"><font size="2">
                        <input name="txtCenterNo" type="text" size="20" maxlength="20" style="border-width: 1px; border-style: solid; border-color: #4960F8" value="<%=strCenterNo%>" disabled>
                        </font>
                      </td>
                    </tr>
                    <tr>
                      <td width="10%" height="25" align="center">
                        <input id="chkNewPass" type="checkbox" name="chkNewPass" onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle">New Password</font> </td>
                      <td width="60%" height="25" colspan="2"><font size="2">
                        <input name="txtNewPass" type="text" size="20" maxlength="10" style="border-width: 1px; border-style: solid; border-color: #4960F8" value="<%=strNewPass%>" disabled>
                        </font>
                      </td>
                    </tr>
                    <tr>
                      <td width="10%" height="25" align="center">
                        <input id="chkDateTime" type="checkbox" name="chkDateTime" onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle">Date/ Time&nbsp;&nbsp;</font></td>
                      <td width="30%" height="25" ><font size="2">
                        <input name="txtDateTime" type="text" size="20" style="border-width: 1px; border-style: solid; border-color:#4960F8" value="<%=strDateTime%>" readonly></font>
                      </td>
                      <td width="30%" height="25" ><font size="2">
                        <div id="calendar" style="width:30; visibility:hidden;">
                          <a href="javascript:ShowCalendar('txtDateTime', 160, 290);">
                            <img border="0" src="images/Calendar.jpg" align="bottom" style="border-width: 1px; border-style: solid; border-color: #4960F8">
                          </a>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td width="10%" height="25" align="center">
                      </td>
                      <td width="30%" height="25" align="center">
                        <p align="right"><font class="fontStyle">Hour:&nbsp;&nbsp; </font>
                      </td>
                      <td width="60%" height="25" colspan="2">
                        <font size="2">
                          <input name="txtHr" type="text" size="2" maxlength="2" style="border-width: 1px; border-style: solid; border-color:#4960F8" value="<%=strHr%>" onblur="javascript:IsInteger(this.value, this.name);" disabled>&nbsp;
                        </font><font class="fontStyle">Minute: </font><font size="2">
                          <input name="txtMin" type="text" size="2" maxlength="2" style="border-width: 1px; border-style: solid; border-color:#4960F8" value="<%=strMin%>" onblur="javascript:IsInteger(this.value, this.name);" disabled >&nbsp;
                       </font><font class="fontStyle">Second: </font><font size="2">
                          <input name="txtSec" type="text" size="2" maxlength="2" style="border-width: 1px; border-style: solid; border-color:#4960F8" value="<%=strSec%>" onblur="javascript:IsInteger(this.value, this.name);" disabled>
                       </font>
                     </td>
                   </tr>
                 </table>
               </div>
             </td>
           </tr>
         </table>
       </div>
       <br>
      </td>
    </tr>
    <tr>
      <td width="100%" valign="top" height="25" colspan="2">
       <center>
       <p>
       <a href="javascript:gotoSubmit()"><image src="images/Submit_s.jpg" style="border-width: 0px;"></a> 
       &nbsp;&nbsp;&nbsp;
       </p>  
       
       
       <p align="center" style="margin-bottom: 15">
         <font size="1" face="Verdana" color="#5373A2">
           Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
         </font>
       </p>

        </center>  
      </td>
    </tr>

    <tr>
      <td width="50%" valign="top" height="25">
        <div id="divThreshold" align="center" style="visibility:hidden;">
          <table border="0" cellpadding="0" cellspacing="0" width="80%" style="border-width: 1px; border-style: solid; border-color: #9BA7FB">
            <tr>
              <td width="100%">
                <div align="center">
                  <table border="0" width="100%" cellpadding="2">
                    <tr>
                      <td width="100%" bgcolor="#9BA7FB" colspan="3" height="25">
                        <p align="center"><b><font face="Verdana" color="#000000" size="2">Threshold</font></b></td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
                        <input id="chkHH" type="checkbox" name="chkHH"  onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>HH</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtHH" type="text" size="10" maxlength="5" style="border-width: 1px; border-style: solid; border-color:#4960F8"  value="<%=strHH%>" onblur="javascript:IsNumberDecimal(this.value, this.name);" disabled>
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
                        <input id="chkH" type="checkbox" name="chkH"  onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>H</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtH" type="text" size="10" maxlength="5" style="border-width: 1px; border-style: solid; border-color:#4960F8"  value="<%=strH%>" onblur="javascript:IsNumberDecimal(this.value, this.name);" disabled>
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
                        <input id="chkL" type="checkbox" name="chkL"  onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>L</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtL" type="text" size="10" maxlength="5" style="border-width: 1px; border-style: solid; border-color:#4960F8"  value="<%=strL%>" onblur="javascript:IsNumberDecimal(this.value, this.name);" disabled>
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
                        <input id="chkLL" type="checkbox" name="chkLL" onclick="javascript:DisabledText(this.id);" value="ON">
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>LL</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtLL" type="text" size="10" maxlength="5" style="border-width: 1px; border-style: solid; border-color:#4960F8"  value="<%=strLL%>" onblur="javascript:IsNumberDecimal(this.value, this.name);" disabled>
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                  </table>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </td>
      <td width="50%" valign="top" height="25">
        <div id="divRepoll" align="center" style="visibility:hidden;">
          <table border="0" cellpadding="0" cellspacing="0" width="80%" style="border-width: 1px; border-style: solid; border-color: #9BA7FB">
            <tr>
              <td width="100%">
                <div align="center">
                  <table border="0" cellpadding="2" width="100%">
                    <tr>
                      <td width="100%" height="25" colspan="3" bgcolor="#9BA7FB">
                        <p align="center"><b><font face="Verdana" color="#000000" size="2">Re-Poll Log Data</font></b></td>
                    </tr>
                    <tr>
                      <td width="20%" height="25" align="center">
                        <p align="left"><font class="fontStyle"><b>Log :</b></font>
                      </td>
                      <td width="80%" height="25" colspan="2">
                        <select id="ddLog" name="ddLog" class="FormDropdown1" onchange="javascript:DisabledText(this.id);">
	                  <option value="0">- Select Log -</option>
                          <option value="Today">Today</option>
                          <option value="Yesterday">Yesterday</option>
                          <option value="Both">Both</option>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <td width="20%" height="25" align="center">
                      </td>
                      <td width="5%" height="25" align="center">
                        <input id="chkLog12am" type="checkbox" name="chkLog12am" value="ON" disabled>
                      </td>
                      <td width="75%" height="25"><font class="fontStyle">12:00 am - 07:45 am</font></td>
                    </tr>
                    <tr>
                      <td width="20%" height="25" align="center">
                      </td>
                      <td width="5%" height="25" align="center">
                       <input id="chkLog8am" type="checkbox" name="chkLog8am" value="ON" disabled>
                      </td>
                      <td width="75%" height="25"><font class="fontStyle">08:00 am - 03:45 pm</font> </td>
                    </tr>
                    <tr>
                      <td width="20%" height="25" align="center">
                      </td>
                      <td width="5%" height="25" align="center">
                        <input id="chkLog345pm" type="checkbox" name="chkLog345pm" value="ON" disabled>
                      </td>
                      <td width="75%" height="25"><font class="fontStyle">03:45 pm - 11:45
                        pm&nbsp;</font></td>
                    </tr>
                  </table>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    
  </table>
  </center>
</div>
<input type="hidden" name="txtError" value="">
<input type="hidden" name="txtErrorColor" value="">
<input type="hidden" name="txtSiteVersionID" value="">
<input type="hidden" name="txtVersionID" value="">

</form>
</body>

</html>
<script language="javascript">
  var strSession = 'true';
  var strDBPwd = "<%=intSelectedDBPwd%>";
  var strVersion = "<%=intSelectedVID%>";
  var strChkCenterNo = "<%=strChkCenterNo%>";
  var strChkNewPass = "<%=strChkNewPass%>";
  var strChkDateTime ="<%=strChkDateTime%>";
  var strChkHH ="<%=strChkHH%>";
  var strChkH ="<%=strChkH%>";
  var strChkL ="<%=strChkL%>";
  var strChkLL ="<%=strChkLL%>";
  var strChkLog12am = "<%=strChkLog12am%>";
  var strChkLog8am = "<%=strChkLog8am%>";
  var strChkLog345pm = "<%=strChkLog345pm%>";

  document.frmUnitConfig.ddSite.value = "<%=strSiteVersionID%>";
  document.frmUnitConfig.txtSiteVersionID.value = "<%=strSiteVersionID%>";
  document.frmUnitConfig.ddMode.value = "<%=strMode%>";
  document.frmUnitConfig.ddLog.value = "<%=strLog%>";
  
  if (strChkCenterNo == "ON")
  {
  document.frmUnitConfig.chkCenterNo.checked = true;
  document.frmUnitConfig.txtCenterNo.disabled= false;
  }
  
  if (strChkNewPass == "ON")
  {
  document.frmUnitConfig.chkNewPass.checked = true;
  document.frmUnitConfig.txtNewPass.disabled= false;
  }
  if (strChkDateTime == "ON")
  {
  document.frmUnitConfig.chkDateTime.checked = true;
  document.frmUnitConfig.txtHr.disabled= false;
  document.frmUnitConfig.txtMin.disabled= false;
  document.frmUnitConfig.txtSec.disabled= false;
  document.getElementById("calendar").style.visibility= "visible";
  }

  if (strChkHH == "ON")
  {
  document.frmUnitConfig.chkHH.checked = true;
  document.frmUnitConfig.txtHH.disabled= false;
  }
  if (strChkH == "ON")
  {
  document.frmUnitConfig.chkH.checked = true;
  document.frmUnitConfig.txtH.disabled= false;
  }
  if (strChkL == "ON")
  {
  document.frmUnitConfig.chkL.checked = true;
  document.frmUnitConfig.txtL.disabled= false;
  }
  if (strChkLL == "ON")
  {
  document.frmUnitConfig.chkLL.checked = true;
  document.frmUnitConfig.txtLL.disabled= false;
  }

  if (document.frmUnitConfig.ddLog.value != "0")
  {
    document.frmUnitConfig.chkLog12am.disabled = false;
    document.frmUnitConfig.chkLog8am.disabled = false;
    document.frmUnitConfig.chkLog345pm.disabled = false;

    if (strChkLog12am == "ON")
    {
      document.frmUnitConfig.chkLog12am.checked = true;
    }
    if (strChkLog8am == "ON")
    {
      document.frmUnitConfig.chkLog8am.checked = true;
    }
    if (strChkLog345pm == "ON")
    {
      document.frmUnitConfig.chkLog345pm.checked = true;
    }
  }

  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

  
  if (strVersion =="M1" || strVersion =="M2" || strVersion =="M3" || strVersion =="M4" || strVersion =="M5")
  {
    document.getElementById("divThreshold").style.visibility= "visible";  
    document.getElementById("divRepoll").style.visibility= "visible";  
  }
  else
  {
    document.getElementById("divThreshold").style.visibility= "hidden";  
    document.getElementById("divRepoll").style.visibility= "hidden";  
  }

  var frmTargetForm = "frmUnitConfig";
  
  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
	document.getElementById("divTWCalendar").style.visibility = 'visible';
	document.getElementById("divTWCalendar").style.left = intLeft;
	document.getElementById("divTWCalendar").style.top = intTop;
  }

</script>
<script language="javascript" src="UnitConfig.js">
</script>
