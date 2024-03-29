<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
  dim objConn
  dim strConn
  dim sqlRs
  dim sqlRs1
  dim strError
  dim strErrorColor
  dim strSite
  dim intSiteID = request.form("ddSite")
  dim intTmp = split(request.form("txtRule"), ",")
  dim intSelectedRuleID = intTmp(0)
  dim strSelectedSIMNo = intTmp(1)
  dim strName
  dim strPost 
  dim strSIMNo 
  dim intPriority 
 
  strConn = ConfigurationSettings.AppSettings("DSNPG") 
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()
  sqlRs1 = new ADODB.Recordset()

  objConn.open(strConn)
 
    sqlRs.Open("SELECT sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
             "from telemetry_site_list_table where siteid='" & intSiteID & "'", objConn)
  if not sqlRs.EOF
    strSite = sqlRs("sites").value
  end if
  sqlRs.close()

  sqlRs.Open("SELECT sname, post, simno, priority " & _
             "from telemetry_dispatch_list_table where ruleid='" & _
             intSelectedRuleID & "' and simno='" & strSelectedSIMNo & "'",objConn)
  if not sqlRs.EOF
        strName = sqlRs("sname").value
    strPost = sqlRs("post").value
    strSIMNo = sqlRs("simno").value
    intPriority = sqlRs("priority").value
  end if
  sqlRs.close()
  objConn.close()
  objConn = nothing
  
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
<form name="frmUpdateDispatch" method="post" action="UpdateDispatch.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/UpdateDispatch.jpg">
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
                <input type="text" name="txtSite" class="inputStyleX" value="<%=strSite%>" size=30 ReadOnly> 
              </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Rule</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <select name="ddRule" class="FormDropdown">
                  <option value="0" > - Select Rule -</option>
                  <%
                    dim intRuleID
                    dim intPosition
                    dim strEquipType
                    
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
 
                    sqlRs.Open("Select ruleid, alarmtype, position from telemetry_rule_list_table " & _
                               "where siteid ='" & intSiteID & "' and dispatch='TRUE'",objConn)
                    
                    do while not sqlRs.EOF
                          sqlRs1.Open("Select sdesc from telemetry_equip_list_table " & _
                               "where siteid ='" & intSiteID & "' and position=" & sqlRs("position").value, objConn)
                      if not sqlRs1.EOF then
                              strEquipType = sqlRs1("sdesc").value
                      end if
                      sqlRs1.Close()
                      intRuleID = sqlRs("ruleid").value
                   %>
                   <option value="<%=intRuleID%>"><%=strEquipType%> : <%=sqlRs("alarmtype").value%></option>
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
                </font>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Name</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtName" class="inputStyle" value="<%=strName%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Post</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtPost" class="inputStyle" value="<%=strPost%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">SIM No</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSIMNo" class="inputStyle" value="<%=strSIMNo%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Priority</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtPriority" class="inputStyle" size="2" value="<%=intPriority%>">
                </td>
            </tr>
            <tr>
              <td width="100" height="26"></td>
              <td width="16" height="26"></td>
  </center>
              <td width="325" height="26">
                <p align="right">
          
                <a href="javascript:goUpdateDispatch()"><img src="images/Submit_s.jpg" border=0></a>
              
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
<input type="hidden" name="txtError" value="">
<input type="hidden" name="ddSite" value="<%=intSiteID%>">
<input type="hidden" name="txtOldSIMNo" value="<%=strSelectedSIMNo%>">
<input type="hidden" name="txtOldRuleID" value="<%=intSelectedRuleID%>">
</form>
<p align="center" style="margin-bottom: 15"><font size="1" face="Verdana" color="#5373A2">Copyright ?
<%=Now.ToString("yyyy") %> Gussmann Sdn Bhd. All rights reserved.</font></p>

</body>

</html>
<script language="javascript">

 document.frmUpdateDispatch.ddRule.value = '<%=intSelectedRuleID%>';


  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "login.aspx";
  }

  document.onkeypress = checkCR;
  
  
  function goUpdateDispatch()
  {
    if (document.frmUpdateDispatch.ddRule.value=="0")
    {
      document.frmUpdateDispatch.txtError.value = "Please Select Rule !";
      document.frmUpdateDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateDispatch.txtName.value=="")
    {
      document.frmUpdateDispatch.txtError.value = "Please Enter Name !";
      document.frmUpdateDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateDispatch.txtPost.value=="")
    {
      document.frmUpdateDispatch.txtError.value = "Please Enter Post !";
      document.frmUpdateDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateDispatch.txtSIMNo.value=="")
    {
      document.frmUpdateDispatch.txtError.value = "Please Enter SIM No !";
      document.frmUpdateDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmUpdateDispatch.txtPriority.value=="")
    {
      document.frmUpdateDispatch.txtError.value = "Please Enter Priority !";
      document.frmUpdateDispatch.txtErrorColor.value = "red";
    }
    else
    {
      document.frmUpdateDispatch.action="HelperPages/UpdateDispatch.aspx";
      document.frmUpdateDispatch.submit();
    }
   document.frmUpdateDispatch.submit();
  }
</script>

