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
 dim intSelectedRuleID = request.form("ddRule")

 dim strSelectedName = request.form("txtName")
 dim strSelectedPost = request.form("txtPost")
 dim strSelectedSIMNo = request.form("txtSIMno")
 dim intSelectedPriority = request.form("txtPriority")
  
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
 
 if intSelectedRuleID ="" then 
   intSelectedRuleID ="0"
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
<form name="frmAddDispatch" method="post" action="AddDispatch.aspx">
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<img border="0" src="images/AddDispatch.jpg">
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
                <select name="ddSite" class="FormDropdown" onchange="javascript:goGetRule();">
                  <option value="0" > - Select Site -</option>
                  <%
                    dim intSiteID
                    dim strSite
                    
                    objConn.open(strConn)
                    
                    if arryControlDistrict(0) <> "ALL" then
                          sqlRs.Open("SELECT siteid, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                                 "from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") " & _
                                 "and siteid not in (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                    else
                          sqlRs.Open("SELECT siteid, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                                 "from telemetry_site_list_table where siteid not in (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                    end if
                    do while not sqlRs.EOF
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
                                 "where siteid ='" & intSelectedSiteID & "' and dispatch='1'", objConn)
                    
                    do while not sqlRs.EOF
                          sqlRs1.Open("Select sdesc from telemetry_equip_list_table " & _
                               "where siteid ='" & intSelectedSiteID & "' and position=" & sqlRs("position").value, objConn)
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
               <select name="ddlctname" class="FormDropdown"  onchange="javascript:SetSimNumber(this.value);">
                  <option value="0" > - Select Contact Name -</option>
                  <% 
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
 
                      sqlRs.Open("Select cname, simno, cpost from telemetry_contact_list_table " & _
                                 "where cstatus='1'", objConn)
                    
                      Do While Not sqlRs.EOF
                        
                   %>
                   <option value="<%=sqlRs("simno").value%>" > <%=sqlRs("cname").value%> </option>
                   <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    objConn = nothing
                  %>
                </select>
                <input type="hidden" name="txtName"  value="<%=strSelectedName%>"/>
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">Post</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">

                <input type="text" name="txtPost" class="inputStyle" value="<%=strSelectedPost%>">
               </td>
            </tr>
            <tr>
              <td width="100" height="26"><b><font size="1" face="Verdana" color="#5373A2">SIM No</font></b></td>
              <td width="16" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="325" height="26"><font color="#0B3D62">
                <input type="text" name="txtSIMNo" class="inputStyle" value="<%=strSelectedSIMNo%>">
               </td>
            </tr>
            <tr>
              <td width="150" height="26"><b><font size="1" face="Verdana" color="#5373A2">Priority</font></b></td>
              <td width="20" height="26"><b><font color="#5373A2">:</font></b></td>
              <td width="180" height="26"><font color="#0B3D62">
                <input type="text" name="txtPriority" class="inputStyle" size="2" value="<%=intSelectedPriority%>">
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
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright ?2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
</body>

</html>
<script language="javascript">

 document.frmAddDispatch.ddSite.value = '<%=intSelectedSiteID%>';
 document.frmAddDispatch.ddRule.value = '<%=intSelectedRuleID%>';


//  var strSession = '<%=session("login")%>';
//  if (strSession != "true")
//  {
//    alert("Session Timeout !");
//    top.location.href = "login.aspx";
//  }

  document.onkeypress = checkCR;
  
  
  function goAddDispatch()
  {
    if (document.frmAddDispatch.ddSite.value=="0")
    {
      document.frmAddDispatch.txtError.value = "Please Select Site !";
      document.frmAddDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmAddDispatch.ddRule.value=="0")
    {
      document.frmAddDispatch.txtError.value = "Please Select Rule !";
      document.frmAddDispatch.txtErrorColor.value = "red";
    }
  else if (document.frmAddDispatch.ddlctname.value == "0")
    {
        document.frmAddDispatch.txtError.value = "Please Select Name !";
      document.frmAddDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmAddDispatch.txtPost.value=="")
    {
      document.frmAddDispatch.txtError.value = "Please Enter Post !";
      document.frmAddDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmAddDispatch.txtSIMNo.value=="")
    {
      document.frmAddDispatch.txtError.value = "Please Enter SIM No !";
      document.frmAddDispatch.txtErrorColor.value = "red";
    }
    else if (document.frmAddDispatch.txtPriority.value=="")
    {
      document.frmAddDispatch.txtError.value = "Please Enter Priority !";
      document.frmAddDispatch.txtErrorColor.value = "red";
    }
    else
    {
      document.frmAddDispatch.action="HelperPages/AddDispatch.aspx";
      document.frmAddDispatch.submit();
      return;
    }
   document.frmAddDispatch.submit();
  }

function goGetRule()
{
 document.frmAddDispatch.ddRule.value = "0";
 document.frmAddDispatch.submit();
}
function SetSimNumber(simno) {
    document.frmAddDispatch.txtSIMNo.value = simno;
    document.frmAddDispatch.txtName.value = document.frmAddDispatch.ddlctname.options[document.frmAddDispatch.ddlctname.selectedIndex].text;
}

</script>

