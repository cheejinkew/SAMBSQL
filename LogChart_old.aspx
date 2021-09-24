<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<%
   dim objConn
   dim sqlRs
   dim strConn
   dim i
   
   dim intMinData(6) as double
   dim intMaxData(6) as double
   dim strlabels(6) as string
   dim intTmp1
   dim intTmp2
   dim strDTNow as DateTime
   dim c As XYChart
   
   strDTNow = "7/1/2005"'formatdatetime(DateTime.Now,DateFormat.ShortDate)
   'strDTNow.AddDays(1)
   
   'response.write(strDTNow & "| ")
   'response.write(strDTNow.AddDays(1))
   'response.end
   

   dim intSelectedSiteID = "1006" 'request.form("ddSite")
   dim strBeginDateTime = strDTNow & " 00:00:00" 
   dim strEndDateTime = strDTNow & " 23:59:59"
   
   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()

   objConn.open(strConn)

   for i = 0 to 6
     sqlRs.open("select max(value) as maximum, min(value) as minimum from telemetry_log_table " & _
                "where siteid = '" & intSelectedSiteID & "' and " & _
                "  sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" , objConn)
     if not sqlRs.EOF then
        intTmp1 = sqlRs("minimum").value
        intTmp2 = sqlRs("maximum").value
        
        if isDBNull(intTmp1) then
          intMinData(i) = 0
        else
          intMinData(i) = intTmp1
        end if
        
        if isDBNull(intTmp2) then
          intMaxData(i) = 0
        else
          intMaxData(i) = intTmp2
        end if
     end if
     
     sqlRs.Close()
     strDTNow = strDTNow.AddDays(1)
     
     'The labels for the chart
     strLabels(i) = formatdatetime(strDTNow,DateFormat.ShortDate)

     strBeginDateTime = strLabels(i) & " 00:00:00"
     strEndDateTime = strLabels(i) & " 23:59:59"

   next i
   objConn.Close()
   objConn = nothing

   'Create a XYChart object of size 550 x 250 pixels
    c = New XYChart(550, 300)

    'Set the plotarea at (50, 50) and of size 450 x 200 pixels. Enable both
    'horizontal and vertical grids by setting their colors to grey (0xc0c0c0)
    c.setPlotArea(50, 10, 450, 200).setGridColor(&Hc0c0c0, &Hc0c0c0)

    'Add a title to the chart
    'c.addTitle("Log History Graphical Analysis")

    'Set the labels on the x axis and the font to Arial Bold. Draw the labels vertical (angle = 90)
    c.xAxis().setLabels(strLabels).setFontStyle("Arial Bold")
    c.xAxis().setLabels(strLabels).setFontAngle(90)

    'Set the font for the y axis labels to Arial Bold
    c.yAxis().setLabelStyle("Arial Bold")

    'Add a Box Whisker layer using light blue 0x9999ff as the fill color and blue
    '(0xcc) as the line color. Set the line width to 2 pixels
'    c.addBoxLayer(Q4Data, Q3Data, &Hff00, "Top 25%")
'    c.addBoxLayer(Q3Data, Q2Data, &H9999ff, "25% - 50%")
'    c.addBoxLayer(Q2Data, Q1Data, &Hffff00, "50% - 75%")
'    c.addBoxLayer(Q1Data, Q0Data, &Hff0000, "Bottom 25%")
     c.addBoxLayer(intMaxData, intMinData, &H9999ff, "")


    'Add legend box at top center above the plot area using 10 pts Arial Bold Font
    Dim b As LegendBox = c.addLegend(50 + 225, 22, False, "Arial Bold", 10)
    b.setAlignment(Chart.TopCenter)
    b.setBackground(Chart.Transparent)

    'output the chart
    WebChartViewer1.Image = c.makeWebImage(Chart.PNG)

    'include tool tip for the chart
    WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
        "title='{xLabel} ({dataSetName}): {bottom} to {top} points'")
%>
<html>
  <body topmargin="5" leftmargin="5" rightmargin="0">
   <chart:WebChartViewer id="WebChartViewer1" runat="server" />
  </body>
</html>

