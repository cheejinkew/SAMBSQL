<%@ Page Language="VB" Debug="true" %>
<!--#include file="../kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim strConn
    Dim sqlRs
    Dim sqlRs1
    Dim strError
    Dim strErrorColor
    Dim intSelectedSiteID = Request.Form("ddSite")
    Dim intSelectedRuleID = Request.Form("ddRule")

    Dim strSelectedName = Request.Form("txtName")
    Dim strSelectedPost = Request.Form("txtPost")
    Dim strSelectedSIMNo = Request.Form("txtSIMno")
    Dim intSelectedPriority = Request.Form("txtPriority")
  
    Dim i
    Dim strControlDistrict
    Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1) Then
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
            Else
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
    End If

    If intSelectedSiteID = "" Then
        intSelectedSiteID = "0"
    End If
 
    If intSelectedRuleID = "" Then
        intSelectedRuleID = "0"
    End If

    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
    sqlRs1 = New ADODB.Recordset()

    strError = Request.Form("txtError")
    strErrorColor = Request.Form("txtErrorColor")
    
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
    <form name="frmAddDispatch" method="post" action="MelakaAddDispatch.aspx">
        <div align="center">
            <center>
                <table border="0" cellpadding="0" cellspacing="0" width="500">
                    <tr>
                        <td>
                            <p align="center">
                                <br>
                                <img border="0" src="images/AddDispatch.jpg">
                                <div align="center" id="Error">
                                    <font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>
                                <div align="center">
                                    <table border="0" cellpadding="0" cellspacing="0" width="400" height="100" style="border-width: 2px;
                                        border-style: double; border-color: #CFD9E7">
                                        <tr>
                                            <td>
                                                <div align="center">
                                                    <br>
                                                    <table border="0" cellpadding="5" width="350" height="63">
                                                        <tr>
                                                            <td width="150" height="25">
                                                                <b><font size="1" face="Verdana" color="#5373A2">Site</font></b></td>
                                                            <td width="20" height="25">
                                                                <b><font color="#5373A2">:</font></b></td>
                                                            <td width="180" height="25">
                                                                <font color="#0B3D62">
                                                                    <select name="ddSite" class="FormDropdown" onchange="javascript:goGetRule();">
                                                                        <option value="0">- Select Site -</option>
                                                                        <%
                                                                            Dim intSiteID
                                                                            Dim strSite
                    
                                                                            objConn.open(strConn)
                    
                                                                            sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                                                                                                           "from telemetry_site_list_table where siteid IN ("& strKontID &") order by sitedistrict, sitetype, sitename", objConn)
                                                                            Do While Not sqlRs.EOF
                                                                                intSiteID = sqlRs("siteid").value
                                                                                strSite = sqlRs("sites").value
                                                                        %>
                                                                        <option value="<%=intSiteID%>">
                                                                            <%=strSite%>
                                                                        </option>
                                                                        <%

                                                                            sqlRs.movenext()
                                                                        Loop
                                                                        sqlRs.close()
                                                                            objConn.close()
                                                                            objConn = Nothing
                                                                        %>
                                                                    </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="100" height="26">
                                                                <b><font size="1" face="Verdana" color="#5373A2">Rule</font></b></td>
                                                            <td width="16" height="26">
                                                                <b><font color="#5373A2">:</font></b></td>
                                                            <td width="325" height="26">
                                                                <font color="#0B3D62">
                                                                    <select name="ddRule" class="FormDropdown">
                                                                        <option value="0">- Select Rule -</option>
                                                                        <%
                                                                            Dim intRuleID
                                                                            Dim intPosition
                                                                            Dim strEquipType
                    
                                                                            objConn = New ADODB.Connection()
                                                                            objConn.open(strConn)
 
                                                                            sqlRs.Open("Select ruleid, alarmtype, position from telemetry_rule_list_table " & _
                                                                                       "where siteid ='" & intSelectedSiteID & "' and dispatch='TRUE'", objConn)
                    
                                                                            Do While Not sqlRs.EOF
                                                                                sqlRs1.Open("Select ""desc"" from telemetry_equip_list_table " & _
                                                                                         "where siteid ='" & intSelectedSiteID & "' and position=" & sqlRs("position").value, objConn)
                                                                                If Not sqlRs1.EOF Then
                                                                                    strEquipType = sqlRs1("desc").value
                                                                                End If
                                                                                sqlRs1.Close()
                                                                                intRuleID = sqlRs("ruleid").value
                                                                        %>
                                                                        <option value="<%=intRuleID%>">
                                                                            <%=strEquipType%>
                                                                            :
                                                                            <%=sqlRs("alarmtype").value%>
                                                                        </option>
                                                                        <%

                                                                            sqlRs.movenext()
                                                                        Loop
                
                                                                        sqlRs.close()
                                                                        objConn.close()
                                                                        objConn = Nothing
                                                                        %>
                                                                    </select>
                                                                </font>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="100" height="26">
                                                                <b><font size="1" face="Verdana" color="#5373A2">Name</font></b></td>
                                                            <td width="16" height="26">
                                                                <b><font color="#5373A2">:</font></b></td>
                                                            <td width="325" height="26">
                                                                <font color="#0B3D62">
                                                                    <input type="text" name="txtName" class="inputStyle" value="<%=strSelectedName%>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="100" height="26">
                                                                <b><font size="1" face="Verdana" color="#5373A2">Post</font></b></td>
                                                            <td width="16" height="26">
                                                                <b><font color="#5373A2">:</font></b></td>
                                                            <td width="325" height="26">
                                                                <font color="#0B3D62">
                                                                    <input type="text" name="txtPost" class="inputStyle" value="<%=strSelectedPost%>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="100" height="26">
                                                                <b><font size="1" face="Verdana" color="#5373A2">SIM No</font></b></td>
                                                            <td width="16" height="26">
                                                                <b><font color="#5373A2">:</font></b></td>
                                                            <td width="325" height="26">
                                                                <font color="#0B3D62">
                                                                    <input type="text" name="txtSIMNo" class="inputStyle" value="<%=strSelectedSIMNo%>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="150" height="26">
                                                                <b><font size="1" face="Verdana" color="#5373A2">Priority</font></b></td>
                                                            <td width="20" height="26">
                                                                <b><font color="#5373A2">:</font></b></td>
                                                            <td width="180" height="26">
                                                                <font color="#0B3D62">
                                                                    <input type="text" name="txtPriority" class="inputStyle" size="2" value="<%=intSelectedPriority%>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="100" height="26">
                                                            </td>
                                                            <td width="16" height="26">
                                                            </td>
            </center>
            <td width="325" height="26">
                <p align="right">
                    <a href="javascript:goAddDispatch()">
                        <img src="images/Submit_s.jpg" border="0"></a>
                &nbsp;&nbsp;&nbsp;
            </td>
            </tr> </table>
        </div>
        <center>
        </center>
        </td> </tr> </table> </div>
        <p align="center" style="margin-bottom: 15">
            <font size="1" face="Verdana" color="#5373A2"></font>
        </p>
        </td> </tr> </table> </div>
        <input type="hidden" name="txtError" value="">
        <input type="hidden" name="txtErrorColor" value="">
        <p align="center" style="margin-bottom: 15">
            <font size="1" face="Verdana" color="#5373A2">Copyright © <%=Now.ToString("yyyy") %> Gussmann Technologies
                Sdn Bhd. All rights reserved. </font>
        </p>
    </form>
</body>
</html>

<script language="javascript">

 document.frmAddDispatch.ddSite.value = '<%=intSelectedSiteID%>';
 document.frmAddDispatch.ddRule.value = '<%=intSelectedRuleID%>';


  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "Melakalogin.aspx";
  }

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
    else if (document.frmAddDispatch.txtName.value=="")
    {
      document.frmAddDispatch.txtError.value = "Please Enter Name !";
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

</script>

