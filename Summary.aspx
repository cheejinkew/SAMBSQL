<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<script language="VB" runat="server">

    Function szParseString(szString As String, szDelimiter As String, nSegmentNumber As Integer)
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

</script>
<%
    Dim SiteID = Request.QueryString("siteid")
    Dim SiteName = Request.QueryString("sitename")
    Dim District = Request.QueryString("district")
    Dim SiteType = Request.QueryString("sitetype")
    Dim Message = Request.QueryString("smessage")
    If Message = "" Then
        Message = "&nbsp;"
    End If
%>
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
   <script src="js/jQuery-2.1.4.min.js"></script>
<script src="js/fusioncharts.charts.js"></script>
    <script src="js/FusionCharts.js"></script>
    <script src="js/fusioncharts.theme.fint.js"></script>
    <link rel="StyleSheet" type="text/css" href="main.css" title="Contemporary" />
    <script language="javascript">

        function loadleft() {
            var obj = document.polling;
            obj.action = "left.aspx";
            obj.target = "contents";
            obj.submit();
        }
    </script>
</head>
<body onload="loadleft();">
    <form name="polling" method="post" action="smspoll.aspx">
    <div align="center">
        <table border="0" cellpadding="0" cellspacing="0" width="70%">
            <tr>
                <td width="100%" height="30" colspan="4">
                    <p align="center">
                        <img border="0" src="images/SiteSummary.jpg">
                </td>
                <tr>
                    <td align="center">
                        <div id="Error">
                            <font color="green" size="1" face="Verdana"><b>
                                <%=Message%></b></font></div>
                    </td>
                </tr>
        </table>
    </div>
    <%
        Dim objConn
        Dim rsRecords
        Dim strConn
        Dim strComment
        Dim strAddress
        Dim strImagePath
        Dim sequence As String
        Dim multi = ""
      
        If SiteType = "RESERVOIR" Then
            multi = "multi"
        End If

        strConn = ConfigurationSettings.AppSettings("DSNPG")
        objConn = New ADODB.Connection()
        rsRecords = New ADODB.Recordset()

	

        objConn.open(strConn)

        rsRecords.Open("select address, comment, image_path " & _
                       "from telemetry_site_list_table where siteid='" & SiteID & "'", objConn)
             
        If Not rsRecords.EOF Then
            strComment = rsRecords("comment").value
            strAddress = rsRecords("address").value
            strImagePath = "images/UploadedImages/" & rsRecords("image_path").value
        Else
            Response.Write("<center><font class='bodytxt'><b>" & "Please Select Site from the left Menu !" & "</b></font></center>")
        End If
         
         
        rsRecords.close()
        objConn.close()
             
        If Session("login") Is Nothing Then
            Response.Redirect("login.aspx")
        End If
        Dim a = "Water Level Trending"
        Dim hreflink As String = ""
        Dim hreflink1 As String = "Trending.aspx?equipname=" & a & "&sitetype=" & SiteType & "&siteid=" & SiteID & "&sitename=" & SiteName & "&district=" & District & "&position=2"
        Select Case SiteType
            Case "RESERVOIR"
                hreflink = "cascadeReservoir.aspx?siteid=" & SiteID & "&sitename=" & SiteName & "&district=" & District
            Case "WTP"
                hreflink = "cascadeWTP.aspx?siteid=" & SiteID & "&sitename=" & SiteName & "&district=" & District
            Case "BPH"
                hreflink = "cascadeBPH.aspx?siteid=" & SiteID & "&sitename=" & SiteName & "&district=" & District
            Case Else
                hreflink = "cascadeReservoir.aspx?siteid=" & SiteID & "&sitename=" & SiteName & "&district=" & District
        End Select
        If SiteID = "" Then Exit Sub
    %>
    <table width="714px" height="100px" border="1">
        <tr>
            <td>
                <table width="300px">
                    <tr>
                        <td style="width: 77px">
                            <div style="font-size: 15;" align="left">
                                District :
                            </div>
                        </td>
                        <td>
                            <input type="text" name="district" value="<%=district%>" readonly style="width: 200px">
                        </td>
                        <tr>
                            <td style="width: 77px">
                                <div style="font-size: 15;" align="left">
                                    Site ID :
                                </div>
                            </td>
                            <td>
                                <input type="text" name="siteid" value="<%=siteid%>" readonly style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 85px">
                                <div style="font-size: 15;" align="left">
                                    Site Name :
                                </div>
                            </td>
                            <td>
                                <input type="text" name="sitename" value="<%=sitename%>" readonly style="width: 200px">
                            </td>
                </table>
            </td>
            <td>
                <table width="414px">
                    <tr>
                        <td bordercolor="#ffffff" style="width: 99px; height: 21px; font-weight: bold;">
                            Timestamp :
                        </td>
                        <td style="width: 200px; height: 21px; font-weight: bold;">
                            <div id="_timestamp">
                                <%=szparsestring(sequence, "/", 2) & "/" & szparsestring(sequence, "/", 1) & "/" & szparsestring(sequence, "/", 3)%></div>
                        </td>
                    </tr>
                    <tr>
                        <td bordercolor="#ffffff" style="width: 120px; font-size: 15;">
                            Polling method :
                        </td>
                        <td style="width: 178px">
                            <select name="pollmethod" id="pollmethod" style="width: 143px; font-size: 15;">
                                <option>SMS</option>
                                <option>GPRS</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td bordercolor="#000000" style="width: 99px">
                            Password :
                        </td>
                        <td style="width: 178px">
                            <input name="password" type="password" id="password2" maxlength="10">
                        </td>
                        <td>
                            <div>
                                <input type="submit" name="Submit" value="Submit"></div>
                        </td>
                    </tr>
                </table>
            </td>
    </table>
    <%	

        objConn.open(strConn)
        Dim refreshinterval As Integer
        Dim equiplist(0) As String
        Dim equipname(0) As String
        Dim equipdesc(0) As String
        Dim multiplier(0) As String
        Dim ulimit(0) As String
        Dim i As Integer
        refreshinterval = 20
        rsRecords.Open("select sdesc, equipname, equiptype, multiplier, max from telemetry_equip_list_table where siteid='" & SiteID & "' order by position", objConn)
        Do While Not rsRecords.EOF
            equiplist(i) = rsRecords.fields("equiptype").value
            equipname(i) = rsRecords.fields("equipname").value
            equipdesc(i) = rsRecords.fields("sdesc").value
            multiplier(i) = rsRecords.fields("multiplier").value
            ulimit(i) = rsRecords.fields("max").value
            i = i + 1
            ReDim Preserve equiplist(i)
            ReDim Preserve equipname(i)
            ReDim Preserve equipdesc(i)
            ReDim Preserve multiplier(i)
            ReDim Preserve ulimit(i)
		
            rsRecords.MoveNext()
        Loop
        rsRecords.close()
	
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        i = 0
        rsRecords.Open("select multiplier, position, alarmtype, colorcode from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc", objConn)
        Do While Not rsRecords.EOF
            rmultiplier(i) = rsRecords.fields("multiplier").value
            rposition(i) = rsRecords.fields("position").value
            ralarmtype(i) = rsRecords.fields("alarmtype").value
            rcolorcode(i) = rsRecords.fields("colorcode").value
            i = i + 1
            ReDim Preserve rmultiplier(i)
            ReDim Preserve rposition(i)
            ReDim Preserve ralarmtype(i)
            ReDim Preserve rcolorcode(i)
            rsRecords.MoveNext()
        Loop
        rsRecords.close()
	
        Dim events(2) As String
        Dim readings(2) As String

        rsRecords.Open("select dtimestamp, value, sevent from telemetry_equip_status_table where siteid='" & SiteID & "' order by position", objConn)
        If rsRecords.eof = False Then
            i = 2
            Do While Not rsRecords.EOF
                events(i) = rsRecords.fields("sevent").value
                sequence = rsRecords.fields("dtimestamp").value
                readings(i) = rsRecords.fields("value").value
                If readings(i) < 0 Then readings(i) = 0
                i = i + 1
                ReDim Preserve events(i)
                ReDim Preserve readings(i)
                rsRecords.movenext()
            Loop
        Else
            Response.Write("Data Not Available")
            Exit Sub
        End If
        rsRecords.close()
	
        rsRecords = Nothing
        objConn.close()
        objConn = Nothing
        Dim XMLData As String
        Dim minvalue As String
        Dim maxvalue As String
        Dim j As Integer
	
        For i = 0 To UBound(equiplist)
            Dim colorrange
            Select Case equiplist(i)
                Case "LEVEL METER"
                    If multiplier(i) = "0" Then
    %>
    </form>
    <table width="732" border="1">
        <tr>
            <td style="width: 364px; height: 23px;">
                <div align="center" style="font-size: 20;">
                    <% =equipdesc(i)%>
                </div>
            </td>
            <td width="356" style="height: 23px">
                <div align="center">
                </div>
            </td>
        </tr>
        <tr>
            <td style="width: 364px">
                <div align="center">
                    <%=readings(i)%></div>
            </td>
        </tr>
    </table>
    <% 
    Else
        XMLData = "<Chart upperLimit='" & ulimit(i) & "' showBorder='0' tickMarkGap='5' bgColor='FBFBFB' lowerLimit='0' majorTMNumber='5' chartTopMargin='20' baseFontColor='000000' baseFontSize='11' minorTMColor='000000' majorTMColor='000000'  minorTMNumber='2' majorTMThickness='1' decimalPrecision='3' tickMarkDecimalPrecision='0' tickMarkGap='5' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' cylColor='9B72CF' cylFillColor='33FFFF' showValue='1' numberSuffix=' meter'><value>" & readings(i) & "</value><annotations><annotationGroup><annotation type='text' label='Water Level: " & readings(i) & " meters' font='Verdana' xPos='120' yPos='0' align='center' vAlign='center' fontcolor='333333' fontSize='10' isBold='1'/></annotationGroup></annotations></Chart>"
				
    %>
    <table width="730" border="1">
        <tr>
            <td width="305">
                <div align="center">
                    <%=equipdesc(i)%></div>
            </td>
            <%  If multi = "multi" Then%>
            <td>
                <div class="TabView" id="TabView" style="width: 350px;">
                    <div style="cursor: hand;" class="Tabs" style="width: 300px;">
                        <a title="click to see Picture" id="pic" style="background-color: #AAB9FD;" onclick="javascript:display1();">
                            Picture </a><a id="tre" title="click to see Trending" style="background-color: white"
                                onclick="javascript:display2();">Trending</a></div>
                </div>
            </td>
            <%Else%>
            <td>
                <div align="center">
                    <a href="<%=hreflink1%>" target="main">Trending Selection</a></div>
            </td>
            <%  End If%>
        </tr>
        <tr>
            <td height="279" rowspan="3">
                <div id="chart-container1" align="center">
                </div>
                <script type="text/javascript">
                    FusionCharts.ready(function () {
                        var fuelVolume = <%=readings(i)%>,
                    fuelWidget = new FusionCharts({
                        
                        type: 'cylinder',
                        dataFormat: 'json',
                        id: 'fuelMeter',
                        renderAt: 'chart-container1',
                        width: '100%',
                        height: '250',
                        dataSource: {
                            "chart": {
                                "caption":'<% =equipdesc(i) %>'+ "["+ '<%=readings(i)%>'+" M]",
                                "subcaptionFontBold": "0",
                                "lowerLimit": "0",
                                "upperLimit": "10",
                                "lowerLimitDisplay": "E",
                                "upperLimitDisplay": "F",
                                "numberSuffix": "M",
                                "showValue": "0",
                                "showhovereffect": "1",
                                "bgCOlor": "#ffffff",
                                "borderAlpha": "0",
                                "cylFillColor": "#008ee4"
                            },
                            "value":  <%=readings(i)%>
                        },
                        "events": {
                            "rendered": function (evtObj, argObj) {
                                setInterval(function () {
                                    fuelVolume = <%=readings(i)%>
                                }, 1000);
                            }
                        }
                    }).render();
                    });

                </script>
            </td>
            <% 
                XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='" & ulimit(i) - 1 & "' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' numberSuffix='m' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
            %>
            <td>
                <%
                    If SiteType <> "RESERVOIR" Then
                %>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="410" height="300" viewastext>
                    <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=400"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
                <%Else%>
                <div id="image1" style="visibility: hidden; display: none;">
                    <img src="<%=strImagePath%>" width="400" height="300">
                </div>
                <div id="trending" style="margin-right: 0px; overflow: auto; overflow-x: hidden;">
                    <iframe id="trendingframe" width="400" height="360" marginheight="0" marginwidth="0"
                        scrolling="auto" style="left: 0;" frameborder="0"></iframe>
                </div>
                <%End If%>
            </td>
        </tr>
        <tr>
            <td>
                <font size="3"><b>Address : </b>
                    <%=strAddress%></font>
            </td>
        </tr>
        <tr>
            <td>
                <font size="3"><b>Comment : </b>
                    <%=strComment%></font>
            </td>
        </tr>
    </table>
    <table width="730" height="45" border="1">
        <tr>
            <%
		
                XMLData = "<Chart upperLimit='" & ulimit(i) & "' gaugeFillMix='{color},{FFFFFF}' gaugeFillRatio='50,50' lowerLimitDisplay='0' showLimits='1' lowerLimit='0' bgAlpha='10'  BorderColor='333333' bgColor='FBFBFB' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' majorTMColor='000000' pointerOnTop='1' showRealTimeValue='1' showLimits='1' showBorder='0' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3'  pointerBgColor='FF3333' gaugeRoundRadius='5' pointerRadius='10' numberSuffix=' meter' chartLeftMargin='30' chartRightMargin='30' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange >"
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
                            colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
                        End If
                    End If
                Next j
                If colorrange = "" Then
                    colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"
                End If
                XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value>"
                XMLData = XMLData & "<styles><definition><style name='limitFont' type='Font' bold='1'/><style name='labelFont' type='Font' bold='1' size='10' color='000000'/></definition><application><apply toObject='GAUGELABELS' styles='labelFont' /><apply toObject='LIMITVALUES' styles='limitFont' /></application></styles></Chart>"
		
            %>
            <td width="882">
                <div id="chartdiv" align="center">
                </div>
                <script type="text/javascript">
                    var myChart = new FusionCharts("Charts/HLinearGauge.swf", "chartdiv", "700", "100", "0", "0");
                    myChart.setDataXML("<%=XMLData%>");
                    myChart.render("chartdiv");
                </script>
            </td>
        </tr>
    </table>
    <table width="729" border="1">
        <tr>
            <td>
                <div align="center">
                    Rules Details</div>
            </td>
            <%
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
            %>
            <td>
                <div align="center">
                    <%=ralarmtype(j)%></div>
            </td>
            <td>
                <div align="center">
                    <%=minvalue & " To " & maxvalue%></div>
            </td>
            <%
            End If
        End If
    Next j
            %>
        </tr>
    </table>
    <%
    End If
Case "FLOW METER"
    If multiplier(i) = "0" Then
    %>
    <%--<table width="731" border="1">
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
</table>--%>
    <% 
    Else
		
        XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='m3/h' baseFontColor='646F8F' baseFontSize='9' majorTMNumber='11' majorTMColor='646F8F' majorTMHeight='9' minorTMNumber='5' minorTMColor='646F8F' minorTMHeight='3' pivotRadius='0' showHoverCap='1' majorTMThickness='1' showGaugeBorder='0' gaugeOuterRadius='105' gaugeInnerRadius='100' gaugeOriginX='155' gaugeOriginY='135' gaugeScaleAngle='280' gaugeAlpha='50' placeValuesInside='1' decimalPrecision='0' displayValueDistance='22' hoverCapBgColor='F2F2FF' hoverCapBorderColor='6A6FA6' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange><color minValue='0' maxValue='" & ulimit(i) & "' code='A1A0FF' /></colorRange><dials><dial value='" & readings(i) & "' bgColor='6A6FA6,A1A0FF' borderAlpha='0' baseWidth='5' topWidth='4' /></dials><customObjects><objectGroup xPos='155' yPos='135' showBelowChart='1'><object type='circle' xPos='0' yPos='0' radius='130' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='000000,2C6BB2, 135FAB' fillAlpha='100,100,100'  fillRatio='80,15,5' showBorder='1' borderColor='2C6BB2' /><object type='circle' xPos='0' yPos='0' radius='120' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='ffffff, D4D4D4' fillAlpha='100,100' fillRatio='20,80' showBorder='1' borderColor='2C6BB2' /><object type='arc' xPos='0' yPos='0' radius='120' innerRadius='115' startAngle='-60' endAngle='240' fillAsGradient='1' fillColor='51884F' fillAlpha='50' fillRatio='100' showBorder='1' borderColor='51884F' /></objectGroup><objectGroup xPos='155' yPos='135' showBelowChart='0'><object type='circle' xPos='0' yPos='0' radius='5' startAngle='0' endAngle='360' borderColor=' bebcb0' fillAsGradient='1' fillColor='A1A0FF,6A6FA6' fillRatio='70,30' /></objectGroup></customObjects></Chart>"

    %>
    <%--<table width="731" border="1">
  <tr>
    <td width="305"><div align="center"><% = equipdesc(i) %></div></td>
    <td width="492"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>&sitetype=<%=SiteType%>&equipdesc=<%=equipdesc(i)%>"><% = equipname(i)%></a></td>
  </tr>
  <tr>
    <td>
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="302" height="270" viewastext>
      <param name="movie" value="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250">
      <param name="FlashVars" value="">
      <param name="quality" value="high">
      <param name="bgcolor" value="#FFFFFF">
      <embed src="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250" flashvars="" quality="high" bgcolor="#FFFFFF" width="425" height="270" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
    </object> </td>
    	<% 
          XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='9' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='m3/h' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
	%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="350" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=430">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=410" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>--%>
    <table width="731" height="45" border="1">
        <tr>
            <%

                XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' m3/h' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange >"
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
                            colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
                        End If
                    End If
                Next j
                If colorrange = "" Then
                    colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"
                End If
                XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
		
            %>
            <td width="882">
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="715" height="120" viewastext>
                    <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="729" border="1">
        <tr>
            <td>
                <div align="center">
                    Rules Details</div>
            </td>
            <%
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
            %>
            <td>
                <div align="center">
                    <%=ralarmtype(j)%></div>
            </td>
            <td>
                <div align="center">
                    <%=minvalue & " To " & maxvalue%></div>
            </td>
            <%
            End If
        End If
    Next j
            %>
        </tr>
    </table>
    <%
    End If
Case "PRESSURE METER"
    If multiplier(i) = "0" Then
    %>
    <table width="732" border="1">
        <tr>
            <td width="357">
                <div align="center">
                    <% = equipdesc(i) %>
                </div>
            </td>
            <td width="359">
                <div align="center">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div align="center">
                    <%=readings(i)%></div>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <% 
    Else
        XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='bar' baseFontColor='646F8F' baseFontSize='9' majorTMNumber='11' majorTMColor='646F8F' majorTMHeight='9' minorTMNumber='5' minorTMColor='646F8F' minorTMHeight='3' pivotRadius='0' showHoverCap='1' majorTMThickness='1' showGaugeBorder='0' gaugeOuterRadius='105' gaugeInnerRadius='100' gaugeOriginX='155' gaugeOriginY='135' gaugeScaleAngle='280' gaugeAlpha='50' placeValuesInside='1' decimalPrecision='0' displayValueDistance='22' hoverCapBgColor='F2F2FF' hoverCapBorderColor='6A6FA6' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange><color minValue='0' maxValue='" & ulimit(i) & "' code='A1A0FF' /></colorRange><dials><dial value='" & readings(i) & "' bgColor='6A6FA6,A1A0FF' borderAlpha='0' baseWidth='5' topWidth='4' /></dials><customObjects><objectGroup xPos='155' yPos='135' showBelowChart='1'><object type='circle' xPos='0' yPos='0' radius='130' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='000000,2C6BB2, 135FAB' fillAlpha='100,100,100' fillRatio='80,15, 5' showBorder='1' borderColor='2C6BB2' /><object type='circle' xPos='0' yPos='0' radius='120' startAngle='0' endAngle='360' fillAsGradient='1' fillColor='ffffff, D4D4D4'  fillAlpha='100,100' fillRatio='20,80' showBorder='1' borderColor='2C6BB2' /><object type='arc' xPos='0' yPos='0' radius='120' innerRadius='115' startAngle='-60' endAngle='240' fillAsGradient='1' fillColor='51884F' fillAlpha='50' fillRatio='100' showBorder='1' borderColor='51884F' /></objectGroup><objectGroup xPos='155' yPos='135' showBelowChart='0'><object type='circle' xPos='0' yPos='0' radius='5' startAngle='0' endAngle='360' borderColor=' bebcb0' fillAsGradient='1' fillColor='A1A0FF,6A6FA6'  fillRatio='70,30' /></objectGroup></customObjects></Chart>"

    %>
    <table width="732" border="1">
        <tr>
            <td width="308">
                <div align="center">
                    <% = equipdesc(i) %>
                </div>
            </td>
            <td width="489">
                <div align="center">
                    <a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>&sitetype=<%=SiteType%>&equipdesc=<%=equipdesc(i)%>">
                        <% = equipname(i)%></a></div>
            </td>
        </tr>
        <tr>
            <td>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="302" height="270" viewastext>
                    <param name="movie" value="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_Angular.swf?data=<%=XMLData %>&amp;chartWidth=287&amp;chartHeight=250"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="425" height="425" name="FusionCharts"
                        align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                </object>
            </td>
            <% 
                XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' numberSuffix=' pa' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='" & ulimit(i) - 1 & "' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' numberSuffix='bar' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
            %>
            <td>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="410" height="350" viewastext>
                    <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=430">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=410"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="732" height="45" border="1">
        <tr>
            <%
			
                XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' bar' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange >"
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
                            colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
                        End If
                    End If
                Next j
                If colorrange = "" Then
                    colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"
                End If
                XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
            %>
            <td width="882">
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="715" height="120" viewastext>
                    <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="729" border="1">
        <tr>
            <td>
                <div align="center">
                    Rules Details</div>
            </td>
            <%
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
            %>
            <td>
                <div align="center">
                    <%=ralarmtype(j)%></div>
            </td>
            <td>
                <div align="center">
                    <%=minvalue & " To " & maxvalue%></div>
            </td>
            <%
            End If
        End If
    Next j
            %>
        </tr>
    </table>
    <%
    End If
Case "PH ANALYZER"
    If multiplier(i) = "0" Then
    %>
    <table width="732" border="1">
        <tr>
            <td width="370">
                <div align="center">
                    <% = equipdesc(i) %>
                </div>
            </td>
            <td width="346">
                <div align="center">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div align="center">
                    <%=readings(i)%></div>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <% 
    Else
        XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='1' numberSuffix='pH' baseFont='Verdana'  showTickMarks='1' showTickValues='1' majorTMNumber='14' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='2' minorTMColor='646F8F' minorTMHeight='3' majorTMThickness='1' decimalPrecision='0' ledGap='2' ledSize='2' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' realTimeValueFontSize='15' > <colorRange> <color minValue='0' maxValue='20' code='00dd00' /> </colorRange> <customObjects> <objectGroup showBelowChart='0'>  <object type='line' xPos='101' yPos='15' toXPos='101' toYPos='213' color='000000' lineThickness='3' /> </objectGroup> </customObjects> <value>" & readings(i) & "</value></Chart>"
    %>
    <table width="733" border="1">
        <tr>
            <td width="307">
                <div align="center">
                    <% = equipdesc(i) %>
                </div>
            </td>
            <td width="490">
                <div align="center">
                    <a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>&sitetype=<%=SiteType%>&equipdesc=<%=equipdesc(i)%>">
                        <% = equipname(i)%>
                    </a>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="302" height="270" viewastext>
                    <param name="movie" value="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="240" height="250" name="FusionCharts"
                        align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                </object>
            </td>
            <% 
                XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' yAxisMinValue='1' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='12' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' numberSuffix='pH' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
            %>
            <td>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="410" height="350" viewastext>
                    <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=430">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=410"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="732" height="45" border="1">
        <tr>
            <%
				
                XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' pH' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange >"
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
                            colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
                        End If
                    End If
                Next j
                If colorrange = "" Then
                    colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"
                End If
                XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"

            %>
            <td width="722">
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="715" height="120" viewastext>
                    <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=120"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="729" border="1">
        <tr>
            <td>
                <div align="center">
                    Rules Details</div>
            </td>
            <%
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
            %>
            <td>
                <div align="center">
                    <%=ralarmtype(j)%></div>
            </td>
            <td>
                <div align="center">
                    <%=minvalue & " To " & maxvalue%></div>
            </td>
            <%
            End If
        End If
    Next j
            %>
        </tr>
    </table>
    <%
    End If
Case "CHLORINE ANALYZER"
    If multiplier(i) = "0" Then
    %>
    <table width="735" border="1">
        <tr>
            <td width="367">
                <div align="center">
                    <% = equipdesc(i) %>
                </div>
            </td>
            <td width="352">
                <div align="center">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div align="center">
                    <%=readings(i)%></div>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <p>
    </p>
    <% 
    Else
        XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='mg/l' baseFont='Verdana'  showTickMarks='1' showTickValues='1' majorTMNumber='5' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='2' minorTMColor='646F8F' minorTMHeight='3' majorTMThickness='1' decimalPrecision='0' ledGap='2' ledSize='2' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' realTimeValueFontSize='15' > <colorRange> <color minValue='0' maxValue='20' code='00dd00' /> </colorRange> <customObjects> <objectGroup showBelowChart='0'>  <object type='line' xPos='101' yPos='15' toXPos='101' toYPos='213' color='000000' lineThickness='3' /> </objectGroup> </customObjects> <value>" & readings(i) & "</value></Chart>"
    %>
    <table width="735" border="1">
        <tr>
            <td width="304">
                <div align="center">
                    <% = equipdesc(i) %>
                </div>
            </td>
            <td width="494">
                <div align="center">
                    <a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>&sitetype=<%=SiteType%>&equipdesc=<%=equipdesc(i)%>&equipdesc=<%=equipdesc(i)%>">
                        <% = equipname(i)%>
                    </a>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="302" height="270" viewastext>
                    <param name="movie" value="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_VerLed.swf?data=<%=XMLData%>&amp;chartWidth=240&amp;chartHeight=250"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="240" height="250" name="FusionCharts"
                        align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                </object>
            </td>
            <% 
                XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='4' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' numberSuffix='mg/l' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
            %>
            <td>
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="410" height="350" viewastext>
                    <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=430">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=410"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="733" height="45" border="1">
        <tr>
            <%
			
                XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' upperLimitDisplay='" & ulimit(i) & "' lowerLimitDisplay='0' showLimits='1' numberSuffix=' ch' BorderColor='333333' BorderThickness='1' showColorNames='1' showTickValues='1' tickMarkGap='3' pointerSides='3' pointerborderColor='333333' pointerBgColor='FF3333' pointerRadius='10' chartLeftMargin='20' chartRightMargin='20' showRealTimeValue='1' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "'><colorRange >"
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
                            colorrange = colorrange & "<color minValue='" & minvalue & "' maxValue='" & maxvalue & "' name='" & ralarmtype(j) & "' code='" & rcolorcode(j) & "' alpha='50'/>"
                        End If
                    End If
                Next j
                If colorrange = "" Then
                    colorrange = "<color minValue='" & 0 & "' maxValue='" & ulimit(i) & "' name='' code='FFFFF' alpha='50'/>"
                End If
                XMLData = XMLData & colorrange & "</colorRange><value>" & readings(i) & "</value></Chart>"
		
            %>
            <td width="723">
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                    width="715" height="120" viewastext>
                    <param name="movie" value="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=700&amp;chartHeight=120">
                    <param name="FlashVars" value="">
                    <param name="quality" value="high">
                    <param name="bgcolor" value="#FFFFFF">
                    <embed src="Charts/FI2_Linear.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=120"
                        flashvars="" quality="high" bgcolor="#FFFFFF" width="715" height="120" align
                        type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                </object>
            </td>
        </tr>
    </table>
    <table width="729" border="1">
        <tr>
            <td>
                <div align="center">
                    Rules Details</div>
            </td>
            <%
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
            %>
            <td>
                <div align="center">
                    <%=ralarmtype(j)%></div>
            </td>
            <td>
                <div align="center">
                    <%=minvalue & " To " & maxvalue%></div>
            </td>
            <%
            End If
        End If
    Next j
            %>
        </tr>
    </table>
    <%
    End If
Case "TURBIDITY"
    If multiplier(i) = "0" Then
    %>
    <%--<table width="731" border="1">
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
</table>--%>
    <% 
    Else
        XMLData = "<Chart upperLimit='" & ulimit(i) & "' lowerLimit='0' numberSuffix='NTU' baseFont='Verdana'  showTickMarks='1' showTickValues='1' majorTMNumber='11' majorTMColor='646F8F'  majorTMHeight='9' minorTMNumber='2' minorTMColor='646F8F' minorTMHeight='3' majorTMThickness='1' decimalPrecision='0' ledGap='2' ledSize='2' dataStreamURL='RealTimeDataFeed.aspx?siteid=" & SiteID & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval & "' realTimeValueFontSize='15' > <colorRange> <color minValue='0' maxValue='20' code='00dd00' /> </colorRange> <customObjects> <objectGroup showBelowChart='0'>  <object type='line' xPos='101' yPos='15' toXPos='101' toYPos='213' color='000000' lineThickness='3' /> </objectGroup> </customObjects> <value>" & readings(i) & "</value></Chart>"
    %>
    <%--<table width="731" border="1">
  <tr>
    <td width="305"><div align="center">
        <% = equipdesc(i) %> 
    </div></td>
    <td width="492"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>&sitetype=<%=SiteType%>&equipdesc=<%=equipdesc(i)%>"><% = equipname(i)%></a></div></td>
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
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='9' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='NTU' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
		%>
        <td>
          <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="410" height="350" viewastext>
            <param name="movie" value="Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=430">
            <param name="FlashVars" value="">
            <param name="quality" value="high">
            <param name="bgcolor" value="#FFFFFF">
            <embed src="Gallery/Charts/FI2_RT_Line.swf?data=<%=XMLData%>&amp;chartWidth=500&amp;chartHeight=410" flashvars="" quality="high" bgcolor="#FFFFFF" width="410" height="300" align type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
        </object></td>
  </tr>
</table>--%>
    <%--<table width="727" height="45" border="1">
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
</table>--%>
    <table width="729" border="1">
        <tr>
            <td>
                <div align="center">
                    Rules Details</div>
            </td>
            <%
                For j = 0 To UBound(rposition)
                    If rposition(j) = i Then
                        If szParseString(rmultiplier(j), ";", 1) = "RANGE" Then
                            minvalue = szParseString(rmultiplier(j), ";", 2)
                            maxvalue = szParseString(rmultiplier(j), ";", 3)
            %>
            <td>
                <div align="center">
                    <%=ralarmtype(j)%></div>
            </td>
            <td>
                <div align="center">
                    <%=minvalue & " To " & maxvalue%></div>
            </td>
            <%
            End If
        End If
    Next j
            %>
        </tr>
    </table>
    <%
    End If
Case "TIME"
    %>
    <%
End Select
colorrange = ""
Next i
    %>
    <table border="1" width="730px">
        <tr>
            <td align="center">
                <div align="center">
                    <a href="<%=hreflink%>" target="main">Cascade Diagram</a></div>
            </td>
        </tr>
    </table>
    <p align="center">
        <font size="1" face="Verdana" color="#5373A2">Copyright ?2008 Gussmann Technologies
            Sdn Bhd. All rights reserved. </font>
    </p>
</body>
</html>

<script language="JavaScript" src="custom/amr/pump_control.js"></script>
   
<script>
    var xmlHttpfeed_1;

    function show_indicator() {
        var url = "ajx/sum_timestamp.aspx?siteid=<%=SiteID%>&sid=" + Math.random()
        xmlHttpfeed_1 = GetXmlHttpObject(ChangingThings)
        xmlHttpfeed_1.open("GET", url, true)
        xmlHttpfeed_1.send(null)

        setTimeout('show_indicator()', 30000);
    }

    function ChangingThings() {
        if (xmlHttpfeed_1.readyState == 4 || xmlHttpfeed_1.readyState == "complete") {
            var total_feed = xmlHttpfeed_1.responseText;

            document.getElementById('_timestamp').innerHTML = total_feed;
        }
    }

    function init_the_show() {
        show_indicator();
    }
    window.onload = init_the_show;

    function display1() {
        document.getElementById('pic').style.backgroundColor = 'white';
        document.getElementById('tre').style.backgroundColor = '#AAB9FD';
        document.getElementById('image1').style.visibility = 'visible';
        document.getElementById('trending').style.visibility = 'hidden';
        document.getElementById('image1').style.display = 'block';
        document.getElementById('trending').style.display = 'none';
    }

    var aa = '<%=multi%>';

    if (aa == "multi") {
        var currentTime = new Date()
        var month = currentTime.getMonth() + 1
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()
        var startdate = year + "-" + month + "-" + day + " " + '00' + ':' + '00' + ':' + '00';
        var enddate = year + "-" + month + "-" + day + " " + '23' + ':' + '59' + ':' + '00';

        var obj1 = "mimicTrendDetails.aspx?siteid=<%=SiteID %>&sitename=<%=SiteName %>&district=<%=District %>&sitetype=<%=SiteType%>&position=2&date=" + startdate;
        document.getElementById('trendingframe').src = obj1;
    }

    function display2() {
        document.getElementById('pic').style.backgroundColor = '#AAB9FD';
        document.getElementById('tre').style.backgroundColor = 'white';
        document.getElementById('trending').style.visibility = 'visible';
        document.getElementById('image1').style.visibility = 'hidden';
        document.getElementById('trending').style.display = 'block';
        document.getElementById('image1').style.display = 'none';
    }
    document.getElementById('_timestamp').innerHTML = "Loading...";
</script>

