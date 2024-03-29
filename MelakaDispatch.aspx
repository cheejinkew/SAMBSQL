<%@ Page Language="VB" Debug="true" %>
<!--#include file="../kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim sqlRs
    Dim sqlRs1
    Dim sqlRs2
    Dim strConn
    Dim intUserID
    Dim intGetUserID
    Dim strError
    Dim strErrorColor
    Dim strUsername
    Dim strDisabled = "true"
    Dim intSelectedSiteID = Request.Form("ddSite")

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

    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
    sqlRs1 = New ADODB.Recordset()
    sqlRs2 = New ADODB.Recordset()
   
    If intSelectedSiteID = "" Then
        intSelectedSiteID = "0"
    End If
   
    strError = Request.Form("txtError")
    strErrorColor = Request.Form("txtErrorColor")

%>
<html>
<head>
    <style>
.bodytxt {font-weight: normal;
          font-size: 11px;
          color: #333333;
          line-height: normal;
          font-family: Verdana, Arial, Helvetica, sans-serif;}
.FormDropdown 
{
      font-family: Verdana, Arial, Helvetica, sans-serif;
      font-size: 12px;
      color:#5F7AFC;
      width: 280px;
      border-width: 1px;
      border-style: solid;
      border-color: #CBD6E4;
}
a { text-decoration: none;}
</style>

    <script language="javascript" src="JavaScriptFunctions.js"></script>

</head>
<body>
    <form name="frmDispatch" method="post" action="UpdateDispatch.aspx">
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="98%">
                <tr>
                    <td width="100%" height="50" colspan="4">
                        <p align="center">
                            <img border="0" src="images/DispatchMgmt.jpg">
                    </td>
                </tr>
                <tr>
                    <td width="9%" height="30">
                        <font face="Verdana" size="2" color="#3952F9"><b>Site</b></font></td>
                    <td width="2%" height="30">
                        <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
                    <td width="69%" height="30">
                        <font face="Verdana" size="2" color="#3952F9">
                            <select name="ddSite" class="FormDropdown" onchange="goSubmit();" style="width: 472px">
                                <option value="0">- Select Site -</option>
                                <%
                                    Dim strSite
                                    Dim intSiteID
               
                                    objConn.open(strConn)
                                    
                                    sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                                                    "from telemetry_site_list_table where IN ("& strKontID &") order by sitedistrict, sitetype, sitename", objConn)
                                    
                                    Do While Not sqlRs.EOF
                                        strSite = sqlRs("sites").value
                                        intSiteID = sqlRs("siteid").value
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
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>
                    </td>
                    <td width="20%" height="30">
                        <p align="right">
                            <b><font size="1" face="Verdana"><a href="MelakaAddDispatch.aspx">Add New Dispatch</a></font></b>
                    </td>
                </tr>
            </table>
        </div>
        <center>
            <table border="0" width="98%" style="font-family: Verdana; font-size: 8pt">
                <tr style="background-color: #465AE8; color: #FFFFFF">
                    <th width="1%">
                        <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmDispatch')">
                    </th>
                    <th width="40%">
                        Rule</th>
                    <th width="20%">
                        Name</th>
                    <th width="17%">
                        Post</th>
                    <th width="15%">
                        SIM No</th>
                    <th width="8%">
                        Priority</th>
                </tr>
                <%
              
                    Dim intRuleID
                    Dim strName
                    Dim strPost
                    Dim intNum = 0
                    Dim strPriority
                    Dim strSIMNo
                    Dim intPosition
                    Dim strAlarmType
                    Dim strEquipType
               
                    objConn = New ADODB.Connection()
                    objConn.open(strConn)
             
                    sqlRs.Open("Select ruleid, alarmtype, position from telemetry_rule_list_table where siteid ='" & intSelectedSiteID & "'", objConn)
                    Do While Not sqlRs.EOF
                        sqlRs1.Open("select ruleid, name, post, priority, simno " & _
                                    " from telemetry_dispatch_list_table " & _
                                    " where ruleid ='" & sqlRs("ruleid").value & "'", objConn)
                        intPosition = sqlRs("position").value
                        strAlarmType = sqlRs("alarmtype").value
                        If Not sqlRs.EOF Then
                            strDisabled = "false"
                        Else
                            strDisabled = "true"
                        End If
             
                        Do While Not sqlRs1.EOF
                            sqlRs2.Open("select ""desc"" from telemetry_equip_list_table" & _
                                        " where siteid ='" & intSelectedSiteID & _
                                        "' and position=" & intPosition, objConn)
                            If Not sqlRs2.EOF Then
                                strEquipType = sqlRs2("desc").value
                            End If
                            sqlRs2.close()
                 
                            intRuleID = sqlRs1("ruleid").value
                            strName = sqlRs1("name").value
                            strPost = sqlRs1("post").value
                            strPriority = sqlRs1("priority").value
                            strSIMNo = sqlRs1("simno").value

                            If intNum = 0 Then
                                intNum = 1

                %>
                <tr bgcolor="#FFFFFF">
                    <%
                    ElseIf intNum = 1 Then
                        intNum = 0
                    %>
                    <tr bgcolor="#E7E8F8">
                        <%
                        End If
                        %>
                        <td width="1%">
                            <input type="checkbox" name="chkDelete" value="<%=intRuleID%>|<%=strSIMNo%>">
                        </td>
                        <td style="margin-left: 5">
                            <b><a href="javascript:gotoUpdate('frmDispatch', 'txtRule','<%=intRuleID%>,<%=strSIMNo%>');">
                                <%=strEquipType%>
                                :
                                <%=strAlarmType%>
                            </a></b>
                        </td>
                        <td style="margin-left: 5">
                            <%=strName%>
                        </td>
                        <td style="margin-left: 5">
                            <%=strPost%>
                        </td>
                        <td style="margin-left: 5">
                            <%=strSIMNo%>
                        </td>
                        <td style="margin-left: 5">
                            <%=strPriority%>
                        </td>
                    </tr>
                    <%
               
                        sqlRs1.movenext()
                    Loop
                    sqlRs1.close()
                    sqlRs.movenext()
                Loop
                sqlRs.close()
                objConn.close()
             
                sqlRs = Nothing
                sqlRs1 = Nothing
                sqlRs2 = Nothing
                objConn = Nothing
                    %>
                    <tr>
                        <td colspan="6">
                            <br>
                            <br>
                            <%If strDisabled = "false" Then%>
                            <a href="javascript:gotoDelete('frmDispatch','HelperPages/DeleteDispatch.aspx');">
                                <img border="0" src="Images/Delete.jpg">
                            </a>
                            <%End If%>
                        </td>
                    </tr>
            </table>
            <input type="hidden" name="txtRule" value="">
            <p align="center" style="margin-bottom: 15">
                <font size="1" face="Verdana" color="#5373A2">Copyright � <%=Now.ToString("yyyy") %> Gussmann Technologies
                    Sdn Bhd. All rights reserved. </font>
            </p>
    </form>
</body>
</html>

<script language="javascript">
  var strDisabled ="<%=strDisabled%>";
  document.onkeypress = checkCR;
  document.frmDispatch.ddSite.value="<%=intSelectedSiteID%>";
  
  if (strDisabled =="true")
  {
    document.frmDispatch.chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.frmDispatch.chkAllDelete.disabled = false;
  }


  function goSubmit()
  {
    document.frmDispatch.action="MelakaDispatch.aspx";
    document.frmDispatch.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }

</script>

