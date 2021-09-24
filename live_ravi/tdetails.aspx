<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>

<script language="VB" runat="server">
    Public SiteID As String
    Function szParseString(ByVal szString As String, ByVal szDelimiter As String, ByVal nSegmentNumber As Integer)
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
   
</script>
<%
    
   
    SiteID = Session("siteid")
    If SiteID = Nothing Then
        Response.Write("THERE IS NO DATA TO BE DISPLAYED")
        Exit Sub
    End If
    Dim District1 = Session("district")
    Dim Position1 = Session("position")
    Dim SiteName = Session("sitename")
    Dim EquipName = "Water Level Trending"
    Dim startdate As String
    Dim enddate1 As String
    Dim enddate As String
    enddate1 = Date.Parse(Now).AddHours(-24)
    enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(enddate1))
    'startdate = request.Form("txtBeginDate") & " " & request.Form("ddBeginHour") & ":" & request.Form("ddBeginMinute") & ":00"
    startdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(enddate).AddHours(-2))
	
    Dim strConn1
    Dim objConn1
    Dim rsRecords
    Dim values() As Double
    Dim sequence()
    Dim sequence1() As String
    Dim i As Integer = 0
    
    Dim strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate))
    Dim strLastDate1
      
    strLastDate1 = strLastDate
    
    strConn1 = ConfigurationSettings.AppSettings("DSNPG")
    objConn1 = New ADODB.Connection()
    rsRecords = New ADODB.Recordset()
    objConn1.open(strConn1)
    
    
    strLastDate = strLastDate1
    Dim xscale = 1
    Do While strLastDate <= enddate
        ' Do While strLastDate <= String.Format("{0:yyyy/MM/dd}", Date.Parse(enddate))
        
        If SiteID = Nothing Then
            Response.Write("THERE IS NO DATA TO BE DISPLAYED")
            Exit Sub
        End If
        'Dim str = "select value,sequence from telemetry_log_table where siteid='" & SiteID & "' and position =" & Position1 & " and sequence between '" & strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc limit 1 "
        Dim str = "select value,sequence from telemetry_log_table where siteid='" & SiteID & "' and position=" & Position1 & " and sequence between '" & strLastDate & ":00' and '" & enddate & "' order by sequence desc limit 1 "
        'rsRecords.open("select value,sequence from telemetry_log_table where siteid='" & SiteID & "' and position =" & Position1 & " and sequence between '" & strLastDate & ":00' and " & "'2007/06/21 11:00:00' order by sequence desc limit 1 ", objConn1)
        Dim st1 = "select value,sequence from telemetry_log_table where siteid='" & SiteID & "' and position=" & Position1 & " and sequence between '" & strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc limit 5 "
        rsRecords.open("select value,sequence from telemetry_log_table where siteid='" & SiteID & "' and position=" & Position1 & " and sequence between '" & strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc limit 5 ", objConn1)
        
        If Not rsRecords.EOF Then
            ReDim Preserve values(i)
            ReDim Preserve sequence(i)
            ReDim Preserve sequence1(i)
            values(i) = rsRecords("value").value
            sequence(i) = rsRecords("sequence").value
            sequence1(i) = String.Format("{0:dd/MM/yyyy HH:mm}", Date.Parse(sequence(i).AddHours(24)))
            i = i + 1
            ' Response.Write(values(i))
            'Else
            '    Response.Write("THERE IS NO DATA TO BE DISPLAYED")
            '    Exit Sub
        End If
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(xscale))
        rsRecords.close()
    Loop
    'rsRecords.Open("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & Position & "' and sequence between '" & startdate & "' and '" & enddate & "' order by sequence asc", objConn1)
    
    'Do While Not rsRecords.EOF
    '    values(i) = rsRecords.fields("value").value
    '    sequence(i) = rsRecords.fields("sequence").value
    '    rsRecords.movenext()
    '    If rsRecords.eof = False Then
    '        i = i + 1
    '        ReDim Preserve values(i)
    '        ReDim Preserve sequence(i)
    '    End If
    'Loop
    'rsRecords.close()
    Dim rmultiplier(0) As String
    Dim rposition(0) As Integer
    Dim ralarmtype(0) As String
    Dim rcolorcode(0) As String
    Dim ralert(0) As Boolean
    i = 0
    rsRecords.Open("select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc", objConn1)
    Do While Not rsRecords.EOF
        rmultiplier(i) = rsRecords("multiplier").value
        rposition(i) = rsRecords("position").value
        ralarmtype(i) = rsRecords("alarmtype").value
        rcolorcode(i) = rsRecords("colorcode").value
        ralert(i) = rsRecords("alert").value
        i = i + 1
        ReDim Preserve rmultiplier(i)
        ReDim Preserve rposition(i)
        ReDim Preserve ralarmtype(i)
        ReDim Preserve rcolorcode(i)
        ReDim Preserve ralert(i)
        rsRecords.MoveNext()
    Loop
    rsRecords.close()
    rsRecords = Nothing
	
    Dim minValue As Integer
    Dim Suffix As String
	
    If InStr(1, EquipName, "Flowmeter") > 0 Then
        Suffix = "m3/h"
        minValue = 0
    End If
	
    If InStr(1, SiteName, "Pressure") > 0 Then
        Suffix = "bar"
        minValue = 0
    End If

    If InStr(1, SiteName, "Tank") > 0 Then
        Suffix = "m"
        minValue = 0
    End If

    If InStr(1, SiteName, "Turbidity") > 0 Then
        Suffix = "NTU"
        minValue = 0
    End If
	
    If InStr(1, SiteName, "pH") > 0 Then
        Suffix = "pH"
        minValue = 1
    End If
	
    If InStr(1, SiteName, "Chlorine") > 0 Then
        Suffix = "ch"
        minValue = 0
    End If
		
    'The data for the line chart
    On Error Resume Next
    'The labels for the line chart

    'Create a XYChart object of size 250 x 250 pixels
    Dim c As XYChart = New XYChart(700, 450, &HFFFFFF, &H0, 1)
    'Dim c As XYChart = New XYChart(650, 370)

    'Set the plotarea at (30, 20) and of size 200 x 200 pixels
    ' c.setPlotArea(90, 20, 550, 300).setGridColor(&HFBCCF9, &HFBCCF9)
    c.setPlotArea(98, 25, 500, 300).setGridColor(&HFBCCF9, &HFBCCF9)
    
    'Add a line chart layer using the given data
    'For i = 0 To UBound(rmultiplier)
    c.addLineLayer(values, &HC000&)
    'Next
    'Set the labels on the x axis.''''''''''45 angle
    
    c.xAxis().setLabels(sequence1).setFontAngle(45)
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''response.write("hai" + "\n" "hallow")
    'For i = 0 To UBound(rmultiplier)
    'c.xAxis().setLabels(sequence).setFontSize(18)
    c.yAxis().setColors(&H0&, &H0&, &H0&)
    'Next
    '	c.yAxis2().setColors(&H0&, &H0&, &H0&)    
    'Display 1 out of 3 labels on the x-axis.
    Dim Div As Integer
    If UBound(values) <= 31 Then
        Div = 0
    Else
        Div = (UBound(values) / 31)
    End If
    
    Dim k As Integer = 0
    ' Dim d = Div * 1
    'While k < sequence.Length
    '    If k Mod d = 0 Then
    '        sequence(k) = " "
    '    End If
    '    k = k + 1
    'End While
    
    'c.addLineLayer(val, &HC000&)
    ' c.xAxis().setLabels(sequence)
    '===========BELOW THREE LINES HAD BEEN MADE DISAVAILABLE BY ME================
    c.xAxis().setLabels(sequence1).setFontAngle(45)
    c.xAxis().setLabels(sequence1).setFontSize(10)
    c.xAxis().setLabelStep(0.5)
    
    '	c.yAxis().addZone(0, 2, &HFF0000)

    Dim maxrulevalue As Double
    Dim minrulevalue As Double
    Dim reverse As Boolean

    reverse = True
    '=============THIS FOR LOOP ALSO MADE MY 
    For i = 0 To UBound(rmultiplier)
        'response.write(minrulevalue & "; ")
        'Response.Write(rmultiplier(i))
        minrulevalue = szParseString(rmultiplier(i), ";", 2)
        maxrulevalue = szParseString(rmultiplier(i), ";", 3)
        If ralert(i) = True Then
            If reverse = True Then
                'response.write(maxrulevalue & "; ")
                c.yAxis().addMark(maxrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
            Else
                'response.write(minrulevalue & "; ")
                c.yAxis().addMark(minrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
            End If
        Else
            reverse = ralert(i)
        End If
    Next i
    Session("district") = Nothing
    Session("siteid") = Nothing
    Session("position") = Nothing
    Session("sitename") = Nothing
   
    'Response.ContentType = "image/png"
    'Response.BinaryWrite(c.makeChart2(Chart.PNG))
    'Response.End()

    'c.makeWebImage(Chart.PNG)
    Dim str As String = "c:/mychart.png"
    c.makeChart(str)

    'include tool tip for the chart
    'WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    '"title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

%>


<%--<table border="1" style="width: 256px">
  <tr>
    <td style="width: 200px"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=District1%>&position=<%=Position1%>" target="main">Trending Selection</a></div></td>
  </tr>
</table>--%>
<
