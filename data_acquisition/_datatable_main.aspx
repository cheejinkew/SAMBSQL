<%@ Page Language="VB" %>

<%@ Import Namespace="ADODB" %>
<!-- this comment puts all versions of Internet Explorer into "reliable mode." -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    If Request.QueryString("ekspot") = "yes" Then
%>
<!--#include file="save2excel.aspx"-->
<%
End If
%>
<!--#include file="report_head.aspx"-->

<script runat="server">
    Dim site
    Dim siteidlist
    
    Dim state2
    Dim level_read, RF_read, cumRainfall, maya, tempoh
    Dim total_rainfall
    Dim names
    Dim i
    Dim end_date
      
    Dim strconn = ConfigurationSettings.AppSettings("DSNPG1")
    'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
    Dim objConn = New ADODB.Connection()
    Dim sqlRs = New ADODB.Recordset()
    
</script>

<%
	Dim Text
    Dim dist As String = Request.QueryString("dist")
    Dim table = Request.QueryString("table")
    Dim start_date = Request.QueryString("start")
    'Dim metar = GetDistrict(strconn, 128, 2).Replace("|", "'")
    If table = 1 Then
        start_date = start_date + " 00:00:00"
    ElseIf table = 2 Then
        start_date = start_date + " 08:00:00"
    ElseIf table = 3 Then
        start_date = start_date + " 16:00:00"
    End If
    Dim k As Integer = 0
   
%>
<html>
<head>
    <title>Data Aquisition Report</title>

    <script type="text/javascript">
function lockCol(tblID) 
{
	var table = document.getElementById(tblID);
	
	var cTR = table.getElementsByTagName('TR');  //collection of rows
	if (table.rows[0].cells[0].className == '') 
	{     
		for (i = 0; i < cTR.length; i++)
			{
			var tr = cTR.item(i);
			tr.cells[0].className = 'locked'
			tr.cells[1].className = 'locked'
			
			}
	}
	else {
		for (i = 0; i < cTR.length; i++)
			{
			var tr = cTR.item(i);
			tr.cells[0].className = ''
			tr.cells[1].className = ''
	      	}
		 }
}

    </script>

    <style>
div#tbl-container {
width: 100%;
height: 450px;
overflow:scroll;
scrollbar-color:#336699;
}

table {
table-layout:fixed;
border-collapse:collapse;
background-color: White;
}

div#tbl-container table th {

}
	

thead th, thead th.locked{
font-size: 14px;
font-weight: bold;
text-align: center;
color: white;
position:relative;
cursor: default; 

}
	
thead th {
top: expression(document.getElementById("tbl-container").scrollTop-2); /* IE5+ only */
z-index: 20;
}

thead th.locked {z-index: 30;
	
}

td.locked,  th.locked
{
background-color: White;

left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;
}

/*these styles have nothing to do with the locked column*/
body {
background-color: white;
color: black;
font-family: Verdana, Arial, Helvetica, sans-serif;
}

td 
{

padding: 1px 1px 1px 1px;
font-size: 11px;
border:1px solid #336699;

}

button {
width: 150px; 
font-weight: bold;
color: navy;
margin-bottom: 5px;
}

div.infobox {
position:absolute; 
top:110px; 
left:470px; 
right:5px; 
border: double 4px #6633ff;
padding:8px; 
font-size:12px; 
font-family:Arial, sans-serif; 
text-align:justify; 
text-justify:newspaper; 
background-color:white;
}

blockquote	{
font-family: Tahoma, Verdana, sans-serif;
font-size: 85%;
border: double 4px #6633ff;
padding: 8px 20px;
margin: 3% auto auto 0;
background-color: white;
width: 418px;
}

.sig	{
color:#6633ff;
font-style: italic;
letter-spacing: 2px;
}
</style>
</head>
<body onload="lockCol('tbl')">
    <center>
        <h4>
            <%If table = "1" Then%>
            <b>WATER LEVEL LOG DATA BETWEEN 12:00AM - 08:00AM (m)</b>
            <%ElseIf table = "2" Then%>
            <b>WATER LEVEL LOG DATA BETWEEN 08:00AM - 04:00PM (m)</b>
            <%ElseIf table = "3" Then%>
            <b>WATER LEVEL LOG DATA BETWEEN 04:00PM - 12:00AM (m)</b>
            <% End If%>
        </h4>
    </center>
    <% 
        tempoh = 8
        end_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(tempoh))%>
    <table style="border: 0px;">
        <tr>
            <td style="border: 0px;">
                <b>District : <font color='blue' size="2">
                    <%=dist %>
                </font></b>
                <br />
                <b>Start :</b>
                <%=Format_Full_Time(start_date,3)%>
                <br />
                <b>End &nbsp; :</b>
                <%=Format_Full_Time(end_date,3)%>
            </td>
        </tr>
    </table>
    <div id="tbl-container">
        <table id="tbl">
            <thead>
                <%  Dim s As Integer = 0%>
                <th style="border-collapse: collapse; width: 100px">
                </th>
                <th style="width: 150px">
                </th>
                <% For s = 0 To 31%>
                <th style="width: 55px">
                </th>
                <% Next%>
                <th style="width: 100px">
                </th>
                <th style="width: 100px">
                </th>
            </thead>
            <%
                Select Case table
                    Case 1 '12:00AM -08:00AM
            %>
            <%  
                
                tempoh = 8
		
                end_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(tempoh))
                objConn.open(strconn)
                'Text = "select siteid,sitename from telemetry_site_list_table where sitetype='RESERVOIR' and sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
				Text = "select siteid,sitename from telemetry_site_list_table where sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
                sqlRs.Open(Text, objConn)
            %>
            <tbody>
                <tr>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Site No</td>
                    <td align="center" style="width: 150px; font-weight: bold;">
                        Site Name
                    </td>
                    <%
                        Dim strdate = start_date
                        For i = 0 To 31
                    %>
                    <td align="center" style="width: 55px; font-weight: bold;">
                        <%=String.Format("{0:HH:mm}", Date.Parse(strdate).AddMinutes(15))%>
                    </td>
                    <%
                        strdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate).AddMinutes(15))
                    Next i
                    %>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Percentage(%)</td>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Latest Value (m)</td>
                </tr>
                <%
                    Do Until sqlRs.EOF
                %>
                <tr>
                    <td align="center" style="width: 100px">
                        <%=sqlRs("siteid").value %>
                    </td>
                    <%--'siteidlist = siteidlist & sqlRs("siteid").value & ","
                     'siteidlist = Left(siteidlist,Len(siteidlist) - 1)--%>
                    <%  site = sqlRs("siteid").value
                        Dim objConn1 = New ADODB.Connection()
                        Dim sqlRs1 = New ADODB.Recordset()
                       
                        objConn1.open(strconn)
                        sqlRs1.open("select alarmtype from telemetry_rule_list_table where siteid='" & site & "'", objConn)
                        If sqlRs1.EOF Then
                            state2 = ""
                        Else
                            state2 = sqlRs1("alarmtype").value
                        End If
                           
                        sqlRs1.Close()
                        objConn1.close()
                        sqlRs1 = Nothing
                        objConn1 = Nothing
                    %>
                    <td align="left" style="width: 150px">
                        <%=GetSiteName(strconn, Trim(sqlRs("siteid").value))%>
                    </td>
                    <%
                        Dim strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddMinutes(-15))
                        For i = 0 To 31
                            level_read = Get_readings_per_hour(1, strconn, sqlRs("siteid").value, 2, String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddMinutes(15)))
                            strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddMinutes(15))
                            names = sqlRs("sitename").value
                            If Not level_read = "-" Then
                                level_read = FormatNumber(level_read)
                            Else
                                k = k + 1
                            End If
                  
                                     
                       
                    %>
                    <td align="center" title="<%=names %>" style="width: 55px">
                        <%  If state2 = "" Then
                                Response.Write("<font color='olive'>" & level_read & " </font>")
                            ElseIf state2 = "LL" Then
                                Response.Write("<font color='black'>" & level_read & " </font>")
                            ElseIf state2 = "L" Then
                                Response.Write("<font color='light blue'>" & level_read & " </font>")
                            ElseIf state2 = "NN" Then
                                Response.Write("<font color='green'>" & level_read & " </font>")
                            ElseIf state2 = "H" Then
                                Response.Write("<font color='maroon'>" & level_read & " </font>")
                            ElseIf state2 = "HH" Then
                                Response.Write("<font color='red'>" & level_read & " </font>")
                            End If
                      
                        %>
                    </td>
                    <%
                    Next i
                    Dim clevel = Get_readings_maxoravg(strconn, sqlRs("siteid").value, 2)
                    sqlRs.MoveNext()
                    If k = 32 Then
                        k = 0
                    ElseIf k >= 1 Then
                        k = System.Convert.ToInt32(Math.Round(((k * 100) / 32), 2))
                        k = 100 - k
                    Else
                        k = 100
                    End If
                    %>
                    <td align="center" title="<%=names %>" style="width: 100px">
                        <% Response.Write(k)%>
                    </td>
                    <td align="center" title="<%=names %>">
                        <% If state2 = "" Then%>
                        <font color="Olive">
                            <%=clevel%>
                        </font>
                        <%ElseIf state2 = "LL" Then%>
                        <font color="black">
                            <%=clevel & " " & "(LL)"%>
                        </font>
                        <%ElseIf state2 = "L" Then%>
                        <font color="light blue">
                            <%=clevel & " " & "(L)"%>
                        </font>
                        <%ElseIf state2 = "NN" Then%>
                        <font color="green">
                            <%=clevel & " " & "(NN)"%>
                        </font>
                        <%ElseIf state2 = "H" Then%>
                        <font color="maroon">
                            <%=clevel & " " & "(H)"%>
                        </font>
                        <%ElseIf state2 = "HH" Then%>
                        <font color="red">
                            <%=clevel & " " & "(HH)"%>
                        </font>
                        <%End If%>
                    </td>
                </tr>
                <%
                    k = 0
                Loop
                %>
            </tbody>
            <%
           
                sqlRs.Close()
                objConn.close()
                sqlRs = Nothing
                objConn = Nothing
            %>
            <%
    
            Case 2 '08:00AM -04:00PM
            %>
            <%  
                tempoh = 8
		
                end_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(tempoh))
                objConn.open(strconn)                
                'Text = "select siteid,sitename from telemetry_site_list_table where sitetype='RESERVOIR' and sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"				
                Text = "select siteid,sitename from telemetry_site_list_table where sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
				sqlRs.Open(Text, objConn)
            %>
            <tbody>
                <tr>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Site No</td>
                    <td align="center" style="width: 150px; font-weight: bold;">
                        Site Name
                    </td>
                    <%
                        Dim strdate = start_date
                        For i = 0 To 31
                    %>
                    <td align="center" style="width: 55px; font-weight: bold;">
                        <%=String.Format("{0:HH:mm}", Date.Parse(strdate).AddMinutes(15))%>
                    </td>
                    <%
                        strdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate).AddMinutes(15))
                    Next i
                    %>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Percentage(%)</td>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Latest Value (m)</td>
                </tr>
                <%
                    Do Until sqlRs.EOF
                %>
                <tr>
                    <td align="center" style="width: 100px">
                        <%=sqlRs("siteid").value%>
                    </td>
                    <%
                        site = sqlRs("siteid").value
                        Dim objConn1 = New ADODB.Connection()
                        Dim sqlRs1 = New ADODB.Recordset()
                       
                        objConn1.open(strconn)
                        sqlRs1.open("select alarmtype from telemetry_rule_list_table where siteid='" & site & "'", objConn)
                        If sqlRs1.EOF Then
                            state2 = ""
                        Else
                            state2 = sqlRs1("alarmtype").value
                        End If
                           
                        sqlRs1.Close()
                        objConn1.close()
                        sqlRs1 = Nothing
                        objConn1 = Nothing
                    %>
                    <td align="left" style="width: 150px">
                        <%=GetSiteName(strconn, Trim(sqlRs("siteid").value))%>
                    </td>
                    <%
                        Dim strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddMinutes(-15))
                        For i = 0 To 31
                            level_read = Get_readings_per_hour(1, strconn, sqlRs("siteid").value, 2, String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddMinutes(15)))
                            strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddMinutes(15))
                            names = sqlRs("sitename").value
                            If Not level_read = "-" Then
                                level_read = FormatNumber(level_read)
                            Else
                                k = k + 1
                            End If
                    %>
                    <td align="center" title="<%=names %>" style="width: 55px">
                       <%  If state2 = "" Then
                                Response.Write("<font color='olive'>" & level_read & " </font>")
                            ElseIf state2 = "LL" Then
                                Response.Write("<font color='black'>" & level_read & " </font>")
                            ElseIf state2 = "L" Then
                                Response.Write("<font color='light blue'>" & level_read & " </font>")
                            ElseIf state2 = "NN" Then
                                Response.Write("<font color='green'>" & level_read & " </font>")
                            ElseIf state2 = "H" Then
                                Response.Write("<font color='maroon'>" & level_read & " </font>")
                            ElseIf state2 = "HH" Then
                                Response.Write("<font color='red'>" & level_read & " </font>")
                            End If
                      
                        %>
                    </td>
                    <%
                    Next i
                    Dim clevel = Get_readings_maxoravg(strconn, sqlRs("siteid").value, 2)
                    sqlRs.MoveNext()
                    If k = 32 Then
                        k = 0
                    ElseIf k >= 1 Then
                        k = System.Convert.ToInt32(Math.Round(((k * 100) / 32), 2))
                        k = 100 - k
                    Else
                        k = 100
                    End If
                    %>
                    <td align="center" title="<%=names %>" style="width: 100px">
                        <% Response.Write(k)%>
                    </td>
                    <td align="center" title="<%=names %>">
                         <% If state2 = "" Then%>
                        <font color="Olive">
                            <%=clevel%>
                        </font>
                        <%ElseIf state2 = "LL" Then%>
                        <font color="black">
                            <%=clevel & " " & "(LL)"%>
                        </font>
                        <%ElseIf state2 = "L" Then%>
                        <font color="light blue">
                            <%=clevel & " " & "(L)"%>
                        </font>
                        <%ElseIf state2 = "NN" Then%>
                        <font color="green">
                            <%=clevel & " " & "(NN)"%>
                        </font>
                        <%ElseIf state2 = "H" Then%>
                        <font color="maroon">
                            <%=clevel & " " & "(H)"%>
                        </font>
                        <%ElseIf state2 = "HH" Then%>
                        <font color="red">
                            <%=clevel & " " & "(HH)"%>
                        </font>
                        <%End If%>
                    </td>
                </tr>
                <%
                    k = 0
                Loop
                %>
            </tbody>
            <%
                sqlRs.Close()
                objConn.close()
                sqlRs = Nothing
                objConn = Nothing
        
            %>
            <%
    
            Case 3 '04:00PM -12:00AM
            %>
            <%  
                
                tempoh = 8
		
                end_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(tempoh))
                objConn.open(strconn)
                
                'Text = "select siteid,sitename from telemetry_site_list_table where sitetype='RESERVOIR' and sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
                Text = "select siteid,sitename from telemetry_site_list_table where sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
				sqlRs.Open(Text, objConn)
            %>
            <tbody>
                <tr>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Site No</td>
                    <td align="center" style="width: 150px; font-weight: bold;">
                        Site Name
                    </td>
                    <%
                        Dim strdate = start_date
                        For i = 0 To 31
                    %>
                    <td align="center" style="width: 55px; font-weight: bold;">
                        <%=String.Format("{0:HH:mm}", Date.Parse(strdate).AddMinutes(15))%>
                    </td>
                    <%
                        strdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate).AddMinutes(15))
                    Next i
                    %>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Percentage(%)</td>
                    <td align="center" style="width: 100px; font-weight: bold;">
                        Latest Value (m)</td>
                </tr>
                <%
                    Do Until sqlRs.EOF
                %>
                <tr>
                    <td align="center" style="width: 100px">
                        <%=sqlRs("siteid").value%>
                    </td>
                    <%
                        site = sqlRs("siteid").value
                        Dim objConn1 = New ADODB.Connection()
                        Dim sqlRs1 = New ADODB.Recordset()
                       
                        objConn1.open(strconn)
                        sqlRs1.open("select alarmtype from telemetry_rule_list_table where siteid='" & site & "'", objConn)
                        If sqlRs1.EOF Then
                            state2 = ""
                        Else
                            state2 = sqlRs1("alarmtype").value
                        End If
                           
                        sqlRs1.Close()
                        objConn1.close()
                        sqlRs1 = Nothing
                        objConn1 = Nothing
                    %>
                    <td align="left" style="width: 150px">
                        <%=GetSiteName(strconn, Trim(sqlRs("siteid").value))%>
                    </td>
                    <%
                        Dim strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddMinutes(-15))
                        For i = 0 To 31
                            level_read = Get_readings_per_hour(1, strconn, sqlRs("siteid").value, 2, String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddMinutes(15)))
                            strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddMinutes(15))
                            names = sqlRs("sitename").value
                            If Not level_read = "-" Then
                                level_read = FormatNumber(level_read)
                            Else
                                k = k + 1
                                
                            End If
                    %>
                    <td align="center" title="<%=names %>" style="width: 55px">
                       <%  If state2 = "" Then
                                Response.Write("<font color='olive'>" & level_read & " </font>")
                            ElseIf state2 = "LL" Then
                                Response.Write("<font color='black'>" & level_read & " </font>")
                            ElseIf state2 = "L" Then
                                Response.Write("<font color='light blue'>" & level_read & " </font>")
                            ElseIf state2 = "NN" Then
                                Response.Write("<font color='green'>" & level_read & " </font>")
                            ElseIf state2 = "H" Then
                                Response.Write("<font color='maroon'>" & level_read & " </font>")
                            ElseIf state2 = "HH" Then
                                Response.Write("<font color='red'>" & level_read & " </font>")
                            End If
                      
                        %>
                    </td>
                    <%
                    Next i
                    Dim clevel = Get_readings_maxoravg(strconn, sqlRs("siteid").value, 2)
                    sqlRs.MoveNext()
                    If k = 32 Then
                        k = 0
                    ElseIf k >= 1 Then
                        k = System.Convert.ToInt32(Math.Round(((k * 100) / 32), 2))
                        k = 100 - k
                    Else
                        k = 100
                    End If
                    %>
                    <td align="center" title="<%=names %>" style="width: 100px">
                        <% Response.Write(k)%>
                    </td>
                    <td align="center" title="<%=names %>">
                        <% If state2 = "" Then%>
                        <font color="Olive">
                            <%=clevel%>
                        </font>
                        <%ElseIf state2 = "LL" Then%>
                        <font color="black">
                            <%=clevel & " " & "(LL)"%>
                        </font>
                        <%ElseIf state2 = "L" Then%>
                        <font color="light blue">
                            <%=clevel & " " & "(L)"%>
                        </font>
                        <%ElseIf state2 = "NN" Then%>
                        <font color="green">
                            <%=clevel & " " & "(NN)"%>
                        </font>
                        <%ElseIf state2 = "H" Then%>
                        <font color="maroon">
                            <%=clevel & " " & "(H)"%>
                        </font>
                        <%ElseIf state2 = "HH" Then%>
                        <font color="red">
                            <%=clevel & " " & "(HH)"%>
                        </font>
                        <%End If%>
                    </td>
                </tr>
                <%
                    k = 0
                Loop
                %>
            </tbody>
            <%
                sqlRs.Close()
                objConn.close()
                sqlRs = Nothing
                objConn = Nothing
        End Select
            %>
        </table>
    </div>
</body>
</html>
<!--#include file="report_foot.aspx"-->
