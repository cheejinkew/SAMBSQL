<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>

<%
 dim objConn
 dim strConn
 dim sqlRs
 dim sqlRs1
 dim strError
 dim strErrorColor
 dim intSelectedSiteID = request.form("ddSite")
 dim intSelectedUnitID = request.form("ddUnit")
 dim strSelectedType = request.form("ddType")
 dim strSelectedDesc = request.form("ddDesc")
 
 dim strSelectedName = request.form("txtName")
 dim strSelectedMult = request.form("txtMult")
 dim strSelectedMeasure = request.form("txtMeasure")
 dim intSelectedIndex = request.form("txtIndex")
 dim intSelectedPosition = request.form("txtPosition")
 dim intSelectedMax = request.form("txtMax")

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
  
 if intSelectedSiteID ="" then 
   intSelectedSiteID ="0"
 end if
 
 if intSelectedUnitID ="" then 
   intSelectedUnitID ="0"
 end if

 if strSelectedType ="" then 
   strSelectedType ="0"
 end if

 if strSelectedDesc ="" then 
   strSelectedDesc ="0"
 end if

 strConn = ConfigurationSettings.AppSettings("DSNPG") 
 objConn = new ADODB.Connection()
 sqlRs = new ADODB.Recordset()
 sqlRs1 = new ADODB.Recordset()

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
<form name="frmAddEquip" method="post" action="AddEquipment.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/AddEquip.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="500" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="450" height="63">
            <tr>
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Site</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25"><font color="#0B3D62">
                <select name="ddSite" class="FormDropdown" onchange="javascript:goGetUnit();">
                  <option value="0" > - Select Site -</option>
                  <%
                    dim intSiteID
                    dim strSite
                    dim strSiteType
                    
                    objConn.open(strConn)
 
                    if arryControlDistrict(0) <> "ALL" then
                          sqlRs.Open("SELECT siteid, sitetype, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                                 "from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") " & _
                                 "and siteid not in (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                    else
                          sqlRs.Open("SELECT siteid, sitetype, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                                 "from telemetry_site_list_table where siteid not in (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                    end if
                    
                    do while not sqlRs.EOF
                      intSiteID = sqlRs("siteid").value
                      strSiteType = sqlRs("sitetype").value
                      strSite = sqlRs("sites").value
                   %>
                   <option value="<%=intSiteID%>"><%=strSite%></option>
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
              <td width="150" height="25"><b><font size="1" face="Verdana" color="#5373A2">Unit</font></b></td>
              <td width="20" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="25"><font color="#0B3D62">
                <select name="ddUnit" class="FormDropdown1">
                  <option value="0" > - Select Unit -</option>
                  <%
                    dim strUnit
                   
                    objConn.open(strConn)
 
                      sqlRs.Open("select versionid + ' : ' + s.unitid as unit " & _
                               "from telemetry_site_list_table s, unit_list u " & _
                               "where siteid='" & intSelectedSiteID & "' and s.unitid = u.unitid order by versionid", objConn)
                    do while not sqlRs.EOF
                      strUnit = sqlRs("unit").value
                                         %>
                   <option value="<%=strUnit%>"><%=strUnit%></option>
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
                <input type="text" name="txtMult" class="inputStyle"  size="25" value="<%=strSelectedMult%>">
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
                <input type="text" name="txtIndex" class="inputStyle" size="5" value="<%=intSelectedIndex%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Position</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtPosition" class="inputStyle" size="5" value="<%=intSelectedPosition%>">
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
          
                <a href="javascript:goAddDispatch()"><img src="images/Submit_s.jpg" border=0></a>
              
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
<input type="hidden" name="txtSiteType" value="">
</form>
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
     Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</body>

</html>
<script language="javascript">

  document.frmAddEquip.ddSite.value = '<%=intSelectedSiteID%>';
  document.frmAddEquip.ddUnit.value = '<%=intSelectedUnitID%>';
  document.frmAddEquip.ddType.value = '<%=strSelectedType%>';
  document.frmAddEquip.ddDesc.value = '<%=strSelectedDesc%>';


  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goAddDispatch()
  {
    if (document.frmAddEquip.ddSite.value=="0")
    {
      document.frmAddEquip.txtError.value = "Please Select Site !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.ddUnit.value=="0")
    {
      document.frmAddEquip.txtError.value = "Please Select Unit !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.ddType.value=="0")
    {
      document.frmAddEquip.txtError.value = "Please Select Equipment Type !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.ddDesc.value=="0")
    {
      document.frmAddEquip.txtError.value = "Please Select Equipment Description !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.txtName.value=="")
    {
      document.frmAddEquip.txtError.value = "Please Enter Equipment Name !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.txtMult.value=="")
    {
      document.frmAddEquip.txtError.value = "Please Enter Multiplier !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.txtMeasure.value=="")
    {
      document.frmAddEquip.txtError.value = "Please Enter Measurement !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.txtIndex.value=="")
    {
      document.frmAddEquip.txtError.value = "Please Enter Index !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.txtPosition.value=="")
    {
      document.frmAddEquip.txtError.value = "Please Enter Position !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else if (document.frmAddEquip.txtMax.value=="")
    {
      document.frmAddEquip.txtError.value = "Please Enter Max !";
      document.frmAddEquip.txtErrorColor.value = "red";
    }
    else
    {
      document.frmAddEquip.action="HelperPages/AddEquipment.aspx";
//      document.frmAddEquip.txtSiteType.value = document.getElementById("ddSite")(document.frmAddEquip.ddSite.selectedIndex).innerHTML;
	  
	  sel = document.frmAddEquip.ddSite.selectedIndex;

	  strSiteName = document.frmAddEquip.ddSite.options[sel].text;	  
      document.frmAddEquip.txtSiteType.value = strSiteName;
//	  alert (strSiteName);
      document.frmAddEquip.submit();
      return;
    }
   document.frmAddEquip.submit();
  }

function goGetUnit()
{
 document.frmAddEquip.ddUnit.value = "0";
 document.frmAddEquip.submit();

}

</script>

