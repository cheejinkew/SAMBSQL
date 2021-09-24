<%@ Page Language="VB" Debug="true" %>
<!--#include file="../kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
    ' Ajax Left feed!
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim strDistrict
    Dim strSelectedDistrict = "Melaka"
    Dim strType
    Dim strSelectedType = Request("ddType")
    Dim strSiteName
    Dim intSiteID
    Dim intUnitID
    Dim intNum
    Dim intSiteType
    Dim strError
    Dim strErrorColor
     
    
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
       
    If strSelectedType = "BPH" Then
        objConn.open("DSN=tm;UID=tmp;PWD=tmp;")
    Else
        objConn.open(strConn)
    End If

    If Request("choice") = "list" Then

        sqlRs.Open("SELECT sitename, siteid, simno,sitetype from telemetry_site_list_table a left join unit_list b on " & _
     "a.unitid=b.unitid where siteid IN ("& strKontID &") order by sitename", objConn)
%>
<center>
    <table border="0" width="100%" style="font-family: Verdana; font-size: 8pt">
        <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="56%">
                Site Name</th>
            <th width="22%">
                Site ID</th>
            <%  Select Case strSelectedType
                    Case "F1 FLOWMETER"%>
            <%Case "RADCOM"%>
            <%Case Else%>
            <th width="22%">
                Sim No</th>
            <%End Select%>
        </tr>
        <%               
            Do While Not sqlRs.EOF
                strSiteName = sqlRs("sitename").value
                intSiteID = sqlRs("siteid").value
                intUnitID = sqlRs("simno").value
                intSiteType = sqlRs("sitetype").value
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
                'If intSiteID = "9012" Then
                Select Case intSiteID
                    Case "9012"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9035B"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9045C"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9045B"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9104B"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9103B"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9046B"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "9049B"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "8511", "8512", "8619", "8620", "8621", "8643", "8546", "8663"
                    'If intSiteID = "STF0" Then
                    '    strSiteName = "P Perhentian Kecil R1"
                    'End If
                    'If intSiteID = "STF1" Then
                    '    strSiteName = "P Perhentian Kecil R2"
                    'End If
                %>
                <td style="margin-left: 5">
                    <b><a href="../../../samb_kontraktor/Summary.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=intSiteType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case Else
                    Select Case strSelectedType
                        Case "RADCOM"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/Radcom.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%			
                Case "F1 FLOWMETER"
                    If Left(intSiteID, 1) = "F" Then
                        If intSiteID = "F00A5" Then
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/perhentian4.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=Server.URLEncode(strSelectedDistrict)%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Else
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/MAG8000.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=Server.URLEncode(strSelectedDistrict)%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                End If
            Else
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/lflowflevel.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                End If
            Case "F2 FLOWMETER"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/flow.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=Server.URLEncode(strSelectedDistrict)%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Case "WTP"
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/cascades.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%	
                Case Else
                %>
                <td style="margin-left: 5">
                    <b><a href="Summary.aspx?siteid=<%=intSiteID%>&sitename=<%=Server.URLEncode(strSiteName)%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
            End Select
    End Select
                %>
                <td style="margin-left: 5">
                    <%=intSiteID%>
                </td>
                <%  Select Case strSelectedType
                        Case "F1 FLOWMETER"%>
                <%Case "RADCOM"%>
                <%Case Else%>
                <td style="margin-left: 5">
                    <%=intUnitID%>
                </td>
                <%End Select%>
            </tr>
            <%
                sqlRs.movenext()
            Loop           
            'If intNum = 0 Then
            '    intNum = 1

        %>
        <%--<tr bgcolor="#FFFFFF">
            <%
            ElseIf intNum = 1 Then
                intNum = 0
            %>
            <tr bgcolor="#E7E8F8">
                <%
                End If 
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/perhentian4.aspx?siteid=F330&sitename=P Perhentian Besar&district=<%=Server.URLEncode(strSelectedDistrict)%>&sitetype=F1 FLOWMETER"
                        target="main">P Perhentian Besar </a></b>
                </td>
                <td style="margin-left: 5">
                    F330
                </td>
                <td style="margin-left: 5">
                    -
                </td>
            </tr>--%>
    </table>
    <%
    Else
              
        sqlRs.Open("SELECT distinct(sitetype) from telemetry_site_list_table where sitedistrict='" & _
                    strSelectedDistrict & "'", objConn)

        Do While Not sqlRs.EOF
            strType = strType & sqlRs("sitetype").value & ","
            sqlRs.movenext()
        Loop
        strType = Left(strType, Len(strType) - 1)
        Response.Write(strType)
    End If

    sqlRs.close()
    objConn.close()
    sqlRs = Nothing
    objConn = Nothing
    %>
