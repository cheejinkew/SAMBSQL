<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
  dim objConn
  dim strConn
  dim sqlRs
  dim sqlRs1
  dim strError
  dim strErrorColor
  
  dim intSiteID = request.form("ddSite")
  
  dim strSelectedSite
  dim strSelectedUnit
  dim strSelectedType
  dim strSelectedDesc
  dim strSelectedName
  dim strSelectedMult
  dim strSelectedMeasure
  dim intSelectedMax
  
  dim intEquipID = request.form("txtEquipID")
  dim arryTmp = split(intEquipID, ",")
  dim intSelectedIndex = arryTmp(0)

  dim intSelectedPosition = arryTmp(1)
  dim intWrongPosition = request.form("txtWrongPosition")

  

  strConn = ConfigurationSettings.AppSettings("DSNPG") 
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  objConn.open(strConn)
 
    sqlRs.Open("SELECT sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
             "from telemetry_site_list_table where siteid='" & intSiteID & "'", objConn)
  if not sqlRs.EOF
    strSelectedSite = sqlRs("sites").value
  end if
  sqlRs.close()

    sqlRs.Open("SELECT versionid, unitid, multiplier, measurement, max, sitetype, equiptype, equipname, sdesc as name " & _
               "from telemetry_equip_list_table where siteid='" & intSiteID & "' " _
               & " and iindex='" & intSelectedIndex & "' and position ='" & intSelectedPosition & "'", objConn)
             
  if not sqlRs.EOF
    strSelectedUnit = sqlRs("versionid").value & " : " & sqlRs("unitid").value
    strSelectedName = sqlRs("equipname").value
    strSelectedMult = sqlRs("multiplier").value
    strSelectedMeasure = sqlRs("measurement").value
    intSelectedMax = sqlRs("max").value
    strSelectedType = sqlRs("equiptype").value
    strSelectedDesc = sqlRs("name").value
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
    width: 280px;
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
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>

<body>
<form name="frmUpdateEquip" method="post" action="UpdateEquipment.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdateEquip.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="500" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="450" height="63">
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Site</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSite" class="inputStyleX" size = "40" readonly value="<%=strSelectedSite%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Unit</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtUnit" class="inputStyleX" readonly value="<%=strSelectedUnit%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Equipment Type</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <select name="ddType" class="FormDropdown1">
                  <option value="0" > - Select Equipment Type -</option>
                  <option value="CHLORINE ANALYSER">Chlorine Analyzer</option>
                  <option value="DATE">Date</option>
                  <option value="FLOW METER">Flow Meter</option>
                  <option value="INTERVAL">Interval</option>
                  <option value="LEVEL METER">Level Meter</option>
                  <option value="MAIN PUMP">Main Pump</option>
                  <option value="PH ANALYZER">PH Analyzer</option>
                  <option value="POWER METER">Power Meter</option>
                  <option value="PRESSURE METER">Pressure Meter</option>
                  <option value="SUB PUMP">Sub Pump</option>
                  <option value="TIME">Time</option>
                  <option value="TURBIDITY">Turbidity</option>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Description</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <select name="ddDesc" class="FormDropdown1">
                  <option value="0" > - Select Description -</option>
                   <option value="B/WASH FLOW METER">B/Wash Flow Meter</option>
                   <option value="CHLORINE ANALYZER">Chlorine Analyzer</option>
                   <option value="DATE">Date</option>
                   <option value="LEVEL SENSOR 1 (STORAGE)">Level Sensor 1 (Storage)</option>
                   <option value="LEVEL SENSOR 1 (SUCTION)">Level Sensor 1 (Suction)</option>
                   <option value="LEVEL SENSOR 2 (STORAGE)">Level Sensor 2 (Storage)</option>
                   <option value="LEVEL SENSOR 2 (SUCTION)">Level Sensor 2 (Suction)</option>
                   <option value="PH ANALYZER">PH Analyzer</option>
                   <option value="PRESSURE METER 2">Pressure Meter 2</option>
                   <option value="PRESSURE SENSOR 1">Pressure Sensor 1</option>
                   <option value="PRESSURE SENSOR 2">Pressure Sensor 2</option>
                   <option value="RAW FLOW METER">Raw Flow Meter</option>
                   <option value="REPORT INTERVAL">Report Interval</option>
                   <option value="TIME">Time</option>
                   <option value="TREATED FLOW METER">Treated Flow Meter</option>
                   <option value="TREATED FLOW METER 1">Treated Flow Meter 1</option>
                   <option value="TREATED FLOW METER 2">Treated Flow Meter 2</option>
                   <option value="TURBIDITY">Turbidity</option>
                   </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Equipment Name</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtName" class="inputStyle" size="25" value="<%=strSelectedName%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Multiplier</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtMult" class="inputStyle" size="25" value="<%=strSelectedMult%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Measurement</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtMeasure" class="inputStyle" size="25" value="<%=strSelectedMeasure%>">
               </td>
            </tr>
             <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Index</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtIndex" class="inputStyleX" readonly value="<%=intSelectedIndex%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Position</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <%if intWrongPosition ="" then%>
                  <input type="text" name="txtPosition" class="inputStyle" size="5" value="<%=intSelectedPosition%>">
                <%else%>
                  <input type="text" name="txtPosition" class="inputStyle" size="5" value="<%=intWrongPosition%>">
                <%end if%>
               
               
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Max</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtMax" class="inputStyle" size="5" value="<%=intSelectedMax%>">
                </td>
            </tr>
            <tr>
              <td width="100" height="26"></td>
              <td width="16" height="26"></td>
  </center>
              <td width="325" height="26">
                <p align="right">
          
                <a href="javascript:goUpdateEquip()"><img src="images/Submit_s.jpg" border=0></a>
              
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
<input type="hidden" name="ddSite" value="<%=intSiteID%>">
<input type="hidden" name="txtEquipID" value="<%=intEquipID%>">
<input type="hidden" name="txtOldPosition" value="<%=intSelectedPosition%>">
</form>
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
     Copyright © <%=Now.ToString("yyyy")%> Gussmann Sdn Bhd. All rights reserved.
  </font>
</p>
</body>

</html>
<script language="javascript">

  document.frmUpdateEquip.ddType.value = '<%=strSelectedType%>';
  document.frmUpdateEquip.ddDesc.value = '<%=strSelectedDesc%>';


  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goUpdateEquip()
  {
    if (document.frmUpdateEquip.ddType.value=="0")
    {
      document.frmUpdateEquip.txtError.value = "Please Select Equipment Type !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateEquip.ddDesc.value=="0")
    {
      document.frmUpdateEquip.txtError.value = "Please Select Equipment Description !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateEquip.txtName.value=="")
    {
      document.frmUpdateEquip.txtError.value = "Please Enter Equipment Name !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateEquip.txtMult.value=="")
    {
      document.frmUpdateEquip.txtError.value = "Please Enter Multiplier !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateEquip.txtMeasure.value=="")
    {
      document.frmUpdateEquip.txtError.value = "Please Enter Measurement !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateEquip.txtPosition.value=="")
    {
      document.frmUpdateEquip.txtError.value = "Please Enter Position !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateEquip.txtMax.value=="")
    {
      document.frmUpdateEquip.txtError.value = "Please Enter Max !";
      document.frmUpdateEquip.txtErrorColor.value = "red";
    }
    else
    {
      document.frmUpdateEquip.action="HelperPages/UpdateEquipment.aspx";
      document.frmUpdateEquip.submit();
    }
   document.frmUpdateEquip.submit();
  }

</script>

