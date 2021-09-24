<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<!--#include file="../kont_id.aspx"-->
<%
   dim objConn
   dim strConn
   dim sqlRs
   dim sqlRs1
   dim strError
   dim strErrorColor
   dim intSelectedSiteID = request.form("ddSite")
   dim intSelectedEquip = request.form("ddEquip")
   dim strSelectedColor = request.form("ddColor")
   dim strSelectedDispatch = request.form("ddDispatch")
   dim strSelectedSeq = request.form("txtSequence")
   dim strSelectedAlert = request.form("ddAlert")
   dim strSelectedFormula = request.form("optFormula")
   dim strSelectedOperator = request.form("ddThreshold")
   dim strSelectedThreshold = request.form("txtThreshold")
   dim strSelectedMax = request.form("txtMax")
   dim strSelectedMin = request.form("txtMin")
   dim strSelectedAMode = request.form("ddAMode")
   dim strSelectedAType = request.form("txtAType")
  
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
 
   if intSelectedEquip ="" then 
     intSelectedEquip ="0"
   end if

   if strSelectedColor ="" then 
     strSelectedColor ="0"
   end if
 
   if strSelectedDispatch ="" then 
     strSelectedDispatch ="0"
   end if

   if strSelectedAlert ="" then 
     strSelectedAlert ="0"
   end if

   if strSelectedAMode ="" then 
     strSelectedAMode ="0"
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
<form name="frmAddRule" method="post" action="MelakaAddRule.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/AddRule.jpg">
<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="450" height="100" style="border-width: 2px; border-style: double; border-color: #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table border="0" cellpadding="5" width="400" height="63">
            <tr>
              <td width="69" height="25"><b><font size="1" face="Verdana" color="#5373A2">Site</font></b></td>
              <td width="5" height="25"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="25" colspan="2"><font color="#0B3D62">
                <select name="ddSite" class="FormDropdown" onchange="goGetEquip()">
                  <option value="0" > - Select Site -</option>
                  <%
                    dim intSiteID
                    dim strSite
                    
                    objConn.open(strConn)
                      'if arryControlDistrict(0) <> "ALL" then
                      sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                                 "from telemetry_site_list_table where siteid IN ("& strKontID &") order by sitedistrict, sitetype, sitename", objConn)
                      'else
                      '  sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                      '             "from telemetry_site_list_table order by sitedistrict, sitetype, sitename", objConn)
                      'end if
                    
                      Do While Not sqlRs.EOF
                          intSiteID = sqlRs("siteid").value
                          strSite = sqlRs("sites").value
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
               </td>
            </tr>
            <tr>
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Equipment</font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddEquip" class="FormDropdown">
                  <option value="0" > - Select Equipment -</option>
                  <%
                    dim strEquip
                    dim intEquipID
                    dim strEquipType
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    sqlRs.Open("Select versionid, unitid, position, ""desc"" from telemetry_equip_list_table " & _
                               "where siteid ='" & intSelectedSiteID & "' and position not in (0,1)",objConn)
                    do while not sqlRs.EOF
                      strEquip = sqlRs("desc").value
                      intEquipID =  sqlRs("unitid").value & "," & sqlRs("versionid").value & "," & sqlRs("position").value
                      
                   %>
                   <option value="<%=intEquipID%>"><%=strEquip%></option>
                   <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    sqlRs = nothing
                    sqlRs1 = nothing
                    objConn = nothing
                  %>
                </select>
               </td>
            </tr>
            <tr>
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Color Code</font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2"><font color="#0B3D62">
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
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Alert </font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddAlert" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Alert -</option>
                  <option value="TRUE">True</option>
                  <option value="FALSE">False</option>
               </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Dispatch </font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddDispatch" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Dispatch -</option>
                  <option value="TRUE">True</option>
                  <option value="FALSE">False</option>
               </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Alarm Mode </font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2"><font color="#0B3D62">
                <select name="ddAMode" class="FormDropdown" style="width: 138; height: 23" size="1">
                  <option value="0" > - Select Mode -</option>
                  <option value="ALARM">Alarm</option>
                  <option value="EVENT">Event</option>
               </select>
                </font>
               </td>
            </tr>
            <tr>
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Alarm Type</font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2"><font size="1" face="Verdana" color="#0B3D62"><input type="text" name="txtAType" class="inputStyle" value="" size="15"></font>
               </td>
            </tr>
            <tr>
              <td width="69" height="26"><b><font size="1" face="Verdana" color="#5373A2">Sequence</font></b></td>
              <td width="5" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="280" height="26" colspan="2">
                <font size="1" face="Verdana" color="#0B3D62">
                <input type="text" name="txtSequence" class="inputStyle"
                 value="" size="4" onblur="javascript:IsInteger(this.value, 'txtSequence')">
                </font>
              </td>
            </tr>
            <tr>
              <td width="69" height="13"><b><font size="1" face="Verdana" color="#5373A2">Formula</font></b></td>
              <td width="5" height="13"><b><font color="#5373A2">:</font></b></td>
              <td width="97" height="13"><font size="1" face="Verdana" color="#0B3D62"><input type="radio" value="Threshold" name="optFormula" onclick="goShowParam()">Threshold&nbsp;&nbsp;&nbsp;</font>
               </td>
              <td width="169" height="13"><font size="1" face="Verdana" color="#0B3D62"><input type="radio" value="Range" name="optFormula" onclick="goShowParam()">Range</font>
               </td>
            </tr>
            <tr>
              <td width="69" height="13"></td>
              <td width="5" height="13"></td>
              <td width="97" height="13"><font size="1" face="Verdana" color="#0B3D62">
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
              <td width="169" height="13" style="word-spacing: 0; margin-top: 0; margin-bottom: 0"><font color="#0B3D62" size="1" face="Verdana">
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
              <td width="69" height="26"></td>
              <td width="5" height="26"></td>
  </center>
              <td width="280" height="26" colspan="2">
                <p align="right">
          
                <a href="javascript:goAddRule()"><img src="images/Submit_s.jpg" border=0></a>
              
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
    Copyright © <%=now.ToString("yyyy") %> Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
<p align="center" style="margin-bottom: 15">&nbsp;</p>
</body>

</html>
<script language="javascript">

 var strFormula ="<%=strSelectedFormula%>";
 
 var error = "false";

 document.frmAddRule.ddSite.value = '<%=intSelectedSiteID%>';
 document.frmAddRule.ddEquip.value = '<%=intSelectedEquip%>';
 document.frmAddRule.ddColor.value = '<%=strSelectedColor%>';
 document.frmAddRule.ddAlert.value = '<%=strSelectedAlert%>';
 document.frmAddRule.ddDispatch.value = '<%=strSelectedDispatch%>';
 document.frmAddRule.txtSequence.value = '<%=strSelectedSeq%>';
 document.frmAddRule.ddAMode.value = '<%=strSelectedAMode%>';
 document.frmAddRule.txtAType.value = '<%=strSelectedAType%>';
 

 if (strFormula =="Threshold")
 {
   document.frmAddRule.optFormula[0].checked ="True";
   document.getElementById('divThreshold').style.visibility = 'visible'; 
   document.frmAddRule.ddThreshold.value ="<%=strSelectedOperator%>";
   document.frmAddRule.txtThreshold.value ="<%=strSelectedThreshold%>";
 }
 else if (strFormula =="Range")
 {
   document.frmAddRule.optFormula[1].checked ="True";
   document.getElementById('divRange').style.visibility = 'visible'; 
   document.frmAddRule.txtMax.value ="<%=strSelectedMax%>";
   document.frmAddRule.txtMin.value ="<%=strSelectedMin%>";
 }



  var strSession = 'true';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "Melakalogin.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goAddRule()
  {
    if (document.frmAddRule.ddSite.value=="0")
    {
      document.frmAddRule.txtError.value = "Please Select Site !";
      error = "true";
    }
    else if (document.frmAddRule.ddEquip.value=="0")
    {
      document.frmAddRule.txtError.value = "Please Select Equipment !";
      error = "true";
    }
    else if (document.frmAddRule.ddAlert.value=="0")
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Select An Option for Alert !";
    }
    else if (document.frmAddRule.ddDispatch.value=="0")
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Select Dispatch !";
    }
    else if (document.frmAddRule.ddColor.value=="0")
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Select Color !";
    }
    else if (document.frmAddRule.ddAMode.value=="0")
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Select Alarm Mode !";
    }
    else if (document.frmAddRule.txtAType.value=="")
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Enter Alarm Type !";
    }
    else if (document.frmAddRule.txtSequence.value=="")
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Enter Sequence !";
    }
    else if (!document.frmAddRule.optFormula[0].checked && !document.frmAddRule.optFormula[1].checked )
    {
      error = "true";
      document.frmAddRule.txtError.value = "Please Select A Formula !";
    }
    else if (document.frmAddRule.optFormula[0].checked)
    {
      if (document.frmAddRule.txtThreshold.value =="")
      {
      error = "true";
      document.frmAddRule.txtError.value = "Please Enter Threshold Value !";
      }
    }
    else if (document.frmAddRule.optFormula[1].checked)
    {
      if (document.frmAddRule.txtMax.value =="")
      {
      error = "true";
      document.frmAddRule.txtError.value = "Please Enter Max Value !";
      }
      else if (document.frmAddRule.txtMin.value =="")
      {
      document.frmAddRule.txtError.value = "Please Enter Min Value !";
      error = "true";
      }
    }
    
    if (error =="true")
    { 
      document.frmAddRule.txtErrorColor.value = "red";
      document.frmAddRule.submit();
    }
    else if (error =="false")
    {     
      document.frmAddRule.action="HelperPages/AddRule.aspx";
      document.frmAddRule.submit();
    }
    
  }
  
function goShowParam()
{
  if(document.frmAddRule.optFormula[0].checked)
  {
    document.getElementById('divThreshold').style.visibility = 'visible'; 
    document.getElementById('divRange').style.visibility = 'hidden'; 
    document.frmAddRule.txtMax.value =""
    document.frmAddRule.txtMin.value =""
    
  };
  
  if(document.frmAddRule.optFormula[1].checked)
  {
    document.getElementById('divRange').style.visibility = 'visible'; 
    document.getElementById('divThreshold').style.visibility = 'hidden'; 
    document.frmAddRule.ddThreshold.value ="="
    document.frmAddRule.txtThreshold.value =""
  };
}

function goGetEquip()
{
 document.frmAddRule.ddEquip.value = "0";
 document.frmAddRule.submit();

}
</script>

