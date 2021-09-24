<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>

<script language="VB" runat="server">
    Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"
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
    
    Function GetSiteComment(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.Open("select address from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
        If Not RS.EOF Then
            If IsDBNull(RS("address").value) = False Then
                GetSiteComment = Server.HtmlEncode(RS("address").value)
            Else
                GetSiteComment = ""
            End If
        Else
            GetSiteComment = ""
        End If
       

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing

    End Function

</script>

<%
    Dim arrylstLabel As New ArrayList
    Dim arrylstValue1 As New ArrayList
    Dim arrylstValue2 As New ArrayList
    Dim DateFinal
    Dim strConn
    Dim objConn
    Dim sqlRs
    Dim sqlRs1
    Dim strValue
    Dim arryValue1() As Double
    Dim arryValue2() As Double

    Dim arryLabel() As String
    Dim arryScale(3) As Double
    Dim arryMax(3) As Double
    Dim arryMeasure(3)
    Dim arryEquipDesc(3)

    Dim i
    Dim j
    Dim intCount = 0
    Dim intChartWidth
    Dim intChartHeight
    Dim intPlotWidth
    Dim intPlotHeight
    Dim blnSequence = False
    Dim blnLast = False
    Dim strStatus
    Dim intSiteID
    Dim intPos
    Dim blnTmp = False
    Dim intInterval
    Dim strFinal As Date
    
    
    Dim lowvalue
    Dim highvalue
    Dim lowvalue2
    Dim highvalue2
    
    Dim equipname = Request.QueryString("equipname") 'request.form("equipname")
    Dim strSelectedDistrict = Request.QueryString("district")
    Dim intSiteID1 = Request.QueryString("siteid") 'request.form("ddSite1")
    Dim intSiteID2 = Request.Form("ddSite2")

    '======================================
    Dim arrySiteID1 = Split(intSiteID1, ",")
    Dim arrySiteID2 = Split(intSiteID2, ",")

    '======================================    
   
    'if arrySiteID1(0) <> "0" then
    intSiteID = arrySiteID1(0)
    '  intPos = arrySiteID1(1)
    'end if

    'if arrySiteID2(0) <> "0" then
    '  intSiteID = intSiteID & "," & arrySiteID2(0)
    '  intPos = intPos & "," & arrySiteID2(1)
    'end if
    Dim lable1 = Request.QueryString("lab")
    Dim strBeginDate = Request.Form("txtBeginDate")
    Dim strBeginHour = Request.Form("ddBeginHour")
    Dim strBeginMin = Request.Form("ddBeginMinute")
   
    Dim strEndDate = Request.Form("txtEndDate")
    Dim strEndHour = Request.Form("ddEndHour")
    Dim strEndMin = Request.Form("ddEndMinute")
    Dim sitename = Request.QueryString("sitename")
    Dim panl = Request.QueryString("Ndays")
    
    Dim district = Request.QueryString("district")
    Dim siteid = Request.QueryString("siteid")
    Dim position = Request.QueryString("position")
    Dim equipment = Request.QueryString("equipment")
    
    Dim arryPos = Split(intPos, ",")
    Dim arrySiteID = Split(intSiteID, ",")
    Dim intLenPos = arryPos.length()
    Dim NodayInmonth As Integer
    '------------------------------------------------------------------
    Dim strData As Date = Request.QueryString("date")
    'Dim sr As String = strData.DaysInMonth(strData.Year, strData.Month)
    Dim strBeginDateTime = String.Format("{0:yyyy/MM/dd 00:00:00}", Date.Parse(Request.QueryString("date")))
    Dim NumberofDays As Integer = Request.QueryString("Ndays")
    
    Dim strEndDateTime
    
    If NumberofDays <= 0 Then
        strEndDateTime = String.Format("{0:yyyy/MM/dd 23:59:59}", Date.Parse(Request.QueryString("date")))
    ElseIf NumberofDays = 6 Then
        strFinal = strData.AddDays(Request.QueryString("Ndays"))
        strEndDateTime = String.Format("{0:yyyy/MM/dd 23:59:59}", strFinal)
        DateFinal = String.Format("{0:yyyy/MM/dd}", strFinal)
        'Response.Write(DateFinal)
    ElseIf NumberofDays > 6 Then
        
        strBeginDateTime = String.Format("{0:yyyy/MM/01 00:00:00}", Date.Parse(Request.QueryString("date")))
        
       
        Dim StDate As Date = Request.QueryString("date")
        
        ' = Request.QueryString("date") 'strData.AddDays(Request.QueryString("Ndays"))
        NodayInmonth = StDate.DaysInMonth(StDate.Year, StDate.Month)
        strFinal = strData.AddDays(NodayInmonth - 1)
        strEndDateTime = String.Format("{0:yyyy/MM/dd 23:59:59}", strFinal)
        'Response.Write("Ndays in a month" & NodayInmonth)
        
        
        
        DateFinal = String.Format("{0:yyyy/MM/dd}", strFinal)
    End If
    
    'Request.QueryString("date") 'Date.Parse(strBeginDate & " " & strBeginHour & ":" & strBeginMin) 
    'Request.QueryString("date") 'Date.Parse(strEndDate & " " & strEndHour & ":" & strEndMin) 
    '----------------------------------------------------
    
    
    Dim strLastDate = Request.Form("date")
    Dim strLastDate1
    String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(Request.QueryString("date"))) 'String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(Request.QueryString("enddatetime"))) '
    If strLastDate = "" Then
        strStatus = "1stPage"
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strBeginDateTime))
    End If
   
    strLastDate1 = strLastDate
   
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
    sqlRs1 = New ADODB.Recordset()
    
    If GetSiteComment(strConn, siteid) = "TM SERVER" Then
        strConn = TM_Conn
    End If

    objConn.open(strConn)
   
    For i = 0 To intLenPos - 1
        sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & arrySiteID(i) & "' and  sequence between '" & strBeginDateTime & "' and '" & strEndDateTime & "'  order by sequence desc", objConn)
        Do While Not sqlRs.EOF
            blnTmp = True
            sqlRs.movenext()
        Loop
        sqlRs.close()
    Next
    ' and position ='" & arryPos(i) & "'
    '***********************************************************************************************
    Dim rmultiplier(0) As String
    Dim rposition(0) As Integer
    Dim ralarmtype(0) As String
    Dim rcolorcode(0) As String
    Dim ralert(0) As Boolean
    i = 0
    sqlRs.Open("select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & Request("SiteID") & "' And alarmmode = 'EVENT' order by position, sequence asc", objConn)
    Do While Not sqlRs.EOF
        rmultiplier(i) = sqlRs.fields("multiplier").value
        rposition(i) = sqlRs.fields("position").value
        ralarmtype(i) = sqlRs.fields("alarmtype").value
        rcolorcode(i) = sqlRs.fields("colorcode").value
        ralert(i) = sqlRs.fields("alert").value
        i = i + 1
        ReDim Preserve rmultiplier(i)
        ReDim Preserve rposition(i)
        ReDim Preserve ralarmtype(i)
        ReDim Preserve rcolorcode(i)
        ReDim Preserve ralert(i)
        sqlRs.MoveNext()
    Loop
    sqlRs.close()
    'sqlRs = nothing
	
    Dim minValue As Integer
    Dim Suffix As String
	
    Suffix = "m3/h"
    
    If InStr(1, equipname, "Flowmeter") > 0 Then
        Suffix = "m<sup>3</sup>/h"
        minValue = 0
    End If
	
    If InStr(1, equipname, "Pressure") > 0 Then
        Suffix = "bar"
        minValue = 0
    End If

    If InStr(1, equipname, "Tank") > 0 Then
        Suffix = "m"
        minValue = 0
    End If

    If InStr(1, equipname, "Turbidity") > 0 Then
        Suffix = "NTU"
        minValue = 0
    End If
	
    If InStr(1, equipname, "pH") > 0 Then
        Suffix = "pH"
        minValue = 1
    End If
	
    If InStr(1, equipname, "Chlorine") > 0 Then
        Suffix = "ch"
        minValue = 0
    End If
    '***********************************************************************************************
    j = 0
    i = 0
    
    Dim sqlRs5 = New ADODB.Recordset()
    Dim objConn5 = New ADODB.Connection()
    objConn5.open(strConn)
    
    sqlRs5.open("SELECT MIN(value) AS minval, MAX(value) AS maxval FROM telemetry_log_table WHERE siteid = '" & arrySiteID(0) & "' and sequence BETWEEN '" & strBeginDateTime & "' and '" & strEndDateTime & "' and position=2", objConn5)
    
    'sqlRs5.open("SELECT MIN(value) AS minval, MAX(value) AS maxval FROM telemetry_log_table WHERE siteid = '" & arrr2(ss) & "' and sequence BETWEEN '" & fir & "' and '" & sec & "'", objConn5)
    lowvalue = sqlRs5("minval").value
    highvalue = sqlRs5("maxval").value
       
    If IsDBNull(lowvalue) = True Then
        lowvalue = 0
    End If
    If IsDBNull(highvalue) = True Then
        highvalue = 0
    End If
    sqlRs5.close()
    objConn5.close()
    
    'objConn5.open(strConn)
    'sqlRs5.open("SELECT MIN(value) AS minval, MAX(value) AS maxval FROM telemetry_log_table WHERE siteid = '" & arrySiteID(0) & "' and sequence BETWEEN '" & strBeginDateTime & "' and '" & strEndDateTime & "' and position=1", objConn5)
    
    ''sqlRs5.open("SELECT MIN(value) AS minval, MAX(value) AS maxval FROM telemetry_log_table WHERE siteid = '" & arrr2(ss) & "' and sequence BETWEEN '" & fir & "' and '" & sec & "'", objConn5)
    'lowvalue2 = sqlRs5("minval").value
    'highvalue2 = sqlRs5("maxval").value
       
    'If IsDBNull(lowvalue) = True Then
    '    lowvalue2 = 0
    'End If
    'If IsDBNull(highvalue) = True Then
    '    highvalue2 = 0
    'End If
    'sqlRs5.close()
    'objConn5.close()
    
       
    For i = 0 To intLenPos - 1
        strLastDate = strLastDate1
        Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDateTime))

            If i = 0 Then
                arrylstLabel.Add(String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strLastDate)))
            End If
            sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                    arrySiteID(i) & "' and  sequence between '" & _
                    strLastDate & "' and '" & strLastDate & "' and position='2' order by sequence desc limit 1 ", objConn)
            'position ='" & arryPos(i) & "' and
            'sqlRs1.open("select max, measurement, ""desc"" from telemetry_equip_list_table where siteid='" & _
            '        arrySiteID(i) & "' and position ='" & arryPos(i) & "'", objConn)
            'and position ='" & arryPos(i) & "'
            
            'Dim sqlRs6 = New ADODB.Recordset()
            'Dim objConn6 = New ADODB.Connection()
            'objConn6.open(strConn)
            'sqlRs6.open("select value, sequence, position from telemetry_log_table where siteid='" & _
            '        arrySiteID(i) & "' and  sequence between '" & _
            '        strLastDate & "' and '" & strLastDate & "' and position='1' order by sequence desc limit 1 ", objConn6)
            
            
            sqlRs1.open("select sitename, max, measurement, ""desc"" " & _
                        " from telemetry_equip_list_table e, telemetry_site_list_table s" & _
                        " where e.siteid='" & arrySiteID(i) & "' " & _
                        " and e.siteid = s.siteid", objConn)

            If Not sqlRs1.EOF Then
         
                arryMax(i) = sqlRs1("max").value
                arryScale(i) = arryMax(i) / 20
                arryMeasure(i) = sqlRs1("measurement").value
                arryEquipDesc(i) = sqlRs1("sitename").value & " : " & sqlRs1("desc").value
	   
            End If
            sqlRs1.close()
         
            strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(15))

            'If Not sqlRs6.EOF Then
            '    Dim strValue2 = sqlRs6("value").value
            '    arrylstValue2.Add(strValue2)
            'Else
            '    arrylstValue2.Add(Chart.NoValue)
            'End If
            
            'sqlRs6.close()
            
            If Not sqlRs.EOF Then
                strValue = sqlRs("value").value
                Select Case i
                    Case 0
                        arrylstValue1.Add(strValue)
                    Case 1
                        arrylstValue2.Add(strValue)
                End Select
    
            Else
                Select Case i
                    Case 0
                        arrylstValue1.Add(Chart.NoValue)
                    Case 1
                        arrylstValue2.Add(Chart.NoValue)
                End Select
            End If
         
            j = j + 1
  
            'if j = 30 then
            '  sqlRs.close()
            '  exit do
            'end if
            sqlRs.close()
            'objConn6.close()
        Loop
        j = 0
    Next
 
    If arrylstLabel.Count < 30 Then
        blnLast = True
    End If
   
    '******************************************
    ReDim arryLabel(arrylstLabel.Count - 1)
    For j = 0 To arrylstLabel.Count - 1
        arryLabel(j) = arrylstLabel.Item(j)
    Next

    ReDim arryValue1(arrylstValue1.Count - 1)
    For j = 0 To arrylstValue1.Count - 1
        arryValue1(j) = arrylstValue1.Item(j)
    Next
   
    ReDim arryValue2(arrylstValue2.Count - 1)
    For j = 0 To arrylstValue2.Count - 1
        arryValue2(j) = arrylstValue2.Item(j)
    Next
   
    '***************************************************************************************
    
    objConn.close()
    objConn = Nothing

    '===================================================================
    '  Drawing the chart.
    '===================================================================

    'response.write ("<br>" & arryscale.length)
    'For j = 0 to arryscale.length - 1
    'response.write ("<br>" & arryscale(j))
    'Next

    intChartWidth = 720
    intPlotWidth = 550
    
    '**  Dim c As XYChart = New XYChart(intChartWidth, 450, &HFFFFFF, &H0, 1)
    Dim c As XYChart = New XYChart(700, 450, &HFFFFFF, &H0, 1)
	 
    c.setPlotArea(85, 70, intPlotWidth, 280).setGridColor(&HFBCCF9, &HFBCCF9)
    '    c.setPlotArea(90, 20, 550, 300).setGridColor(&H97A9FF, &H97A9FF)
    

    'Add the title, with arial font size 15 with blue background
    'c.addTitle("Multiple Trends Comparison", "Verdana Bold ", 12).setAlignment(2)'.setBackground(&HAAB9FD)  
  
    'Add a legend box (100, 25) (top of plot area) using horizontal layout. Use 8 pts
    'Arial font. Disable bounding box (set border to transparent).
  
    '**  Dim legendBox As LegendBox = c.addLegend(90, 0, False, "aaaa", 8)
    '**   legendBox.setCols(-2)   
    '**   legendBox.setBackground(Chart.Transparent, Chart.Transparent)

    'Set the labels on the x axis
    c.xAxis().setLabels(arryLabel).setFontStyle("Arial")
    c.xAxis().setLabels(arryLabel).setFontAngle(45)
     
    'Set the title on the x axis
    '**   c.xAxis().setTitle("Log Date Time")
  
    '***************************************************************************************
    Select Case intLenPos
        Case 1
      
            c.yAxis().setTitle("m3/h").setAlignment(Chart.TopLeft2)
            'c.yAxis2().setTitle("bar").setAlignment(Chart.TopRight2)
            '**   c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
            c.yAxis().setColors(&H0&, &H0&, &H0&)
            'c.yAxis2().setLinearScale(lowvalue2, highvalue2)
     
            Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HC000&, arryEquipDesc(0))
            layer0.setLineWidth(1)
            'Dim layer3 As LineLayer = c.addLineLayer(arryValue2, &H996000&, arryEquipDesc(0))
            'layer3.setLineWidth(1)

        Case 2
      
            '**	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)      
            '**   c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
            c.yAxis().setColors(&H0&, &H0&, &H0&)
            '**   c.yAxis().setLinearScale(0, arryMax(0), arryScale(0)) 'This line

            Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HC000&, arryEquipDesc(0))
            '**      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))      
                              
            layer0.setLineWidth(1)
            '**      layer1.setLineWidth(2)
      
    End Select
    
    c.yAxis().addMark(highvalue, &HFF0000, "Max =" & highvalue).setLineWidth(2)
    c.yAxis().addMark(lowvalue, &HFF0000, "Min =" & lowvalue).setLineWidth(2)
    
    'c.yAxis().addMark(highvalue2, &HFF0000, "Max =" & highvalue2).setLineWidth(2)
    'c.yAxis().addMark(lowvalue2, &HFF0000, "Min =" & lowvalue2).setLineWidth(2)

    'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
    If UBound(arryLabel) <= 30 Then
        intInterval = 0
    Else
        intInterval = (UBound(arryLabel) / 30)
    End If
    c.xAxis().setLabelStep(intInterval)
    '================================================================================================
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
    '================================================================================================
    c.layout()
    WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
    '   WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    '                             "title='[{dataSetName}] Date: {xLabel} ; Value: {value|2} meters'")
    WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
     "title='Time {xLabel}: " & equipname & " {value} " & Suffix & "'")
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
<script type="text/javascript" language="javascript">
   function fun()
   {
  
     window.setInterval("fun1()",2000);
   }
   function fun1()
   {
   
   document.getElementById("map").innerHTML="";
    document.getElementById("cont").style.visibility="visible";
   }
   </script>
</head>
<body onload="fun()">
<div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="../images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
   </div>
<div id="cont" style="visibility:hidden;">
    <div align="center">
        <table cellspacing="0" cellpadding="0" border="0" style=" position:absolute ; font-size: 0.2in; font-family: Verdana; color: white; width: 90%; left: 8px; top: 10px;">
            <tbody>
                <tr>
                    <td width="100%" colspan="1" style="height: 25px; background-color:#aab9fd ">
                        <p align="center" >
                          <%=Request("lab")%> Summary Details 
                         <%-- for <%=Request("sitename")%>--%>
                             </p> 
                      </td></tr>
                       <tr>
                        <td width="100%" colspan="1" style="font-size:0.15in; height: 25px; background-color:#aab9fd">
                         <p align="center">  
                            <%  If panl = 6 Then%>
                                  From :
                                  <%=String.Format("{0:yyyy/MM/dd }", Date.Parse(Request.QueryString("date")))%>  To  <%=String.Format("{0:yyyy/MM/dd }", strFinal)%> 
                                <% ElseIf panl > 6 Then%>
                                  From :
                                  <%=String.Format("{0:yyyy/MM/dd }", Date.Parse(Request.QueryString("date")))%>  To  <%=String.Format("{0:yyyy/MM/dd }", strFinal)%> 
                                <% ElseIf panl < 6 Or NodayInmonth < 6 Then%>
                                  on
                                  <%=String.Format("{0:yyyy/MM/dd }", Date.Parse(Request.QueryString("date")))%>
                                <%End If %>
                            
                        </p>
                    </td>
                </tr>
                
            </tbody>
        </table>
        <br />
        <br />
        <br />
    </div>
    <table width="409" border="1" cellspacing="0">
        <tbody>
            <tr>
                <td style="width: 192px">
                    <div align="right">
                        Site ID :
                    </div>
                </td>
                <td>
                    <%=Request("siteid")%>
                </td>
            </tr>
            <tr>
                <td style="width: 192px">
                    <div align="right">
                        Site Name :
                    </div>
                </td>
                <td>
                    <%=Request("sitename")%>
                </td>
            </tr>
            <%--<tr>
                <td colspan="2" align="center">
                    <a href="Trending.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&district=<%=request("dddistrict")%>&sitetype=<%=request("sitetype") %>&equipname=<%=equipname%>&position=<%=request("Position")%>"
                        target="main">Trending Selection</a></td>
                <tr>--%>
        </tbody>
    </table>
    <table border="1" cellspacing="0">
        <tr>
            <td align="center">
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
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <font style="font-family: Verdana; color: #3D62F8"><b>No Data To Be Displayed !</b></font>
                        </div>
                    </center>
                    <%End If%> </div>
            </td>
        </tr>
       </table>
        
     <p align="center"><a href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p>   
</body>
</html>
