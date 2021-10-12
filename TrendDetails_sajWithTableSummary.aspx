<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<script language="VB" runat="server">

	Function szParseString(ByVal szString As String, ByVal szDelimiter As String, ByVal nSegmentNumber As Integer)
		On Error Resume Next
		Dim nIndex As Integer
		Dim szTemp As String
		Dim nPos As Integer

		szTemp = szString

		For nIndex = 1 To nSegmentNumber - 1
			nPos = InStr(szTemp, szDelimiter)
			If nPos Then
				szTemp = Mid$(szTemp, nPos + 1)
			Else
				Exit Function
			End If
		Next
		nPos = InStr(szTemp, szDelimiter)

		If nPos Then
			szParseString = Left$(szTemp, nPos - 1)
		Else
			szParseString = szTemp
		End If

	End Function

	Function GetData() As DataTable

		'Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
		'objConn = New ADODB.Connection()
		'objConn.open(strConn)

		Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")

		Dim SiteID = Request.Form("siteid")
		Dim Position = Request.Form("position")
		Dim startdate As String
		Dim enddate As String
		startdate = Request.Form("txtBeginDate") & " " & Request.Form("ddBeginHour") & ":" & Request.Form("ddBeginMinute") & ":00"
		enddate = Request.Form("txtEndDate") & " " & Request.Form("ddEndHour") & ":" & Request.Form("ddEndMinute") & ":00"
		'startdate = "2021-03-07 00:00:00"
		'enddate = "2021-03-08 23:59:59"
		Dim strBeginDateTime = Date.Parse(startdate)
		Dim strEndDateTime = Date.Parse(enddate)
		Dim strStartdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
		Dim strEnddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strEndDateTime))

		Using con As New SqlConnection(constr)
			'Using cmd As New SqlCommand(" select siteid,position,dtimestamp ,value from telemetry_log_table where siteid ='S1-21' AND dtimestamp BETWEEN '2021-02-02' AND '2021-02-03' and position='62'and value>0 order by dtimestamp asc")
			'Using cmd As New SqlCommand(" Select value, dtimestamp, position from telemetry_log_table where siteid='8622' and position in ('2', '0') and dtimestamp between '2021-03-07 00:00:00:00' and '2021-03-08 23:59:59:59' order by dtimestamp desc")
			Using cmd As New SqlCommand("Select CAST(AVG(value) AS DECIMAL(10,2)) AS 'Average Level',max(value) As 'Max Level',min(value) As 'Min Level', ( SELECT((SELECT MAX(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & SiteID & "' And position in ('" & Position & "', '0') and dtimestamp between '" & strStartdate & "' and '" & strEnddate & "' ORDER by value )AS BottomHalf)+(SELECT MIN(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & SiteID & "' And position in ('" & Position & "', '0') and dtimestamp between '" & strStartdate & "' and '" & strEnddate & "' ORDER by value DESC) AS TopHalf)) / 2 )AS 'Median Level' From telemetry_log_table Where siteid ='" & SiteID & "' And position In ('" & Position & "', '0') and dtimestamp between '" & strStartdate & "' and '" & strEnddate & "' ")
				Using sda As New SqlDataAdapter()
					cmd.Connection = con
					sda.SelectCommand = cmd
					Using dt As New DataTable()
						sda.Fill(dt)
						Return dt
					End Using
				End Using
			End Using
		End Using
	End Function
</script>
<%
	'On Error Resume Next 
	' Dim yAxisTitle As String

	'dim equipname = request.form("equipname")
	'dim strSelectedDistrict = request.form("ddDistrict")
	'dim intSiteID1 = request.form("ddSite1")
	' Dim intSiteID2 = Request.Form("ddSite2")
	' Dim EquipDesc = Request.Form("equipdesc")
	Dim printsubmit As String = "no"
	Dim SiteID = Request.Form("siteid")
	Dim SiteName = Request.Form("sitename")
	Dim District = Request.Form("ddDistrict")
	Dim Position = Request.Form("position")
	Dim EquipName = Request.Form("equipname")
	Dim EquipDesc = Request.Form("equipdesc")
	Dim version = Request.Form("v")
	Dim blnTmp = False
	Dim startdate As String
	Dim enddate As String
	startdate = Request.Form("txtBeginDate") & " " & Request.Form("ddBeginHour") & ":" & Request.Form("ddBeginMinute") & ":00"
	enddate = Request.Form("txtEndDate") & " " & Request.Form("ddEndHour") & ":" & Request.Form("ddEndMinute") & ":00"
	Dim strBeginDateTime = Date.Parse(startdate)
	Dim strEndDateTime = Date.Parse(enddate)

	Dim strLastDate = Request.Form("txtLastDate")
	Dim strLastDate1
	Dim strLastDateForSummaryTable

	If strLastDate = "" Then
		strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
	End If

	strLastDateForSummaryTable = String.Format("{0:yyyy/MM/dd}", Date.Parse(strBeginDateTime))
	Dim StrDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
	Dim StrDate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strEndDateTime))

	strLastDate1 = strLastDate
	Dim strConn
	Dim objConn
	Dim rsRecords
	Dim values(0) As Double
	Dim sequence(0) As String
	Dim i As Integer

	strConn = ConfigurationSettings.AppSettings("DSNPG")
	objConn = New ADODB.Connection()
	rsRecords = New ADODB.Recordset()
	objConn.open(strConn)

	Dim maxrulevalue As Double
	Dim minrulevalue As Double
	Dim reverse As Boolean
	Dim thresholdValueMax As Double

	Dim rmultiplier(0) As String
	Dim rposition(0) As Integer
	Dim ralarmtype(0) As String
	Dim rcolorcode(0) As String
	Dim ralert(0) As Boolean
	i = 0

	If (Position = "2") Then 'M4/M5
		rsRecords.Open("select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc", objConn)
		Do While Not rsRecords.EOF
			rmultiplier(i) = rsRecords.fields("multiplier").value
			rposition(i) = rsRecords.fields("position").value
			ralarmtype(i) = rsRecords.fields("alarmtype").value
			rcolorcode(i) = rsRecords.fields("colorcode").value
			ralert(i) = rsRecords.fields("alert").value
			i = i + 1
			ReDim Preserve rmultiplier(i)
			ReDim Preserve rposition(i)
			ReDim Preserve ralarmtype(i)
			ReDim Preserve rcolorcode(i)
			ReDim Preserve ralert(i)
			rsRecords.MoveNext()
		Loop
		rsRecords.close()

		thresholdValueMax = 8.0
		For i = 0 To (UBound(rmultiplier))
			maxrulevalue = szParseString(rmultiplier(i), ";", 3)
			If thresholdValueMax < maxrulevalue Then
				thresholdValueMax = maxrulevalue
			End If
		Next
	Else 'S1
		Dim nMaxStart = String.Format("{0:yyyy/MM/dd}", Date.Parse(strBeginDateTime))
		Dim nMaxEnd = String.Format("{0:yyyy/MM/dd}", Date.Parse(strEndDateTime))

		Dim strSQL = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
				  SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
				  nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
		rsRecords.Open(strSQL, objConn)

		'response.write (strSQL)
		thresholdValueMax = 100.0
		Do While Not rsRecords.EOF
			If (IsNumeric(rsRecords.fields("nMax").value)) Then
				thresholdValueMax = rsRecords.fields("nMax").value
			Else
				thresholdValueMax = 10
			End If
			rsRecords.MoveNext()
		Loop
		If thresholdValueMax = 0 Then
			thresholdValueMax = 8.0
		End If
		rsRecords.close()
	End If

	strLastDate = strLastDate1
	'strLastDate = strStartDate
	Dim dubValue As Double
	i = 0
	Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDateTime))
		Dim txt = ""
		' Response.Write("Version"& version)


		If version = "M6" Then
			txt = "select top 1 value, dtimestamp, position from telemetry_log_table_m6 where siteid='" & _
			  SiteID & "' and position in ('" & Position & "', '0') and dtimestamp between '" & _
			   Convert.ToDateTime(strLastDate).AddMinutes(-10).ToString("yyyy/MM/dd HH:mm") & ":00' and '" & strLastDate & ":59' order by dtimestamp desc"
		Else
			txt = "select top 1 value, dtimestamp, position from telemetry_log_table where siteid='" & _
			  SiteID & "' and position in ('" & Position & "', '0') and dtimestamp between '" & _
			   strLastDate & ":00' and '" & strLastDate & ":59' order by dtimestamp desc"
		End If

		rsRecords.Open(txt, objConn)

		'Response.Write(txt)

		'If Position <> "2" then
		'    response.write(txt & "<br />")
		'End if
		'response.write("select value, dtimestamp from telemetry_log_table where siteid='" & SiteID & "' and position ='" & position & "' and dtimestamp between '" & startdate & "' and '" & enddate & "' order by dtimestamp desc")
		'rsRecords.Open("select value, dtimestamp from telemetry_log_table where siteid='" & SiteID & "' and position ='" & Position & "' and dtimestamp between '" & startdate & "' and '" & enddate & "' order by dtimestamp", objConn)
		'if rsrecords.eof = true then exit sub
		'Do While Not rsRecords.EOF    

		If rsRecords.eof = False Then
			blnTmp = True
			dubValue = CDbl(rsRecords.fields("value").value)
			If dubValue < 0.0 Then
				dubValue = 0.1
			End If
			' Response.Write(thresholdValueMax & "> " & dubValue & "<br/>")
			If (thresholdValueMax >= dubValue And dubValue >= 0.0) Then

				values(i) = dubValue
				sequence(i) = Convert.ToString(strLastDate)
				'sequence(i) = rsRecords.fields("sequence").value
				i = i + 1
				ReDim Preserve values(i)
				ReDim Preserve sequence(i)

			End If
			'Else

			'    If i = 0 Then
			'        values(i) = Chart.NoValue
			'    Else
			'        values(i) = values(i - 1)
			'    End If
			'    'values(i) = Chart.NoValue
			'    sequence(i) = Convert.ToString(strLastDate)
			'    'sequence(i) = rsRecords.fields("sequence").value
			'    i = i + 1
			'    ReDim Preserve values(i)
			'    ReDim Preserve sequence(i)


		End If
		If version = "M6" Then
			strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(15))
		Else
			strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(15))
		End If

		rsRecords.close()
	Loop
	'values(i) = Chart.NoValue

	rsRecords = Nothing


	Dim minValue As Integer
	Dim Suffix As String
	Dim yAxisTitle
	yAxisTitle = " "
	If InStr(1, UCase(EquipDesc), "FLOW METER") > 0 Then
		Suffix = "m3/h"
		minValue = 0
		yAxisTitle = "Meter Cube Per Hour (m3/h)"
	End If

	If InStr(1, UCase(EquipDesc), "PRESSURE") > 0 Then
		Suffix = "bar"
		minValue = 0
		yAxisTitle = "Pressure (Bar)"
	End If

	If InStr(1, UCase(EquipDesc), "LEVEL") > 0 Then
		Suffix = "m"
		minValue = 0
		yAxisTitle = "Water Level (Meter)"
	End If

	If InStr(1, UCase(EquipDesc), "TURBIDITY") > 0 Then
		Suffix = "NTU"
		minValue = 0
		yAxisTitle = "Turbidity (NTU)"
	End If

	If InStr(1, UCase(EquipDesc), "PH") > 0 Then
		Suffix = "pH"
		minValue = 1
		yAxisTitle = "pH Level"
	End If

	If InStr(1, UCase(EquipDesc), "CHLORINE") > 0 Then
		Suffix = "ch"
		minValue = 0
		yAxisTitle = "Chlorine Level"
	End If

	'***********************************************************************************************
	'The data for the line chart
	On Error Resume Next



	Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

	'Set the plotarea at (30, 20) and of size 200 x 200 pixels
	c.setPlotArea(90, 20, 550, 300).setGridColor(&HFBCCF9, &HFBCCF9)


	c.addLineLayer(values, &HC000&)


	c.yAxis().setColors(&H0&, &H0&, &H0&)

	Dim Div As Integer


	If UBound(values) <= 31 Then
		Div = 1
	Else
		Div = (UBound(values) / 31)
	End If


	'Dim k As Integer = 0
	'Dim d = Div * 2
	'While k < sequence.Length
	'    If k Mod d = 2 Then
	'        sequence(k) = " "
	'    End If
	'    k = k + 1

	'End While

	'c.addLineLayer(val, &HC000&)
	c.addTitle("Site ID : " & SiteID, "Times New Roman Bold", 12)
	c.yAxis().setTitle(yAxisTitle, "Arial Bold Italic", 12)
	c.xAxis().setTitle("Timestamp", "Arial Bold Italic", 12)
	c.xAxis().setLabels(sequence).setFontAngle(45)

	c.xAxis().setLabelStep(Div)

	'	c.yAxis().addZone(0, 2, &HFF0000)


	c.yAxis.setLinearScale(0.0, (thresholdValueMax + 1))
	reverse = True
	Dim strColor = "0021FF"


	For i = 0 To UBound(rmultiplier)
		'response.write(minrulevalue & "; ")
		minrulevalue = szParseString(rmultiplier(i), ";", 2)
		maxrulevalue = szParseString(rmultiplier(i), ";", 3)
		If (ralarmtype(i) = "L" Or ralarmtype(i) = "H") Then
			strColor = "0021FF"
		Else
			strColor = rcolorcode(i)
		End If
		'If ralert(i) = True Then
		If ralarmtype(i) <> "NN" Then
			If ralarmtype(i) = "L" Or ralarmtype(i) = "LL" Then
				'response.write(maxrulevalue & "; ")
				c.yAxis().addMark(maxrulevalue, "&H" & strColor, ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
			Else
				'response.write(minrulevalue & "; ")
				c.yAxis().addMark(minrulevalue, "&H" & strColor, ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
			End If
		End If
		'Else
		'reverse = ralert(i)
		'End If
	Next i

	'================================================================================================
	c.layout()
	WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
	'   WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
	'                             "title='[{dataSetName}] Date: {xLabel} ; Value: {value|2} meters'")
	WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
	 "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

	'kew add for graph summary data 15/9/2021
	If Not Me.IsPostBack Then
		'Populating a DataTable from database.
		Dim dt As DataTable = Me.GetData()

		'Building an HTML string.
		Dim html As New StringBuilder()

		'Table start.
		html.Append("<table border = '1' style='table-layout: auto;width: 100%;text-align: center;'>")

		'Building the Header row.
		html.Append("<tr>")
		For Each column As DataColumn In dt.Columns
			html.Append("<th>")
			html.Append(column.ColumnName)
			html.Append("</th>")
		Next
		html.Append("</tr>")

		'Building the Data rows.
		For Each row As DataRow In dt.Rows
			html.Append("<tr>")
			For Each column As DataColumn In dt.Columns
				html.Append("<td>")
				If row.IsNull(column.ColumnName) Then
					html.Append("N/A")
				Else
					html.Append(row(column.ColumnName))
				End If

				html.Append("</td>")
			Next
			html.Append("</tr>")
		Next

		'Table end.
		html.Append("</table>")

		'Append the HTML string to Placeholder.
		'PlaceHolder1.Controls.Add(New Literal() With {.Text = html.ToString()})
		PlaceHolder1.Controls.Add(New LiteralControl(html.ToString()))
	End If

%>
<html>
<head>
    <style>
        body
        {
            overflow-x: hidden;
            scrollbar-face-color: #FFFFFF;
            scrollbar-3dlight-color: #AAB9FD;
            scrollbar-highlight-color: #5F7AFC;
            scrollbar-shadow-color: #5F7AFC;
            scrollbar-arrow-color: #5F7AFC;
        }
    </style>
    <style media="print" type="text/css">
        body
        {
            color: #000000;
            background: #ffffff;
            font-family: verdana,arial,sans-serif;
            font-size: 15pt;
        }
        #hide1
        {
            display: none;
        }
        #hide2
        {
            display: none;
        }
    </style>
</head>
<body>
    <form name="form1" action="TrendDetails.aspx" method="POST">
    <div align="center">
        <table cellspacing="0" cellpadding="0" width="70%" border="0">
            <tbody>
                <tr>
                    <td width="100%" colspan="4" height="50">
                        <p align="center">
                            <img src="images/TrendingDetails.jpg" border="0">
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <table id="hide1" width="409" border="1" cellspacing="0">
        <tbody>
            <tr>
                <td width="200">
                    <div align="right">
                        District :
                    </div>
                </td>
                <td width="193">
                    <%=Request("dddistrict")%>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right">
                        Site ID :
                    </div>
                </td>
                <td>
                    <%=Request("siteid")%>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right">
                        Site Name :
                    </div>
                </td>
                <td>
                    <%=Request("sitename")%>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right">
                        Equipment :</div>
                </td>
                <td>
                    <%=equipname%>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right">
                        Position :
                    </div>
                </td>
                <td>
                    <%=Request("position")%>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a href="Trending.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&district=<%=request("dddistrict")%>&sitetype=<%=request("sitetype") %>&equipname=<%=equipname%>&v=<%=version%>&position=<%=request("Position")%>">
                        Trending Selection</a>
                </td>
                <tr>
        </tbody>
    </table>
    <table id="hide2">
        <tr>
            <td>
                <a href="javascript:goCreateExcel()">
                    <img border="0" src="images/SaveExcel.jpg" align="absbottom"></a>&nbsp;&nbsp;<a href="javascript:printsubmit();"><img
                        alt="Print" border="0" src="images/print.jpg" align="absbottom" /></a>
            </td>
        </tr>
    </table>
    <table border="1" cellspacing="0">
        <tr>
            <td align="center">
                Trending for
                <%=SiteName%>
                <%'=equipname%>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle">
                <div align="center" valign="middle" style="background-color: white">
                    <%If blnTmp = True Then%>
                    <chart:WebChartViewer ID="WebChartViewer1" runat="server" />
                    <%Else%>
                    <center>
                        <div align="center" valign="center" style="border: 1 solid; width: 400; height: 300;">
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <font style="font-family: Verdana; color: #3D62F8"><b>No Data To Be Displayed !</b></font>
                        </div>
                    </center>
                    <%End If%>
            </td>
        </tr>
				<tr>
			<td>
			                     <asp:PlaceHolder  ID = "PlaceHolder1" runat="server" /> 
				</td>
		</tr>
    </table>
<%--kew add for combined graph, Tabular, summary table--%>
&nbsp;
   <%  If equipname = "Water Level Trending" Then%>

           <table border="1" cellspacing="0">
			    <tr align="center" ><td colspan="6" style="font-weight: bold;">Tabular Trend</td></tr>
           <tr align="center" >
			   <td style="font-weight: bold;width:115px; height: 17px;">No.Item</td>
			   <td style="font-weight: bold;width:151px; height: 17px;">Date & Time</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Average Level</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Max Level</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Min Level</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Median Level</td>
           </tr>
               <%
				   'Dim con As New Data.Odbc.OdbcConnection(strConn)
				   'Dim dr As Data.Odbc.OdbcDataReader

				   strConn = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
				   objConn = New SqlConnection(strConn)
				   Dim number As Integer = 1

				   Do While strLastDateForSummaryTable <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDateTime))
					   'Dim ds As Data.Odbc.OdbcDataAdapter
					   'Dim str1 As String = "SELECT dtimestamp,value FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & strLastDate & ":00' and '" & strLastDate & ":59' and position='" & position & " ' group by dtimestamp,value order by dtimestamp"
					   Dim str2 As String = "Select CAST(AVG(value) AS DECIMAL(10,2)) AS 'Average Level',max(value) As 'Max Level',min(value) As 'Min Level', ( SELECT((SELECT MAX(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & SiteID & "' And position in ('" & Position & "', '0') and dtimestamp between '" & strLastDateForSummaryTable & " 00:00:00' and '" & strLastDateForSummaryTable & " 23:59:59' ORDER by value )AS BottomHalf)+(SELECT MIN(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & SiteID & "' And position in ('" & Position & "', '0') and dtimestamp between '" & strLastDateForSummaryTable & " 00:00:00' and '" & strLastDateForSummaryTable & " 23:59:59' ORDER by value DESC) AS TopHalf)) / 2 )AS 'Median Level' From telemetry_log_table Where siteid ='" & SiteID & "' And position In ('" & Position & "', '0') and dtimestamp between '" & strLastDateForSummaryTable & " 00:00:00' and '" & strLastDateForSummaryTable & " 23:59:59' "
					   objConn.Open()
					   'Dim cmd As New Data.Odbc.OdbcCommand(str, objConn)
					   'dr = cmd.ExecuteReader()
					   'While (dr.Read())
					   Dim cmd1 As New SqlCommand(str2, objConn)
					   Dim reader As SqlDataReader = cmd1.ExecuteReader
					   While (reader.Read())
						   Response.Write("<tr><td align=center><font color='Black'>" & number & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & strLastDateForSummaryTable & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & reader(0) & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & reader(1) & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & reader(2) & "</td>")
						   Response.Write("<td align=center><font color=Black>" & reader(3) & "</font></td> </tr>")
					   End While
					   objConn.Close()

					   strLastDateForSummaryTable = String.Format("{0:yyyy/MM/dd}", Date.Parse(strLastDateForSummaryTable).AddDays(1))
					   number = number + 1
				   Loop
           %>                                
          </table> 

    <%end if %>
    
    	&nbsp;
   <%  If equipname = "Water Level Trending" Then%>
           <div >
           <table border="1" cellspacing="0">
		   <tr align="center" ><td colspan="2" style="font-weight: bold;">Summary Table</td></tr>
           <tr align="center" ><td style="font-weight: bold;width:177px; height: 17px;">Time</td>
           <td style="font-weight: bold; height: 17px; width: 89px;">Level (m)</td></tr>
               <%
				   'Dim con As New Data.Odbc.OdbcConnection(strConn)
				   'Dim dr As Data.Odbc.OdbcDataReader

				   strConn = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
				   objConn = New SqlConnection(strConn)

				   'Dim ds As Data.Odbc.OdbcDataAdapter
				   Dim str1 As String = "SELECT dtimestamp,value FROM telemetry_log_table WHERE (siteid = '" & SiteID & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='" & Position & " ' group by dtimestamp,value order by dtimestamp"
				   '  Dim str As String = "SELECT dtimestamp,value FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='" & position & " ' group by dtimestamp,value order by dtimestamp"

				   ' "SELECT  distinct(to_char(dtimestamp, 'HH24:mm:ss')) AS dtimestamp, value as minval, value as minpressure, position as position1, position as position2 FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and to_char(dtimestamp, 'yyyy/MM/dd') ='" & StrDate & "' and position='2' group by to_char(dtimestamp, 'HH24:mm:ss'),value,position order by to_char(dtimestamp, 'HH24:mm:ss') desc "
				   objConn.Open()
				   'Dim cmd As New Data.Odbc.OdbcCommand(str, objConn)
				   'dr = cmd.ExecuteReader()
				   'While (dr.Read())
				   Dim cmd1 As New SqlCommand(str1, objConn)
				   Dim reader As SqlDataReader = cmd1.ExecuteReader
				   While (reader.Read())
					   Response.Write("<tr><td align=center><font color='Black'>" & reader(0) & "</td>")
					   Response.Write("<td align=center><font color=Fuchsia>" & reader(1) & "</font></td> </tr>")
				   End While
				   objConn.Close()
           %>                                
          </table> 
           </div>
    <%end if %>
<%--end kew add for combined graph, Tabular, summary table--%>
    </form>
</body>
</html>
<script type="text/javascript">
    function printsubmit() {
        if ('<%=blnTmp%>' == "True") {
            print();
        }
        else {
            alert("No Data To Print");
        }
    }

    function goCreateExcel() {
        var strURL;
        var dist = '<%=Request("dddistrict")%>';
        var dtype = '<%=Request("sitetype") %>';
        var SiteID = '<%=Request("siteid")%>';
        var SiteName = '<%=Request("sitename")%>';
        var EquipName = '<%=equipname%>';
        var strBeginDateTime = '<%=strBeginDateTime %>';
        var strEndDateTime = '<%=strEndDateTime %>';
        var position = '<%=Request("Position")%>';
        strURL = "ExcelTrending.aspx?"
        strURL = strURL + "dist=" + dist + "&dtype=" + dtype + "&SiteID=" + SiteID + "&Position=" + position + "&EquipName=" + EquipName + "&SiteName=" + SiteName
        strURL = strURL + "&BeginDateTime=" + strBeginDateTime + "&EndDateTime=" + strEndDateTime
        document.form1.action = strURL;
        document.form1.submit();
    }
</script>
