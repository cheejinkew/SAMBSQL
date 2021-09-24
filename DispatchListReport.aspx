<%@ Page Language="VB" Debug="true" %>

<!--#include file="kont_id.aspx"-->
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
    Dim ec As String = "false"
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
        .bodytxt
        {
            font-weight: normal;
            font-size: 11px;
            color: #333333;
            line-height: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
        }
        .FormDropdown
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #5F7AFC;
            width: 90%;
            border-width: 1px;
            border-style: solid;
            border-color: #CBD6E4;
        }
        a
        {
            text-decoration: none;
        }
    </style>
    <script language="javascript" src="JavaScriptFunctions.js"></script>
</head>
<body>
    <form name="frmDispatch" method="post" action="UpdateDispatch.aspx">
    <div align="center">
        <table border="0" cellpadding="0" cellspacing="0" width="98%">
            <tr>
                <td width="100%" height="50" colspan="4">
                    <center>
                        <table style="font-family: Verdana; font-size: 11px;">
                            <tr>
                                <td style="height: 20px; background-color: #4D90FE;" align="left">
                                    <b style="color: White;">&nbsp;District List Report :</b>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 450px; border: solid 1px #3952F9;">
                                    <table style="width: 450px;">
                                        <tr>
                                            <td colspan="3">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <b style="color: #5f7afc; font-size: small">Site</b>
                                            </td>
                                            <td>
                                                <b style="color: #5f7afc;">:</b>
                                            </td>
                                            <td align="left">
                                                <font face="Verdana" size="2" color="#3952F9">
                                                    <select name="ddSite" class="FormDropdown" id="ddSite" onchange="goSubmit();">
                                                        <option value="0">- Select Site -</option>
                                                        <option value="ALL">ALL</option>
                                                        <%
                                                            Dim strSite
                                                            Dim intSiteID
               
                                                            objConn.open(strConn)
      
                                                            If arryControlDistrict(0) <> "ALL" Then
                                                                sqlRs.Open("SELECT siteid, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                                                                        "from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") " & _
                                                                        "and siteid NOT IN (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                                                            Else
                                                                sqlRs.Open("SELECT siteid, sitedistrict + ' : ' + sitetype + ' : ' + sitename as sites " & _
                                                                        "from telemetry_site_list_table where siteid NOT IN (" & strKontID & ") order by sitedistrict, sitetype, sitename", objConn)
                                                            End If
               
                                                            Do While Not sqlRs.EOF
                                                                strSite = sqlRs("sites").value
                                                                intSiteID = sqlRs("siteid").value
                                                        %>
                                                        <option value="<%=intSiteID%>">
                                                            <%=strSite%></option>
                                                        <%

                                                            sqlRs.movenext()
                                                        Loop
                
                                                        sqlRs.close()
                                                        objConn.close()
                                                        objConn = Nothing
               
                                                        %>
                                                    </select></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <br />
                                            </td>
                                        </tr>
                                        <tr><td colspan ="3" style="text-align:right;"><a href="javascript:ExcelReport();"><input  class="button-blue button-blue:active button-blue:hover buttonAlign" type="button" name="btnExcel" value="Excel"/></a></td></tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </center>
                </td>
            </tr>
        </table>
    </div>
    <center>
        <table border="0" width="98%" style="font-family: Verdana; font-size: 8pt">
            <tr style="background-color: #5f7afc; color: #FFFFFF">
            <th width="5%">
                   S.No
                </th>
                <th width="10%">
                    Site District
                </th>
                <th width="10%">
                    Site ID
                </th>
                <th width="20%">
                    Site Name
                </th>
                <th width="40%">
                    Rule
                </th>
                <th width="20%">
                    Name
                </th>
                <th width="17%">
                    Post
                </th>
                <th width="15%">
                    SIM No
                </th>
                <th width="8%">
                    Priority
                </th>
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
                Dim siteid
                Dim sitename
                Dim sitedistrict
                objConn = New ADODB.Connection()
                objConn.open(strConn)
                If intSelectedSiteID = "ALL" Then
                    sqlRs.Open("select d.sitedistrict ,c.siteid,d.sitename , c.sdesc+':'+b.alarmtype  srule,a.sname ,a.post ,a.simno ,a.priority  from telemetry_dispatch_list_table a inner join telemetry_rule_list_table b on a.ruleid=b.ruleid inner join telemetry_equip_list_table c inner join telemetry_site_list_table d on c.siteid =d.siteid   on b.siteid =c.siteid and b.position =c.position where d.sitedistrict<>'Testing' order by d.sitedistrict, c.siteid", objConn)
                Else
                    sqlRs.Open("select d.sitedistrict , c.siteid,d.sitename , c.sdesc+':'+b.alarmtype  srule,a.sname ,a.post ,a.simno ,a.priority  from telemetry_dispatch_list_table a inner join telemetry_rule_list_table b on a.ruleid=b.ruleid inner join telemetry_equip_list_table c inner join telemetry_site_list_table d on c.siteid =d.siteid   on b.siteid =c.siteid and b.position =c.position  where c.siteid ='" & intSelectedSiteID & "'", objConn)
                End If
                Dim sno As Integer = 1
                Do While Not sqlRs.EOF
                    
                    siteid = sqlRs("siteid").value
                    sitename = sqlRs("sitename").value
                    strEquipType = sqlRs("srule").value
                    strName = sqlRs("sname").value
                    strPost = sqlRs("post").value
                    strPriority = sqlRs("priority").value
                    strSIMNo = sqlRs("simno").value
                    sitedistrict = sqlRs("sitedistrict").value

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
                     <td style="margin-left: 5">
                        <%= sno%>
                    </td>
                     <td style="margin-left: 5">
                        <%= sitedistrict%>
                    </td>
                    <td style="margin-left: 5">
                        <%= siteid%>
                    </td>
                    <td style="margin-left: 5">
                        <%= sitename%>
                    </td>
                    <td style="margin-left: 5">
                        <%=strEquipType%>
                    </td>
                    <td style="margin-left: 5">
                        <%=strName%>
                    </td>
                    <td style="margin-left: 5">
                        <%=strPost%>s
                    </td>
                    <td style="margin-left: 5">
                        <%=strSIMNo%>
                    </td>
                    <td style="margin-left: 5">
                        <%=strPriority%>
                    </td>
                </tr>
                <%
                    sno = sno+1
                    ec = "true"
                    sqlRs.movenext()
                Loop
                sqlRs.close()
                objConn.close()
             
                sqlRs = Nothing
          
                objConn = Nothing
                %>
        </table>
        <input type="hidden" name="txtRule" value="">
        <p align="center" style="margin-bottom: 15">
            <font size="1" face="Verdana" color="#5373A2">Copyright ?2005 Gussmann Technologies
                Sdn Bhd. All rights reserved. </font>
        </p>
    </form>
    <form id="excelform" method="get" action="ExcelDispatchListReport.aspx"> 
        <input type="hidden" id="siteid" name="siteid" value="" />
    </form>
</body>
</html>
<script language="javascript">
    var strDisabled = "<%=strDisabled%>";
    document.onkeypress = checkCR;
    document.frmDispatch.ddSite.value = "<%=intSelectedSiteID%>";

    if (strDisabled == "true") {
        document.frmDispatch.chkAllDelete.disabled = strDisabled;
    }
    else {
        document.frmDispatch.chkAllDelete.disabled = false;
    }
    var ec=<%=ec %>;
    function ExcelReport() {
    ec=true;
        if (ec == true) {
        var siteid=document.getElementById("ddSite").value;
        document.getElementById("siteid").value=siteid;
            var excelformobj = document.getElementById("excelform");
            excelformobj.submit();
        }
        else {
            alert("First click submit button");
        }
    }
    function goSubmit() {
        document.frmDispatch.action = "DispatchListReport.aspx";
        document.frmDispatch.submit();
    }

    var strSession = '<%=session("login")%>';
    if (strSession != "true") {
        top.location.href = "login.aspx";
    }

</script>
