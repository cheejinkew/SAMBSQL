<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %> 
<%@ Register TagPrefix="chart" Namespace="ChartDirector" Assembly="netchartdir" %>
<%
	dim SiteID = request.Form("siteid")
	dim SiteName = request.Form("sitename")
	dim District = request.Form("district")
	dim Position = request.Form("position")
	dim EquipName = request.Form("equipname")	

	dim startdate as string
	dim enddate as string
	dim trendstart as string
	dim trendend as string
	dim heading as string
	
	startdate = request.Form("txtBeginDate") & " " & request.Form("ddBeginHour") & ":" & request.Form("ddBeginMinute") & ":00"
	enddate = request.Form("txtEndDate") & " " & request.Form("ddEndHour") & ":" & request.Form("ddEndMinute") & ":00"
		
	if SiteID = "" then
		SiteID = request.querystring("siteid")
		SiteName = request.QueryString("sitename")
		District = request.QueryString("district")
		Position = request.QueryString("position")
		EquipName = request.QueryString("equipname")
		startdate = request.QueryString("startdate")
		enddate = request.QueryString("enddate")
		trendstart = request.QueryString("trendstart")
		trendend = request.QueryString("trendend")
		heading = request.QueryString("heading")
	end if
		
	if trendstart = "" then
		trendstart = startdate
		trendend = dateadd("h", -8, trendstart)
	else
		if heading = "b" then
			trendstart = trendend
			trendend = dateadd("h", -8, trendstart)
		else
			trendend = trendstart
			trendstart =dateadd("h", +8, trendstart)
		end if
	end if
	
	dim strConn
	dim objConn
	dim rsRecords
	dim values(0) as double
	dim sequence(0) as string
	dim i as integer
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
   	objConn.open(strConn)
	response.Write("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & position & "' and sequence between '" & trendend & "' and '" & trendstart & "' order by sequence desc")
'	rsRecords.Open("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & position & "' and sequence between '" & startdate & "' and '" & enddate & "' order by sequence desc",objConn)
	rsRecords.Open("select value, sequence from telemetry_log_table where siteid='" & SiteID & "' and position ='" & position & "' and sequence between '" & trendend & "' and '" & trendstart & "' order by sequence desc",objConn)
	'if rsrecords.eof = true then exit sub
   	do while not rsRecords.EOF
		values(i) = rsrecords.fields("value").value
		sequence(i) = rsrecords.fields("sequence").value
		i = i + 1
		redim preserve values(i)
		redim preserve sequence(i)
		rsrecords.movenext
	loop
	rsrecords.close
	rsrecords = nothing
	
	dim minValue as integer
	dim Suffix as string
	if instr(1, equipname, "Flowmeter") > 0 then
		Suffix = "m3/h"
		minvalue = 0
	end if
	
	if instr(1, equipname, "Pressure") > 0 then
		Suffix = "bar"
		minvalue = 0
	end if

	if instr(1, equipname, "Tank") > 0 then
		Suffix = "m"
		minvalue = 0
	end if

	if instr(1, equipname, "Turbidity") > 0 then
		Suffix = "NTU"
		minvalue = 0
	end if
	
	if instr(1, equipname, "pH") > 0 then
		Suffix = "pH"
		minvalue = 1
	end if
	
	if instr(1, equipname, "Chlorine") > 0 then
		Suffix = "ch"
		minvalue = 0
	end if
		
	'for i = 0 to 20
	'	values(i) = i
	'	sequence(i) = i
	'	redim preserve values(i)
	'	redim preserve sequence(i)		
	'next i
	    'The data for the line chart
	on error resume next
    'The labels for the line chart

    'Create a XYChart object of size 250 x 250 pixels
    Dim c As XYChart = New XYChart(650, 450)

    'Set the plotarea at (30, 20) and of size 200 x 200 pixels
    c.setPlotArea(90, 20, 550, 350)

    'Add a line chart layer using the given data
    c.addLineLayer(values)

    'Set the labels on the x axis.
	c.xAxis().setLabels(sequence).setFontAngle(90)    
	'Display 1 out of 3 labels on the x-axis.
    c.xAxis().setLabelStep(10)

    'output the chart
    WebChartViewer1.Image = c.makeWebImage(Chart.PNG)

    'include tool tip for the chart
    WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
    "title='Time {xLabel}: Water Level {value} meter'")
	
	
%>

<h1>Trending Details </h1>
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
    <td height="479">
		<chart:WebChartViewer id="WebChartViewer1" runat="server" />
	</td>
  </tr>
</table>
<table width="728" border="1">
  <tr>
    <td width="215"><div align="center"><a href="TrendReport.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname%>&position=<%=position%>&startdate=<%=startdate%>&enddate=<%=enddate%>&trendstart=<%=trendstart%>&trendend=<%=trendend%>&heading=b"><%=trendend %></a></div></td>
    <td width="286">&nbsp;</td>
    <td width="205"><div align="center"><a href="TrendReport.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname%>&position=<%=position%>&startdate=<%=startdate%>&enddate=<%=enddate%>&trendstart=<%=trendstart%>&trendend=<%=trendend%>&heading=f"><%=trendstart %></a></div></td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="729" height="989" border="1">
  <tr>
    <td width="729" height="35"><table width="723" border="1">
        <tr>
          <td width="202">Event Analysis from </td>
          <td width="217"><div align="center"><%=startdate%> </div></td>
          <td width="62"><div align="center">To</div></td>
          <td width="214"><div align="center"><%=enddate%> </div></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="446"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="721" height="444" id="FusionCharts" viewastext>
        <param name="movie" value="Charts/FC_2_3_Pie2D.swf?currTime=9%2F22%2F2005+1%3A34%3A38+PM&amp;dataUrl=Gallery/Data/Pie2D_1.xml&amp;chartWidth=350&amp;chartHeight=250">
        <param name="FlashVars" value="">
        <param name="quality" value="high">
        <param name="bgcolor" value="#FFFFFF">
        <embed src="Charts/FC_2_3_Pie2D.swf?currTime=9%2F22%2F2005+1%3A34%3A38+PM&amp;dataUrl=Gallery/Data/Pie2D_1.xml&amp;chartWidth=350&amp;chartHeight=250" flashvars="" quality="high" bgcolor="#FFFFFF" width="721" height="444" name="FusionCharts" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
    </object></td>
  </tr>
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="723" height="500" viewastext>
        <param name="movie" value="Charts/FC_2_3_SSGrid.swf?currTime=9%2F22%2F2005+1%3A34%3A38+PM&amp;dataUrl=Gallery/Data/Pie2D_1.xml&amp;chartWidth=350&amp;chartHeight=150">
        <param name="FlashVars" value="&alternateRowBgColor=CCCC00&alternateRowBgAlpha=10&listRowDividerColor=FFAF00&listRowDividerAlpha=70&navButtonColor=FFAF00&navButtonHoverColor=CCCC00">
        <param name="quality" value="high">
        <param name="bgcolor" value="#FFFFFF">
        <embed src="Charts/FC_2_3_SSGrid.swf?currTime=9%2F22%2F2005+1%3A34%3A38+PM&amp;dataUrl=Gallery/Data/Pie2D_1.xml&amp;chartWidth=350&amp;chartHeight=150" flashvars="&alternateRowBgColor=CCCC00&alternateRowBgAlpha=10&listRowDividerColor=FFAF00&listRowDividerAlpha=70&navButtonColor=FFAF00&navButtonHoverColor=CCCC00" quality="high" bgcolor="#FFFFFF" width="723" height="500" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
    </object></td>
  </tr>
</table>
<p>&nbsp;</p>
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

