<%@ Page Language="VB" Debug="true" AutoEventWireup="true" %>

<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>

<script runat="server">
    
    Dim xcount As Integer = 7
        
    Dim district As String
    Dim site1 As String
    Dim site2 As String
    Dim site3 As String
    Dim site4 As String
    Dim siteidstr As String = ""
    Dim posstr As String = ""
    
    Dim noofsites As Integer
        
    Dim siteid(3) As String
    Dim position(3) As String
    Dim sitename(4) As String
    Dim measurement(4) As String
    Dim lenpos As Int32
    Dim recordsfound = False
    
    Dim intCount = 0
    Dim intChartWidth = 750
    Dim intChartHeight = 450
    Dim intPlotWidth = 550
    Dim intPlotHeight = 250
    Dim blnSequence = False
       
    Dim interval As Integer
    Dim style As Integer
    Dim xmax
    Dim xmin
          
    Dim begindatetime
    Dim enddatetime
    Dim nextdatetime
    
    Dim fdatetime
    Dim pdatetime
    Dim ndatetime
    Dim ldatetime
    Dim originalviewquery
    
    Dim fbquery As String
    Dim pbquery As String
    Dim nbquery As String
    Dim lbquery As String
    
    Dim y1min As Double
    Dim y1max As Double
    Dim y2min As Double
    Dim y2max As Double
    Dim y3min As Double
    Dim y3max As Double
    Dim y4min As Double
    Dim y4max As Double
    Dim operation As String
    
    Dim xys As Byte
   
    Dim xdivstr As String = ""
    
    Dim firsttime As Byte
       
    Dim tyAxis3 As Axis
    
    Sub Page_Load(ByVal Source As Object, ByVal E As EventArgs)
     
    
       
        Dim yvalues As New ArrayList
    
    
        Dim strConn
        Dim objConn
        Dim sqlRs
        Dim sqlRs1
     
        'Retrive Query string values 
        begindatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("begindatetime")))
        enddatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("enddatetime")))
        
        district = Request.QueryString("district")
        site1 = Request.QueryString("site1")
        site2 = Request.QueryString("site2")
        site3 = Request.QueryString("site3")
        site4 = Request.QueryString("site4")
        interval = Request.QueryString("interval")
  
        
        style = Request.QueryString("style")
        
        y1min = Request.QueryString("y1min")
        y1max = Request.QueryString("y1max")
        
        y2min = Request.QueryString("y2min")
        y2max = Request.QueryString("y2max")
        
        y3min = Request.QueryString("y3min")
        y3max = Request.QueryString("y3max")
        
        y4min = Request.QueryString("y4min")
        y4max = Request.QueryString("y4max")
        
        operation = Request.QueryString("operation")
        
        xys = Request.QueryString("xys")
        
        
        
        xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmin")))
        xmax = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
        
        If Request.QueryString("firsttime") Is Nothing Then
            firsttime = 0
        Else
            firsttime = Request.QueryString("firsttime")
        End If
        
        
        
            
        Select Case operation
            Case "submit", "x"
                If xmin > xmax Then
                    xmax = xmin
                    xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
                End If
                
                Session("xmin") = xmin
                Session("xmax") = xmax
                Dim fdatetime As DateTime = Date.Parse(xmin)
                Dim ldatetime As DateTime = Date.Parse(xmax)
                Dim tminutes As Integer = (ldatetime - fdatetime).TotalMinutes
                   
                Select Case tminutes
                    Case 14401 To 100800
                        interval = 10080
                    Case 7201 To 14400
                        interval = 1440
                    Case 2401 To 7200
                        interval = 720
                    Case 1201 To 2400
                        interval = 240
                    Case 601 To 1200
                        interval = 120
                    Case 301 To 600
                        interval = 60
                    Case 151 To 300
                        interval = 30
                    Case 1 To 150
                        interval = 15
                    Case Else
                        interval = 15
                    
                End Select
                
                xcount = tminutes / interval
                If (xcount > 10) Then
                    xcount = 10
                    interval = 15
                End If
                Session("xcount") = xcount
                Session("y1min") = y1min
                Session("y1max") = y1max
                
                Session("y2min") = y2min
                Session("y2max") = y2max
                
                Session("y3min") = y3min
                Session("y3max") = y3max
                
                Session("y4min") = y4min
                Session("y4max") = y4max
            Case "y"
                Session("y1min") = y1min
                Session("y1max") = y1max
                
                Session("y2min") = y2min
                Session("y2max") = y2max
                
                Session("y3min") = y3min
                Session("y3max") = y3max
                
                Session("y4min") = y4min
                Session("y4max") = y4max
                
            Case "style"
                
                y1min = Session("y1min")
                y1max = Session("y1max")
                
                y2min = Session("y2min")
                y2max = Session("y2max")
                
                y3min = Session("y3min")
                y3max = Session("y3max")
                
                y4min = Session("y4min")
                y4max = Session("y4max")
                
                xmin = Session("xmin")
                xmax = Session("xmax")
                
                        
            Case Else
                If xmin > xmax Then
                    xmax = xmin
                    xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
                End If
                
                Session("xmin") = xmin
                Session("xmax") = xmax
                
                
        End Select
        
        xcount = Session("xcount")
       
            
        Dim temparray As String()
        Dim tempsiteidlist As New ArrayList
        If Not site1 = "no" Then
            temparray = Split(site1, ",")
            siteid(0) = temparray(0)
            position(0) = temparray(1)
            tempsiteidlist.Add(siteid(0))
        End If
        
                       
        If Not site2 = "no" Then
            temparray = Split(site2, ",")
            siteid(1) = temparray(0)
            position(1) = temparray(1)
            tempsiteidlist.Add(siteid(1))
        End If
            
        If Not site3 = "no" Then
            temparray = Split(site3, ",")
            siteid(2) = temparray(0)
            position(2) = temparray(1)
            tempsiteidlist.Add(siteid(2))
        End If
            
        If Not site4 = "no" Then
            temparray = Split(site4, ",")
            siteid(3) = temparray(0)
            position(3) = temparray(1)
            tempsiteidlist.Add(siteid(3))
        End If
        
       
        noofsites = tempsiteidlist.Count
             
              
        Dim xvalues(xcount) As String
    
        Dim site1yvalues(xcount) As Double
        Dim site2yvalues(xcount) As Double
        Dim site3yvalues(xcount) As Double
        Dim site4yvalues(xcount) As Double
    
       
        yvalues.Add(site1yvalues)
        yvalues.Add(site2yvalues)
        yvalues.Add(site3yvalues)
        yvalues.Add(site4yvalues)
        
        
                           
                            
        strConn = ConfigurationSettings.AppSettings("DSNPG")
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        sqlRs1 = New ADODB.Recordset()

        objConn.open(strConn)
   
        'Findout records are existed or not
        Dim index As Int32 = 0
        For index = 0 To noofsites - 1
            sqlRs1.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                            siteid(index) & "' and position ='" & position(index) & "' and sequence between '" & xmin & "' and '" & enddatetime & "' ", objConn)
            If Not sqlRs1.EOF Then
                recordsfound = True
                sqlRs1.close()
                Exit For
            End If
            sqlRs1.close()
        Next
        
        '***********************************************************************************************
        '  Generate X Values,Y Values
        '***********************************************************************************************
        If recordsfound = True Then
            
                  
            Dim i As Integer
        
            For i = 0 To noofsites - 1
                
                sqlRs1.open("select sitename,e.sitetype as sitetype,max, measurement, ""desc"" " & _
                             " from telemetry_equip_list_table e, telemetry_site_list_table s" & _
                             " where e.siteid='" & siteid(i) & "' and position ='" & position(i) & "'" & _
                             " and e.siteid = s.siteid", objConn)

           
                If Not sqlRs1.EOF Then
                
                    measurement(i) = sqlRs1("measurement").value
                    sitename(i) = sqlRs1("sitename").value & " : " & sqlRs1("desc").value
                End If
                sqlRs1.close()
            
                nextdatetime = xmin
                Dim j As Integer
                For j = 0 To xcount
                
          
                    If i = 0 Then
                        xvalues(j) = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(nextdatetime))
                    End If
                
       
                    sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                                siteid(i) & "' and position ='" & position(i) & "' and sequence between '" & _
                                nextdatetime & ":00' and '" & nextdatetime & ":59' order by sequence desc limit 1 ", objConn)
         
                    nextdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(nextdatetime).AddMinutes(interval))
                                           
                    Dim strValue
                    If i = 0 Then
                        If Not sqlRs.EOF Then
                            strValue = sqlRs("value").value
                            If y1min = 0 And y1max = 0 Then
                                yvalues(i)(j) = strValue
                            ElseIf y1min <= strValue And y1max >= strValue Then
                                yvalues(i)(j) = strValue
                            Else
                                yvalues(i)(j) = Chart.NoValue
                            End If
                        
                        
                        Else
                            yvalues(i)(j) = Chart.NoValue
                    
                        End If
                    ElseIf i = 1 Then
                        If Not sqlRs.EOF Then
                            strValue = sqlRs("value").value
                            If y2min = 0 And y2max = 0 Then
                                yvalues(i)(j) = strValue
                            ElseIf y2min <= strValue And y2max >= strValue Then
                                yvalues(i)(j) = strValue
                            Else
                                yvalues(i)(j) = Chart.NoValue
                            End If
                        
                        
                        Else
                            yvalues(i)(j) = Chart.NoValue
                    
                        End If
                    ElseIf i = 2 Then
                        If Not sqlRs.EOF Then
                            strValue = sqlRs("value").value
                            If y3min = 0 And y3max = 0 Then
                                yvalues(i)(j) = strValue
                            ElseIf y3min <= strValue And y3max >= strValue Then
                                yvalues(i)(j) = strValue
                            Else
                                yvalues(i)(j) = Chart.NoValue
                            End If
                        
                        
                        Else
                            yvalues(i)(j) = Chart.NoValue
                    
                        End If
                    ElseIf i = 3 Then
                        If Not sqlRs.EOF Then
                            strValue = sqlRs("value").value
                            If y4min = 0 And y4max = 0 Then
                                yvalues(i)(j) = strValue
                            ElseIf y4min <= strValue And y4max >= strValue Then
                                yvalues(i)(j) = strValue
                            Else
                                yvalues(i)(j) = Chart.NoValue
                            End If
                        
                        
                        Else
                            yvalues(i)(j) = Chart.NoValue
                    
                        End If
                    End If
                    'If Not sqlRs.EOF Then
                    '    strValue = sqlRs("value").value
                    '    yvalues(i)(j) = strValue
                    'Else
                    '    yvalues(i)(j) = Chart.NoValue
                    
                    'End If
                                
                    sqlRs.close()
              
                Next
            
            Next
                 
            '***************************************************************************************

            
            Dim lastdatetime As String = enddatetime
            sqlRs.open("select max(sequence) as lastdate from telemetry_log_table where siteid='" & siteid(0) & "' and position ='" & position(0) & "' and sequence between '" & begindatetime & "' and '" & enddatetime & "'", objConn)
            If Not sqlRs.EOF Then
                If Not IsDBNull(sqlRs("lastdate").value) Then
                    lastdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(sqlRs("lastdate").value).AddMinutes(-interval * (xcount - 1)))
                End If
            End If
        
            sqlRs.close()
            
            objConn.close()
            objConn = Nothing
        
        
            pdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(xmin).AddMinutes(-interval))
            ndatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(xmin).AddMinutes(interval))
        
            Dim sitestr As String = "&site1=" + site1 + "&site2=" + site2 + "&site3=" + site3 + "&site4=" + site4
            fbquery = "MTrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & sitestr & "&interval=" & interval & "&district=" & district & "&style=" & style & "&xmin=" & begindatetime & "&xmax=" & xmax & "&y1min=" & y1min & "&y1max=" & y1max & "&y2min=" & y2min & "&y2max=" & y2max & "&y3min=" & y3min & "&y3max=" & y3max & "&y4min=" & y4min & "&y4max=" & y4max & "&operation=first"
            pbquery = "MTrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & sitestr & "&interval=" & interval & "&district=" & district & "&style=" & style & "&xmin=" & pdatetime & "&xmax=" & xmax & "&y1min=" & y1min & "&y1max=" & y1max & "&y2min=" & y2min & "&y2max=" & y2max & "&y3min=" & y3min & "&y3max=" & y3max & "&y4min=" & y4min & "&y4max=" & y4max & "&operation=prev"
            If (DateTime.Parse(xmin) >= DateTime.Parse(enddatetime).AddMinutes(-interval)) Then
                nbquery = "#"
            Else
                nbquery = "MTrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & sitestr & "&interval=" & interval & "&district=" & district & "&style=" & style & "&xmin=" & ndatetime & "&xmax=" & xmax & "&y1min=" & y1min & "&y1max=" & y1max & "&y2min=" & y2min & "&y2max=" & y2max & "&y3min=" & y3min & "&y3max=" & y3max & "&y4min=" & y4min & "&y4max=" & y4max & "&operation=next"
            End If
            
            lbquery = "MTrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & sitestr & "&interval=" & interval & "&district=" & district & "&style=" & style & "&xmin=" & lastdatetime & "&xmax=" & xmax & "&y1min=" & y1min & "&y1max=" & y1max & "&y2min=" & y2min & "&y2max=" & y2max & "&y3min=" & y3min & "&y3max=" & y3max & "&y4min=" & y4min & "&y4max=" & y4max & "&operation=last"
            
            originalviewquery = "MTrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & sitestr & "&interval=15&district=" & district & "&style=" & style & "&xmin=" & begindatetime & "&xmax=" & enddatetime & "&y1min=0&y1max=0&y2min=0&y2max=0&y3min=0&y3max=0&y4min=0&y4max=0&operation=submit"
        
       
            
        
       
            '===================================================================
            '  Drawing the chart.
            '===================================================================
      
            Dim c As XYChart = New XYChart(intChartWidth, intChartHeight, &HFFFFFF, &H0, 1)
	 
            c.setPlotArea(85, 100, intPlotWidth, intPlotHeight, &HEEEEEE, &HFFFFFF).setGridColor(&HC0C0C0, &HC0C0C0)
    


            'Set the labels on the x axis
            c.xAxis().setLabels(xvalues).setFontStyle("Arial")
            c.xAxis().setLabels(xvalues).setFontAngle(45)
            c.xAxis().setLabels(xvalues).setFontColor(&HCC)
            c.yAxis().setColors(&H0&, &H0&, &H0&)
        
            c.addLegend(100, 20, False, "", 8).setBackground(Chart.Transparent)
    
            Select Case noofsites
                Case 1
                
                Case 2
                    Select Case style
            
                        Case 1
                        
                                               
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As LineLayer = c.addLineLayer(yvalues(0), &HCC0000, sitename(0))
                            layer0.setLineWidth(3)
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                            Dim layer1 As LineLayer = c.addLineLayer(yvalues(1), &H8000, sitename(1))
                            layer1.setLineWidth(3)
                            layer1.setUseYAxis2()
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
                                      
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                          
                        
                        Case 2
                            'line layer of site 1 
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As LineLayer = c.addLineLayer(yvalues(0), &HCC0000, sitename(0))
                            layer0.setLineWidth(3)
                            layer0.set3D(-1)
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                            Dim layer1 As LineLayer = c.addLineLayer(yvalues(1), &H8000, sitename(1))
                            layer1.setLineWidth(3)
                            layer1.set3D(-1)
                            layer1.setUseYAxis2()
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
                                      
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                        
                                   
                                           
                        Case 3
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                                                               
                            Dim layer1 As AreaLayer = c.addAreaLayer(yvalues(0), &HAACC0000, sitename(0), 2)
                            Dim layer2 As AreaLayer = c.addAreaLayer(yvalues(1), &HAA00AA00, sitename(1), 2)
                                    
                            layer2.setUseYAxis2()
                      
                                            
                            layer1.setLineWidth(2)
                            layer2.setLineWidth(2)
                      
                    
                        
                            layer1.set3D(-1)
                            layer2.set3D(-1)
                     
                 
                        
                            layer1.setBorderColor(&HCC0000)
                            layer2.setBorderColor(&H8000)
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
                                      
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                                 
                                             
                        Case 4
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As BarLayer = c.addBarLayer(yvalues(0), &HBBCC0000, sitename(0))
                            layer0.setBorderColor(&HCC0000)
                            layer0.setBarWidth(30)
                            layer0.set3D(-1)
                      
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
                        
            
                            Dim layer1 As BarLayer = c.addBarLayer(yvalues(1), &HBB008000, sitename(1))
                            layer1.setBorderColor(&H8000)
                            layer1.set3D(-1)
                        
                      
                            layer1.setBarWidth(30)
                            layer1.setDataCombineMethod(3)
                            layer1.setUseYAxis2()
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
                                      
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            
                    
                   
                    End Select
                
               
                
                Case 3
                    Select Case style
            
                        Case 1
                        
                                               
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As LineLayer = c.addLineLayer(yvalues(0), &HCC0000, sitename(0))
                            layer0.setLineWidth(3)
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                            Dim layer1 As LineLayer = c.addLineLayer(yvalues(1), &H8000, sitename(1))
                            layer1.setLineWidth(3)
                            layer1.setUseYAxis2()
                        
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
                        
                            
            
                            Dim layer2 As LineLayer = c.addLineLayer(yvalues(2), &HCC, sitename(2))
                            layer2.setLineWidth(3)
                            layer2.setUseYAxis(yAxis3)
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
            
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                                                          
                        
                        Case 2
                            'line layer of site 1 
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As LineLayer = c.addLineLayer(yvalues(0), &HCC0000, sitename(0))
                            layer0.setLineWidth(3)
                            layer0.set3D(-1)
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                            Dim layer1 As LineLayer = c.addLineLayer(yvalues(1), &H8000, sitename(1))
                            layer1.setLineWidth(3)
                            layer1.set3D(-1)
                            layer1.setUseYAxis2()
                        
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
            
                            Dim layer2 As LineLayer = c.addLineLayer(yvalues(2), &HCC, sitename(2))
                            layer2.setLineWidth(3)
                            layer2.set3D(-1)
                            layer2.setUseYAxis(yAxis3)
                            
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                        
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
            
                                           
                        Case 3
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                       
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
            
                        
            
                                              
                            Dim layer1 As AreaLayer = c.addAreaLayer(yvalues(0), &HAACC0000, sitename(0), 4)
                            Dim layer2 As AreaLayer = c.addAreaLayer(yvalues(1), &HAA00AA00, sitename(1), 4)
                            Dim layer3 As AreaLayer = c.addAreaLayer(yvalues(2), &HAA0000AA, sitename(2), 4)
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                     
                        
                        
                            layer2.setUseYAxis2()
                            layer3.setUseYAxis(yAxis3)
                    
                        
                            layer1.setLineWidth(2)
                            layer2.setLineWidth(2)
                            layer3.setLineWidth(2)
                    
                        
                            layer1.set3D(-1)
                            layer2.set3D(-1)
                            layer3.set3D(-1)
                 
                        
                            layer1.setBorderColor(&HCC0000)
                            layer2.setBorderColor(&H8000)
                            layer3.setBorderColor(&HCC)
                        
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                
  
                                             
                        Case 4
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As BarLayer = c.addBarLayer(yvalues(0), &HBBCC0000, sitename(0))
                            layer0.setBorderColor(&HCC0000)
                            layer0.setBarWidth(30)
                            layer0.set3D(-1)
                      
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
                        
            
                            Dim layer1 As BarLayer = c.addBarLayer(yvalues(1), &HBB008000, sitename(1))
                            layer1.setBorderColor(&H8000)
                            layer1.set3D(-1)
                        
                      
                            layer1.setBarWidth(30)
                            layer1.setDataCombineMethod(3)
                            layer1.setUseYAxis2()
                        
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
            
                            Dim layer2 As BarLayer = c.addBarLayer(yvalues(2), &HBB0000CC, sitename(2))
                            layer2.set3D(-1)
                            layer2.setBorderColor(&HCC)
                            layer2.setBarWidth(30)
                            layer2.setUseYAxis(yAxis3)
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                       
                        
                   
                    End Select
               
                Case 4
                    Select Case style
            
                        Case 1
                        
                                               
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As LineLayer = c.addLineLayer(yvalues(0), &HCC0000, sitename(0))
                            layer0.setLineWidth(3)
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                            Dim layer1 As LineLayer = c.addLineLayer(yvalues(1), &H8000, sitename(1))
                            layer1.setLineWidth(3)
                            layer1.setUseYAxis2()
                        
                            Dim tyAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            tyAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            tyAxis3.setColors(&HCC, &HCC, &HCC)
                                                        
                            Dim layer2 As LineLayer = c.addLineLayer(yvalues(2), &HCC, sitename(2))
                            layer2.setLineWidth(3)
                            layer2.setUseYAxis(tyAxis3)
                                    
                            Dim yAxis4 As Axis = c.addAxis(Chart.Right, 50)
                            yAxis4.setTitle(measurement(3)).setAlignment(Chart.TopRight2)
                            yAxis4.setColors(&H880088, &H880088, &H880088)
            
                            Dim layer3 As LineLayer = c.addLineLayer(yvalues(3), &H880088, sitename(3))
                            layer3.setLineWidth(3)
                            layer3.setUseYAxis(yAxis4)
                            
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                tyAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                            If Not (y4min = 0 And y4max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y4max - y4min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis4.setLinearScale(y4min, y4max, minval)
                            End If
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += tyAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis4.getHTMLImageMap("javascript:selecty4('{value}');", " ", "title='Value = {value}'")
                          
                                               
                        Case 2
                            'line layer of site 1 
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As LineLayer = c.addLineLayer(yvalues(0), &HCC0000, sitename(0))
                            layer0.setLineWidth(3)
                            layer0.set3D(-1)
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                            Dim layer1 As LineLayer = c.addLineLayer(yvalues(1), &H8000, sitename(1))
                            layer1.setLineWidth(3)
                            layer1.set3D(-1)
                            layer1.setUseYAxis2()
                        
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
            
                            Dim layer2 As LineLayer = c.addLineLayer(yvalues(2), &HCC, sitename(2))
                            layer2.setLineWidth(3)
                            layer2.set3D(-1)
                            layer2.setUseYAxis(yAxis3)
            
                            Dim yAxis4 As Axis = c.addAxis(Chart.Right, 50)
                            yAxis4.setTitle(measurement(3)).setAlignment(Chart.TopRight2)
                            yAxis4.setColors(&H880088, &H880088, &H880088)
            
                            Dim layer3 As LineLayer = c.addLineLayer(yvalues(3), &H880088, sitename(3))
                            layer3.setLineWidth(3)
                            layer3.set3D(-1)
                            layer3.setUseYAxis(yAxis4)
                        
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                            If Not (y4min = 0 And y4max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y4max - y4min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis4.setLinearScale(y4min, y4max, minval)
                            End If
                            
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis4.getHTMLImageMap("javascript:selecty4('{value}');", " ", "title='Value = {value}'")
                            
                            
                        Case 3
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
            
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
            
                       
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
            
                        
            
                            Dim yAxis4 As Axis = c.addAxis(Chart.Right, 50)
                            yAxis4.setTitle(measurement(3)).setAlignment(Chart.TopRight2)
                            yAxis4.setColors(&H880088, &H880088, &H880088)
            
                                              
                            Dim layer1 As AreaLayer = c.addAreaLayer(yvalues(0), &HAACC0000, sitename(0), 4)
                            Dim layer2 As AreaLayer = c.addAreaLayer(yvalues(1), &HAA00AA00, sitename(1), 4)
                            Dim layer3 As AreaLayer = c.addAreaLayer(yvalues(2), &HAA0000AA, sitename(2), 4)
                            Dim layer4 As AreaLayer = c.addAreaLayer(yvalues(3), &HAA880088, sitename(3), 4)
                        
                        
                            layer2.setUseYAxis2()
                            layer3.setUseYAxis(yAxis3)
                            layer4.setUseYAxis(yAxis4)
                        
                            layer1.setLineWidth(2)
                            layer2.setLineWidth(2)
                            layer3.setLineWidth(2)
                            layer4.setLineWidth(2)
                        
                            layer1.set3D(-1)
                            layer2.set3D(-1)
                            layer3.set3D(-1)
                            layer4.set3D(-1)
                        
                            layer1.setBorderColor(&HCC0000)
                            layer2.setBorderColor(&H8000)
                            layer3.setBorderColor(&HCC)
                            layer4.setBorderColor(&H880088)
                        
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                            If Not (y4min = 0 And y4max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y4max - y4min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis4.setLinearScale(y4min, y4max, minval)
                            End If
                            
                                                  
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis4.getHTMLImageMap("javascript:selecty4('{value}');", " ", "title='Value = {value}'")
                                             
                        Case 4
                        
                            c.yAxis().setTitle(measurement(0)).setAlignment(Chart.TopLeft2)
                            c.yAxis().setColors(&HCC0000, &HCC0000, &HCC0000)
            
                            Dim layer0 As BarLayer = c.addBarLayer(yvalues(0), &HBBCC0000, sitename(0))
                            layer0.setBorderColor(&HCC0000)
                            layer0.setBarWidth(30)
                            layer0.set3D(-1)
                      
                            c.yAxis2().setTitle(measurement(1)).setAlignment(Chart.TopRight2)
                            c.yAxis2().setColors(&H8000, &H8000, &H8000)
                        
            
                            Dim layer1 As BarLayer = c.addBarLayer(yvalues(1), &HBB008000, sitename(1))
                            layer1.setBorderColor(&H8000)
                            layer1.set3D(-1)
                        
                      
                            layer1.setBarWidth(30)
                            layer1.setDataCombineMethod(3)
                            layer1.setUseYAxis2()
                        
                            Dim yAxis3 As Axis = c.addAxis(Chart.Left, 50)
                            yAxis3.setTitle(measurement(2)).setAlignment(Chart.TopLeft2)
                            yAxis3.setColors(&HCC, &HCC, &HCC)
            
                            Dim layer2 As BarLayer = c.addBarLayer(yvalues(2), &HBB0000CC, sitename(2))
                            layer2.set3D(-1)
                            layer2.setBorderColor(&HCC)
                            layer2.setBarWidth(30)
                            layer2.setUseYAxis(yAxis3)
            
                            Dim yAxis4 As Axis = c.addAxis(Chart.Right, 50)
                            yAxis4.setTitle(measurement(3)).setAlignment(Chart.TopRight2)
                            yAxis4.setColors(&H880088, &H880088, &H880088)
            
                            Dim layer3 As BarLayer = c.addBarLayer(yvalues(3), &HBB880088, sitename(3))
                            layer3.set3D(-1)
                            layer3.setBorderColor(&H880088)
                            layer3.setBarWidth(30)
                            layer3.setUseYAxis(yAxis4)
                        
                            If Not (y1min = 0 And y1max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y1max - y1min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis.setLinearScale(y1min, y1max, minval)
                            End If
        
                            If Not (y2min = 0 And y2max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y2max - y2min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                c.yAxis2.setLinearScale(y2min, y2max, minval)
                            End If
       
            
                            If Not (y3min = 0 And y3max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y3max - y3min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis3.setLinearScale(y3min, y3max, minval)
                            End If
                            
                            If Not (y4min = 0 And y4max = 0) Then
                                Dim lines As Integer = 3
                                Dim min As Integer = 20
                                Dim yvalue As Double = y4max - y4min
                                Dim minval As Double
                                For lines = 3 To 10
                                    Dim str As String = yvalue / lines
                                    Dim len As Integer = str.Length
                                    If (min >= len) Then
                                        min = len
                                        minval = yvalue / lines
                                    End If
            
                                Next
                                yAxis4.setLinearScale(y4min, y4max, minval)
                            End If
                            
                            
                            
                                                     
                            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
                                                                   
                            WebChartViewer1.ImageMap += c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
                            
                            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
                            
                            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:selecty1('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += c.yAxis2.getHTMLImageMap("javascript:selecty2('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis3.getHTMLImageMap("javascript:selecty3('{value}');", " ", "title='Value = {value}'")
                            WebChartViewer1.ImageMap += yAxis4.getHTMLImageMap("javascript:selecty4('{value}');", " ", "title='Value = {value}'")
                       
                      
                    End Select
                
            End Select
        
                           
            '================================================================================================
    
            Dim xdivheight As Integer = intPlotHeight
            Dim xintervalwidth As Double
            Dim xintervalwidth1 As Double
            Dim tdwidth As Integer = 108
            Dim xdivtop As Integer = 0
           
            If noofsites = 2 Then
                tdwidth = 98
                xdivtop = 88
            ElseIf noofsites = 3 Then
                tdwidth = 103
                xdivtop = 83
            Else
                tdwidth = 109
                xdivtop = 76
            End If
            For index = 1 To xcount + 1
                                                             
                                              
                         
                xintervalwidth = intPlotWidth / (xcount)
                xintervalwidth1 = intPlotWidth / (xcount + 1)
                
                If Not xcount = 0 Then
                    
                    Select Case style
                        Case 1
                            xdivstr = xdivstr + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth) + 85) & "px;top:99px;width:2px;height:" & xdivheight & "px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                        Case 2, 3
                            xdivstr = xdivstr + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth) + tdwidth) & "px;top:" & xdivtop & "px;width:2px;height:" & xdivheight & "px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                        Case 4
                            xdivstr = xdivstr + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth1) + tdwidth + (xintervalwidth1 / 2)) & "px;top:" & xdivtop & "px;width:2px;height:" & xdivheight & "px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                            
                                     
                                        
                    End Select
                End If
                
            Next
            
                  
            
        End If
        
       
    End Sub
    
</script>

<%  If recordsfound = True Then%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Trending Graph</title>

    <script language="javascript" type="text/javascript">
    function leftpageload()
       {
        var obj=document.getElementById("MTrendingWithZoom");
        obj.action="MGraphSelection.aspx";
        obj.target="contents";
        obj.submit();
       }
    </script>

</head>
<body style="margin-left: 15px; margin-top: 16px; font-family: Verdana; color: #5F7AFC;
    font-size: 11px;" <%if firsttime=1 then %>onload="leftpageload();" <%end if %>>
    <table cellspacing="0" cellpadding="0">
        <tr align="center">
            <td align="center" style="height: 28px">
                <img src="images/MultipleTrend.jpg" alt="" />
            </td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <table cellspacing="0" cellpadding="3">
                    <tr>
                        <td>
                            <a href="<%=fbquery%>" onclick="btclick(this);">
                                <img src="images/sfirst.jpg" width="60" height="29" alt="First" style="border: 0px;" /></a>
                        </td>
                        <td>
                            <a href="<%=pbquery%>" onclick="btclick(this);">
                                <img src="images/sprev.jpg" width="60" height="29" alt="Previous" style="border: 0px;" /></a>
                        </td>
                        <td>
                        </td>
                        <td>
                            <a href="<%=nbquery%>" onclick="btclick(this);">
                                <img src="images/snext.jpg" width="60" height="29" alt="Next" style="border: 0px;" /></a>
                        </td>
                        <td>
                            <a href="<%=lbquery%>" onclick="btclick(this);">
                                <img src="images/slast.jpg" width="60" height="29" alt="Last" style="border: 0px;" /></a>
                        </td>
                        <td>
                        </td>
                        <td align="right">
                            <b style="font-family: Verdana; size: 1; color: #5F7AFC">Interval</b>&nbsp;
                            <select size="1" id="intervaldropdownlist" onchange="intervalchange(this);">
                                <option value="15">15 Minutes</option>
                                <option value="30">30 Minutes</option>
                                <option value="60">1 Hour</option>
                                <option value="120">2 Hours</option>
                                <option value="240">4 Hours</option>
                                <option value="720">12 Hours</option>
                                <option value="1440">1 Day</option>
                                <option value="10080">1 Week</option>
                            </select>
                        </td>
                        <td>
                        </td>
                        <td align="right">
                            <a href="<%=originalviewquery%>">
                                <img src="images/originalview.jpg" alt="Original View" style="border: 0px;" /></a>
                        </td>
                        <td>
                        </td>
                       
                        <td>
                            <b style="font-family: Verdana; font-size: 11px; color: #5F7AFC">Interval Selection</b>&nbsp;
                            <input id="intervalcheck" name="intervalcheck" type="checkbox" <%if xys=1 then  %>checked="checked"
                                <%end if %> onclick="intervalcheckclick(this);" value="<%=xys %>" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <chart:WebChartViewer ID="WebChartViewer1" runat="server" />
                <div id="maindiv"  style="width: 750px; height: 450px; position: absolute;
                    left: 14px; top: 81px; background-color: Transparent;">
                    <%If xys = 1 Then%>
                    <%=xdivstr%>
                    <%End If%>
                </div>
                <div id="intervaldivs" style="visibility: hidden;">
                    <%=xdivstr%>
                </div>
               
            </td>
        </tr>
        
    </table>
    <form method="get" id="MTrendingWithZoom">
        <input type="hidden" name="begindatetime" id="begindatetime" value="<%=begindatetime %>" />
        <input type="hidden" name="enddatetime" id="enddatetime" value="<%=enddatetime  %>" />
        <input type="hidden" name="xmin" id="xmin" value="<%=xmin %>" />
        <input type="hidden" name="xmax" id="xmax" value="<%=xmax %>" />
        <input type="hidden" name="district" id="district" value="<%=district %>" />
        <input type="hidden" name="site1" id="site1" value="<%=site1%>" />
        <input type="hidden" name="site2" id="site2" value="<%=site2%>" />
        <input type="hidden" name="site3" id="site3" value="<%=site3%>" />
        <input type="hidden" name="site4" id="site4" value="<%=site4%>" />
        <input type="hidden" name="interval" id="interval" value="<%=interval %>" />
        <input type="hidden" name="style" id="style" value="<%=style %>" />
        <input type="hidden" name="y1min" id="y1min" value="<%=y1min %>" />
        <input type="hidden" name="y1max" id="y1max" value="<%=y1max %>" />
        <input type="hidden" name="y2min" id="y2min" value="<%=y2min %>" />
        <input type="hidden" name="y2max" id="y2max" value="<%=y2max %>" />
        <input type="hidden" name="y3min" id="y3min" value="<%=y3min %>" />
        <input type="hidden" name="y3max" id="y3max" value="<%=y3max %>" />
        <input type="hidden" name="y4min" id="y4min" value="<%=y4min %>" />
        <input type="hidden" name="y4max" id="y4max" value="<%=y4max %>" />
        <input type="hidden" name="operation" id="operation" value="<%=operation %>" />
        <input type="hidden" name="xys" id="xys" value="<%=xys %>" />
    </form>
    

    <script type="text/javascript" language="javascript" src="MTrendingWithZoom.js"></script>

    <script type="text/javascript" language="javascript"> 
       document.getElementById("intervaldropdownlist").value=document.getElementById("interval").value
             
    </script>

</body>
</html>
<%  Else%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Trending Graph</title>
</head>
<body>
    <table width="100%">
        <tr>
            <td align="center" style="height: 28px">
                <img src="images/TrendingDetails.jpg" alt="" />
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" style="height: 450px;">
                <b style="font-family: Verdana; color: #3D62F8">No Data To Be Displayed !</b></td>
        </tr>
    </table>
</body>
</html>
<%  End If%>
