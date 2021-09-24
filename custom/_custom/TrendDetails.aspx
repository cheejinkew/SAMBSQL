<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>

<script language="VB" runat="server">

Function szParseString(szString As String, szDelimiter As String, nSegmentNumber As Integer) 
    Dim nIndex  As Integer
    Dim szTemp  As String
    Dim nPos    As Integer

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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
</script>

<%
	dim SiteID = request.Form("siteid")
	dim SiteName = request.Form("sitename")
	dim District = request.Form("district")
	dim Position = request.Form("position")
	dim EquipName = request.Form("equipname")

	dim startdate as string
	dim enddate as string
    Dim xscale = Request.Form("ddXScale")
	startdate = request.Form("txtBeginDate") & " " & request.Form("ddBeginHour") & ":" & request.Form("ddBeginMinute") & ":00"
	enddate = request.Form("txtEndDate") & " " & request.Form("ddEndHour") & ":" & request.Form("ddEndMinute") & ":00"
	
	dim strConn
	dim objConn
	dim rsRecords
    Dim values() As Double
    Dim sequence(0) As String
    Dim i As Integer = 0
    
    Dim strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate))
    Dim strLastDate1
   
       
    strLastDate1 = strLastDate
    
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
    objConn.open(strConn)
    
    
    strLastDate = strLastDate1
    Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(enddate))
        rsRecords.open("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & Position & "' and sequence between '" & strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc limit 1 ", objConn)
        If Not rsRecords.EOF Then
            ReDim Preserve values(i)
            ReDim Preserve sequence(i)
            
            values(i) = rsRecords.fields("value").value
            sequence(i) = rsRecords.fields("sequence").value
            
            i = i + 1
            
            
        End If
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(xscale))
        rsRecords.close()
    Loop
    
    'rsRecords.Open("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & Position & "' and sequence between '" & startdate & "' and '" & enddate & "' order by sequence asc", objConn)
    
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
    rsRecords = Nothing
	
    Dim minValue As Integer
    Dim Suffix As String
	
    If InStr(1, EquipName, "Flowmeter") > 0 Then
        Suffix = "m3/h"
        minValue = 0
    End If
	
    If InStr(1, EquipName, "Pressure") > 0 Then
        Suffix = "bar"
        minValue = 0
    End If

    If InStr(1, EquipName, "Tank") > 0 Then
        Suffix = "m"
        minValue = 0
    End If

    If InStr(1, EquipName, "Turbidity") > 0 Then
        Suffix = "NTU"
        minValue = 0
    End If
	
    If InStr(1, EquipName, "pH") > 0 Then
        Suffix = "pH"
        minValue = 1
    End If
	
    If InStr(1, EquipName, "Chlorine") > 0 Then
        Suffix = "ch"
        minValue = 0
    End If
		
    'The data for the line chart
    On Error Resume Next
    'The labels for the line chart

    'Create a XYChart object of size 250 x 250 pixels
    Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

    'Set the plotarea at (30, 20) and of size 200 x 200 pixels
    c.setPlotArea(90, 20, 550, 300).setGridColor(&HFBCCF9, &HFBCCF9)

    'Add a line chart layer using the given data
    c.addLineLayer(values, &HC000&)
    
    'Set the labels on the x axis.
    'c.xAxis().setLabels(sequence).setFontAngle(45)
    'c.xAxis().setLabels(sequence).setFontSize(10)
    c.yAxis().setColors(&H0&, &H0&, &H0&)
    '	c.yAxis2().setColors(&H0&, &H0&, &H0&)    
    'Display 1 out of 3 labels on the x-axis.
    Dim Div As Integer
    If UBound(values) <= 31 Then
        Div = 1
    Else
        Div = (UBound(values) / 31)
    End If
    
    
    
    Dim k As Integer = 0
    Dim d = Div * 2
    While k < sequence.Length
        If k Mod d = 0 Then
            sequence(k) = " "
        End If
        k = k + 1
     
    End While
    
    'c.addLineLayer(val, &HC000&)
    
    c.xAxis().setLabels(sequence).setFontAngle(45)
    c.xAxis().setLabels(sequence).setFontSize(10)
    c.xAxis().setLabelStep(Div)
    
    '	c.yAxis().addZone(0, 2, &HFF0000)

    Dim maxrulevalue As Double
    Dim minrulevalue As Double
    Dim reverse As Boolean

    reverse = True
    For i = 0 To UBound(rmultiplier)
        'response.write(minrulevalue & "; ")
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
	
    'output the chart
    WebChartViewer1.Image = c.makeWebImage(Chart.PNG)

    'include tool tip for the chart
    WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

%>

<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="70%">
    <tr>
      <td width="100%" height="50" colspan="4">
        <p align="center"><img border="0" src="../images/TrendingDetails.jpg">
      </td>
    </tr>
  </table>
</div>
<table width="409" border="1">
  <tr>
    <td width="200"><div align="right">District : </div></td>
    <td width="193"><%=district%></td>
  </tr>
  <tr>
    <td><div align="right">Site ID : </div></td>
    <td><%=siteid%></td>
  </tr>
  <tr>
    <td><div align="right">Site Name : </div></td>
    <td><%=sitename%></td>
  </tr>
  <tr>
    <td><div align="right">Equipment :</div></td>
    <td><%=equipname%></td>
  </tr>
  <tr>
    <td><div align="right">Position : </div></td>
    <td><%=position%></td>
  </tr>
</table>
<table width="410" border="1">
  <tr>
    <td><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname%>&position=<%=Position%>" target="main">Trending Selection</a></div></td>
  </tr>
</table>
<table width="729" height="523" border="1">
  <tr>
    <td width="673" height="36"><div align="center">Trending for <%=equipname%></div></td>
  </tr>
  <tr>
    <td height="479"> <chart:WebChartViewer id="WebChartViewer1" runat="server" /> </td>
  </tr>
</table>

