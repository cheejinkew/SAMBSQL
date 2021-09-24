<%@ Page Language="VB" Debug="true" AutoEventWireup="true" %>

<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>

<script runat="server">
    
    Dim xcount As Integer = 10
    Dim strConn
    Dim objConn
    Dim sqlRs
    Dim sqlRs1
     
    
    Dim intCount = 0
    Dim intChartWidth = 720
    Dim intChartHeight = 450
    Dim intPlotWidth = 550
    Dim intPlotHeight = 280
    Dim blnSequence = False
    Dim recordsfound = False
    
    Dim equipment As String
    Dim district As String
    Dim siteid As String
    Dim position As Integer
    Dim interval As Integer
    Dim style As Integer
    Dim xselection As Integer
    Dim xmax
    Dim xmin
    Dim ymin As Double
    Dim ymax As Double
    
    Dim operation As String
    
    
    Dim x1 As Int32
    Dim x2 As Int32
    Dim y1 As Int32
    Dim y2 As Int32
    
    Dim xys As Byte
   
          
    
    Dim begindatetime
    Dim enddatetime
    Dim nextdatetime
    Dim lastdatetime
    
    
    Dim fdatetime
    Dim pdatetime
    Dim ndatetime
    Dim ldatetime
    Dim originalviewquery
    
    Dim fbquery As String
    Dim pbquery As String
    Dim nbquery As String
    Dim lbquery As String
        
    Dim xarea As String = ""
    Dim yarea As String = ""
    Dim xdiv As String = ""
    Dim ydiv As String = ""
    
    
    
    Sub Page_Load(ByVal Source As Object, ByVal E As EventArgs)
           
        If Session("login") Is Nothing Then
            Response.Redirect("login.aspx")
        End If
       
        
        'Read query string values
        
        equipment = Request.QueryString("equipment")
        district = Request.QueryString("district")
        siteid = Request.QueryString("siteid")
        position = Request.QueryString("position")
        style = Request.QueryString("style")
        interval = Request.QueryString("interval")
        operation = Request.QueryString("operation")
        xys = Request.QueryString("xys")
        
                
        begindatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("begindatetime")))
        enddatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("enddatetime")))
        
        xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmin")))
        xmax = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
        
        If xmin > xmax Then
            xmax = xmin
            xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
        End If
            
                
        ymin = Request.QueryString("ymin")
        ymax = Request.QueryString("ymax")
        x1 = Request.QueryString("x1")
        x2 = Request.QueryString("x2")
        y1 = Request.QueryString("y1")
        y2 = Request.QueryString("y2")
           
        lastdatetime = enddatetime
        
        
        strConn = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        sqlRs1 = New ADODB.Recordset()

        
        'findout what operation performed
        
        Select Case operation
            
            'Submit button clicked 
            
            Case "submit"
                
                xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmin")))
                xmax = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
               
                If xmin > xmax Then
                    xmax = xmin
                    xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
                End If
                
                Dim fdatetime As DateTime = Date.Parse(xmin)
                Dim ldatetime As DateTime = Date.Parse(xmax)
                Dim tminutes As Integer = (ldatetime - fdatetime).TotalMinutes
                Dim interval As Integer
            
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
                    Session("xcount") = 10
                    Session("interval") = 15
                Else
                    Session("interval") = interval
                    Session("xcount") = xcount
                End If
                
                Session("ymin") = ymin
                Session("ymax") = ymax
                
            Case "x"
                xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmin")))
                xmax = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
               
                If xmin > xmax Then
                    xmax = xmin
                    xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("xmax")))
                End If
                
                Dim fdatetime As DateTime = Date.Parse(xmin)
                Dim ldatetime As DateTime = Date.Parse(xmax)
                Dim tminutes As Integer = (ldatetime - fdatetime).TotalMinutes
                Dim interval As Integer
            
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
                xcount = tminutes / interval
                If (xcount > 10) Then
                    Session("xcount") = 10
                    Session("interval") = 15
                Else
                    Session("interval") = interval
                    Session("xcount") = xcount
                    
                End If
                
            Case "y"
                Session("ymin") = ymin
                Session("ymax") = ymax
            Case "zoom"
                               
                'Create temparary chart for finding xmin,xmax and ymin,ymax
                
                Dim txcount = Session("xcount")
                If txcount = 0 Then
                    txcount = 1
                End If
                Dim tinterval = Session("interval")
                Dim tnextdatetime = xmin
                
                Dim txvalues(txcount) As String
                Dim tyvalues(txcount) As Double
                
                objConn.open(strConn)
                
                Dim j As Integer
                For j = 0 To txcount
       
                    txvalues(j) = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(tnextdatetime))
       
                    sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                            siteid & "' and position ='" & position & "' and sequence = '" & txvalues(j) & "' order by sequence desc limit 1 ", objConn)
             
         
                    tnextdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(tnextdatetime).AddMinutes(tinterval))
            
                    Dim strvalue
                    If Not sqlRs.EOF Then
                        strvalue = sqlRs("value").value
                
                        If (ymin = 0 And ymax = 0) Then
                            tyvalues(j) = strvalue
                        ElseIf (strvalue >= ymin And strvalue <= ymax) Then
                            tyvalues(j) = strvalue
                        Else
                            tyvalues(j) = Chart.NoValue
                        End If
               
                    Else
                        tyvalues(j) = Chart.NoValue
                    End If
                
                    sqlRs.close()
        
                Next
                
                objConn.close()
                
                Dim plotgap As Integer = 85
                Dim xwidth As Integer
                Select Case style
                    Case 1, 3
                        plotgap = 85 + (intPlotWidth / (txcount + 1)) / 2
                        xwidth = intPlotWidth / (txcount + 1)
                    Case 2, 4
                        plotgap = 92 + (intPlotWidth / (txcount + 1)) / 2
                        xwidth = intPlotWidth / (txcount + 1)
                    Case 5, 7, 9, 11
                        plotgap = 85
                        xwidth = intPlotWidth / txcount
                    Case 6, 8, 10, 12
                        plotgap = 92
                        xwidth = intPlotWidth / txcount
                End Select
                
                'Find xmin,xmax values
                Dim k As Integer = 1
                For k = 1 To txcount
                    If Not ((k * xwidth) + plotgap) < x1 Then
                        Exit For
                    End If
                Next
                xmin = txvalues(k - 1)
                
                For k = 1 To txcount
                    If Not ((k * xwidth) + plotgap) < x2 Then
                        Exit For
                    End If
                Next
                xmax = txvalues(k - 1)
                                           
              
                Dim fdatetime As DateTime = Date.Parse(xmin)
                Dim ldatetime As DateTime = Date.Parse(xmax)
                Dim tminutes As Integer = (ldatetime - fdatetime).TotalMinutes
                Dim interval As Integer
            
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
                    Session("xcount") = 10
                    Session("interval") = 15
                    Session("xmin") = xmin
                    Session("xmax") = xmax
                Else
                    Session("interval") = interval
                    Session("xcount") = xcount
                    Session("xmin") = xmin
                    Session("xmax") = xmax
                End If
                
                'Draw Temp chart for finding Previous ymin,ymax values
                Dim tempchart As XYChart = New XYChart(intChartWidth, intChartHeight, &HFFFFFF, &H0, 1)
                tempchart.setPlotArea(85, 70, intPlotWidth, intPlotHeight, &HEEEEEE, &HFFFFFF).setGridColor(&HC0C0C0, &HC0C0C0)
             
                tempchart.xAxis().setLabels(txvalues).setFontStyle("Arial")
                tempchart.xAxis().setLabels(txvalues).setFontAngle(45)
                tempchart.yAxis().setColors(&H0&, &H0&, &H0&)
                
                
                    
                Select Case style
                    Case 1
                        Dim tbarlayer As BarLayer = tempchart.addBarLayer(tyvalues, tempchart.gradientColor(0, 350, 0, 70, &H8000, &HFFFFFF), "")
                        tbarlayer.setBarShape(1)
                        tbarlayer.setBarWidth(15)
                    Case 2
                        Dim tbarlayer As BarLayer = tempchart.addBarLayer(tyvalues, tempchart.gradientColor(0, 350, 0, 70, &H8000, &HFFFFFF), "")
                        tbarlayer.setBarShape(1)
                        tbarlayer.setBarWidth(15)
                        tbarlayer.set3D(-1)
           
                    Case 3
                        Dim tbarlayer As BarLayer = tempchart.addBarLayer(tyvalues, &HC000&, "")
                        tbarlayer.setBarShape(Chart.CircleShape)
                        tbarlayer.setBarWidth(15)
                         
                    Case 4
                        Dim tbarlayer As BarLayer = tempchart.addBarLayer(tyvalues, &HC000&, "")
                        tbarlayer.setBarShape(Chart.CircleShape)
                        tbarlayer.setBarWidth(15)
                        tbarlayer.set3D(-1)
                    Case 5
                        Dim tlayer As LineLayer = tempchart.addLineLayer(tyvalues, &HC000&, "")
                        tlayer.setLineWidth(4)
                        tlayer.addDataSet(tyvalues, &HCF4040, "").setDataSymbol(Chart.SquareSymbol, 8)
                                                    
                    Case 6
                        Dim tlayer As LineLayer = tempchart.addLineLayer(tyvalues, &HC000&, "")
                        tlayer.setLineWidth(4)
                        tlayer.set3D(-1)
               
                    Case 7
                        Dim tsteplayer As StepLineLayer = tempchart.addStepLineLayer(tyvalues, &HC000&, "")
                        tsteplayer.setLineWidth(5)
               
                    Case 8
                        Dim tsteplayer As StepLineLayer = tempchart.addStepLineLayer(tyvalues, &HC000&, "")
                        tsteplayer.setLineWidth(4)
                        tsteplayer.set3D(-1)
            
                    Case 9
                        Dim tarealayer As AreaLayer = tempchart.addAreaLayer(tyvalues, &HC000)
                        tarealayer.setGapColor(1)
               
                    Case 10
                        Dim tarealayer As AreaLayer = tempchart.addAreaLayer(tyvalues, &HC000)
                        tarealayer.set3D(-1)
              
                    Case 11
                        Dim tarealayer As AreaLayer = tempchart.addAreaLayer(tyvalues, tempchart.gradientColor(0, 70, 0, 350, &H40FF8000, &H40FFFFFF))
                
                    Case 12
                        Dim tarealayer As AreaLayer = tempchart.addAreaLayer(tyvalues, tempchart.gradientColor(0, 70, 0, 350, &H40FF8000, &H40FFFFFF))
                        tarealayer.set3D(-1)
                        
                        
                End Select
                
                
                If Not (ymin = 0 And ymax = 0 Or ymax = ymin) Then
                    Dim tlines As Integer = 3
                    Dim tmin As Integer = 20
                    Dim tyvalue As Double = ymax - ymin
                    Dim tminval As Double
                    For tlines = 3 To 10
                        Dim tstr As String = tyvalue / tlines
                        Dim tlen As Integer = tstr.Length
                        If (tmin >= tlen) Then
                            tmin = tlen
                            tminval = tyvalue / tlines
                        End If
            
                    Next
                    tempchart.yAxis.setLinearScale(ymin, ymax, tminval)
                End If
                
                tempchart.layout()
              
                Dim maxv As Single = tempchart.yAxis.getMaxValue()
                Dim minv As Single = tempchart.yAxis.getMinValue()
                Dim ti() As Double = tempchart.yAxis.getTicks()
                
                Dim plotygap As Integer = 70
                Select Case style
                    Case 1, 3, 5, 7, 9, 11
                        plotygap = 69
                    Case 2, 4, 6, 8, 10, 12
                        plotygap = 62
                End Select
               
                Dim l As Int32 = ti.Length
                For k = 1 To ti.Length
                    l = l - 1
                    If (k * (intPlotHeight / ti.Length) + plotygap) > y1 Then
                        Exit For
                    End If
                Next
                If Not (ti.Length = 0) Then
                    ymax = ti(l - 1)
                End If
             
                     
                l = ti.Length
                For k = 1 To ti.Length
                    l = l - 1
                    If (k * (intPlotHeight / ti.Length) + plotygap) > y2 Then
                        Exit For
                    End If
                Next
                If Not (ti.Length = 0) Then
                    ymin = ti(l)
                End If
                
                                                         
                
                Session("ymin") = ymin
                Session("ymax") = ymax
              
               
                         
            Case "ov"
                xmin = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("begindatetime")))
                xmax = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(Request.QueryString("enddatetime")))
               
                
                Dim fdatetime As DateTime = Date.Parse(xmin)
                Dim ldatetime As DateTime = Date.Parse(xmax)
                Dim tminutes As Integer = (ldatetime - fdatetime).TotalMinutes
                Dim interval As Integer
            
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
                
                xcount = tminutes / interval
                If (xcount > 10) Then
                    Session("xcount") = 10
                    Session("interval") = 15
                Else
                    Session("interval") = interval
                    Session("xcount") = xcount
                End If
                Session("ymin") = ymin
                Session("ymax") = ymax
                
            Case "style"
                xmin = Session("xmin")
                xmax = Session("xmax")
                ymin = Session("ymin")
                ymax = Session("ymax")
            Case "ic"
                interval = Request.QueryString("interval")
                Session("interval") = interval
                Session("xcount") = 10
            Case "last"
                
                
        End Select
        Session("xmin") = xmin
        Session("xmax") = xmax
        Session("xys") = xys
        
        
        xcount = Session("xcount")
        interval = Session("interval")
        xys = Session("xys")
        
        Dim xvalues(xcount) As String
        Dim yvalues(xcount) As Double
        
       
                            
              
        'Findout Records are existed or not
        objConn.open(strConn)
        sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                         siteid & "' and position ='" & position & "' and sequence between '" & _
                         xmin & "' and '" & enddatetime & "' order by sequence desc", objConn)
        If Not sqlRs.EOF Then
            recordsfound = True
        End If
        sqlRs.close()
        
        
        sqlRs.open("select max(sequence) as lastdate from telemetry_log_table where siteid='" & siteid & "' and position ='" & position & "' and sequence between '" & begindatetime & "' and '" & enddatetime & "'", objConn)
        If Not sqlRs.EOF Then
            If Not IsDBNull(sqlRs("lastdate").value) Then
                'lastdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(sqlRs("lastdate").value))
                lastdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(sqlRs("lastdate").value).AddMinutes(-interval * (xcount - 1)))
            End If
        End If
        
        sqlRs.close()
        
        
        If recordsfound = True Then
            
                   
            '***********************************************************************************************
            '  Generate X Values,Y Values
            '***********************************************************************************************
            If operation = "last" Then
                xmin = lastdatetime
            End If
            nextdatetime = xmin
            Dim i As Integer
            For i = 0 To xcount
       
                xvalues(i) = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(nextdatetime))
       
                sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                        siteid & "' and position ='" & position & "' and sequence = '" & xvalues(i) & "' order by sequence desc limit 1 ", objConn)
             
         
                nextdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(nextdatetime).AddMinutes(interval))
            
                Dim strvalue
                If Not sqlRs.EOF Then
                    strvalue = sqlRs("value").value
                
                    If (ymin = 0 And ymax = 0 Or ymin = ymax) Then
                        yvalues(i) = strvalue
                    ElseIf (strvalue >= ymin And strvalue <= ymax) Then
                        yvalues(i) = strvalue
                    Else
                        yvalues(i) = Chart.NoValue
                    End If
               
                Else
                    yvalues(i) = Chart.NoValue
                End If
                
                sqlRs.close()
        
            Next
  
     
            '***************************************************************************************

            objConn.close()
            objConn = Nothing
        
        
            pdatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(xmin).AddMinutes(-interval))
            ndatetime = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(xmin).AddMinutes(interval))
               
            fbquery = "STrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & "&siteid=" & siteid & "&position=" & position & "&interval=" & interval & "&district=" & district & "&equipment=" & equipment & "&style=" & style & "&xmin=" & begindatetime & "&xmax=" & xmax & "&ymin=" & ymin & "&ymax=" & ymax & "&x1=0&y1=0&x2=0&y2=0&operation=first"
            pbquery = "STrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & "&siteid=" & siteid & "&position=" & position & "&interval=" & interval & "&district=" & district & "&equipment=" & equipment & "&style=" & style & "&xmin=" & pdatetime & "&xmax=" & xmax & "&ymin=" & ymin & "&ymax=" & ymax & "&x1=0&y1=0&x2=0&y2=0&operation=prev"
            If (DateTime.Parse(xmin) >= DateTime.Parse(enddatetime).AddMinutes(-interval)) Then
                nbquery = "#"
            Else
                nbquery = "STrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & "&siteid=" & siteid & "&position=" & position & "&interval=" & interval & "&district=" & district & "&equipment=" & equipment & "&style=" & style & "&xmin=" & ndatetime & "&xmax=" & xmax & "&ymin=" & ymin & "&ymax=" & ymax & "&x1=0&y1=0&x2=0&y2=0&operation=next"
            End If
            
            lbquery = "STrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & "&siteid=" & siteid & "&position=" & position & "&interval=" & interval & "&district=" & district & "&equipment=" & equipment & "&style=" & style & "&xmin=" & lastdatetime & "&xmax=" & xmax & "&ymin=" & ymin & "&ymax=" & ymax & "&x1=0&y1=0&x2=0&y2=0&operation=last"
            
            originalviewquery = "STrendingWithZoom.aspx?begindatetime=" & begindatetime & "&enddatetime=" & enddatetime & "&siteid=" & siteid & "&position=" & position & "&interval=15&district=" & district & "&equipment=" & equipment & "&style=" & style & "&xmin=" & begindatetime & "&xmax=" & enddatetime & "&ymin=0&ymax=0&x1=0&y1=0&x2=0&y2=0&operation=ov"
       
           
            '===================================================================
            '  Drawing the chart.
            '===================================================================
      
            Dim c As XYChart = New XYChart(intChartWidth, intChartHeight, &HFFFFFF, &H0, 1)
	 
            c.setPlotArea(85, 70, intPlotWidth, intPlotHeight, &HEEEEEE, &HFFFFFF).setGridColor(&HC0C0C0, &HC0C0C0)
    
            'Set the labels on the x axis
            c.xAxis().setLabels(xvalues).setFontStyle("Arial")
            c.xAxis().setLabels(xvalues).setFontAngle(45)
            c.xAxis().setLabels(xvalues).setFontColor(&HCC)
            c.yAxis().setColors(&H0&, &H0&, &H0&)
    
            Select Case style
                Case 1
                   
                    Dim barlayer As BarLayer = c.addBarLayer(yvalues, c.gradientColor(0, 350, 0, 70, &H8000, &HFFFFFF), "")
                    'Dim barlayer As BarLayer = c.addBarLayer(yvalues, &HC000&, "")
                    barlayer.setBarShape(1)
                    barlayer.setBarWidth(15)
               
                Case 2
                    Dim barlayer As BarLayer = c.addBarLayer(yvalues, c.gradientColor(0, 350, 0, 70, &H8000, &HFFFFFF), "")
                    'Dim barlayer As BarLayer = c.addBarLayer(yvalues, &HC000&, "")
                    barlayer.setBarShape(1)
                    barlayer.setBarWidth(15)
                    barlayer.set3D(-1)
           
                Case 3
                    Dim barlayer As BarLayer = c.addBarLayer(yvalues, &HC000&, "")
                    barlayer.setBarShape(Chart.CircleShape)
                    barlayer.setBarWidth(15)
                         
                Case 4
                    Dim barlayer As BarLayer = c.addBarLayer(yvalues, &HC000&, "")
                    barlayer.setBarShape(Chart.CircleShape)
                    barlayer.setBarWidth(15)
                    barlayer.set3D(-1)
                Case 5
                    Dim layer As LineLayer = c.addLineLayer(yvalues, &HC000&, "")
                    layer.setLineWidth(4)
                    layer.addDataSet(yvalues, &HCF4040, "").setDataSymbol(Chart.SquareSymbol, 8)
                    'layer.setDataLabelFormat("{value|1}")
                            
                Case 6
                    Dim layer As LineLayer = c.addLineLayer(yvalues, &HC000&, "")
                    layer.setLineWidth(4)
                    layer.set3D(-1)
               
                Case 7
                    Dim steplayer As StepLineLayer = c.addStepLineLayer(yvalues, &HC000&, "")
                    steplayer.setLineWidth(5)
               
                Case 8
                    Dim steplayer As StepLineLayer = c.addStepLineLayer(yvalues, &HC000&, "")
                    steplayer.setLineWidth(4)
                    steplayer.set3D(-1)
            
                Case 9
                    Dim arealayer As AreaLayer = c.addAreaLayer(yvalues, &HC000)
                    arealayer.setGapColor(1)
               
                Case 10
                    Dim arealayer As AreaLayer = c.addAreaLayer(yvalues, &HC000)
                    'arealayer.setGapColor(3)
                    arealayer.set3D(-1)
              
                Case 11
                    Dim arealayer As AreaLayer = c.addAreaLayer(yvalues, c.gradientColor(0, 70, 0, 350, &H40FF8000, &H40FFFFFF))
                
                Case 12
                    Dim arealayer As AreaLayer = c.addAreaLayer(yvalues, c.gradientColor(0, 70, 0, 350, &H40FF8000, &H40FFFFFF))
                    arealayer.set3D(-1)
                     
                
            End Select
        
            
            If Not (ymin = 0 And ymax = 0) Then
                'c.yAxis.setLinearScale(ymin, ymax)
                Dim lines As Integer = 3
                Dim min As Integer = 20
                Dim yvalue As Double = ymax - ymin
                Dim minval As Double
                For lines = 3 To 10
                    Dim str As String = yvalue / lines
                    Dim len As Integer = str.Length
                    If (min >= len) Then
                        min = len
                        minval = yvalue / lines
                    End If
            
                Next
                c.yAxis.setLinearScale(ymin, ymax, minval)
            End If
           
            c.yAxis.setLabelStyle.setFontColor(&HFF)
           
            
            '================================================================================================
    
            c.layout()
            Dim index As Integer
            Dim xdivheight As Integer = 0
            Dim xintervalwidth As Double
            Dim xintervalwidth1 As Double
            For index = 1 To xcount + 1
                                
                If yvalues(index - 1) = 1.7E+308 Then
                    xdivheight = 280
                Else
                    xdivheight = c.getYCoor(yvalues(index - 1)) - 70
                End If
               
               
                xintervalwidth = 550 / xcount
                xintervalwidth1 = 550 / (xcount + 1)
                
                If Not xcount = 0 Then
                    
                
                    Select Case style
                        Case 1, 3
                            xdiv = xdiv + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth1) + 85 + (xintervalwidth1 / 2)) & "px;top:71px;width:2px;height:280px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                        Case 2, 4
                            xdiv = xdiv + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth1) + 92 + (xintervalwidth1 / 2)) & "px;top:65px;width:2px;height:280px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                        Case 5, 7, 9, 11
                            xdiv = xdiv + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth) + 85) & "px;top:71px;width:2px;height:280px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                        Case 6, 8, 10, 12
                            xdiv = xdiv + "<div title=""Time = " & xvalues(index - 1) & """ style=""left:" & System.Convert.ToInt32(((index - 1) * xintervalwidth) + 92) & "px;top:65px;width:2px;height:280px;position:absolute;background-color: silver;"" onmouseover=""xdivover(this);"" onmouseout=""xdivout(this);"" onclick=""xdivclick('" & xvalues(index - 1) & "',this)"" ></div>"
                                        
                    End Select
                End If
                
            Next
            c.layout()
            Dim tic() As Double = c.yAxis.getTicks()
            For index = 0 To tic.Length - 1
                Select Case style
                    Case 1, 3, 5, 7, 9, 11
                        ydiv = ydiv + "<div title=""Value = " & tic(index) & """ style=""left:85px;top:" & c.getYCoor(tic(index)) & "px;width:550px;height:2px;position:absolute;background-color: silver;font-size:1px;"" onmouseover=""ydivover(this);"" onmouseout=""ydivout(this);"" onclick=""ydivclick('" & tic(index) & "',this)"" ></div>"
                    Case 2, 4, 6, 8, 10, 12
                        ydiv = ydiv + "<div title=""Value = " & tic(index) & """ style=""left:94px;top:" & c.getYCoor(tic(index)) - 6 & "px;width:550px;height:2px;position:absolute;background-color: silver;font-size:1px;"" onmouseover=""ydivover(this);"" onmouseout=""ydivout(this);"" onclick=""ydivclick('" & tic(index) & "',this)"" ></div>"
                        
                End Select
               
                           
            Next
            xdiv += ydiv
             
       
       
            WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
            
            'Generate Imagemap for x axis labels,y axis labels
           
            WebChartViewer1.ImageMap = c.getHTMLImageMap("", " ", "title='Time = {xLabel} &#013;Value = {value}'")
            WebChartViewer1.ImageMap += c.yAxis.getHTMLImageMap("javascript:getyvalue('{value}');", " ", "title='Value = {value}'")
            WebChartViewer1.ImageMap += c.xAxis.getHTMLImageMap("javascript:getdate('{label}');", " ", "title='Date & Time = {label}'")
            
            'Add drag events for chart image
           
            'WebChartViewer1.Attributes.Add("ondragstart", "imgdown(this);")
            'WebChartViewer1.Attributes.Add("ondragend", "imgup(this);")
            'WebChartViewer1.Attributes.Add("ondrag", "imgmove(this);")
        End If
        
        
    End Sub
    
</script>

<%  If recordsfound = True Then%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Trending Graph</title>
</head>
<body style="margin-left: 15px; margin-top: 16px; font-family: Verdana; color: #5F7AFC;
    font-size: 11px;">
    <table cellspacing="0" cellpadding="0">
        <tr align="center">
            <td align="center" style="height: 28px">
                <img src="images/TrendingDetails.jpg" alt="" />
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
                            <b style="font-family: Verdana; font-size: 11px; color: #5F7AFC">Interval</b>&nbsp;
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
                            <a href="<%=originalviewquery%>" onclick="btclick(this);">
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
                <div id="maindiv" style="width: 720px; height: 450px; position: absolute; left: 14px;
                    top: 80px; background-color: Transparent; visibility: hidden;">
                    <%If xys = 1 Then%>
                    <%=xdiv %>
                    <%End If%>
                </div>
                <div id="intervaldivs" style="visibility: hidden;">
                    <%=xdiv %>
                </div>
            </td>
        </tr>
    </table>
    <form method="get" action="" id="STrendingWithZoom">
        <input type="hidden" name="begindatetime" id="begindatetime" value="<%=begindatetime %>" />
        <input type="hidden" name="enddatetime" id="enddatetime" value="<%=enddatetime  %>" />
        <input type="hidden" name="siteid" id="siteid" value="<%=siteid %>" />
        <input type="hidden" name="position" id="position" value="<%=position %>" />
        <input type="hidden" name="interval" id="interval" value="<%=interval %>" />
        <input type="hidden" name="district" id="district" value="<%=district %>" />
        <input type="hidden" name="equipment" id="equipment" value="<%=equipment %>" />
        <input type="hidden" name="style" id="style" value="<%=style %>" />
        <input type="hidden" name="xselection" id="xselection" value="<%=xselection %>" />
        <input type="hidden" name="xmin" id="xmin" value="<%=xmin %>" />
        <input type="hidden" name="xmax" id="xmax" value="<%=xmax %>" />
        <input type="hidden" name="ymin" id="ymin" value="<%=ymin %>" />
        <input type="hidden" name="ymax" id="ymax" value="<%=ymax %>" />
        <input type="hidden" name="x1" id="x1" value="0" />
        <input type="hidden" name="y1" id="y1" value="0" />
        <input type="hidden" name="x2" id="x2" value="0" />
        <input type="hidden" name="y2" id="y2" value="0" />
        <input type="hidden" name="operation" id="operation" value="no" />
        <input type="hidden" name="xys" id="xys" value="<%=xys %>" />
    </form>

    <script type="text/javascript" language="javascript" src="STrendingWithZoom.js"></script>

    <script type="text/javascript" language="javascript"> 
         document.getElementById("intervaldropdownlist").value=document.getElementById("interval").value
         adjustdiv();
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
                <b style="font-family: Verdana; color: #5F7AFC; font-size: 15px;">No Data To Be Displayed
                    !</b></td>
        </tr>
    </table>
</body>
</html>
<%  End If%>
