<%@ Page Language="VB" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
    Dim objConn = New ADODB.Connection()
    Dim sqlRs = New ADODB.Recordset()
    Dim strConn = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
    Dim Tmconn = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
    Dim district = "Melaka"
    Dim sitetype = Request("Type")
    Dim str As String = ""
    Dim strSiteName
    Dim siteid
    Dim sqlRs1
    Dim intNum
%>
<!--#include file="report_head.aspx"-->
<html>
<head>
    <title>Summary Page</title>
    <style type="text/css">/* Show only to IE PC \*/
* html .boxhead h2 {height: 1%;} /* For IE 5 PC */
 
.sidebox {
	 margin: 0 auto; /* center for now */
	width:490px; /* ems so it will grow */
	/*background: url(images/sbhead-r.gif) no-repeat bottom left;
	background-attachment:fixed;
    background-position: 10% 50%; */
	
}
.boxhead {
	background: url(images/sbhead-r.gif) no-repeat top right;
	margin: 0;
	padding: 0;
	text-align: center;
}
.boxhead h2 {
	background: url(images/sbhead-l.gif) no-repeat top left;
	margin: 0;
	padding: 22px 30px 5px;
	color: white; 
	font-weight: bold; 
	font-size: 1.2em; 
	line-height: 1em;
	text-shadow: rgba(0,0,0,.4) 0px 2px 5px; /* Safari-only, but cool */
}
.boxbody {
	/* background: url(images/sbbody-r.gif) no-repeat bottom left; */
	
	margin: 0;
	padding: 5px 5px 31px;
}

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
.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;color:#5F7AFC;font-weight:bold;text-align:right}
</style>
</head>
<body>
    <div>
        <center>
            <div>
                <img border="0" src="images/SiteSummary.jpg" alt="Site Summary" />
            </div>
            <br />
            <table style="font-family: Verdana; font-size: 11px;" cellpadding="0" cellspacing="0"
                border="0">
                <tr>
                    <td style="vertical-align: top">
                        <div class="sidebox">
                            <div class="boxhead">
                                <h2>
                                    Alor Gajah</h2>
                            </div>
                            <div class="boxbody">
                                <table border="1" align="center" style="border: solid 1 black; font-family: Verdana;
                                    font-size: 11px; width: 500px; height: auto;">
                                    <tr style="background-color: #4682b4; border: solid 1 black; color: #FFFFFF;">
                                        <th>
                                            Sitename</th>
                                        <th>
                                            Last Date Time</th>
                                        <th>
                                            Value</th>
                                    </tr>
                                    <%
                                        district = "Alor Gajah"
                                        intNum = 0
                                        'str = "SELECT siteid,sitename from telemetry_site_list_table where sitedistrict = '" & district & "'ORDER BY sitename ASC"
                                        str = "select t1.siteid,case when t1.sitetype ='RESERVOIR' then t1.sitename else t1.sitename+'_'+t2.sdesc end as sitename ,t2.position,t1.sitetype  from telemetry_site_list_table  t1 inner join telemetry_equip_list_table t2 on t1.siteid =t2.siteid where t1.sitedistrict = '" & district & "' and t1.sitetype  in ('BPH','RESERVOIR')  and SUBSTRING(t2.sdesc ,1,5)='LEVEL' ORDER BY sitename ASC"
                                       
                                        objConn.open(strConn)
                                        sqlRs.Open(str, objConn)
                                        Do While Not sqlRs.EOF
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
                                            <td>
                                                <%=sqlRs("sitename").value%>
                                            </td>
                                            <td>
                                                <%= GetLastSequence(Tmconn, sqlRs("siteid").value, sqlRs("position").value)%>
                                            </td>
                                            <td>
                                               <a style="text-decoration: none;" href="Summary.aspx?district=<%=district%>&siteid=<%=sqlRs("siteid").value%>&sitename=<%=sqlRs("sitename").value%>&position=<%=sqlRs("position").value%>&sitetype=<%=sqlRs("sitetype").value%>"
                                                    title="Trending">
                                                    <%=Get_Current_Value(Tmconn, sqlRs("siteid").value, sqlRs("position").value, 2)%>
                                                    m</a>
                                            </td>
                                        </tr>
                                        <%
                                            sqlRs.movenext()
                                        Loop
                                        sqlRs.close()
                                        objConn.close()
                                        %>
                                </table>
                            </div>
                        </div>
                    </td>      
                    <td style="vertical-align: top">
                    <div class="sidebox">
                            <div class="boxhead">
                                <h2>
                                    Jasin</h2>
                            </div>
                            <div class="boxbody">
                                <table border="1" align="center" style="border: solid 1 black; font-family: Verdana;
                                    font-size: 11px; width: 450px; height: auto;">
                                    <tr style="background-color: #4682b4; border: solid 1 black; color: #FFFFFF;">
                                        <th>
                                            Sitename</th>
                                        <th>
                                            Last Date Time</th>
                                        <th>
                                            Value</th>
                                    </tr>
                                    <%
                                        district = "Jasin"
                                        intNum = 0
                                        str = "SELECT siteid,sitename from telemetry_site_list_table where sitedistrict = '" & district & "'ORDER BY sitename ASC"
                                        objConn.open(strConn)
                                        sqlRs.Open(str, objConn)
                                        Do While Not sqlRs.EOF
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
                                            <td>
                                                <%=sqlRs("sitename").value%>
                                            </td>
                                            <td>
                                                <%=GetLastSequence(Tmconn, sqlRs("siteid").value, 2)%>
                                            </td>
                                            <td>
                                                <a style="text-decoration: none;" href="Summary.aspx?district=<%=district%>&siteid=<%=sqlRs("siteid").value%>&sitename=<%=sqlRs("sitename").value%>&position=2&sitetype=RESERVOIR"
                                                    title="Trending">
                                                    <%=Get_Current_Value(Tmconn, sqlRs("siteid").value, 2, 2)%>
                                                    m</a>
                                            </td>
                                        </tr>
                                        <%
                                            sqlRs.movenext()
                                        Loop
                                        sqlRs.close()
                                        objConn.close()
                                        %>
                                </table>
                            </div>
                        </div>
                    </td>              
                </tr>
                 <tr>
                    <td style="vertical-align: top">
                        <div class="sidebox">
                            <div class="boxhead">
                                <h2>
                                    Melaka Tengah</h2>
                            </div>
                            <div class="boxbody">
                                <table border="1" align="center" style="border: solid 1 black; font-family: Verdana;
                                    font-size: 11px; width: 450px; height: auto;">
                                    <tr style="background-color: #4682b4; border: solid 1 black; color: #FFFFFF;">
                                        <th>
                                            Sitename</th>
                                        <th>
                                            Last Date Time</th>
                                        <th>
                                            Value</th>
                                    </tr>
                                    <%
                                        district = "Melaka Tengah"
                                        intNum = 0
                                        str = "SELECT siteid,sitename from telemetry_site_list_table where sitedistrict = '" & district & "'ORDER BY sitename ASC"
                                        objConn.open(strConn)
                                        sqlRs.Open(str, objConn)
                                        Do While Not sqlRs.EOF
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
                                            <td>
                                                <%=sqlRs("sitename").value%>
                                            </td>
                                            <td>
                                                <%=GetLastSequence(Tmconn, sqlRs("siteid").value, 2)%>
                                            </td>
                                            <td>
                                                <a style="text-decoration: none;" href="Summary.aspx?district=<%=district%>&siteid=<%=sqlRs("siteid").value%>&sitename=<%=sqlRs("sitename").value%>&position=2&sitetype=RESERVOIR"
                                                    title="Trending">
                                                    <%=Get_Current_Value(Tmconn, sqlRs("siteid").value, 2, 2)%>
                                                    m</a>
                                            </td>
                                        </tr>
                                        <%
                                            sqlRs.movenext()
                                        Loop
                                        sqlRs.close()
                                        objConn.close()
                                        %>
                                </table>
                            </div>
                        </div>
                    </td>     
                    </tr>
            </table>
        </center>
    </div>
</body>
</html>
