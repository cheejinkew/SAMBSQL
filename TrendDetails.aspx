<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
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

    'sigh
'    Dim txt = "select value, sequence, position from telemetry_log_table where siteid='" & _
'                SiteID & "' and position ='" & Position & "' and sequence between '" & _
'                 strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc limit 1 "
    Function getLastTime(ByVal siteID as String, ByRef objConn as ADODB.Connection) as String
        Dim rstRet
        Dim strSQL as String

        strSQL = "SELECT top 1 dtimestamp from telemetry_equip_status_table WHERE siteid='" & siteID & "' ORDER BY dtimestamp DESC "
        rstRet = New ADODB.Recordset()
        rstRet.Open(strSQL, objConn)
        If Not rstRet.EOF Then
            getLastTime = rstRet("dtimestamp").value
        Else
            getLastTime = String.Format("{0:yyyy-MM-dd HH:mm}",Now())
        End If
       rstRet.Close
       rstRet = Nothing
    End Function

</script>

<%
  
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
    Dim blnTmp = False
    Dim startdate As String
    Dim enddate As String
    startdate = Request.Form("txtBeginDate") & " " & Request.Form("ddBeginHour") & ":" & Request.Form("ddBeginMinute") & ":00"
    enddate = Request.Form("txtEndDate") & " " & Request.Form("ddEndHour") & ":" & Request.Form("ddEndMinute") & ":00"
    Dim strBeginDateTime = Date.Parse(startdate)
    Dim strEndDateTime = Date.Parse(enddate)
   
   
   'response.write("date: "& strBeginDateTime &" "& strEndDateTime)
    Dim strLastDate = Request.Form("txtBeginDate") & " " & Request.Form("ddBeginHour") & ":" & Request.Form("ddBeginMinute")  'Request("txtLastDate")
    Dim strLastDate1

    If strLastDate = "" Then
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
    End If
   
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
    
    thresholdValueMax = 0.0
    For i = 0 To (UBound(rmultiplier))
        maxrulevalue = szParseString(rmultiplier(i), ";", 3)
        If thresholdValueMax < maxrulevalue Then
            thresholdValueMax = maxrulevalue
        End If
    Next
    
    strLastDate = strLastDate1
    Dim dubValue As Double
    i = 0
    
    'Response.write("last date:"& strLastDate.Tostring() &" compare "& getLastTime(SiteID,objConn ) &"<br>" )

    'new added
    Dim strEndEnd, strRecEnd
    strRecEnd = Date.Parse(getLastTime(SiteID,objConn ))
    strEndEnd = Date.Parse(Request.Form("txtEndDate") & " " & Request.Form("ddEndHour") & ":" & Request.Form("ddEndMinute"))

    If strEndEnd > strRecEnd Then
        strEndEnd = strRecEnd
    End If 

    If strEndEnd > Now() Then
        strEndEnd = Now()
    End If
    
    strLastDate = Date.Parse(strLastDate)
    'Dim strTemp = Date.Parse(getLastTime(SiteID,objConn ))
    Dim cnt as integer
    cnt =0

    'strLastDate = String.Format("{0:yyyy-MM-dd HH:mm}",Date.Parse(strLastDate))
    'strTemp = String.Format("{0:yyyy-MM-dd HH:mm}",Date.Parse(getLastTime(SiteID,objConn )))

    'Response.write("date"& String.Format("{0:yyyy-MM-dd HH:mm}",strLastDate ) &"==="& String.Format("{0:yyyy-MM-dd HH:mm}",strEndEnd) & "<br>")

    Do While strLastDate <= strEndEnd  '2012-01-18
    cnt = cnt + 1
    'Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDateTime))
    'Do While strLastDate <= Date.Parse(strEndDateTime)

    'Response.write("date"& String.Format("{0:yyyy-MM-dd HH:mm}",strLastDate ) &"==="& String.Format("{0:yyyy-MM-dd HH:mm}",strEndEnd) & "<br>")

        Dim txt = "select top 1 value, dtimestamp, position from telemetry_log_table where siteid='" & _
                SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                 String.Format("{0:yyyy/MM/dd HH:mm}", strLastDate) & ":00' and '" & String.Format("{0:yyyy/MM/dd HH:mm}", strLastDate) & ":59' order by dtimestamp desc "
        rsRecords.Open(txt, objConn)
        'response.write(txt &"<br> --")
        'response.write("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & position & "' and sequence between '" & startdate & "' and '" & enddate & "' order by sequence desc")
        'rsRecords.Open("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & Position & "' and sequence between '" & startdate & "' and '" & enddate & "' order by sequence", objConn)
        'if rsrecords.eof = true then exit sub
        'Do While Not rsRecords.EOF    
           
        If rsRecords.eof = False Then
            blnTmp = True
            dubValue = CDbl(rsRecords.fields("value").value)
            If (dubValue > 0.0) Then
                values(i) = dubValue
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
        strLastDate = Date.Parse(strLastDate).AddMinutes(15)
        'strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(15))
        rsRecords.close()
        If cnt > 2880 Then
            Exit do
        End if
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
  
    Dim Div As Integer = 1
    If UBound(values) <= 31 Then
        Div = 1
    Else
        Div = (UBound(values) / 31)
    End If
    
    c.addTitle("Site ID : " & SiteID, "Times New Roman Bold", 12)
    c.yAxis().setTitle(yAxisTitle, "Arial Bold Italic", 12)
    c.xAxis().setTitle("Timestamp", "Arial Bold Italic", 12)
    c.xAxis().setLabels(sequence).setFontAngle(45)
    c.xAxis().setLabelStep(Div)
    c.yAxis.setLinearScale(0.0, (thresholdValueMax + 1))
   
    reverse = True
    Dim strColor = "FFB000"
    For i = 0 To UBound(rmultiplier)
        'response.write(minrulevalue & "; ")
        minrulevalue = szParseString(rmultiplier(i), ";", 2)
        maxrulevalue = szParseString(rmultiplier(i), ";", 3)
        If (ralarmtype(i) = "L" Or ralarmtype(i) = "H") Then
            strColor = "0000ff"
        Else
            strColor = rcolorcode(i)
        End If
        'If ralert(i) = True Then
        If ralarmtype(i) <> "NN" Then
            If (ralarmtype(i) = "L" Or ralarmtype(i) = "LL" Or ralarmtype(i) = "NN") Then
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
    <style media="print" type="text/css">
body {color : #000000;background : #ffffff;font-family : verdana,arial,sans-serif;font-size : 15pt;}
/*
#hide1
{display : none;}
*/
#hide2
{display : none;}
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
                        <a href="Trending.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&district=<%=request("dddistrict")%>&sitetype=<%=request("sitetype") %>&equipname=<%=equipname%>&position=<%=request("Position")%>"
                            target="main">Trending Selection</a></td>
                    <tr>
            </tbody>
        </table>
        <%-- <table id="hide2">
            <tr>
                <td>
                    <a href="javascript:goCreateExcel()">
                        <img border="0" src="images/SaveExcel.jpg" align="absbottom"></a>&nbsp;&nbsp;<a href="javascript:printsubmit();"><img
                            alt="Print" border="0" src="images/print.jpg" align="absbottom" /></a>
                </td>
            </tr>
        </table>--%>
        <table border="1" cellspacing="0">
            <tr>
                <td align="center">
                    Trending for
                    <%=equipname%>
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
        </table>

        <br /><br />
        <center><input type="button" value="  Print  " onclick="window.print();" /></center>
    </form>
</body>
</html>

<script type="text/javascript">
function printsubmit()
  {
  if('<%=blnTmp%>'=="True")
  {
  print();
  }
  else{
  alert("No Data To Print");
  }
  }

function goCreateExcel() 
  {  
    var strURL;
    var dist='<%=Request("dddistrict")%>';
    var dtype='<%=Request("sitetype") %>';
    var SiteID='<%=Request("siteid")%>';
    var SiteName = '<%=Request("sitename")%>';
    var EquipName='<%=equipname%>';
    var strBeginDateTime = '<%=strBeginDateTime %>';   
    var strEndDateTime = '<%=strEndDateTime %>';
    var position='<%=Request("Position")%>';   
    strURL = "ExcelTrending.aspx?"
    strURL = strURL + "dist=" + dist + "&dtype=" + dtype + "&SiteID=" + SiteID + "&Position=" + position + "&EquipName=" + EquipName + "&SiteName=" + SiteName 
    strURL = strURL + "&BeginDateTime=" + strBeginDateTime + "&EndDateTime=" + strEndDateTime    
    document.form1.action=strURL;
    document.form1.submit();
  }
</script>

