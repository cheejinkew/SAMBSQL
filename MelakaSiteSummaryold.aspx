<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim Tmconn = "DSN=tm;UID=tmp;PWD=tmp;"
    Dim district = "Besut"
    Dim sitetype = Request("Type")
  
    Dim strSiteName
    Dim siteid
    Dim sqlRs1
    Dim total = "Pressure"
%>
<!--#include file="report_head.aspx"-->
<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
    <style>
 a {text-decoration: none;} 

.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:right}
div#preload{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold}
div#trends {position:absolute;width:750px;height:440px;top:10px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
div#below {position:absolute;width:700px;height:100px;top:370px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
div#footnote{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#CBD6E4;font-weight:bold}
.td_label1{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:center}

.inputStyle
{
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  font-family: Verdana;
  font-size: 10pt;
  color: #3952F9;
  height: 20px
}
</style>
    <title>Site Summary</title>
    <div>
        <br />
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="50%">
                <tr>
                    <td width="100%" height="30" colspan="4">
                        <p align="center">
                            <img border="0" src="images/SiteSummary.jpg">
                    </td>
                </tr>
            </table>
        </div>
        <table width="240" border="0">
            <tr>
                <td class="td_label">
                    District :
                </td>
                <td>
                    <input type="text" name="siteid" class="inputStyle" value="<%=district%>" readonly></td>
            </tr>
        </table>
        <div style="padding-left: 18">
            <table border="1" align="center" style="border: solid 1 black; font-family: Verdana;
                font-size: 8pt">
                <tr style="background-color: #465AE8; border: solid 1 black; color: #FFFFFF">
                    <th style="border: solid 1 black;" width="180px">
                        Site Name</th>
                    <th style="border: solid 1 black;" width="160px">
                        Type</th>
                    <th style="border: solid 1 black;" width="160px">
                        Value</th>
                </tr>
                <%
                    Dim intNum = "0"
                    Dim i = 2
                    strConn = ConfigurationSettings.AppSettings("DSNPG")
                    objConn = New ADODB.Connection()
                    sqlRs = New ADODB.Recordset()
                    sqlRs1 = New ADODB.Recordset()
                    Dim position1 = ""
                    Dim positionpre = ""
                    Dim positionbar = ""
                    Dim st = ""
                    Dim st1 = ""
                    Dim siteFlow1 As String = "Flow"
                    Dim siteLevel1 As String = "Level"
                    objConn.open(strConn)
                    sqlRs.Open("SELECT sitename, siteid from telemetry_site_list_table where sitedistrict = '" & district & "' and siteid in ('STEF','STF1','STF0','F330') order by sitename", objConn)
                                               
                    Do While Not sqlRs.EOF
                        strSiteName = sqlRs("sitename").value
                        siteid = sqlRs("siteid").value
                        st = " m ^ 3/h"
                        st1 = " Bar"
                        
                        Tmconn = "DSN=g1;UID=tmp;PWD=tmp;"
                        position1 = 48
                        positionpre = 52
                        positionbar = 40
                      
                        If intNum = "0" Then%>
                <tr style="border: solid 1 black;" bgcolor="#FFFFFF">
                    <%  Else%>
                    <tr style="border: solid 1 black;" bgcolor="#E7E8F8">
                        <%
                        End If
                        %>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a>
                                <%=strSiteName%>
                            </a></font>
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue">
                                <%=siteLevel1%>
                            </font>
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a href="custom/CascadeTSelection.aspx?district=<%=district%>&siteid=<%=siteid%>&sitename=<%=strSiteName%>&position=<%=position1%>&equipname=WATER LEVEL"
                                title="Trending">
                                <%=Get_Current_Value(Tmconn, siteid, position1, 2)%>
                                m </a></font>
                        </td>
                    </tr>
                    <%If siteid = "STEF" Then%>
                    <tr style="border: solid 1 black;" bgcolor="#FFFFFF">
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue">Level 2 </font>
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a href="custom/CascadeTSelection.aspx?district=<%=district%>&siteid=<%=siteid%>&sitename=<%=strSiteName%>&position=49&equipname=WATER LEVEL"
                                title="Trending">
                                <%=Get_Current_Value(Tmconn, siteid, 49, 2)%>
                                m </a></font>
                        </td>
                    </tr>
                    <%End If%>
                    <tr style="border: solid 1 black;">
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            Last Update :<br />
                            <a>
                                <%=GetLastSequence(Tmconn, siteid, positionpre)%>
                            </a>
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a>
                                <%=siteFlow1 %>
                            </a></font>
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a href="custom/CascadeTSelection.aspx?district=<%=district%>&siteid=<%=siteid%>&sitename=<%=strSiteName%>&position=52&equipname=Flow Meter"
                                title="Trending">
                                <%=Get_Current_Value_Flowm(Tmconn, siteid, positionpre, 2) & st%>
                            </a></font>
                        </td>
                    </tr>
                    <%If siteid = "STEF" Then%>
                    <tr style="border: solid 1 black;">
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a>Flow 2 </a></font>
                        </td>
                        <td class="td_label1" style="font-family: Verdana;" align="center">
                            <font color="blue"><a href="custom/CascadeTSelection.aspx?district=<%=district%>&siteid=<%=siteid%>&sitename=<%=strSiteName%>&position=53&equipname=Flow Meter"
                                title="Trending">
                                <%=Get_Current_Value_Flowm(Tmconn, siteid, 53, 2) & st%>
                            </a></font>
                        </td>
                    </tr>
                    <%End If%>
                    <%
                    
                        If intNum = 1 Then
                            intNum = 0
                        Else
                            intNum = 1
                        End If
                        i = i + 1
                        sqlRs.movenext()
                    Loop
                    sqlRs.close()
                            
                    If intNum = "0" Then
                        intNum = 1%>
                    <tr style="border: solid 1 black;" bgcolor="#FFFFFF">
                        <%  Else
                                intNum = 0%>
                        <tr style="border: solid 1 black;" bgcolor="#E7E8F8">
                            <%
                            End If
                            %>
                            <td class="td_label1" style="font-family: Verdana;" align="center">
                                <font color="blue"><a>P Perhentian Besar </a></font>
                                <br />
                                Last Update :<br />
                                <a>
                                    <%=GetLastSequence(Tmconn, "F330", position1)%>
                                </a>
                            </td>
                            <td class="td_label1" style="font-family: Verdana;" align="center">
                                <font color="blue"><a>Flow</a></font></td>
                            <td class="td_label1" style="font-family: Verdana;" align="center">
                                <font color="blue"><a href="custom/CascadeTSelection.aspx?district=<%=district%>&siteid=F330&sitename=P Perhentian Besar&position=52&equipname=Flow Meter"
                                    title="Trending">
                                    <%=Get_Current_Value_Flowm(Tmconn, "F330", positionpre, 2) & st%>
                                </a></font>
                            </td>
                        </tr>
            </table>
        </div>
    </div>
</body>
</html>
