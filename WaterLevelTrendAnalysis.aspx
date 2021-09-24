<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<%
   dim arrylstLabel as new ArrayList
   dim arrylstValue1 as new ArrayList
   dim arrylstValue2 as new ArrayList
   dim arrylstValue3 as new ArrayList
   dim arrylstValue4 as new ArrayList

   dim arrylstValue5 as new ArrayList
   dim arrylstValue6 as new ArrayList
   dim arrylstValue7 as new ArrayList
   dim arrylstValue8 as new ArrayList

   dim strConn
   dim objConn
   dim sqlRs
   dim sqlRs1
   dim strValue
   dim arryValue1() as double
   dim arryValue2() as double
   dim arryValue3() as double
   dim arryValue4() as double
   
   dim arryValue5() as double
   dim arryValue6() as double
   dim arryValue7() as double
   dim arryValue8() as double

   dim arryLabel() as string
   dim arryScale(7) as double
   dim arryMax(7) as double
   'dim arryMeasure(7)
   dim arryEquipDesc(7)

   dim i
   dim j
   dim intCount = 0
   dim intChartWidth
   dim intChartHeight
   dim intPlotWidth
   dim intPlotHeight
   dim blnSequence = false
   dim blnLast = false
   dim strStatus
   dim intSiteID
   dim intPos
   dim blnTmp = false
   dim intInterval
   
   dim strSelectedDistrict = request.form("ddDistrict")
   dim intSiteID1 = request.form("ddSite1")
   dim intSiteID2 = request.form("ddSite2")
   dim intSiteID3 = request.form("ddSite3")
   dim intSiteID4 = request.form("ddSite4")

   dim intSiteID5 = request.form("ddSite5")
   dim intSiteID6 = request.form("ddSite6")
   dim intSiteID7 = request.form("ddSite7")
   dim intSiteID8 = request.form("ddSite8")

   '======================================
   dim arrySiteID1 = split(intSiteID1, ",")
   dim arrySiteID2 = split(intSiteID2, ",")
   dim arrySiteID3 = split(intSiteID3, ",")
   dim arrySiteID4 = split(intSiteID4, ",")
   
   dim arrySiteID5 = split(intSiteID5, ",")
   dim arrySiteID6 = split(intSiteID6, ",")
   dim arrySiteID7 = split(intSiteID7, ",")
   dim arrySiteID8 = split(intSiteID8, ",")
   '======================================   
   
   '============= lines 4 viewing posted data =============
   'dim haiy = request.form("ddDistrict") & "<br>" & request.form("ddSite1") & "<br>" & request.form("ddSite2") & "<br>" & request.form("ddSite3") & "<br>" & request.form("ddSite4") & "<br>" & request.form("ddSite5") & "<br>" & request.form("ddSite6") & "<br>" & request.form("ddSite7") & "<br>" & request.form("ddSite8") & "<br>"
   'haiy += request.form("txtBeginDate") & "<br>" & request.form("ddBeginHour") & "<br>" & request.form("ddBeginMinute") & "<br>" & request.form("txtEndDate") & "<br>" & request.form("ddEndHour") & "<br>" & request.form("ddEndMinute") & "<br>" & request.form("txtLastDate")
   '=======================================================
   
   if arrySiteID1(0) <> "0" then
     intSiteID = arrySiteID1(0)
     intPos = arrySiteID1(1)
   end if

   if arrySiteID2(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID2(0)
     intPos = intPos & "," & arrySiteID2(1)
   end if
   
   if arrySiteID3(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID3(0)
     intPos = intPos & "," & arrySiteID3(1)
   end if

   if arrySiteID4(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID4(0)
     intPos = intPos & "," & arrySiteID4(1)
   end if

   if arrySiteID5(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID5(0)
     intPos = intPos & "," & arrySiteID5(1)
   end if

   if arrySiteID6(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID6(0)
     intPos = intPos & "," & arrySiteID6(1)
   end if
   
   if arrySiteID7(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID7(0)
     intPos = intPos & "," & arrySiteID7(1)
   end if
   
   if arrySiteID8(0) <> "0" then
     intSiteID = intSiteID & "," & arrySiteID8(0)
     intPos = intPos & "," & arrySiteID8(1)
   end if
   
   dim strBeginDate = request.form("txtBeginDate")
   dim strBeginHour= request.form("ddBeginHour")
   dim strBeginMin = request.form("ddBeginMinute")
   
   dim strEndDate = request.form("txtEndDate")
   dim strEndHour = request.form("ddEndHour")
   dim strEndMin = request.form("ddEndMinute")
   dim arryPos = split(intPos, ",")
   dim arrySiteID = split(intSiteID, ",")
   dim intLenPos = arryPos.length()
   
   dim strBeginDateTime = Date.Parse(strBeginDate & " " & strBeginHour & ":" & strBeginMin) 
   dim strEndDateTime = Date.Parse(strEndDate & " " & strEndHour & ":" & strEndMin) 
   
   dim strLastDate = request.form("txtLastDate")
   dim strLastDate1 
   
   if strLastDate = "" then
     strStatus = "1stPage"
     strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
   end if
   
   strLastDate1 = strLastDate
   
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   sqlRs1 = new ADODB.Recordset()

   objConn.open(strConn)
   
   for i = 0 to intLenPos - 1
        sqlRs.open("select value, dtimestamp, position from telemetry_log_table where siteid='" & _
                  arrySiteID(i) & "' and position ='" & arryPos(i) & "' and dtimestamp between '" & _
                  strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00' and '" & _
                  strEndDate & " " & strEndHour & ":" & strEndMin & ":59' order by dtimestamp desc", objConn)
     do while not sqlRs.EOF
       blnTmp = true
       sqlRs.movenext
     loop
     sqlRs.close()
   next

  '***********************************************************************************************
   j = 0
   i = 0
       
     for i = 0 to intLenPos - 1    
       strLastDate = strLastDate1
       do while strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strEndDateTime))

         if i = 0 then
           arrylstLabel.Add(String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate)))
         end if         
            sqlRs.open("select top 1 value, dtimestamp, position from telemetry_log_table where siteid='" & _
                 arrySiteID(i) & "' and position ='" & arryPos(i) & "' and dtimestamp between '" & _
                 strLastDate & ":00' and '" & strLastDate & ":59' order by dtimestamp desc ", objConn)
         
         'sqlRs1.open("select max, measurement, ""desc"" from telemetry_equip_list_table where siteid='" & _
         '        arrySiteID(i) & "' and position ='" & arryPos(i) & "'", objConn)
         
            sqlRs1.open("select sitename, max, measurement, sdesc " & _
                     " from telemetry_equip_list_table e, telemetry_site_list_table s" & _
                     " where e.siteid='" & arrySiteID(i) & "' and position ='" & arryPos(i) & "'" & _
                     " and e.siteid = s.siteid", objConn)

         if not sqlRs1.EOF then 
         
           arryMax(i) = sqlRs1("max").value
           arryScale(i) = arryMax(i) / 20
	   'arryMeasure(i)= sqlRs1("measurement").value
	   arryEquipDesc(i)= sqlRs1("sitename").value & " : " & sqlRs1("sdesc").value
	   
         end if
         sqlRs1.close()
         
         strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strLastDate).AddMinutes(15))

         if not sqlRs.EOF then
           strValue = sqlRs("value").value
           select case i
             case 0
               arrylstValue1.Add(strValue)
             case 1
               arrylstValue2.Add(strValue)
             case 2
               arrylstValue3.Add(strValue)
             case 3
               arrylstValue4.Add(strValue)
             case 4
               arrylstValue5.Add(strValue)
             case 5
			   arrylstValue6.Add(strValue)
             case 6
			   arrylstValue7.Add(strValue)
             case 7
			   arrylstValue8.Add(strValue)			   
           end select
    
         else
           select case i
             case 0
               arrylstValue1.Add(Chart.NoValue)
             case 1
               arrylstValue2.Add(Chart.NoValue)
             case 2
               arrylstValue3.Add(Chart.NoValue)
             case 3
               arrylstValue4.Add(Chart.NoValue)
             case 4
			   arrylstValue5.Add(Chart.NoValue)
			 case 5
			   arrylstValue6.Add(Chart.NoValue)
			 case 6
			   arrylstValue7.Add(Chart.NoValue)			   
			 case 7
			   arrylstValue8.Add(Chart.NoValue)			   
           end select
         end if
         
         j = j + 1
  
         'if j = 30 then
         '  sqlRs.close()
         '  exit do
         'end if
       sqlRs.close()
       loop
       j = 0
      Next
 
   if arrylstLabel.count < 30 then
     blnLast = true
   end if
   
  '******************************************
   Redim arryLabel(arrylstLabel.count - 1)
   For j = 0 to arrylstLabel.count - 1
     arryLabel(j) = arrylstLabel.Item(j)  
   Next

   Redim arryValue1(arrylstValue1.count - 1)
   For j = 0 to arrylstValue1.count - 1
     arryValue1(j) = arrylstValue1.Item(j)  
   Next
   
   Redim arryValue2(arrylstValue2.count - 1)
   For j = 0 to arrylstValue2.count - 1
     arryValue2(j) = arrylstValue2.Item(j)  
   Next
   
   Redim arryValue3(arrylstValue3.count - 1)
   For j = 0 to arrylstValue3.count - 1
     arryValue3(j) = arrylstValue3.Item(j)  
   Next

   Redim arryValue4(arrylstValue4.count - 1)
   For j = 0 to arrylstValue4.count - 1
     arryValue4(j) = arrylstValue4.Item(j)  
   Next
   
   Redim arryValue5(arrylstValue5.count - 1)
   For j = 0 to arrylstValue5.count - 1
     arryValue5(j) = arrylstValue5.Item(j)  
   Next
   
   Redim arryValue6(arrylstValue6.count - 1)
   For j = 0 to arrylstValue6.count - 1
     arryValue6(j) = arrylstValue6.Item(j)  
   Next
   
   Redim arryValue7(arrylstValue7.count - 1)
   For j = 0 to arrylstValue7.count - 1
     arryValue7(j) = arrylstValue7.Item(j)
   Next
   
   Redim arryValue8(arrylstValue8.count - 1)
   For j = 0 to arrylstValue8.count - 1
     arryValue8(j) = arrylstValue8.Item(j)
   Next   
   
  '***************************************************************************************

   objConn.close()
   objConn = nothing

  '===================================================================
  '  Drawing the chart.
  '===================================================================

  'response.write ("<br>" & arryscale.length)
  'For j = 0 to arryscale.length - 1
	'response.write ("<br>" & arryscale(j))
  'Next

  intChartWidth = 720
  intPlotWidth = 550
    
  Dim c As XYChart = New XYChart(intChartWidth, 450, &HFFFFFF, &H0, 1)

  '==== Set the plot area at (100, 25) and of size 450 x 300 pixels. Enabled both
  '==== vertical and horizontal grids by setting their colors to light grey (0xc0c0c0)
   c.setPlotArea(85, 70, intPlotWidth, 280).setGridColor(&HFBCCF9, &HFBCCF9)

   'Add the title, with arial font size 15 with blue background
   'c.addTitle("Multiple Trends Comparison", "Verdana Bold ", 12).setAlignment(2)'.setBackground(&HAAB9FD)  
  
  'Add a legend box (100, 25) (top of plot area) using horizontal layout. Use 8 pts
  'Arial font. Disable bounding box (set border to transparent).
  
  Dim legendBox As LegendBox = c.addLegend(90, 0, False, "aaaa", 8)
   legendBox.setCols(-2)   
   legendBox.setBackground(Chart.Transparent, Chart.Transparent)

  'Set the labels on the x axis
   c.xAxis().setLabels(arryLabel).setFontStyle("Arial")
   c.xAxis().setLabels(arryLabel).setFontAngle(45)
     
  'Set the title on the x axis
   c.xAxis().setTitle("Log Date Time")
  
  '***************************************************************************************
   select case intLenPos
     case 1
      
	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))      
      
      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))
      layer0.setLineWidth(2)

     case 2
      
	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)      
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))

      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))      
                              
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)      
     
     case 3

	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))

      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))         
      Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &Hcc, arryEquipDesc(2))          
                              
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)
      layer2.setLineWidth(2)      
     
     case 4

	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))

      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))         
      Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &Hcc, arryEquipDesc(2))    
      Dim layer3 As LineLayer = c.addLineLayer(arryValue4, &H880088, arryEquipDesc(3))                     
                              
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)
      layer2.setLineWidth(2)
      layer3.setLineWidth(2)      
     
     case 5

	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))

      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))         
      Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &Hcc, arryEquipDesc(2))    
      Dim layer3 As LineLayer = c.addLineLayer(arryValue4, &H880088, arryEquipDesc(3))               
      Dim layer4 As LineLayer = c.addLineLayer(arryValue5, &H80C0FF, arryEquipDesc(4))      
                              
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)
      layer2.setLineWidth(2)
      layer3.setLineWidth(2)
      layer4.setLineWidth(2)      
      
     case 6

	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))

      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))         
      Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &Hcc, arryEquipDesc(2))    
      Dim layer3 As LineLayer = c.addLineLayer(arryValue4, &H880088, arryEquipDesc(3))               
      Dim layer4 As LineLayer = c.addLineLayer(arryValue5, &H80C0FF, arryEquipDesc(4))          
      Dim layer5 As LineLayer = c.addLineLayer(arryValue6, &HFF00&, arryEquipDesc(5))                
                              
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)
      layer2.setLineWidth(2)
      layer3.setLineWidth(2)
      layer4.setLineWidth(2)
      layer5.setLineWidth(2)      

     case 7

	  c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))

      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))         
      Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &Hcc, arryEquipDesc(2))    
      Dim layer3 As LineLayer = c.addLineLayer(arryValue4, &H880088, arryEquipDesc(3))               
      Dim layer4 As LineLayer = c.addLineLayer(arryValue5, &H80C0FF, arryEquipDesc(4))          
      Dim layer5 As LineLayer = c.addLineLayer(arryValue6, &HFF00&, arryEquipDesc(5))                
      Dim layer6 As LineLayer = c.addLineLayer(arryValue7, &HC0C0C0, arryEquipDesc(6))
                        
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)
      layer2.setLineWidth(2)
      layer3.setLineWidth(2)
      layer4.setLineWidth(2)
      layer5.setLineWidth(2)
      layer6.setLineWidth(2)      
            
     case 8

      c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
      'c.yAxis().setTitle(arryMeasure(0)).setAlignment(Chart.TopLeft2)
      c.yAxis().setColors(&H0&, &H0&, &H0&)
      c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))         
                
      Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &Hcc0000, arryEquipDesc(0))     
      Dim layer1 As LineLayer = c.addLineLayer(arryValue2, &H8000, arryEquipDesc(1))         
      Dim layer2 As LineLayer = c.addLineLayer(arryValue3, &Hcc, arryEquipDesc(2))    
      Dim layer3 As LineLayer = c.addLineLayer(arryValue4, &H880088, arryEquipDesc(3))               
      Dim layer4 As LineLayer = c.addLineLayer(arryValue5, &H80C0FF, arryEquipDesc(4))          
      Dim layer5 As LineLayer = c.addLineLayer(arryValue6, &HFF00&, arryEquipDesc(5))                
      Dim layer6 As LineLayer = c.addLineLayer(arryValue7, &HC0C0C0, arryEquipDesc(6))
      Dim layer7 As LineLayer = c.addLineLayer(arryValue8, &HFFFF&, arryEquipDesc(7))
                  
      layer0.setLineWidth(2)
      layer1.setLineWidth(2)
      layer2.setLineWidth(2)
      layer3.setLineWidth(2)
      layer4.setLineWidth(2)
      layer5.setLineWidth(2)
      layer6.setLineWidth(2)
      layer7.setLineWidth(2)
      
   end select

   if ubound(arryLabel) <= 30 then 
     intInterval = 0
   else
     intInterval = (ubound(arryLabel) / 30)
   end if
   c.xAxis().setLabelStep(intInterval)

   c.layout()
   WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
   WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
                             "title='[{dataSetName}] Date: {xLabel} ; Value: {value|2} meters'")
%>
<html>
<head>
<% 'response.write ("arr") %>
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
  <body><form name=checkboxform>
  <% 'response.write (haiy)%>
  <table width="720" border="1" style="border-collapse: collapse; border: 1px solid #AAC6FF;">
<%
	Dim OddorEven, someCounter
	OddorEven = 1
	for someCounter = 0 to intLenPos - 1
	if OddorEven = 1 Then
%>
	<tr><td width="50%" valign="middle" style="border: 1px solid #AAC6FF;">
<%
	Else
%>
	<td width="50%" valign="middle" style="border: 1px solid #AAC6FF;">
<%	
	End If
%>
<div id="option<%=someCounter%>"><input type="checkbox" name="check<%=someCounter%>" onclick="javascript:click_checking(<%=someCounter%>);" value="id<%=someCounter%>" checked><b><font face="Verdana" size=-3><%=arryEquipDesc(someCounter)%></font></b></div>
<%	
	if OddorEven = 1 Then
	OddorEven = 2
%>
	</td>
<%
	Else
	OddorEven = 1
%>
	</td></tr>
<%	
	End If
	Next someCounter
	
	If OddorEven = 2 Then response.write ("<td style='border: 1px solid #AAC6FF;'>&nbsp;</td></tr>")
%>	
	<tr><td colspan="2" align="center" valign="middle">
	<a href="javascript:requery_checking();"><img border="0" src="images/Submit_s.jpg"></a>	
	</td></tr></table></form>
    <form name="frmDisCon" method="post" action="WTAnalysis.aspx">
    <div align="center">    
    <p><img border="0" src="images/WTA.jpg"></p>    
    <br>
    <%if blnTmp=true then%>
      <chart:WebChartViewer id="WebChartViewer1" runat="server" />
       <table>
        <tr>
          <td>
            <a href="javascript:gotoSubmit()"><img border="0" src="images/Back.jpg"></a>
          </td>
          <td>
          </td>
        </tr>
      </table>
    <%else%>
      <center>
      <div align="center" valign="center" style="border: 1 solid; width: 400; height: 300;">
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
       <font style="font-family: Verdana; color: #3D62F8"><b> No Data To Be Displayed !</b></font>
      </div>
      <br>
      <a href="javascript:gotoSubmit()"><img border="0" src="images/Back.jpg"></a>
      </center>
    <%end if%>
      <input type="hidden" name="ddDistrict" value="">
      <input type="hidden" name="txtLastDate" value="">
      <input type="hidden" name="ddSite1" value="">
      <input type="hidden" name="ddSite2" value="">
      <input type="hidden" name="ddSite3" value="">
      <input type="hidden" name="ddSite4" value="">
      <input type="hidden" name="ddSite5" value="">
      <input type="hidden" name="ddSite6" value="">
      <input type="hidden" name="ddSite7" value="">
      <input type="hidden" name="ddSite8" value="">
      <input type="hidden" name="txtBeginDate" value="">
      <input type="hidden" name="ddBeginHour" value="">
      <input type="hidden" name="ddBeginMinute" value="">
      <input type="hidden" name="txtEndDate" value="">
      <input type="hidden" name="ddEndHour" value="">
      <input type="hidden" name="ddEndMinute" value="">
      <input type="hidden" name="txtStatus" value="">
    </form>
        
    <form name="hiddenform" method="post" action="aspdotnetfordummies.aspx">
      <input type="hidden" name="ddDistrict" value="">      
      <input type="hidden" name="ddSite1" value="">
      <input type="hidden" name="ddSite2" value="">
      <input type="hidden" name="ddSite3" value="">
      <input type="hidden" name="ddSite4" value="">
      <input type="hidden" name="ddSite5" value="">
      <input type="hidden" name="ddSite6" value="">
      <input type="hidden" name="ddSite7" value="">
      <input type="hidden" name="ddSite8" value="">      
      <input type="hidden" name="txtBeginDate" value="">
      <input type="hidden" name="ddBeginHour" value="">
      <input type="hidden" name="ddBeginMinute" value="">      
      <input type="hidden" name="txtEndDate" value="">
      <input type="hidden" name="ddEndHour" value="">
      <input type="hidden" name="ddEndMinute" value="">      
      <input type="hidden" name="txtLastDate" value="">
      
      <input type="hidden" name="txtSiteName1" value="">
	  <input type="hidden" name="txtSiteName2" value="">
	  <input type="hidden" name="txtSiteName3" value="">
	  <input type="hidden" name="txtSiteName4" value="">
	  <input type="hidden" name="txtSiteName5" value="">
	  <input type="hidden" name="txtSiteName6" value="">
	  <input type="hidden" name="txtSiteName7" value="">
	  <input type="hidden" name="txtSiteName8" value="">
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
    document.frmDisCon.ddSite5.value="<%=intSiteID5%>";
    document.frmDisCon.ddSite6.value="<%=intSiteID6%>";
    document.frmDisCon.ddSite7.value="<%=intSiteID7%>";
    document.frmDisCon.ddSite8.value="<%=intSiteID8%>";

    document.frmDisCon.txtBeginDate.value="<%=strBeginDate%>";
    document.frmDisCon.ddBeginHour.value="<%=strBeginHour%>";
    document.frmDisCon.ddBeginMinute.value="<%=strBeginMin%>";
    
    document.frmDisCon.txtEndDate.value="<%=strEndDate%>";
    document.frmDisCon.ddEndHour.value="<%=strEndHour%>";
    document.frmDisCon.ddEndMinute.value="<%=strEndMin%>";

    document.frmDisCon.submit();
  }
  
  function click_checking(nilai)
  {	
	kaunter = 0;
	for (var j = 0; j <=<%=intLenPos-1%>; j++)
	{
		box = eval("document.checkboxform.check" + j); 
		if (box.checked == false) kaunter=kaunter+1;
	}
	if (kaunter == <%=intLenPos-1%>)
	{
		alert("Please select at least 2 equipments for trend comparison !");
		box = eval("document.checkboxform.check" + nilai); 
	    box.checked = true;
	}
  }
  
  function requery_checking()
  {	
	kaunter = 0;
	for (var j = 0; j <=<%=intLenPos-1%>; j++)
	{
		box = eval("document.checkboxform.check" + j); 
		if (box.checked == false) kaunter=kaunter+1;
	}
	if (kaunter == <%=intLenPos-1%>)
	{
		alert("Please select at least 2 equipments for trend comparison !");   
	}
	else
	{
		reShuffle();		
	}
  }
  
  function reShuffle()
  {
	var Site= new Array();	
	var semetar = new Array();
	posisi = 0;
		
	Site[0] = "<%=intSiteID1%>";
	Site[1] = "<%=intSiteID2%>";
	Site[2] = "<%=intSiteID3%>";
	Site[3] = "<%=intSiteID4%>";
	Site[4] = "<%=intSiteID5%>";
	Site[5] = "<%=intSiteID6%>";
	Site[6] = "<%=intSiteID7%>";
	Site[7] = "<%=intSiteID8%>";
		
    for (var x = 0; x < <%=intLenPos%>; ++x)
	{		    				
		        for (var y = posisi; y < <%=intLenPos%>; ++y)
                {
						box = eval("document.checkboxform.check" + y);
						if (box.checked == true)
						{
							// Arrange new array
							semetar[x]= Site[y];
							//alert("x "+x+",y "+y);
							break;
						}
						else ++posisi;						
                } 		
                ++posisi;                
	}
	// resetting original array to zero
	for (var z = 0; z < <%=intLenPos%>; ++z) Site[z]=0;
	// assign original array to new array	
	for (var z = 0; z < semetar.length; ++z) Site[z]=semetar[z];
	//================================== alert !
	//for (var z = 0; z < <%=intLenPos%>; ++z) document.write("<br>Site["+ z +"] : " + Site[z]);
	//==================================
    document.hiddenform.ddDistrict.value="<%=strSelectedDistrict%>";
    //document.hiddenform.txtLastDate.value="<%=strLastDate%>";
    document.hiddenform.txtLastDate.value="";
    document.hiddenform.ddSite1.value=Site[0];
    document.hiddenform.ddSite2.value=Site[1];
    document.hiddenform.ddSite3.value=Site[2];
    document.hiddenform.ddSite4.value=Site[3];
    document.hiddenform.ddSite5.value=Site[4];
    document.hiddenform.ddSite6.value=Site[5];
    document.hiddenform.ddSite7.value=Site[6];
    document.hiddenform.ddSite8.value=Site[7];

    document.hiddenform.txtBeginDate.value="<%=strBeginDate%>";
    document.hiddenform.ddBeginHour.value="<%=strBeginHour%>";
    document.hiddenform.ddBeginMinute.value="<%=strBeginMin%>";
    
    document.hiddenform.txtEndDate.value="<%=strEndDate%>";
    document.hiddenform.ddEndHour.value="<%=strEndHour%>";
    document.hiddenform.ddEndMinute.value="<%=strEndMin%>";
	
	document.hiddenform.action ="WaterLevelTrendAnalysis.aspx";
	document.hiddenform.submit();
  }  
</script>
