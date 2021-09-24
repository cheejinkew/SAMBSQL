<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB,System.Data.Odbc" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>

<script language="VB" runat="server">

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
  
    ' Dim yAxisTitle As String

    'dim equipname = request.form("equipname")
    'dim strSelectedDistrict = request.form("ddDistrict")
    'dim intSiteID1 = request.form("ddSite1")
    ' Dim intSiteID2 = Request.Form("ddSite2")
    ' Dim EquipDesc = Request.Form("equipdesc")

    Dim SiteID = Request.QueryString("siteid")
    Dim SiteName = Request.QueryString("sitename")
    Dim District = Request.QueryString("district")
    Dim Position = Request.QueryString("position")
    Dim EquipName = Request.QueryString("equipname")
    Dim EquipDesc = Request.QueryString("equipdesc")
    Dim blnTmp = False
    Dim startdate As String
    Dim enddate As String
    startdate = Request.QueryString("date")
    Dim strBeginDateTime = String.Format("{0:yyyy/MM/dd}", Date.Parse(startdate)) & " 00:00:00"
    Dim strEndDateTime = String.Format("{0:yyyy/MM/dd}", Date.Parse(startdate)) & " 23:59:59"
   
    Dim strLastDate = Request("txtLastDate")
    Dim strLastDate1
   
    If strLastDate = "" Then
        
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
    End If
   
    strLastDate1 = strLastDate
    Dim strConn
    Dim objConn As OdbcConnection
    Dim rsRecords As OdbcCommand
    Dim values(0) As Double
    Dim sequence(0) As String
    Dim i As Integer
    Dim dr As OdbcDataReader
    strConn = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
    objConn = New OdbcConnection(strConn)
    objConn.Open()
    
    Dim maxrulevalue As Double
    Dim minrulevalue As Double
    Dim reverse As Boolean
    Dim thresholdValueMax As Double
    Dim sDate As String = ""
    strLastDate = strLastDate1
    Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDateTime))
        sDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(-30))
        Dim txt = "select top 1 value, dtimestamp, position from telemetry_log_table where siteid='" & _
                SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                 sDate & ":00' and '" & strLastDate & ":59' order by dtimestamp desc"
        rsRecords = New OdbcCommand(txt, objConn)
        dr = rsRecords.ExecuteReader()
                  
        If dr.Read() Then
            blnTmp = True
            Dim vv = dr("value").ToString()
            If (CDbl(vv) <> 0.0 Or CDbl(vv) <> 0) Then
                values(i) = vv
                sequence(i) = Convert.ToString(strLastDate)
                'sequence(i) = rsRecords.fields("sequence").value
                i = i + 1
                ReDim Preserve values(i)
                ReDim Preserve sequence(i)
            End If
        Else
            values(i) = Chart.NoValue
            sequence(i) = Convert.ToString(strLastDate)
            'sequence(i) = rsRecords.fields("sequence").value
            i = i + 1
            ReDim Preserve values(i)
            ReDim Preserve sequence(i)
        End If
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(15))
        dr.Close()
        rsRecords.Dispose()
    Loop
    
    'values(i) = Chart.NoValue
    
	
    Dim rmultiplier(0) As String
    Dim rposition(0) As Integer
    Dim ralarmtype(0) As String
    Dim rcolorcode(0) As String
    Dim ralert(0) As Boolean
    i = 0
    rsRecords = New OdbcCommand("select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc", objConn)
    dr = rsRecords.ExecuteReader()
    Do While dr.Read()
        rmultiplier(i) = dr("multiplier").ToString()
        rposition(i) = dr("position").ToString()
        ralarmtype(i) = dr("alarmtype").ToString()
        rcolorcode(i) = dr("colorcode").ToString()
        ralert(i) = dr("alert").ToString()
        i = i + 1
        ReDim Preserve rmultiplier(i)
        ReDim Preserve rposition(i)
        ReDim Preserve ralarmtype(i)
        ReDim Preserve rcolorcode(i)
        ReDim Preserve ralert(i)
    Loop
    rsRecords.Dispose()
    dr.Close()
    
    thresholdValueMax = 0.0
    For k As Int32 = 0 To (UBound(rmultiplier))
        maxrulevalue = szParseString(rmultiplier(k), ";", 3)
        If thresholdValueMax < maxrulevalue Then
            thresholdValueMax = maxrulevalue
        End If
    Next
    
    
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
    Dim strColor = "FFB000"
    For i = 0 To UBound(rmultiplier)
        'response.write(minrulevalue & "; ")
        minrulevalue = szParseString(rmultiplier(i), ";", 2)
        maxrulevalue = szParseString(rmultiplier(i), ";", 3)
        If (ralarmtype(i) = "L" Or ralarmtype(i) = "H") Then
            strColor = "FFB000"
        Else
            strColor = rcolorcode(i)
        End If
        If ralarmtype(i) <> "NN" Then
            If ralarmtype(i) = "L" Or ralarmtype(i) = "LL" Then
                'response.write(maxrulevalue & "; ")
                c.yAxis().addMark(maxrulevalue, "&H" & strColor, ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
            Else
                'response.write(minrulevalue & "; ")
                c.yAxis().addMark(minrulevalue, "&H" & strColor, ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
            End If
        Else
            reverse = ralert(i)
        End If
    Next i
    '================================================================================================
    c.layout()
    WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
    WebChartViewer2.Image = c.makeWebImage(Chart.PNG)
    '   WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    '                             "title='[{dataSetName}] Date: {xLabel} ; Value: {value|2} meters'")
    WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
     "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

%>
<html>
<head>
    <style>
 body
   {
   overflow-x:hidden;
   scrollbar-face-color: #FFFFFF ;
   scrollbar-3dlight-color: #AAB9FD ;
   scrollbar-highlight-color: #5F7AFC ;
   scrollbar-shadow-color: #5F7AFC;
   scrollbar-arrow-color: #5F7AFC;
   }
</style>
</head>
<body>
    <table border="1" cellspacing="0">
        <tr>
            <td align="center" valign="middle">
                <div align="center" valign="middle" style="background-color: white">
                    <%If blnTmp = True Then%>
                    <chart:WebChartViewer ID="WebChartViewer1" runat="server" Style="width: 390px; height:340px;" />
                    <%Else%>
                    <div align="center" valign="middle" style="background-color: white">
                        <chart:WebChartViewer ID="WebChartViewer2" runat="server" Style="width: 390px; height: 340px;" />
                    </div>
                    <%End If%>
                </div>
                 <div align="right">
                            <a href="Trending.aspx?siteid=<%=siteid%>&v=m5&sitename=<%=sitename%>&district=<%=district%>&position=<%=position%>&sitetype=RESERVOIR&equipname=Water Level Trending"
                                target="main">> Trending Selections</a></div>
            </td>
        </tr>
</body>
</html>
