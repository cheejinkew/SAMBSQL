<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<%
    Dim arrylstLabel As New ArrayList
    Dim arrylstValue1 As New ArrayList
    Dim arrylstValue2 As New ArrayList
    Dim arrylstValue3 As New ArrayList
    Dim arrylstValue4 As New ArrayList

    Dim strConn
    Dim objConn
    Dim sqlRs
    Dim sqlRs1
    Dim strValue
    Dim arryrows(3) As Integer
    Dim arryValue1() As Double
    Dim arryValue2() As Double
    Dim arryValue3() As Double
    Dim arryValue4() As Double
    Dim arryLabel() As String
    Dim arryScale(3) As Double
    Dim arryMax(3) As Double
    Dim arryMeasure(3)
    Dim arryEquipDesc(3)
    Dim arrySitetype(3) As String

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
    Dim DataFound = False
    Dim intInterval
   
    Dim strSelectedDistrict = Request.Form("ddDistrict")
    Dim intSiteID1 = Request.Form("ddSite1")
    Dim intSiteID2 = Request.Form("ddSite2")
    Dim intSiteID3 = Request.Form("ddSite3")
    Dim intSiteID4 = Request.Form("ddSite4")

    Dim arrySiteID1 = Split(intSiteID1, ",")
    Dim arrySiteID2 = Split(intSiteID2, ",")
    Dim arrySiteID3 = Split(intSiteID3, ",")
    Dim arrySiteID4 = Split(intSiteID4, ",")
   
    If arrySiteID1(0) <> "0" Then
        intSiteID = arrySiteID1(0)
        intPos = arrySiteID1(1)
    End If

    If arrySiteID2(0) <> "0" Then
        intSiteID = intSiteID & "," & arrySiteID2(0)
        intPos = intPos & "," & arrySiteID2(1)
    End If
   
    If arrySiteID3(0) <> "0" Then
        intSiteID = intSiteID & "," & arrySiteID3(0)
        intPos = intPos & "," & arrySiteID3(1)
    End If

    If arrySiteID4(0) <> "0" Then
        intSiteID = intSiteID & "," & arrySiteID4(0)
        intPos = intPos & "," & arrySiteID4(1)
    End If

    Dim strBeginDate = Request.Form("txtBeginDate")
    Dim strBeginHour = Request.Form("ddBeginHour")
    Dim strBeginMin = Request.Form("ddBeginMinute")
   
    Dim strEndDate = Request.Form("txtEndDate")
    Dim strEndHour = Request.Form("ddEndHour")
    Dim strEndMin = Request.Form("ddEndMinute")
    Dim arryPos = Split(intPos, ",")
    Dim arrySiteID = Split(intSiteID, ",")
    Dim intLenPos = arryPos.length()
   
    Dim strBeginDateTime = Date.Parse(strBeginDate & " " & strBeginHour & ":" & strBeginMin)
    Dim strEndDateTime = Date.Parse(strEndDate & " " & strEndHour & ":" & strEndMin)
   
    Dim strLastDate = Request.Form("txtLastDate")
    Dim strLastDate1
   
    If strLastDate = "" Then
        strStatus = "1stPage"
        strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
    End If
   
    strLastDate1 = strLastDate
   
   
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
    sqlRs1 = New ADODB.Recordset()

    objConn.open(strConn)
   
    'For i = 0 To intLenPos - 1
    '    sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
    '                 arrySiteID(i) & "' and position ='" & arryPos(i) & "' and sequence between '" & _
    '                 strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00' and '" & _
    '                 strEndDate & " " & strEndHour & ":" & strEndMin & ":59' order by sequence desc", objConn)
    '    Do While Not sqlRs.EOF
    '        DataFound = True
    '        Exit Do
    '        'sqlRs.movenext()
    '    Loop
    '    If DataFound Then
    '        sqlRs.close()
    '        Exit For
    '    Else
    '        sqlRs.close()
    '    End If
        
    'Next
    
    For i = 0 To intLenPos - 1
        sqlRs.open("select count(*) as rows from telemetry_log_table where siteid='" & _
                     arrySiteID(i) & "' and position ='" & arryPos(i) & "' and dtimestamp between '" & _
                     strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00' and '" & _
                     strEndDate & " " & strEndHour & ":" & strEndMin & ":59' ", objConn)
        
        If Not sqlRs.EOF Then
            arryrows(i) = sqlRs("rows").value()
            If (arryrows(i) > 0) Then
                DataFound = True
            End If
        End If
        sqlRs.close()
        
    Next

    '***********************************************************************************************
    j = 0
    i = 0
    If DataFound Then
        For i = 0 To intLenPos - 1
            strLastDate = strLastDate1
        
            sqlRs1.open("select sitename,e.sitetype as sitetype,max, measurement, sdesc " & _
                         " from telemetry_equip_list_table e, telemetry_site_list_table s" & _
                         " where e.siteid='" & arrySiteID(i) & "' and position ='" & arryPos(i) & "'" & _
                         " and e.siteid = s.siteid", objConn)

            If Not sqlRs1.EOF Then
                arryMax(i) = sqlRs1("max").value
                arrySitetype(i) = sqlRs1("sitetype").value
                arryScale(i) = arryMax(i) / 20
                arryMeasure(i) = sqlRs1("measurement").value
                arryEquipDesc(i) = sqlRs1("sitename").value & " : " & sqlRs1("sdesc").value
            End If
            sqlRs1.close()
        
       
            Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strEndDateTime))

                If i = 0 Then
                    arrylstLabel.Add(String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate)))
                End If
            
                sqlRs.open("select top 1 value, dtimestamp, position from telemetry_log_table where siteid='" & _
                        arrySiteID(i) & "' and position ='" & arryPos(i) & "' and dtimestamp between '" & _
                        strLastDate & ":00' and '" & strLastDate & ":59' order by dtimestamp desc ", objConn)
         
                 
                
                strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(15))

                If Not sqlRs.EOF Then
                    strValue = sqlRs("value").value
                         
                    Select Case i
                        Case 0
                            arrylstValue1.Add(strValue)
                        Case 1
                            arrylstValue2.Add(strValue)
                        Case 2
                            arrylstValue3.Add(strValue)
                        Case 3
                            arrylstValue4.Add(strValue)
                    End Select
                Else
                    Select Case i
                        Case 0
                            arrylstValue1.Add(Chart.NoValue)
                        Case 1
                            arrylstValue2.Add(Chart.NoValue)
                        Case 2
                            arrylstValue3.Add(Chart.NoValue)
                        Case 3
                            arrylstValue4.Add(Chart.NoValue)
                    End Select
                End If
         
                j = j + 1
                sqlRs.close()
            Loop
            j = 0
        Next
 
        If arrylstLabel.Count < 30 Then
            blnLast = True
        End If
   
        '******************************************
        ReDim arryLabel(arrylstLabel.Count - 1)
        arrylstLabel.CopyTo(arryLabel)
        
        
        ReDim arryValue1(arrylstValue1.Count - 1)
        arrylstValue1.CopyTo(arryValue1)
        
   
        ReDim arryValue2(arrylstValue2.Count - 1)
        arrylstValue2.CopyTo(arryValue2)
        
        
        ReDim arryValue3(arrylstValue3.Count - 1)
        arrylstValue3.CopyTo(arryValue3)
        

        ReDim arryValue4(arrylstValue4.Count - 1)
        arrylstValue4.CopyTo(arryValue4)
        
        '******************************************

        objConn.close()
        objConn = Nothing

        '===================================================================
        '  Drawing the chart.
        '===================================================================

        intChartWidth = 720
        intPlotWidth = 550
    
        Dim c As XYChart = New XYChart(intChartWidth, 425, &HFFFFFF, &H0, 1)


        'Set the plot area at (100, 25) and of size 450 x 300 pixels. Enabled both
        'vertical and horizontal grids by setting their colors to light grey (0xc0c0c0)
        c.setPlotArea(85, 50, intPlotWidth, 280).setGridColor(&HFBCCF9, &HFBCCF9)

        'Add the title, with arial font size 15 with blue background
        'c.addTitle("Multiple Trends Comparison", "Verdana Bold ", 12).setBackground(&HAAB9FD)
  
  
        'Add a legend box (100, 25) (top of plot area) using horizontal layout. Use 8 pts
        'Arial font. Disable bounding box (set border to transparent).
        c.addLegend(90, 0, False, "aaaa", 8).setBackground(Chart.Transparent)


        'Set the labels on the x axis
        c.xAxis().setLabels(arryLabel).setFontStyle("Arial")
        c.xAxis().setLabels(arryLabel).setFontAngle(45)
   
        'Set the title on the x axis
        c.xAxis().setTitle("Log Date Time")
  
    
        '***************************************************************************************
        Dim percent As Integer = 10
    
        Select Case intLenPos
            Case 1
                c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
                c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HCC0000, arryEquipDesc(0))
                layer0.setLineWidth(2)
      
                Array.Sort(arryValue1)
                Array.Reverse(arryValue1)
            
                Dim index As Integer = 0
                Dim max As Integer
                Dim scale As Integer
                
                If (arryrows(0) > 0) Then
                    While arryValue1(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue1(index))
                Else
                    max = arryMax(0)
                End If
                               
                scale = (percent * max) / 100
                max = max + scale * 2
            
                c.yAxis().setLinearScale(0, max, scale)
              

            Case 2
                c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
                c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
                     
                Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HCC0000, arryEquipDesc(0))
                layer0.setLineWidth(2)
            
                Array.Sort(arryValue1)
                Array.Reverse(arryValue1)
            
                Dim index As Integer = 0
                Dim max As Integer
                Dim scale As Integer
                
                If (arryrows(0) > 0) Then
                    While arryValue1(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue1(index))
                Else
                    max = arryMax(0)
                End If
                
                scale = (percent * max) / 100
                max = max + scale * 2
                     
                c.yAxis().setLinearScale(0, max, scale)
            
                c.yAxis2().setTitle(arryMeasure(1)).setAlignment(Chart.TopRight2)
                c.yAxis2().setColors(&H8000, &H8000, &H8000)
         
                Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))
                layer1.setLineWidth(2)
                layer1.setUseYAxis2()
            
                Array.Sort(arryValue2)
                Array.Reverse(arryValue2)
                
                index = 0
                max = 0
                scale = 0
                
                If (arryrows(1) > 0) Then
                    While arryValue2(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue2(index))
                Else
                    max = arryMax(1)
                End If
               
                scale = (percent * max) / 100
                max = max + scale * 2
           
                c.yAxis2().setLinearScale(0, max, scale)
     
            Case 3
                c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
                c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HCC0000, arryEquipDesc(0))
                layer0.setLineWidth(2)
            
                Array.Sort(arryValue1)
                Array.Reverse(arryValue1)
            
                Dim index As Integer = 0
                Dim max As Integer
                Dim scale As Integer
                
                If (arryrows(0) > 0) Then
                    While arryValue1(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue1(index))
                Else
                    max = arryMax(0)
                End If
                           
                scale = (percent * max) / 100
                max = max + scale * 2
            
                c.yAxis().setLinearScale(0, max, scale)

                c.yAxis2().setTitle(arryMeasure(1)).setAlignment(Chart.TopRight2)
                c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))
                layer1.setLineWidth(2)
                layer1.setUseYAxis2()
            
                Array.Sort(arryValue2)
                Array.Reverse(arryValue2)
            
                index = 0
                max = 0
                scale = 0
                
                If (arryrows(1) > 0) Then
                    While arryValue2(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue2(index))
                Else
                    max = arryMax(1)
                End If
            
                scale = (percent * max) / 100
                max = max + scale * 2
            
                c.yAxis2().setLinearScale(0, max, scale)
            
                Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                yAxis3.setTitle(arryMeasure(2)).setAlignment(Chart.TopLeft2)
                yAxis3.setColors(&HCC, &HCC, &HCC)
            
                Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &HCC, arryEquipDesc(2))
                layer2.setLineWidth(2)
                layer2.setUseYAxis(yAxis3)
            
                Array.Sort(arryValue3)
                Array.Reverse(arryValue3)
                
                index = 0
                max = 0
                scale = 0
                
                If (arryrows(2) > 0) Then
                    While arryValue3(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue3(index))
                Else
                    max = arryMax(2)
                End If
            
               
                scale = (percent * max) / 100
                max = max + scale * 2
            
                yAxis3.setLinearScale(0, max, scale)
                         
            Case 4

                c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
                c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HCC0000, arryEquipDesc(0))
                layer0.setLineWidth(2)
            
                Array.Sort(arryValue1)
                Array.Reverse(arryValue1)
            
                Dim index As Integer = 0
                Dim max As Integer
                Dim scale As Integer
                
                If (arryrows(0) > 0) Then
                    While arryValue1(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue1(index))
                Else
                    max = arryMax(0)
                End If
                            
                scale = (percent * max) / 100
                max = max + scale * 2
            
                c.yAxis().setLinearScale(0, max, scale)

                c.yAxis2().setTitle(arryMeasure(1)).setAlignment(Chart.TopRight2)
                c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))
                layer1.setLineWidth(2)
                layer1.setUseYAxis2()
            
                Array.Sort(arryValue2)
                Array.Reverse(arryValue2)
            
                index = 0
                max = 0
                scale = 0
                
                If (arryrows(1) > 0) Then
                    While arryValue2(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue2(index))
                Else
                    max = arryMax(1)
                End If
                
                scale = (percent * max) / 100
                max = max + scale * 2
            
                c.yAxis2().setLinearScale(0, max, scale)
            
                Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                yAxis3.setTitle(arryMeasure(2)).setAlignment(Chart.TopLeft2)
                yAxis3.setColors(&HCC, &HCC, &HCC)
            
                Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &HCC, arryEquipDesc(2))
                layer2.setLineWidth(2)
                layer2.setUseYAxis(yAxis3)
            
                Array.Sort(arryValue3)
                Array.Reverse(arryValue3)
            
                index = 0
                max = 0
                scale = 0
                
                If (arryrows(2) > 0) Then
                    While arryValue3(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue3(index))
                Else
                    max = arryMax(2)
                End If
                
                scale = (percent * max) / 100
                max = max + scale * 2
            
                yAxis3.setLinearScale(0, max, scale)

                Dim yAxis4 As Axis = c.addAxis(Chart.Right, 50)
                yAxis4.setTitle(arryMeasure(3)).setAlignment(Chart.TopRight2)
                yAxis4.setColors(&H880088, &H880088, &H880088)
            
                Dim layer3 As LineLayer = c.addLineLayer(arryValue4, &H880088, arryEquipDesc(3))
                layer3.setLineWidth(2)
                layer3.setUseYAxis(yAxis4)
            
                Array.Sort(arryValue4)
                Array.Reverse(arryValue4)
            
                index = 0
                max = 0
                scale = 0
                
                If (arryrows(3) > 0) Then
                    While arryValue4(index) = 1.7E+308
                        index = index + 1
                    End While
                    max = Math.Ceiling(arryValue4(index))
                Else
                    max = arryMax(3)
                End If
                
                scale = (percent * max) / 100
                max = max + scale * 2
            
                yAxis4.setLinearScale(0, max, scale)
     
  
        End Select

        If UBound(arryLabel) <= 30 Then
            intInterval = 0
        Else
            intInterval = (UBound(arryLabel) / 30)
        End If
        c.xAxis().setLabelStep(intInterval)

        c.layout()
        WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
        WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
                                 "title='[{dataSetName}] Date: {xLabel} ; Value: {value|2} meters'")
    End If
    
%>
<html>
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
<body>
    <form name="frmDisCon" method="post" action="TrendSelection.aspx">
        <div align="center">
            <br>
            <p>
                <img border="0" src="images/MultipleTrend.jpg">
                <br>
                <br>
                <%If DataFound = True Then%>
                <chart:WebChartViewer id="WebChartViewer1" runat="server" />
                <table>
                    <tr>
                        <td>
                            <a href="javascript:gotoSubmit()">
                                <img border="0" src="images/Back.jpg"></a>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <%Else%>
                <center>
                    <div align="center" valign="center" style="border-width: 1px; body-style: solid;
                        width: 400; height: 300;">
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <font style="font-family: Verdana; color: #3D62F8"><b>No Data To Be Displayed !</b></font>
                    </div>
                    <br>
                    <a href="javascript:gotoSubmit()">
                        <img border="0" src="images/Back.jpg"></a>
                </center>
                <%End If%>
                <input type="hidden" name="ddDistrict" value="">
                <input type="hidden" name="txtLastDate" value="">
                <input type="hidden" name="ddSite1" value="">
                <input type="hidden" name="ddSite2" value="">
                <input type="hidden" name="ddSite3" value="">
                <input type="hidden" name="ddSite4" value="">
                <input type="hidden" name="txtBeginDate" value="">
                <input type="hidden" name="ddBeginHour" value="">
                <input type="hidden" name="ddBeginMinute" value="">
                <input type="hidden" name="txtEndDate" value="">
                <input type="hidden" name="ddEndHour" value="">
                <input type="hidden" name="ddEndMinute" value="">
                <input type="hidden" name="txtStatus" value="">
    </form>
</body>
</html>

<script language="javascript">
  function gotoSubmit()
  {
    document.frmDisCon.ddDistrict.value="<%=strSelectedDistrict%>";
    document.frmDisCon.txtLastDate.value="<%=strLastDate%>";
    document.frmDisCon.ddSite1.value="<%=intSiteID1%>";
    document.frmDisCon.ddSite2.value="<%=intSiteID2%>";
    document.frmDisCon.ddSite3.value="<%=intSiteID3%>";
    document.frmDisCon.ddSite4.value="<%=intSiteID4%>";

    document.frmDisCon.txtBeginDate.value="<%=strBeginDate%>";
    document.frmDisCon.ddBeginHour.value="<%=strBeginHour%>";
    document.frmDisCon.ddBeginMinute.value="<%=strBeginMin%>";
    
    document.frmDisCon.txtEndDate.value="<%=strEndDate%>";
    document.frmDisCon.ddEndHour.value="<%=strEndHour%>";
    document.frmDisCon.ddEndMinute.value="<%=strEndMin%>";

    document.frmDisCon.submit();
  }
</script>

