<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<!-- #Include file="../custom/mimicinfo.aspx" -->
<!--#include file="../kont_id.aspx"-->
<%
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim strDistrict
    Dim strSelectedDistrict = Request("ddDistrict")
    Dim strType
    Dim strSelectedType = Request("ddType")
    Dim strSiteName
    Dim intSiteID
    Dim intUnitID
    Dim intNum
    Dim strError
    Dim strErrorColor
    Dim vesrionid
     
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
   
    objConn.open(strConn)
	
'========== Try getting the XML data ===========
	
Response.Buffer = True
Dim TWL1, BWL1
Dim xml,el
	xml = Server.CreateObject("Microsoft.XMLDOM")
	xml.async = False
	xml.load (Server.MapPath( "..\custom\info\mimic.xml"))

If not xml.parseError.errorCode <> 0 Then
	if (xml.documentElement.hasChildNodes()) then		
		el = xml.getElementsByTagName("site")
		TWL1 = get_values(el,"id","8535","system")
	end if
else
		TWL1 = "N/A"	
End If
'=======================================

    If Request("choice") = "list" Then

        '   sqlRs.Open("SELECT sitename, siteid, unitid from telemetry_site_list_table where sitedistrict='" & _
        '              strSelectedDistrict & "' and sitetype='" & strSelectedType & "' order by sitename",objConn)
              
        sqlRs.Open("SELECT sitename, siteid, simno,versionid from telemetry_site_list_table a left join unit_list b on " & _
          "a.unitid=b.unitid where sitedistrict='" & strSelectedDistrict & "' and siteid NOT IN (" & strKontID & ") and sitetype='" & strSelectedType & "' order by sitename", objConn)
%>
<center>
    <table border="0" width="100%" style="font-family: Verdana; font-size: 8pt">
        <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="56%">Site Name</th>
            <th width="12%">System</th>
			<th width="10%">Site ID</th>
            <th width="22%">Sim No</th>
        </tr>
        <%               
            Do While Not sqlRs.EOF
                strSiteName = sqlRs("sitename").value
                intSiteID = sqlRs("siteid").value
                '      intUnitID = sqlRs("unitid").value
                intUnitID = sqlRs("simno").value
                vesrionid = sqlRs("versionid").value
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

                If strSelectedType = "WTP" Then%>
                <td style="margin-left: 5">
                    <b><a href="Summarywtp.aspx?siteid=<%=intSiteID%>&sitename=<%=strSiteName%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>                    
             <%   
             ElseIf strSelectedType = "BPH" Then%>
               <td style="margin-left: 5">
                  <% If intSiteID = "S1H1" Then%>
                    <b><a href="../custom/bph_s1h1.aspx"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                    <% ElseIf intSiteID = "S1H2" Then%>
                     <b><a href="../custom/bph_s1h2.aspx"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                     <% ElseIf intSiteID = "S1H3" Then%>
                     <b><a href="../custom/bph_s1h3.aspx"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                    <%End If%>
                </td>                      
             <%   
             Else
                    
                    If intSiteID = "9012" Then
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/bph_ambs.aspx?siteid=<%=intSiteID%>&sitename=<%=strSiteName%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%  Else
                        If strSelectedType = "DAM" Then
                %>
                <td style="margin-left: 5">
                    <b><a href="custom/dam.aspx?siteid=<%=intSiteID%>&sitename=<%=strSiteName%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                Else
                %>
                <td style="margin-left: 5">
                    <b><a href="Summary.aspx?siteid=<%=intSiteID%>&sitename=<%=strSiteName%>&district=<%=strSelectedDistrict%>&sitetype=<%=strSelectedType%>&v=<%=vesrionid%>"
                        target="main">
                        <%=strSiteName%>
                    </a></b>
                </td>
                <%
                End If
            End If
        End If%>
				<td style="text-align:center;"><%=get_values(el,"id",intSiteID,"system")%></td>
                <td style="margin-left: 5"><%=intSiteID%></td>
                <td style="margin-left: 5"><%=intUnitID%></td>
            </tr>
        <%
            sqlRs.movenext()
        Loop
        %>
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