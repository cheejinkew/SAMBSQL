<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
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

</script>
<html>
<head>
<style>
 .bodytxt 
 {
   font-weight: normal;
   font-size: 11px;
   color: red;
   line-height: normal;
   font-family: Verdana, Arial, Helvetica, sans-serif;
 }

</style>
</head>
<body>

<form name="polling" method="post" action="smspoll.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/SiteSummary.jpg">
            
          </td>
        </tr>
      </table>
    </div>

  <h1></h1>
  <%
	dim SiteID = request.querystring("siteid")
	dim SiteName = request.QueryString("sitename")
	dim District = request.QueryString("district")
	dim SiteType = request.QueryString("sitetype")
   	dim objConn
   	dim rsRecords
   	dim strConn
   	dim strComment
   	dim strAddress
   	dim strImagePath
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()

        objConn.open(strConn)

        rsRecords.Open("select address, comment, image_path " & _
                       "from telemetry_site_list_table where siteid='" & SiteID & "'", objConn)
             
        if not rsRecords.EOF then
          strComment = rsRecords("comment").value
          strAddress = rsRecords("address").value
          strImagePath = "images/UploadedImages/" & rsRecords("image_path").value
        else
          response.Write("<center><font class='bodytxt'><b>" & "Please Select Site from the left Menu !" & "</b></font></center>")
        end if
         
         
        rsRecords.close()
        objConn.close()
             
   	if session("login") is nothing then
   	  response.redirect ("login.aspx")
   	end if
	dim hreflink as string
	select case SiteType
	case "RESERVOIR"
		hreflink = "cascadeReservoir.aspx?siteid=" & siteid & "&sitename=" & sitename & "&district=" & district
	case "WTP"
		hreflink = "cascadeWTP.aspx?siteid=" & siteid & "&sitename=" & sitename & "&district=" & district
	case "BPH"
		hreflink = "cascadeBPH.aspx?siteid=" & siteid & "&sitename=" & sitename & "&district=" & district
	end select
	if SiteID = "" then exit sub



	%>
<meta http-equiv="refresh" content="20; URL=Summary.aspx?siteid=<%=SiteID%>&sitename=<%=SiteName%>&district=<%=district%>&sitetype=<%=SiteType%>">
  <table width="409" border="1">
    <tr>
      <td width="200"><div align="right">District : </div></td>
      <td width="193"><input type="text" name="district" value="<%=district%>" readonly></td>
    </tr>
    <tr>
      <td><div align="right">Site ID : </div></td>
      <td><input type="text" name="siteid" value="<%=siteid%>" readonly></td>
    </tr>
    <tr>
      <td><div align="right">Site Name : </div></td>
      <td><input type="text" name="sitename" value="<%=sitename%>" readonly></td>
    </tr>
  </table>
  <table width="410" border="1">
    <tr>
      <td><div align="center"><a href="<%=hreflink%>" target="main">Cascade Diagram</a></div></td>
    </tr>
  </table>
  <p>Polling method :
    <select name="pollmethod" id="pollmethod">
      <option>SMS</option>
      <option>GPRS</option>
    </select>
  Password :  
  <input name="password" type="password" id="password2" maxlength="10">
  <input type="submit" name="Submit" value="Submit">
  <%	

   	objConn.open(strConn)
	dim refreshinterval as integer
	dim equiplist(0) as string
	dim equipname(0) as string
	dim equipdesc(0) as string
	dim multiplier(0) as string
	dim ulimit(0) as string
   	dim i as integer
	refreshinterval = 10
	rsRecords.Open("select " & chr(34) & "desc" & chr(34) & ", equipname, equiptype, multiplier, max from telemetry_equip_list_table where siteid='" & SiteID & "' order by position",objConn)
   	do while not rsRecords.EOF
		equiplist(i) = rsrecords.fields("equiptype").value 
		equipname(i) = rsrecords.fields("equipname").value
		equipdesc(i) = rsrecords.fields("desc").value 
		multiplier(i) = rsrecords.fields("multiplier").value
		ulimit(i) = rsrecords.fields("max").value
		i = i + 1
		redim preserve equiplist(i)
		redim preserve equipname(i)
		redim preserve equipdesc(i)
		redim preserve multiplier(i)
		redim preserve ulimit(i)
		
		rsRecords.MoveNext
	loop
	rsRecords.close
	
	dim rmultiplier(0) as string
	dim rposition(0) as integer
	dim ralarmtype(0) as string
	dim rcolorcode(0) as string
	i = 0
	rsRecords.Open("select multiplier, position, alarmtype, colorcode from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc",objConn)
   	do while not rsRecords.EOF
		rmultiplier(i) = rsrecords.fields("multiplier").value 
		rposition(i) = rsrecords.fields("position").value 
		ralarmtype(i) = rsrecords.fields("alarmtype").value
		rcolorcode(i) = rsrecords.fields("colorcode").value
		i = i + 1
		redim preserve rmultiplier(i)
		redim preserve rposition(i)
		redim preserve ralarmtype(i)
		redim preserve rcolorcode(i)
		rsRecords.MoveNext
	loop
	rsRecords.close
	
	dim events(2) as string
	dim sequence as string
	dim readings(2) as string

	rsRecords.Open("select sequence, value, event from telemetry_equip_status_table where siteid='" & SiteID & "' order by position",objConn)
   	if rsrecords.eof = false then
		i = 2
		do while not rsRecords.EOF
			events(i) = rsrecords.fields("event").value 
			sequence = rsrecords.fields("sequence").value 
			readings(i) = rsrecords.fields("value").value
			if readings(i) < 0 then readings(i) = 0
			i = i + 1
			redim preserve events(i)
			redim preserve readings(i)
			rsrecords.movenext
		loop
	else
		response.Write("Data Not Available")
		exit sub
	end if
	rsrecords.close
	
	rsrecords = nothing
	objConn.close
	objConn = Nothing
	dim XMLData as string
	dim minvalue as string
	dim maxvalue as string
	dim j as integer
	
	for i = 0 to ubound(equiplist)
		dim colorrange
		select case equiplist(i)
		case "LEVEL METER"
			if multiplier(i) = "0" then
		%>
  </p>
</form>
<table width="732" border="1">
  <tr>
    <td width="360"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="356"><div align="center"></div></td>
  </tr>
  <tr>
    <td><div align="center"><%=readings(i)%></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
	
<p></p>
	<% 
	else
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' majorTMNumber='5' majorTMColor='000000'  minorTMNumber='2' majorTMThickness='1' decimalPrecision='3' tickMarkDecimalPrecision='0' tickMarkGap='5' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' cylColor='9B72CF' cylFillColor='000000' showValue='1' numberSuffix=' meter'><value>" & readings(i) & "</value></Chart>"
	%>
    <table width="730" border="1">
      <tr>
    	<td width="305"><div align="center"><% = equipdesc(i) %></div></td>
	    <td width="492"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>"><% = equipname(i)%></a></div></td>
      </tr>
      <tr>
        <td height="279" rowspan="3">
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="302" height="270" viewastext>
            <param name="movie" value="Charts/FI2_Cylinder.swf?data=<%=XMLData%>&amp;chartWidth=287&amp;chartHeight=250">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Charts/FI2_Cylinder.swf?data=<%=XMLData%>&amp;chartWidth=287&amp;chartHeight=250" flashvars="" quality="high" bgcolor="#FFFFFF" width="302" height="270" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
          </object>        
        </td>
	  <% 
	     XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='" & ulimit(i) -1 & "' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='m' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='11'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
	  %>
        <td>        
          <%
            if SiteType <> "RESERVOIR" then
          %>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="300" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
          </object>
          <%else%>
             <img src="<%=strImagePath%>" width="410" height="300">
          <%end if%>
        
        </td>
      </tr>
      <tr>
        <td><font size="3"><b>Address : </b><%=strAddress%></font></td>
      </tr>
      <tr>
        <td><font size="3"><b>Comment : </b><%=strComment%></font></td>
      </tr>
    
</table>
	<table width="730" height="45" border="1">
 	<tr>
	<%
		
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' numberSuffix=' meter' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange >"
		for j = 0 to ubound(rposition)
			if rposition(j) = i then
				if szparsestring(rmultiplier(j), ";", 1) = "RANGE" then
					minvalue = szparsestring(rmultiplier(j), ";", 2)
					maxvalue = szparsestring(rmultiplier(j), ";", 3)
					colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
				end if
			end if
		next j
		if colorrange = "" then
			colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"		
		end if
		XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
		
	%>
     <td width="882"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="715" height="120" id="FusionCharts" viewastext>
       <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
       <param name="FlashVars" value="">
       <param name="quality" value="high">
       <param name="bgcolor" value="#FFFFFF">
       <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120" flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" name="FusionCharts" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
     </object></td>
 	</tr>
</table>
    <p></p>
		<%
			end if
		case "FLOW METER"
			if multiplier(i) = "0" then
		%>
<table width="731" border="1">
  <tr>
    <td width="357"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="358"><div align="center"></div></td>
  </tr>
  <tr>
    <td><div align="center">        <%=readings(i)%>
    </div></td>
    <td>&nbsp;</td>
  </tr>
</table>
	
<p></p>
	<% 
	else 
		
	XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='m3/h' baseFontColor='646F8F' baseFontSize='9' majorTMNumber='11' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='5' minorTMColor='646F8F' minorTMHeight='3' pivotRadius='0' showHoverCap='1' majorTMThickness='1' showGaugeBorder='0' gaugeOuterRadius='105' gaugeInnerRadius='100' gaugeOriginX='155' gaugeOriginY='135' gaugeScaleAngle='280' gaugeAlpha='50' placeValuesInside='1' decimalPrecision='0' displayValueDistance='22' hoverCapBgColor='F2F2FF' hoverCapBorderColor='6A6FA6' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange><color minValue='0' maxValue='" & ulimit(i) & "' code='A1A0FF' /></colorRange><dials><dial value='" & readings(i) & "' bgColor='6A6FA6,A1A0FF' borderAlpha='0' baseWidth='5' topWidth='4' /></dials><customObjects><objectGroup xPos='155' yPos='135' showBelowChart='1'><object type='circle' xPos='0' yPos='0' radius='130' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='000000,2C6BB2, 135FAB' fillAlpha='100,100,100'  fillRatio='80,15, 5' showBorder='1' borderColor='2C6BB2' /><object type='circle' xPos='0' yPos='0' radius='120' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='ffffff, D4D4D4'  fillAlpha='100,100'  fillRatio='20,80' showBorder='1' borderColor='2C6BB2' /><object type='arc' xPos='0' yPos='0' radius='120' innerRadius='115' startAngle='-60' endAngle='240' fillAsGradient='1' fillColor='51884F'  fillAlpha='50' fillRatio='100' showBorder='1' borderColor='51884F' /></objectGroup><objectGroup xPos='155' yPos='135' showBelowChart='0'><object type='circle' xPos='0' yPos='0' radius='5' startAngle='0' endAngle='360' borderColor=' bebcb0' fillAsGradient='1' fillColor='A1A0FF,6A6FA6'  fillRatio='70,30' /></objectGroup></customObjects></Chart>"

	%>
<table width="731" border="1">
  <tr>
    <td width="305"><div align="center"><% = equipdesc(i) %></div></td>
    <td width="492"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>"><% = equipname(i)%></a></td>
  </tr>
  <tr>
    <td>	 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="302" height="270" viewastext>
      <param name="movie" value="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250">
      <param name="FlashVars" value="">
      <param name="quality" value="high">
      <param name="bgcolor" value="#FFFFFF">
      <embed src="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250" flashvars="" quality="high" bgcolor="#FFFFFF" width="425" height="270" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
    </object> </td>
    	<% 
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='9' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='m3/h' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='11'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
		%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="300" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>
	<table width="731" height="45" border="1">
 	<tr>
	<%

		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' m3/h' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange >"
		for j = 0 to ubound(rposition)
			if rposition(j) = i then
				if szparsestring(rmultiplier(j), ";", 1) = "RANGE" then
					minvalue = szparsestring(rmultiplier(j), ";", 2)
					maxvalue = szparsestring(rmultiplier(j), ";", 3)
					colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
				end if
			end if
		next j
		if colorrange = "" then
			colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"		
		end if
		XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
		
	%>
     <td width="882"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="715" height="120" viewastext>
       <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
       <param name="FlashVars" value="">
       <param name="quality" value="high">
       <param name="bgcolor" value="#FFFFFF">
       <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120" flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
     </object></td>
 	</tr>
</table>
<p></p>
		<%
			end if
		case "PRESSURE METER"
			if multiplier(i) = "0" then
		%>
<table width="732" border="1">
  <tr>
    <td width="357"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="359"><div align="center"></div></td>
  </tr>
  <tr>
    <td><div align="center"><%=readings(i)%></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
	
<p></p>
	<% 
	else 
	'XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='bar' baseFontColor='646F8F'  majorTMNumber='11' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='5' minorTMColor='646F8F' minorTMHeight='3' pivotRadius='0' showHoverCap='1' majorTMThickness='1' showGaugeBorder='0' gaugeOuterRadius='150' gaugeInnerRadius='140' gaugeOriginX='210' gaugeOriginY='210' gaugeScaleAngle='280' gaugeAlpha='50' placeValuesInside='1' decimalPrecision='0' displayValueDistance='22' hoverCapBgColor='F2F2FF' hoverCapBorderColor='6A6FA6' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange><color minValue='0' maxValue='" & ulimit(i) & "' code='A1A0FF' /> </colorRange> <dials> 	<dial value='" & readings(i) & "' bgColor='6A6FA6,A1A0FF' borderAlpha='0' baseWidth='5' topWidth='4' /></dials><customObjects>	<objectGroup xPos='210' yPos='210' showBelowChart='1'>	<object type='circle' xPos='0' yPos='0' radius='200' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='000000,2C6BB2, 135FAB' fillAlpha='100,100,100'  fillRatio='80,15, 5' showBorder='1' borderColor='2C6BB2' /><object type='circle' xPos='0' yPos='0' radius='180' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='ffffff, D4D4D4'  fillAlpha='100,100'  fillRatio='20,80' showBorder='1' borderColor='2C6BB2' /><object type='arc' xPos='0' yPos='0' radius='180' innerRadius='170' startAngle='-60' endAngle='240' fillAsGradient='1' fillColor='51884F'  fillAlpha='50' fillRatio='100' showBorder='1' borderColor='51884F' /></objectGroup><objectGroup xPos='210' yPos='210' showBelowChart='0'>	<object type='circle' xPos='0' yPos='0' radius='14' startAngle='0' endAngle='360' borderColor=' bebcb0' fillAsGradient='1' fillColor='A1A0FF,6A6FA6'  fillRatio='70,30' /></objectGroup></customObjects></Chart>"
	XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='bar' baseFontColor='646F8F' baseFontSize='9' majorTMNumber='11' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='5' minorTMColor='646F8F' minorTMHeight='3' pivotRadius='0' showHoverCap='1' majorTMThickness='1' showGaugeBorder='0' gaugeOuterRadius='105' gaugeInnerRadius='100' gaugeOriginX='155' gaugeOriginY='135' gaugeScaleAngle='280' gaugeAlpha='50' placeValuesInside='1' decimalPrecision='0' displayValueDistance='22' hoverCapBgColor='F2F2FF' hoverCapBorderColor='6A6FA6' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange><color minValue='0' maxValue='" & ulimit(i) & "' code='A1A0FF' /></colorRange><dials><dial value='" & readings(i) & "' bgColor='6A6FA6,A1A0FF' borderAlpha='0' baseWidth='5' topWidth='4' /></dials><customObjects><objectGroup xPos='155' yPos='135' showBelowChart='1'><object type='circle' xPos='0' yPos='0' radius='130' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='000000,2C6BB2, 135FAB' fillAlpha='100,100,100'  fillRatio='80,15, 5' showBorder='1' borderColor='2C6BB2' /><object type='circle' xPos='0' yPos='0' radius='120' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='ffffff, D4D4D4'  fillAlpha='100,100'  fillRatio='20,80' showBorder='1' borderColor='2C6BB2' /><object type='arc' xPos='0' yPos='0' radius='120' innerRadius='115' startAngle='-60' endAngle='240' fillAsGradient='1' fillColor='51884F'  fillAlpha='50' fillRatio='100' showBorder='1' borderColor='51884F' /></objectGroup><objectGroup xPos='155' yPos='135' showBelowChart='0'><object type='circle' xPos='0' yPos='0' radius='5' startAngle='0' endAngle='360' borderColor=' bebcb0' fillAsGradient='1' fillColor='A1A0FF,6A6FA6'  fillRatio='70,30' /></objectGroup></customObjects></Chart>"

	%>
<table width="732" border="1">
  <tr>
    <td width="308"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="489"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>"><% = equipname(i)%></a></div></td>
  </tr>
  <tr>
    <td>		
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" WIDTH="302" HEIGHT="270" VIEWASTEXT>
			<param NAME="movie" VALUE="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250">
			<param NAME="FlashVars" VALUE="">
			<param NAME="quality" VALUE="high">
			<param NAME="bgcolor" VALUE="#FFFFFF">
			<embed src="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250" FlashVars="" quality="high" bgcolor="#FFFFFF" WIDTH="425" HEIGHT="425" NAME="FusionCharts" ALIGN TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
	  </object>	</td>
    	<% 
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' numberSuffix=' pa' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='" & ulimit(i) -1 & "' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='bar' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='11'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
		%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="300" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>
	<table width="732" height="45" border="1">
 	<tr>
	<%
			
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' bar' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange >"
		for j = 0 to ubound(rposition)
			if rposition(j) = i then
				if szparsestring(rmultiplier(j), ";", 1) = "RANGE" then
					minvalue = szparsestring(rmultiplier(j), ";", 2)
					maxvalue = szparsestring(rmultiplier(j), ";", 3)
					colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
				end if
			end if
		next j
		if colorrange = "" then
			colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"		
		end if
		XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"		
	%>
     <td width="882"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="715" height="120" viewastext>
       <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
       <param name="FlashVars" value="">
       <param name="quality" value="high">
       <param name="bgcolor" value="#FFFFFF">
       <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120" flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
     </object></td>
 	</tr>
</table>
<p></p>
		        
        <%
			end if
		case "PH ANALYZER"
			if multiplier(i) = "0" then
		%>
<table width="732" border="1">
  <tr>
    <td width="370"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="346"><div align="center"></div></td>
  </tr>
  <tr>
    <td><div align="center"><%=readings(i)%></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
	
<p></p>
	<% 
	else 
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='1' numberSuffix='pH' baseFont='Verdana'  showTickMarks='1' showTickValues='1' majorTMNumber='14' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='2' minorTMColor='646F8F' minorTMHeight='3' majorTMThickness='1' decimalPrecision='0' ledGap='2' ledSize='2' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' realTimeValueFontSize='15' > <colorRange> <color minValue='0' maxValue='20' code='00dd00' /> </colorRange> <customObjects> <objectGroup showBelowChart='0'>  <object type='line' xPos='101' yPos='15' toXPos='101' toYPos='213' color='000000' lineThickness='3' /> </objectGroup> </customObjects> <value>" & readings(i) & "</value></Chart>"
	%>
<table width="733" border="1">
  <tr>
    <td width="307"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="490"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>"><% = equipname(i)%></a></div></td>
  </tr>
  <tr>
    <td> <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" WIDTH="302" HEIGHT="270" VIEWASTEXT>
			<param NAME="movie" VALUE="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250">
			<param NAME="FlashVars" VALUE="">
			<param NAME="quality" VALUE="high">
			<param NAME="bgcolor" VALUE="#FFFFFF">
			<embed src="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250" FlashVars="" quality="high" bgcolor="#FFFFFF" WIDTH="240" HEIGHT="250" NAME="FusionCharts" ALIGN TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">

			</object></td>
        <% 
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' yAxisMinValue='1' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='12' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='pH' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='11'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
		%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="300" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>		        
	<table width="732" height="45" border="1">
 	<tr>
	<%
				
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' pH' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange >"
		for j = 0 to ubound(rposition)
			if rposition(j) = i then
				if szparsestring(rmultiplier(j), ";", 1) = "RANGE" then
					minvalue = szparsestring(rmultiplier(j), ";", 2)
					maxvalue = szparsestring(rmultiplier(j), ";", 3)
					colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
				end if
			end if
		next j
		if colorrange = "" then
			colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"		
		end if
		XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"

	%>
     <td width="722"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="715" height="120" viewastext>
       <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
       <param name="FlashVars" value="">
       <param name="quality" value="high">
       <param name="bgcolor" value="#FFFFFF">
       <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=120" flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
     </object></td>
 	</tr>
</table>
<p></p>

        <%
			end if
		case "CHLORINE ANALYZER"
			if multiplier(i) = "0" then
		%>
<table width="735" border="1">
  <tr>
    <td width="367"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="352"><div align="center"></div></td>
  </tr>
  <tr>
    <td><div align="center"><%=readings(i)%></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
	
<p></p>
	<% 
		else 
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='mg/l' baseFont='Verdana'  showTickMarks='1' showTickValues='1' majorTMNumber='5' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='2' minorTMColor='646F8F' minorTMHeight='3' majorTMThickness='1' decimalPrecision='0' ledGap='2' ledSize='2' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' realTimeValueFontSize='15' > <colorRange> <color minValue='0' maxValue='20' code='00dd00' /> </colorRange> <customObjects> <objectGroup showBelowChart='0'>  <object type='line' xPos='101' yPos='15' toXPos='101' toYPos='213' color='000000' lineThickness='3' /> </objectGroup> </customObjects> <value>" & readings(i) & "</value></Chart>"
	%>
<table width="735" border="1">
  <tr>
    <td width="304"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="494"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>"><% = equipname(i)%></a></div></td>
  </tr>
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" WIDTH="302" HEIGHT="270" VIEWASTEXT>
			<param NAME="movie" VALUE="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250">
			<param NAME="FlashVars" VALUE="">
			<param NAME="quality" VALUE="high">
			<param NAME="bgcolor" VALUE="#FFFFFF">
			<embed src="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250" FlashVars="" quality="high" bgcolor="#FFFFFF" WIDTH="240" HEIGHT="250" NAME="FusionCharts" ALIGN TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">

			</object></td>
        <% 
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='4' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='mg/l' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='11'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
		%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="300" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>
	<table width="733" height="45" border="1">
 	<tr>
	<%
			
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' ch' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange >"
		for j = 0 to ubound(rposition)
			if rposition(j) = i then
				if szparsestring(rmultiplier(j), ";", 1) = "RANGE" then
					minvalue = szparsestring(rmultiplier(j), ";", 2)
					maxvalue = szparsestring(rmultiplier(j), ";", 3)
					colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
				end if
			end if
		next j
		if colorrange = "" then
			colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"		
		end if
		XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
		
	%>
     <td width="723"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="715" height="120" viewastext>
       <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
       <param name="FlashVars" value="">
       <param name="quality" value="high">
       <param name="bgcolor" value="#FFFFFF">
       <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=120" flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
     </object></td>
 	</tr>
</table>		        
<p></p>

        <%
			end if
		case "TURBIDITY"
			if multiplier(i) = "0" then
		%>
<table width="731" border="1">
  <tr>
    <td width="352"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="363"><div align="center"></div></td>
  </tr>
  <tr>
    <td><div align="center"><%=readings(i)%></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
	
<p></p>
	<% 
	else 
		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='NTU' baseFont='Verdana'  showTickMarks='1' showTickValues='1' majorTMNumber='11' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='2' minorTMColor='646F8F' minorTMHeight='3' majorTMThickness='1' decimalPrecision='0' ledGap='2' ledSize='2' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' realTimeValueFontSize='15' > <colorRange> <color minValue='0' maxValue='20' code='00dd00' /> </colorRange> <customObjects> <objectGroup showBelowChart='0'>  <object type='line' xPos='101' yPos='15' toXPos='101' toYPos='213' color='000000' lineThickness='3' /> </objectGroup> </customObjects> <value>" & readings(i) & "</value></Chart>"
	%>
<table width="731" border="1">
  <tr>
    <td width="305"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="492"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>"><% = equipname(i)%></a></div></td>
  </tr>
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" WIDTH="302" HEIGHT="270" VIEWASTEXT>
			<param NAME="movie" VALUE="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250">
			<param NAME="FlashVars" VALUE="">
			<param NAME="quality" VALUE="high">
			<param NAME="bgcolor" VALUE="#FFFFFF">
			<embed src="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250" FlashVars="" quality="high" bgcolor="#FFFFFF" WIDTH="240" HEIGHT="250" NAME="FusionCharts" ALIGN TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">

			</object></td>
        <% 
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='9' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='NTU' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='11'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
		%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="300" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>
	<table width="727" height="45" border="1">
 	<tr>
	<%

		XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' NTU' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"'><colorRange >"
		for j = 0 to ubound(rposition)
			if rposition(j) = i then
				if szparsestring(rmultiplier(j), ";", 1) = "RANGE" then
					minvalue = szparsestring(rmultiplier(j), ";", 2)
					maxvalue = szparsestring(rmultiplier(j), ";", 3)
					colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
				end if
			end if
		next j
		if colorrange = "" then
			colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"		
		end if
		XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
		

	%>
     <td width="888"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="715" height="120" viewastext>
       <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
       <param name="FlashVars" value="">
       <param name="quality" value="high">
       <param name="bgcolor" value="#FFFFFF">
       <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120" flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
     </object></td>
 	</tr>
</table>		        
<p></p>

        <%
			end if
		case "TIME"
		%>
<table width="730" border="1">
<tr>
<td width="355" height="55"><div align="left">
  <p align="right">Timestamp (DD/MM/YY HH:MM:SS) : </p>
  </div></td>
<td width="359"><div align="center"><%=szparsestring(sequence, "/", 2) & "/" & szparsestring(sequence, "/", 1) & "/" & szparsestring(sequence, "/", 3)%></div></td>
</tr>
</table>
<p></p>
        <%
		end select
		colorrange = ""
	next i
%>
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</body>
</html>