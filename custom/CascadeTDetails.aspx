<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
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

Function DifferString(szFirst As date, szSecond As date) As Integer
    Dim nDiffer  As Integer    
    select case DateDiff(DateInterval.Minute,szFirst,szSecond)
		case <119
			DifferString = 5
		case 120 to 719
			DifferString = 10
		case 720 to 1439
			DifferString = 15
		case 1440 to 2880
                'DifferString = 20
                DifferString = 30
            Case Is > 2880
                DifferString = 30
        End Select
	'dim t  as datetime=cDate('2006-11-01 00:00:00')	
End Function

Function Differ4Value(szFirst As date, szSecond As date) As Integer
    Dim nDiffer  As Integer    
    select case DateDiff(DateInterval.Minute,szFirst,szSecond)
		case <119
			'Differ4Value = 5
			Differ4Value = 15
		case 120 to 719
			'Differ4Value = 10
			Differ4Value = 15
		case 720 to 1439
			'Differ4Value = 15
			Differ4Value = 30
		case 1440 to 2880
			'Differ4Value = 20
			Differ4Value = 30
		case else
			'Differ4Value = 30
			Differ4Value = 45
    end select	
End Function

Function DifferStringAsDate(szFirst As date, szSecond As date) As Boolean
    Dim nDiffer  As Integer
    'Convert.ToDateTime(XL.RowField.Trim)
    'DifferStringAsDate = DateDiff(DateInterval.Minute,szFirst,szSecond)
    if szFirst<szSecond then
		DifferStringAsDate = 1
    else
		DifferStringAsDate = 0
    end if
End Function

Function GetLastSequence(strConn As String,strSite As String,nPos As Integer) As String   
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select sequence from telemetry_log_table where siteid='" & _
	        strSite & "' and position ='" & nPos & "' order by sequence desc limit 1", nOConn)

   if RS.eof then
		GetLastSequence = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(now))
   else
		GetLastSequence = RS("sequence").value
   end if   
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function DifString(strConn As String,strSite As String,nPos As Integer,szPrev As date, szLast As date) As Integer
   Dim nSConn
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()
   
   RS.open("select value, sequence, position from telemetry_log_table where siteid='" & _
	        strSite & "' and position ='" & nPos & "' and sequence between '" & _
            szPrev & ":00' and '" & szLast & ":59' order by sequence desc", nOConn)
               
End Function

Function GetSiteAddress(strConn As String,strSite As String) As String
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select address from telemetry_site_list_table where siteid='" & strSite & "'",nOConn)   	   			
   			if not RS.EOF then
				GetSiteAddress = server.htmlencode(RS("address").value)
			else
				GetSiteAddress = ""
			end if

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing	
   
End Function
</script>
<%
   dim apaapaje,jj
   dim arrylstLabel as new ArrayList
   dim arrylstValue1 as new ArrayList
   dim arrylstValue2 as new ArrayList
    Dim z As String
    Dim x As String
   dim strConn,TM_Conn
   dim objConn
   dim sqlRs
   dim sqlRs1
   dim strValue
   dim arryValue1() as double
   dim arryValue2() as double
   
    Dim arrysort() As String
    
   dim arryLabel() as string
   dim arryScale(3) as double
   dim arryMax(3) as double
   dim arryMeasure(3)
   dim arryEquipDesc(3)

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

   dim equipname = ucase(request("equipname"))
   dim strSelectedDistrict = request("ddDistrict")
   dim sitename = request("sitename")
   dim intSiteID1 =	request("ddSite1")

   '======================================
   dim arrySiteID1 = split(intSiteID1, ",")

   '======================================    
   
   if arrySiteID1(0) <> "0" then
     intSiteID = arrySiteID1(0)
     intPos = arrySiteID1(1)
   end if
  
   dim strBeginDate = request("txtBeginDate")
   dim strBeginHour= request("ddBeginHour")
   dim strBeginMin = request("ddBeginMinute")
   
   dim strEndDate =	request("txtEndDate")
   dim strEndHour =	request("ddEndHour")
   dim strEndMin =	request("ddEndMinute")
   
   dim arryPos = split(intPos, ",")
   dim arrySiteID = split(intSiteID, ",")
   dim intLenPos = arryPos.length()
   
   dim strBeginDateTime = Date.Parse(strBeginDate & " " & strBeginHour & ":" & strBeginMin) 
   dim strEndDateTime = Date.Parse(strEndDate & " " & strEndHour & ":" & strEndMin)   
   
   dim strLastDate = request("txtLastDate")
   dim strLastDate1
   dim last_logged
   
   if strLastDate = "" then
     strStatus = "1stPage"
     strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
   end if
   
   strLastDate1 = strLastDate
   
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   sqlRs1 = new ADODB.Recordset()  

 for i = 0 to intLenPos - 1
 

strConn = ConfigurationSettings.AppSettings("DSNPG")
TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"

if GetSiteAddress(strConn,arrySiteID(i))="TM SERVER" Then
	 strConn = TM_Conn
End if
	 last_logged = GetLastSequence(strConn,arrySiteID(i),arryPos(i))
	 objConn.open(strConn)
     sqlRs.open("select max(value) as max from telemetry_log_table where siteid='" & _
                  arrySiteID(i) & "' and position ='" & arryPos(i) & "' and sequence between '" & _
                  strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00' and '" & _
                  strEndDate & " " & strEndHour & ":" & strEndMin & ":59'", objConn)

	 'If IsDBNull(sqlRs(0))Then
	 if sqlRs.recordcount = 0 then
		arryMax(i) = 10
	 else	 
		
		If IsDBNull(sqlRs("max").value) Then		
			arrymax(i) = 10			
		else			
			arrymax(i) = System.Math.Ceiling(sqlRs("max").value)+1
		end if
		'arryMax(i) = math.round(sqlRs("max").value,0)+1
	 end if 
	 
	 select case arryMax(i)
		case > 20
			arryScale(i) = arryMax(i) / 20
		case else
			arryScale(i) = arryMax(i) / 10
	 end select
	 
	 sqlRs.Close

'   for i = 0 to intLenPos - 1
     sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                  arrySiteID(i) & "' and position ='" & arryPos(i) & "' and sequence between '" & _
                  strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00' and '" & _
                  strEndDate & " " & strEndHour & ":" & strEndMin & ":59' order by sequence desc limit 10", objConn)

'     sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
'                  arrySiteID(i) & "' and position ='" & arryPos(i) & "' and sequence between '" & _
'                  strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00' and '" & _
'                  strEndDate & " " & strEndHour & ":" & strEndMin & ":59' order by sequence", objConn)
                  
     do while not sqlRs.EOF
       blnTmp = true
       sqlRs.movenext
     loop
     sqlRs.close()
     objConn.close()    
   next

	'***********************************************************************************************
	dim rmultiplier(0) as string
	dim rposition(0) as integer
	dim ralarmtype(0) as string
	dim rcolorcode(0) as string
	dim ralert(0) as boolean	
	i = 0	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'sqlRs.Open("select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & request("SiteID") & "' And alarmmode = 'EVENT' order by position, sequence asc",objConn)
   	'do while not sqlRs.EOF
	'	rmultiplier(i) = sqlRs.fields("multiplier").value 
	'	rposition(i) = sqlRs.fields("position").value 
	'	ralarmtype(i) = sqlRs.fields("alarmtype").value
	'	rcolorcode(i) = sqlRs.fields("colorcode").value
	'	ralert(i) = sqlRs.fields("alert").value
	'	i = i + 1
	'	redim preserve rmultiplier(i)
	'	redim preserve rposition(i)
	'	redim preserve ralarmtype(i)
	'	redim preserve rcolorcode(i)
	'	redim preserve ralert(i)
	'	sqlRs.MoveNext
	'loop	
	'sqlRs.close
	'sqlRs = nothing
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	
	dim minValue as integer
	dim Suffix as string

	if instr(1, equipname, "WATER LEVEL") > 0 then
		Suffix = "meter"
		minvalue = 0
	end if
	
	if instr(1, equipname, "LEVEL") > 0 then
		Suffix = "meter"
		minvalue = 0
	end if
	
	if instr(1, equipname, "FLOW") > 0 then
		Suffix = "m3/hr"
		minvalue = 0
		
		arrymax(i) = Math.Round(arrymax(i)) * 2

'		for jj = 1 to len(arrymax(i))-3
'			apaapaje = apaapaje & "0"
'		next jj
'		arrymax(i) = Convert.ChangeType(left(arrymax(i),1) & apaapaje, GetType(double))
		
		arryScale(i) = arryMax(i) / 5
	end if
	
	if instr(1, equipname, "TOTALIZER") > 0 then
		Suffix = "m3"
		minvalue = 0

		arrymax(i) = arrymax(i) * 2
		
		for jj = 1 to len(arrymax(i))-3
			apaapaje = apaapaje & "0"
		next jj
		arrymax(i) = Convert.ChangeType(left(arrymax(i),1) & apaapaje, GetType(double))
		
		arryScale(i) = arryMax(i) / 5
	end if

	if instr(1, equipname, "FLOWMETER") > 0 then
		Suffix = "m3/h"
		minvalue = 0
	end if
	
	if instr(1, equipname, "PRESSURE") > 0 then
		Suffix = "bar"
		minvalue = 0
	end if

	if instr(1, equipname, "TANK") > 0 then
		Suffix = "m"
		minvalue = 0
	end if

	if instr(1, equipname, "TURBIDITY") > 0 then
		Suffix = "NTU"
		minvalue = 0
	end if
	
	if instr(1, equipname, "PH") > 0 then
		Suffix = "pH"
		minvalue = 1
	end if
	
	if instr(1, equipname, "CHLORINE") > 0 then
		Suffix = "ch"
		minvalue = 0
	end if	
	
	'*********************************************************************************************** search data part
   dim previous_LastDate,previous_Value
   j = 0
   i = 0   
       
     for i = 0 to intLenPos - 1 

	'strConn = ConfigurationSettings.AppSettings("DSNPG")
				
       strLastDate = strLastDate1
       
       do while strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strEndDateTime))
         if i = 0 then
           arrylstLabel.Add(String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate)))
         end if         
		 objConn.open(strConn)
         sqlRs.open("select value, sequence, position from telemetry_log_table where siteid='" & _
                 arrySiteID(i) & "' and position ='" & arryPos(i) & "' and sequence between '" & _
                 strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc", objConn)

		 previous_LastDate = strLastDate
'		 response.write(previous_LastDate & "<br>")
		         
'=== Taking max value, blablabla if exist ===
         
         sqlRs1.open("select sitename, max, measurement, ""desc"" " & _
                     " from telemetry_equip_list_table e, telemetry_site_list_table s" & _
                     " where e.siteid='" & arrySiteID(i) & "' and position ='" & arryPos(i) & "'" & _
                     " and e.siteid = s.siteid", objConn)

         if not sqlRs1.EOF then 
			if request("x")= "point" then           
					arryMax(i) = sqlRs1("max").value
					arryScale(i) = arryMax(i) / 20
			end if			   
			arryMeasure(i)= sqlRs1("measurement").value
			arryEquipDesc(i)= sqlRs1("sitename").value & " : " & sqlRs1("desc").value			
			strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strLastDate).AddMinutes(15))
		 else
			strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strLastDate).AddMinutes(DifferString(strBeginDateTime,strEndDateTime)))
			'strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strLastDate).AddMinutes(15))
         end if
		 
         sqlRs1.close()      
         

'======== SET VALUE & NO VALUE

         if not sqlRs.EOF then
	           strValue = sqlRs("value").value               
               Select Case i
					Case 0
                        arrylstValue1.Add(strValue)
                    Case 1
                        arrylstValue2.Add(strValue)
               End Select
         else               
               Select Case i
					Case 0
                        arrylstValue1.Add(Chart.NoValue)
                    Case 1
                        arrylstValue2.Add(Chart.NoValue)
               End Select
               
               '=== FAKE PATCH                
'                Select Case i
'                    Case 0
'						if Not DifferStringAsDate(strLastDate, last_logged) then
'							arrylstValue1.Add(Chart.NoValue)
'						else
'							arrylstValue1.Add(strValue)
'						end if
'                    Case 1
'						if Not DifferStringAsDate(strLastDate, last_logged) then
'							arrylstValue2.Add(Chart.NoValue)
'						else
'							arrylstValue2.Add(strValue)
'						end if
'                End Select
               
               '=== PATCHES
         end if
         
         j = j + 1
  
         'if j = 30 then
         '  sqlRs.close()
         '  exit do
         'end if
  
			sqlRs.close()
			objConn.close()   
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
    
    If equipname = "TOTALIZER" Then
    
        Array.Sort(arryValue1)
        z = arryValue1(0)
    
        Dim count = arrylstValue1.Count - 1
        Dim v
    
        For v = 0 To arrylstValue1.Count - 1
        
             x = arryValue1(count)
            If Not x = "1.7E+308" Then
                Exit For
            End If
            count = count - 1
        Next
    End If
    ReDim arryValue2(arrylstValue2.Count - 1)
    For j = 0 To arrylstValue2.Count - 1
        arryValue2(j) = arrylstValue2.Item(j)
    Next
    '******************************************

    'objConn.close()
    objConn = Nothing

    '===================================================================
    '  Drawing the chart.
    '===================================================================

    'response.write ("<br>" & arryscale.length)
    'For j = 0 to arryscale.length - 1
    'response.write ("<br>" & arryscale(j))
    'Next

    intChartWidth = 700
    intPlotWidth = 550
    
    '**  Dim c As XYChart = New XYChart(intChartWidth, 450, &HFFFFFF, &H0, 1)	 
    Dim c As XYChart = New XYChart(698, 450)
	 
    'c.setPlotArea(85, 70, intPlotWidth, 280).setGridColor(&HFBCCF9, &HFBCCF9)
    c.setPlotArea(85, 70, intPlotWidth, 280, &HFFFFFF, -1, &HFBCCF9, &HFBCCF9, -1)


    'Add the title, with arial font size 15 with blue background   
    c.addTitle(UCase(sitename & " " & equipname & " Trending Chart."), "Arial Bold", 14, &H52A0AA)
  
    'Add a legend box (100, 25) (top of plot area) using horizontal layout. Use 8 pts
    'Arial font. Disable bounding box (set border to transparent).
  
    '**  Dim legendBox As LegendBox = c.addLegend(90, 0, False, "aaaa", 8)
    '**   legendBox.setCols(-2)   
    '**   legendBox.setBackground(Chart.Transparent, Chart.Transparent)

    'Set the labels on the x axis
    c.xAxis().setLabels(arryLabel).setFontStyle("Arial")
    c.xAxis().setLabels(arryLabel).setFontAngle(45)
     
    'Set the title on the x axis
    c.xAxis().setTitle("Log Date Time")
    c.xAxis().setColors(&HFBCCF9&, &H0&, &H0&)
    '***************************************************************************************      
    'c.yAxis().setTitle("Meters").setAlignment(Chart.TopLeft2)
    c.yAxis().setTitle(Suffix).setAlignment(Chart.TopLeft2)
  
    'c.yAxis().setTitle(Suffix).setAlignment(Chart.TopLeft2)
    c.yAxis().setColors(&HFBCCF9&, &H0&, &H0&)
  
    
    
    
    If equipname = "TOTALIZER" Then
        
        'c.yAxis().setLinearScale(1130000, 1140000, 500)
        x = x + 2000
        z = z - 1000
        c.yAxis().setLinearScale(z, x, 2000)
    Else
        
        c.yAxis().setLinearScale(0, arryMax(0), arryScale(0))
    End If
    
   
  
    
    
    
      
    Dim layer0 As LineLayer = c.addLineLayer(arryValue1, &HC000&, arryEquipDesc(0))
    layer0.setLineWidth(2)
  
    If UBound(arryLabel) <= 30 Then
        intInterval = 0
    Else
        intInterval = (UBound(arryLabel) / 30)
    End If
    c.xAxis().setLabelStep(intInterval)
    '============================================================== Rule Lines (Mark)
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
    WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
                              "title='Date: {xLabel} ; Value: {value|2} " & Suffix & "'")
    '   WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    '                             "title='[{dataSetName}] Date: {xLabel} ; Value: {value|2} meters'")
    '   WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    '    "title='Time {xLabel}: " & equipname & " : {value} " & Suffix & "'")
%>
<html>
<head>
</head>
<body bgcolor="white">
<div align="center">
    &nbsp;&nbsp;&nbsp;
<table border="0" CELLSPACING="0">
<tr><td align="center" valign="middle" >
    <div align="center" valign="middle" style="background-color:transparent">	  
    <%if blnTmp=true then%>
      <chart:WebChartViewer id="WebChartViewer1" runat="server" />
      <%--<%If equipname = "TOTALIZER" Then%>
      <center>
      <div align="center" valign="center" style="border: 1px solid; width: 300px; height: 1px;">
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
       <font style="font-family: Verdana; color: black"><b> total water(Max): <%= x%>m3</b></font>
      </div>     
      </center>
     <%End If%>--%>
    <%else%>
      <center>
      <div align="center" valign="center" style="border: 1px solid; width: 400px; height: 300px;">
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
       <font style="font-family: Verdana; color: #3D62F8"><b> No Data To Be Displayed !</b></font>
      </div>     
      </center>
    <%
        End If%>
</td></tr></table></div>
<p align="center"><a href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p>
  </body>
</html>