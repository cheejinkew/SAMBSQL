<%@ Page Language="VB" %>
<%@ Import Namespace="ADODB" %>
<!-- this comment puts all versions of Internet Explorer into "reliable mode." -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    If Request.QueryString("ekspot") = "yes" Then
%>
<!--#include file="../save2excel.aspx"-->
<%
End If
%>
<!--#include file="../report_head.aspx"-->
<%    Dim dists As String = Request.QueryString("dist")
   dim GetCon as integer = 0
   dim strconn
      if dists = "Kangar" then 
            
               GetCon = 0
                strconn = ConfigurationSettings.AppSettings("DSNPG1")
            else 
              
               GetCon = 1
                strconn = ConfigurationSettings.AppSettings("DSNPGI")
	        end if
             %>
<script runat="server">
    Dim site
    Dim siteidlist
    Dim arr As New ArrayList()
    Dim arr2 As New ArrayList()
    Dim arr3 As New ArrayList()
    Dim arr4 As New ArrayList()
    Dim arr5 As New ArrayList()
    Dim arr6 As New ArrayList()
    Dim arr7 As New ArrayList()
    Dim arr8 As New ArrayList()
    
    
    Dim sel = "no"
    Dim state2
    Dim level_read, RF_read, cumRainfall, maya, tempoh
    Dim total_rainfall
    Dim names
    Dim i
    Dim cont
    Dim end_date
    Dim state3
    Dim state4
    Dim arrclear = "yes"
    
           

    'Dim strconn = "DSN=g1;UID=tmp;PWD=tmp;"
    'Dim strconn = ConfigurationSettings.AppSettings("DSNPGI")
    'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
    Dim objConn = New ADODB.Connection()
    Dim sqlRs = New ADODB.Recordset()
    
    Function Get_level_Type(ByVal strConn As String, ByVal str As String) As String
        Dim nOConn
        Dim RS
        Dim Words
        Dim Words2
        Dim alarm1
        Dim alarm2
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        RS.open("select alarmtype,multiplier from telemetry_rule_list_table where siteid='" & str & "' and alarmtype in ('HH','H','LL','L','NN')", nOConn)

        If Not RS.EOF Then
            Do Until RS.EOF
                Words = Words & RS("alarmtype").value & ","
                Words2 = Words2 & RS("multiplier").value & ","
                RS.movenext()
            Loop
            alarm1 = Split(Words, ",")
            alarm2 = Split(Words2, ",")
            For i = 0 To alarm1.length - 2
                'arr(i) = alarm1(i)
                'arr2(i) = alarm2(i)
                arr.Add(alarm1(i))
                arr2.Add(alarm2(i))
            Next
        Else
            Words = ""
            Words2 = ""
        End If
        Get_level_Type = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function
    
    Function Get_root_Color(ByVal str As String,ByVal clr As String) As String
        On Error Resume Next
        Dim str2 = str
        If str2 = "-" Then
            state2 = ""
        Else
            str2 = Convert.ChangeType(str, TypeCode.Double)
            Dim brr3 = Convert.ChangeType(arr3(1), TypeCode.Double)
            Dim brr4 = Convert.ChangeType(arr4(1), TypeCode.Double)
            Dim brr5 = Convert.ChangeType(arr5(1), TypeCode.Double)
            Dim brr6 = Convert.ChangeType(arr6(1), TypeCode.Double)
            Dim brr7 = Convert.ChangeType(arr7(1), TypeCode.Double)
            Dim brr32 = Convert.ChangeType(arr3(2), TypeCode.Double)
            Dim brr42 = Convert.ChangeType(arr4(2), TypeCode.Double)
            Dim brr52 = Convert.ChangeType(arr5(2), TypeCode.Double)
            Dim brr62 = Convert.ChangeType(arr6(2), TypeCode.Double)
            Dim brr72 = Convert.ChangeType(arr7(2), TypeCode.Double)
        
            If str2 >= brr3 And str2 <= brr32 Then
                state2 = arr(0)
            ElseIf str2 >= brr4 And str2 <= brr42 Then
                state2 = arr(1)
            ElseIf str2 >= brr5 And str2 <= brr52 Then
                state2 = arr(2)
            ElseIf str2 >= brr6 And str2 <= brr62 Then
                state2 = arr(3)
            ElseIf str2 >= brr7 And str2 <= brr72 Then
                state2 = arr(4)
            Else
                state2 = ""
            End If
        End If
              
        Get_root_Color = state2
        If clr = "yes" Then
            arr.Clear()
            arr2.Clear()
            arr3.Clear()
            arr4.Clear()
            arr5.Clear()
            arr6.Clear()
            arr7.Clear()
        End If
    End Function

</script>
<%
    Dim text
    Dim dist As String = Request.QueryString("dist")
    Dim table = Request.QueryString("table")
    Dim start_date = Request.QueryString("start")
    
    end_date = start_date + " 08:00"
	start_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(end_date).AddDays(-1))	
	'tempoh = 24
	'end_date = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(tempoh))
    Dim k As Integer = 0   
%>
<html><head>
<!--#include file="report_style.inc"-->
<title>Samb Aquisition Report</title>
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
			tr.cells[2].className = 'locked'
			}
	}
	else {
		for (i = 0; i < cTR.length; i++)
			{
			var tr = cTR.item(i);
			tr.cells[0].className = ''
			tr.cells[1].className = ''
			tr.cells[2].className = ''
	      	}
	}
	// This code is to reset the Cell: Start Here
	table.rows[2].cells[0].className = 'td_column_title';
	table.rows[2].cells[1].className = 'td_column_title';
	table.rows[2].cells[2].className = 'td_column_title';
	// This code is to reset the Cell: End Here
}
</script>
</head>
<body class="report" onload="lockCol('tbl')">
    <center><h4><b>24 HOURS WATER LEVEL DATA BETWEEN <%=Format_Full_Time(start_date,2)%> AND <%=Format_Full_Time(end_date,2)%></b></h4></center>
    <table style="border: 0px;">
        <tr>
            <td class="td_head" style="border: 0px;">
                <b>District : <font color='blue' size="2"><%=dist %></font></b>
                <br />
                <b>Start :</b><%=start_date%> AM
                <br />
                <b>End &nbsp; :</b><%=end_date%> AM
            </td>
        </tr>
    </table>
    <div id="tbl-container">
        <table id="tbl">
            <thead>
				<% dim s %>
                <th style="border-collapse: collapse; width: 50px">
                </th>
                <th style="width: 150px">
                </th>
                 <th style="width: 100px">
                </th>
                <% For s = 0 To 24%>
                <th style="width: 55px">
                </th>
                <% Next%>
                <th style="width: 100px">
                </th>
                <th style="width: 100px">
                </th>
            </thead>
            <%                
                objConn.open(strconn)              
				Text = "select siteid,sitename from telemetry_site_list_table where sitedistrict='" & dist & "' and exists (select unitid from unit_list where versionid like 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
                sqlRs.Open(text, objConn)
            %>
            <tbody>
                <tr>
                    <td rowspan="2" class="td_column_title" style="text-align:center;">Site No</td>
                    <td rowspan="2" class="td_column_title" style="text-align:center;">Site Name</td>
					<td rowspan="2" class="td_column_title" style="text-align:center;">Simcard No</td>
                    <td colspan="16" class="td_column_title" style="background-color: #eeeeee;"><%=Format_Full_Time(start_date,2)%></td>
                    <td colspan="9" class="td_column_title" style="background-color: #fbf5e8;"><%=Format_Full_Time(end_date,2)%></td>
                    <td rowspan="2" class="td_column_title">Percentage(%)</td>
					<td rowspan="2" class="td_column_title">Last Value (m)</td>
				</tr><tr>
                    <%
                        Dim strdate = start_date
                        For i = 0 To 24
                    %>
                    <td class="td_column_title" style="width: 50px;
					<% 	if i<16 then
							Response.Write("background-color: #eeeeee;")
						else
							Response.Write("background-color: #fbf5e8;")
						end if
					%>">
                        <%=String.Format("{0:HH:mm}", Date.Parse(strdate).AddHours(i))%>
                    </td>
                    <%
						Next i
                    %>
                </tr>
                <%
                    Do Until sqlRs.EOF
                %>
                <tr>
                    <td align="center" class="td_data"><%=sqlRs("siteid").value %></td>
                     <%  site = sqlRs("siteid").value
                           sel="no"     
                         state3 = Get_level_Type(strconn, site)
                        If state3 = "" Then
                             sel = "yes"
                        Else
                            For i = 0 To arr2.Count - 1
                                state3 = Split(arr2(i), ";")
                                If i = 0 Then
                                    For cont = 0 To state3.length - 1
                                        arr3.Add(state3(cont))
                                    Next
                                ElseIf i = 1 Then
                                    For cont = 0 To state3.length - 1
                                        arr4.Add(state3(cont))
                                    Next
                                ElseIf i = 2 Then
                                    For cont = 0 To state3.length - 1
                                        arr5.Add(state3(cont))
                                    Next
                                ElseIf i = 3 Then
                                    For cont = 0 To state3.length - 1
                                        arr6.Add(state3(cont))
                                    Next
                                ElseIf i = 4 Then
                                    For cont = 0 To state3.length - 1
                                        arr7.Add(state3(cont))
                                    Next
                                End If
                            Next
                        End If
                                   
                    %>
                    <td align="left" title="<%=GetSIM(strConn,Trim(sqlRs("siteid").value))%>"><%=GetSiteName(strconn, Trim(sqlRs("siteid").value))%></td>
					<td align="left" class="td_data"><%=GetSIM(strConn,Trim(sqlRs("siteid").value))%></td>
                    <%
                        Dim strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date))
                        For i = 0 To 24
							if i = 24 then
								level_read = Get_readings_per_hour(GetCon,strconn, sqlRs("siteid").value, 2, String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(i).AddMinutes(-15)))
							else
								level_read = Get_readings_per_hour(GetCon,strconn, sqlRs("siteid").value, 2, String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(start_date).AddHours(i)))
							end if
                            strdate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strdate1).AddHours(1))
                            names = sqlRs("sitename").value
                            If Not level_read = "-" Then                          
                                level_read = level_read
                            Else                               
                                k = k + 1
                            End If
                            If sel = "yes" Then
                                state2 = ""
                            Else
                                arrclear = "no"
                                state2 = Get_root_Color(level_read, arrclear )
                            End If
                    %>
                    <td class="td_data" align="center" title="<%=names %> : <%=Date.Parse(start_date).AddHours(i)%>"><%
					select case state2
                        case "LL"
                            Response.Write("<font color='black'>" & level_read & " </font>")
                        case "L"
                            Response.Write("<font color='light blue'>" & level_read & " </font>")
                        case "NN"
                            Response.Write("<font color='green'>" & level_read & " </font>")
                        case "H"
                            Response.Write("<font color='maroon'>" & level_read & " </font>")
                        case "HH"
                            Response.Write("<font color='red'>" & level_read & " </font>")
						case "" 
                            Response.Write("<font color='Fuchsia'>" & level_read & state2 & " </font>")
						case else
                            Response.Write("<font color='Fuchsia'>" & level_read & " </font>")
                    end select                      
					%></td><%                        
                    Next i
                    Dim clevel = Get_readings_maxoravg(strconn, sqlRs("siteid").value, 2)
					Dim time_es = Get_Current_Timestamp(GetCOn,strconn, sqlRs("siteid").value, 2)
                    sqlRs.MoveNext()
                    If k = 25 Then
                        k = 0
                    ElseIf k >= 1 Then
                        k = System.Convert.ToInt32(Math.Round(((k * 100) / 25), 2))
                        k = 100 - k
                    Else
                        k = 100
                    End If
                    
                    If sel = "yes" Then
                        state2 = ""
                    Else
                        arrclear = "yes"
                        state2 = Get_root_Color(clevel,arrclear )
                    End If
                                     
                    %>
                    <td class="td_data" align="center" title="<%=names %>">
                        <% Response.Write(k)%>
                    </td>
                    <td class="td_data" align="center" title="<%=time_es %>"><%
					select case state2
						case "LL"
						%><font color="black"><%=clevel & " " & "(LL)"%></font><%
						case "L"
						%><font color="light blue"><%=clevel & " " & "(L)"%></font><%
						case "NN"
						%><font color="green"><%=clevel & " " & "(NN)"%></font><%
						case "H"
						%><font color="maroon"><%=clevel & " " & "(H)"%></font><%
						case "HH"
						%><font color="red"><%=clevel & " " & "(HH)"%></font><%
						case ""
						%><font color="Fuchsia"><%=clevel%></font><%
						case else
						%><font color="Fuchsia"><%=clevel%></font><%
					End select
					%></td>
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
      
        </table>
    </div>
</body>
</html>
<!--#include file="../report_foot.aspx"-->