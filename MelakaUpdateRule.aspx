<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim strConn
   dim sqlRs
   dim sqlRs1
   dim strError
   dim strErrorColor
   dim strRuleIDSiteName = split(request.form("txtRuleIDSiteName"), ",")
   
   dim intRuleID = strRuleIDSiteName(0)
   dim strSiteName =strRuleIDSiteName(1)
   dim intSiteID
   dim intVersionID
   dim intUnitID
   dim strEquip 
   dim strColor
   dim strDispatch
   dim strSeq
   dim strAlert
   dim ArryFormula ()
   dim strFormula
   dim strOperator
   dim intThreshold
   dim intMax
   dim intMin
   dim strAlarmMode
   dim strAlarmType
   dim intPosition
   dim strMultiplier
  
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

   objConn.open(strConn)
   sqlRs.Open("SELECT siteid, position, colorcode, alert, dispatch, alarmmode,alarmtype, sequence, multiplier " & _
            "from telemetry_rule_list_table " & _
            "where ruleid = '" & intRuleID & "'", objConn)
    
   if not sqlRs.EOF then
     intSiteID = sqlRs("siteid").value
     intPosition = sqlRs("position").value
     strColor= sqlRs("colorcode").value
     strSeq = sqlRs("sequence").value
     strDispatch = sqlRs("dispatch").value
     if strDispatch ="1" then
       strDispatch = "TRUE"
     else 
       strDispatch = "FALSE"
     end if
     
     strAlert = sqlRs("alert").value
     if strAlert ="1" then
       strAlert = "TRUE"
     else
       strAlert = "FALSE"
     end if
     
     strAlarmMode = sqlRs("alarmmode").value
     strAlarmType = sqlRs("alarmtype").value
     strMultiplier = sqlRs("multiplier").value
     ArryFormula = split(strMultiplier, ";")
     
     select case ArryFormula(0)
       case "RANGE"
         intMin = ArryFormula(1)
         intMax = ArryFormula(2)
       case "THRESHOLD"
         intThreshold = ArryFormula(1)
         strOperator = ArryFormula(2)
     end select
     sqlRs1.Open("SELECT versionid, unitid, ""desc"" from telemetry_equip_list_table " & _
            "where siteid = '" & intSiteID & "' and position ='" & intPosition & "'", objConn)
     
     if not sqlRs1.EOF then
       intVersionID = sqlRs1("versionid").value
       intUnitID = sqlRs1("unitid").value
       strEquip= sqlRs1("desc").value
     end if
     sqlRs1.close()
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
<form name="frmUpdateRule" method="post" action="UpdateRule.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="650">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdateRule.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="500" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="450" height="63">
            <tr>
              <td width="25%" height="25"><b><font size="1" face="Verdana" color="#5373A2">District</font></b></td>
              <td width="5%" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font size="1" face="Verdana" color="#0B3D62">
                <input type="text" name="ddSite" class="inputStyleX" value="<%=strSiteName%>" size = 40></font>
              </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Equipment</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font color="#0B3D62">
                <input type="text" name="ddEquip" class="inputStyleX" value="<%=strEquip%>" size = 40></font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Color Code</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddColor" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Color -</option>
                  
                  <option value="FF0000">Red</option>
                  <option value="FF7636">Orange</option>
                  <option value="FFFF00">Yellow</option>
                  <option value="00FF00">Green</option>
                  <option value="0000FF">Blue</option>
                  <option value="C0C0C0">Grey</option>
                </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Alert </font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddAlert" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Alert -</option>
                  <option value="TRUE">True</option>
                  <option value="FALSE">False</option>
               </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Dispatch </font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddDispatch" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Dispatch -</option>
                  <option value="TRUE">True</option>
                  <option value="FALSE">False</option>
               </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Alarm Mode </font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddAMode" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Mode -</option>
                  <option value="ALARM">Alarm</option>
                  <option value="EVENT">Event</option>
               </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Alarm Type</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2"><font size="1" face="Verdana" color="#0B3D62"><input type="text" name="txtAType" class="inputStyle" value="" size="15"></font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="26"><b><font size="1" face="Verdana" color="#5373A2">Sequence</font></b></td>
              <td width="5%" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="70%" height="26" colspan="2">
                <font size="1" face="Verdana" color="#0B3D62">
                <input type="text" name="txtSequence" class="inputStyle" 
                 value="" size="4" onblur="javascript:IsInteger(this.value, 'txtSequence')">
                </font>
              </td>
            </tr>
            <tr>
              <td width="25%" height="13"><b><font size="1" face="Verdana" color="#5373A2">Formula</font></b></td>
              <td width="5%" height="13"><b><font color="#5373A2">:</font></b></td>
              <td width="25%" height="13"><font size="1" face="Verdana" color="#0B3D62"><input type="radio" value="Threshold" name="optFormula" onclick="goShowParam()">Threshold&nbsp;&nbsp;&nbsp;</font>
               </td>
              <td width="45%" height="13"><font size="1" face="Verdana" color="#0B3D62"><input type="radio" value="Range" name="optFormula" onclick="goShowParam()">Range</font>
               </td>
            </tr>
            <tr>
              <td width="25%" height="13"></td>
              <td width="5%" height="13"></td>
              <td width="25%" height="13"><font size="1" face="Verdana" color="#0B3D62">
              <div id="divThreshold" style="visibility: hidden;">
              
                <select size="1" name="ddThreshold"  class="FormDropdown1">
                  <option value="=" selected>=</option>
                  <option value="&gt;=">&gt;=</option>
                  <option value="&gt;">&gt;</option>
                  <option value="&lt;=">&lt;=</option>
                  <option value="&lt;">&lt;</option>
                </select>
                <input type="text" name="txtThreshold" class="inputStyle" 
                value="" onblur="javascript:IsNumberDecimal(this.value, 'txtThreshold')" size="3">
                </font>
               </div> 
               </td>
              <td width="45%" height="13" style="word-spacing: 0; margin-top: 0; margin-bottom: 0"><font color="#0B3D62" size="1" face="Verdana">
              <div id="divRange" style="visibility: hidden;">
                Min
                  <input type="text" name="txtMin" class="inputStyle"
                  value="" onblur="javascript:IsNumberDecimal(this.value, 'txtMin')" size="3">
                Max
                  <input type="text" name="txtMax" class="inputStyle" 
                  value="" onblur="javascript:IsNumberDecimal(this.value, 'txtMax')" size="3">
                </font>
              </div>
              </td>
            </tr>
            <tr>
              <td width="25%" height="26"></td>
              <td width="5%" height="26"></td>
  </center>
              <td width="70%" height="26" colspan="2">
                <p align="right">
          
                <a href="javascript:goUpdateRule()"><img src="images/Submit_s.jpg" border=0></a>
              
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
<input type="hidden" name="txtUnitID" value="<%=intUnitID%>">
<input type="hidden" name="txtVersionID" value="<%=intVersionID%>">
<input type="hidden" name="txtSiteID" value="<%=intSiteID%>">
<input type="hidden" name="txtRuleID" value="<%=intRuleID%>">
<input type="hidden" name="txtPosition" value="<%=intPosition%>">
<input type="hidden" name="txtRuleIDSiteName" value="<%=intRuleID%>,<%=strSiteName%>">

<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
<p align="center" style="margin-bottom: 15">&nbsp;</p>
</body>

</html>
<script language="javascript">

 var strFormula ="<%=ArryFormula(0)%>";
 var error = "false";

 document.forms[0].ddColor.value = '<%=strColor%>';
 document.forms[0].ddAlert.value = '<%=strAlert%>';
 document.forms[0].ddDispatch.value = '<%=strDispatch%>';
 document.forms[0].txtSequence.value = '<%=strSeq%>';
 document.forms[0].ddAMode.value = '<%=strAlarmMode%>';
 document.forms[0].txtAType.value = '<%=strAlarmType%>';

 if (strFormula =="THRESHOLD")
 {
   document.forms[0].optFormula[0].checked ="True";
   document.getElementById('divThreshold').style.visibility = 'visible'; 
   document.forms[0].ddThreshold.value ="<%=strOperator%>";
   document.forms[0].txtThreshold.value ="<%=intThreshold%>";
 }
 else if (strFormula =="RANGE")
 {
   document.forms[0].optFormula[1].checked ="True";
   document.getElementById('divRange').style.visibility = 'visible'; 
   document.forms[0].txtMax.value ="<%=intMax%>";
   document.forms[0].txtMin.value ="<%=intMin%>";
 }

  var strSession = 'true';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goUpdateRule()
  {
    if (document.forms[0].ddAlert.value=="0")
    {
      
      error = "true";
      document.forms[0].txtError.value = "Please Select An Option for Alert !";
    }
    else if (document.forms[0].ddDispatch.value=="0")
    {
      error = "true";
      document.forms[0].txtError.value = "Please Select Dispatch !";
    }
    else if (document.forms[0].ddColor.value=="0")
    {
      error = "true";
      document.forms[0].txtError.value = "Please Select Color !";
    }
    else if (document.forms[0].ddAMode.value=="0")
    {
      error = "true";
      document.forms[0].txtError.value = "Please Select Alarm Mode !";
    }
    else if (document.forms[0].txtAType.value=="")
    {
      error = "true";
      document.forms[0].txtError.value = "Please Enter Alarm Type !";
    }
    else if (document.forms[0].txtSequence.value=="")
    {
      error = "true";
      document.forms[0].txtError.value = "Please Enter Sequence !";
    }
    else if (!document.forms[0].optFormula[0].checked && !document.forms[0].optFormula[1].checked )
    {
      error = "true";
      document.forms[0].txtError.value = "Please Select A Formula !";
    }
    else if (document.forms[0].optFormula[0].checked)
    {
      if (document.forms[0].txtThreshold.value =="")
      {
      error = "true";
      document.forms[0].txtError.value = "Please Enter Threshold Value !";
      }
    }
    else if (document.forms[0].optFormula[1].checked)
    {
      if (document.forms[0].txtMax.value =="")
      {
      error = "true";
      document.forms[0].txtError.value = "Please Enter Max Value !";
      }
      else if (document.forms[0].txtMin.value =="")
      {
      document.forms[0].txtError.value = "Please Enter Min Value !";
      error = "true";
      }
    }
    
    if (error =="true")
    { 
      
      document.forms[0].txtErrorColor.value = "red";
      document.forms[0].submit();
    }
    else if (error =="false")
    {     
      document.forms[0].action="HelperPages/UpdateRule.aspx";
      document.forms[0].submit();
    }
    
  }
  
function goShowParam()
{
  if(document.forms[0].optFormula[0].checked)
  {
    document.getElementById('divThreshold').style.visibility = 'visible'; 
    document.getElementById('divRange').style.visibility = 'hidden'; 
    document.forms[0].txtMax.value =""
    document.forms[0].txtMin.value =""
    
  };
  
  if(document.forms[0].optFormula[1].checked)
  {
    document.getElementById('divRange').style.visibility = 'visible'; 
    document.getElementById('divThreshold').style.visibility = 'hidden'; 
    document.forms[0].ddThreshold.value ="="
    document.forms[0].txtThreshold.value =""
  };
}

</script>

