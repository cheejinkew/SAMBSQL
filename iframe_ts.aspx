<%@ Page Language="VB" Debug="true" %>

<html>
<head>
    <script language="JavaScript" src="ajx/FusionCharts.js"></script>
    <title>trending frame</title>
</head>
<body>
    <form id="form1">
    <div>
        <%            
            Dim startdate = Request("txtBeginDate1")
            Dim enddate = Request("txtEndDate1")
            Dim siteid = Request("siteid")
            Dim position = Request("position")
            Dim district = Request("district")
            Dim sitetype = Request("sitetype")
            Dim sitename = Request("sitename")
            Dim caption = Request("caption")
            Dim version = Request("v")
            Dim values1(0) As String
            Dim sequence1(0) As String
            Dim i As Integer
            Dim v As Integer
            Dim XMLData1
            Dim extra
            Dim get_MAX = 0
            
            Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
            Dim objConn = New ADODB.Connection()
            Dim rsRecords1 = New ADODB.Recordset()
            Dim rsRecords2 = New ADODB.Recordset()
            Dim Div As Integer
            objConn.open(strConn)
            ' ==========================================================================================================
            rsRecords2.Open("select max from telemetry_equip_list_table where siteid='" & siteid & "' and position =" & position, objConn)
            If Not rsRecords2.EOF Then
                get_MAX = rsRecords2.fields("max").value
                'response.write("<p>" & rsRecords2.fields("max").value & "</p>")
            End If
            rsRecords2.close()
            ' ==========================================================================================================
            If version = "M6" Then
                rsRecords2.Open("select value, dtimestamp from telemetry_log_table_m6 where siteid='" & siteid & "' and position ='" & position & "' and dtimestamp between '" & startdate & "' and '" & enddate & "' order by dtimestamp asc", objConn)
            
                If rsRecords2.EOF Then
                    rsRecords2.close()
                    rsRecords2.Open("select value, dtimestamp from telemetry_log_table_m6 where siteid='" & siteid & "' and dtimestamp between '" & startdate & "' and '" & enddate & "' order by dtimestamp asc", objConn)
                End If
            Else
                rsRecords2.Open("select value, dtimestamp from telemetry_log_table where siteid='" & siteid & "' and position ='" & position & "' and dtimestamp between '" & startdate & "' and '" & enddate & "' order by dtimestamp asc", objConn)
            
                If rsRecords2.EOF Then
                    rsRecords2.close()
                    rsRecords2.Open("select value, dtimestamp from telemetry_log_table where siteid='" & siteid & "' and dtimestamp between '" & startdate & "' and '" & enddate & "' order by dtimestamp asc", objConn)
                End If
            End If
           
            
            Do While Not rsRecords2.EOF
                values1(v) = rsRecords2.fields("value").value
                sequence1(v) = rsRecords2.fields("dtimestamp").value
                rsRecords2.movenext()
                If rsRecords2.eof = False Then
                    v = v + 1
                    ReDim Preserve values1(v)
                    ReDim Preserve sequence1(v)
                End If
            Loop
            
            rsRecords2.close()
            ' ==================================== Checks should anywhere here =============================================
            Dim LowerVal = LBound(values1)
            Dim UpperVal = UBound(values1)
            Dim restoreVal As Double = 0.0
            
            For i = LowerVal To UpperVal
                If values1(i) <= get_MAX Then
                    restoreVal = values1(i)
                    i = UpperVal
                End If
            Next
            
            For i = LowerVal To UpperVal
                
                If Not i = LowerVal Then
                    'if not i=UpperVal-1 then
                    If i < UpperVal Then
                        If values1(i) = 0 Then ' Case when the value is 0
                            'values1(i)  = (values1(i-1)  + values1(i+1) )/2					
                            If Not values1(i + 1) = 0 Then
                                values1(i) = values1(i - 1)
                            End If
                        End If
                        If values1(i) > get_MAX Then ' Case when the value is more than maximum
                            'values1(i)  = (values1(i-1)  + values1(i+1) )/2
                            'If Not values1(i + 1) > get_MAX Then
                            values1(i) = values1(i - 1)
                            'End If
                        End If
                    End If
                    
                    'If (values1(i) - values1(i - 1) > 1.0 Or values1(i) - values1(i - 1) < -1.0) And values1(i) <= get_MAX Then
                    '    values1(i) = values1(i - 1)
                    'End If
                    
                Else
                    If values1(i) > get_MAX Then
                        values1(i) = restoreVal
                    End If
                End If
                
                'response.write("<p>" & sequence(i) & " : " & values1(i) & "</p>")
            Next
            ' ==================================== Checks should anywhere here =============================================
            If Not sequence1(0) = "" Then
                For i = 0 To sequence1.Length - 1
                  
                    extra = extra & "<set name='" & sequence1(i) & "' value='" & values1(i) & "'/>"
                                      
                Next
               
                rsRecords1.Open("select alarmtype,colorcode,multiplier  from telemetry_rule_list_table where siteid='" & siteid & "' and position ='" & position & "' and alarmtype<>'NN' ", objConn)
           
                Dim alerts = ""
                Dim strMaxYaxis As String = "0"
                Do While Not rsRecords1.EOF
                
                    Dim multiplier As String = Split(rsRecords1("multiplier").value, ";")(2)
                    Dim color = "#" & rsRecords1("colorcode").value
                    Dim alarmtype = rsRecords1("alarmtype").value
                    If CDbl(strMaxYaxis) < CDbl(multiplier) Then
                        strMaxYaxis = multiplier
                    End If
                    Dim limitters As String
                    If alarmtype = "H" Or alarmtype = "HH" Then
                        limitters = Split(rsRecords1("multiplier").value, ";")(1)
                    Else
                        limitters = Split(rsRecords1("multiplier").value, ";")(2)
                    End If
                    alerts = alerts & "<line startValue='" & limitters & "' color='" & color & "' displayvalue='" & alarmtype & "' />"
                    ' <line startvalue='50'  endValue='80' displayValue='Warning' color='BC9F3F' isTrendZone='1' showOnTop='0' alpha='25' valueOnRight='1'/>
                    rsRecords1.movenext()
               
                Loop
                
                strMaxYaxis = (CDbl(strMaxYaxis) + 1.0).ToString()
                Dim step1
                rsRecords1.close()
                objConn.close()
                rsRecords1 = Nothing
                rsRecords2 = Nothing
                objConn = Nothing
                Dim intInterval
                
                
                If UBound(sequence1) <= 15 Then
                    intInterval = 0
                Else
                    intInterval = (UBound(sequence1) / 12)
                End If
                               
                step1 = intInterval
                XMLData1 = "<chart fontcolor='333333' topmargin='0' labelStep='" & step1 & "' fontSize='10' isBold='1' showBorder='0' chartLeftMargin='30' bgColor='FFFFFF' slantLabels='1' labelDisplay='Rotate' caption='" & caption & "'  xAxisName='Time Stamp' yAxisName='Values' numberSuffix='m' showNames='1' showValues='0' rotateNames='1' showColumnShadow='1' animation='1' yAxisMaxValue='" & strMaxYaxis & "' showAlternateHGridColor='1' AlternateHGridColor='ff5904' divLineColor='91AF46' divLineAlpha='30' alternateHGridAlpha='5' canvasBorderColor='666666' baseFontColor='666666' lineColor='008000' numVDivlines='7' lineAlpha='50'>" & extra & " <trendLines> " & alerts & " </trendLines></chart>"
                Response.Write(XMLData1)
        %>
        <div id="Div2" align="center">
        </div>
        <script type="text/javascript">
            var myChart = new FusionCharts("Charts/Line(2).swf", "Div2", "400", "300", "0", "0");
            myChart.setDataXML("<%=XMLData1%>");
            myChart.render("Div2");
        </script>
        <%Else%>
        <table align="center" height="300">
            <tr>
                <td>
                    <div id="nodata" align="center" style="font-weight: bold; color: Blue;">
                        No data to be displayed</div>
                </td>
            </tr>
        </table>
        <% End If%>
        <table align="center" border="0" width="400">
            <tr>
                <td align="center">
                    <a href="javascript:yesterdate();">
                        <img src="images/last1day.jpg" border="0"></a> &nbsp;&nbsp; <a href="javascript:twodaysdate();">
                            <img src="images/last2days.jpg" border="0"></a> &nbsp;&nbsp; <a href="javascript:lastweakdate();">
                                <img src="images/1week.jpg" border="0"></a> &nbsp;&nbsp; <a href="javascript:lastmonthdate();">
                                    <img src="images/1-month.jpg" border="0"></a>
                </td>
                <tr>
                    <td>
                        <div align="right">
                            <a href="Trending.aspx?siteid=<%=siteid%>&v=<%=version%>&sitename=<%=sitename%>&district=<%=district%>&position=<%=position%>&sitetype=<%=SiteType%>&equipname=Water Level Trending"
                                target="main">> Trending Selections</a></div>
                    </td>
                </tr>
        </table>
        <input id="txtBeginDate1" name="txtBeginDate1" type="hidden" value="<%=startdate%>" />
        <input id="txtEndDate1" name="txtEndDate1" type="hidden" value="<%=enddate%>" />
        <input id="position" name="position" type="hidden" value="<%=position%>" />
        <input id="siteid" name="siteid" type="hidden" value="<%=siteid%>" />
        <input id="caption" name="caption" type="hidden" value="<%=caption%>" />
        <input id="district" name="district" type="hidden" value="<%=district%>" />
        <input id="sitename" name="sitename" type="hidden" value="<%=sitename%>" />
        <input id="sitetype" name="sitetype" type="hidden" value="<%=sitetype%>" />
         <input id="v" name="v" type="hidden" value="<%=version%>" />
    </div>
    </div>
    </form>
</body>
</html>
<script language="javascript">

    function yesterdate() {
        var currentTime = new Date()
        var month = currentTime.getMonth() + 1
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()

        document.getElementById('txtBeginDate1').value = year + "-" + month + "-" + day + " " + '00' + ':' + '00' + ':' + '00';

        document.getElementById('txtEndDate1').value = year + "-" + month + "-" + day + " " + '23' + ':' + '59' + ':' + '00';
        document.getElementById('position').value = '<%=position%>';
        document.getElementById('siteid').value = '<%=siteid%>';
        document.getElementById('caption').value = 'Last 1 day chart';
        document.getElementById('district').value = '<%=district%>';
        document.getElementById('sitename').value = '<%=sitename%>';
        document.getElementById('sitetype').value = '<%=sitetype%>';
        document.getElementById('v').value = '<%=version%>';
        form1.submit();
    }

    function twodaysdate() {
        var currentTime = new Date()
        currentTime.setHours(-24)
        var month = currentTime.getMonth() + 1
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()

        var currentTime1 = new Date()
        var month1 = currentTime1.getMonth() + 1
        var day1 = currentTime1.getDate()
        var year1 = currentTime1.getFullYear()

        document.getElementById('txtBeginDate1').value = year + "-" + month + "-" + day + " " + '00' + ':' + '00' + ':' + '00';
        document.getElementById('txtEndDate1').value = year1 + "-" + month1 + "-" + day1 + " " + '23' + ':' + '59' + ':' + '00';
        document.getElementById('position').value = '<%=position%>';
        document.getElementById('siteid').value = '<%=siteid%>';
        document.getElementById('caption').value = 'Last 2 days chart';
        document.getElementById('district').value = '<%=district%>';
        document.getElementById('sitename').value = '<%=sitename%>';
        document.getElementById('sitetype').value = '<%=sitetype%>';
        document.getElementById('v').value = '<%=version%>';
        form1.submit();
    }

    function lastweakdate() {
        var currentTime = new Date()
        currentTime.setHours(-154)
        var month = currentTime.getMonth() + 1
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()


        var currentTime1 = new Date()
        var month1 = currentTime1.getMonth() + 1
        var day1 = currentTime1.getDate()
        var year1 = currentTime1.getFullYear()

        document.getElementById('txtBeginDate1').value = year + "-" + month + "-" + day + " " + '00' + ':' + '00' + ':' + '00';

        document.getElementById('txtEndDate1').value = year1 + "-" + month1 + "-" + day1 + " " + '23' + ':' + '59' + ':' + '00';
        document.getElementById('position').value = '<%=position%>';
        document.getElementById('siteid').value = '<%=siteid%>';
        document.getElementById('caption').value = 'Last week chart';
        document.getElementById('district').value = '<%=district%>';
        document.getElementById('sitename').value = '<%=sitename%>';
        document.getElementById('sitetype').value = '<%=sitetype%>';
        document.getElementById('v').value = '<%=version%>';
        form1.submit();

    }
    function lastmonthdate() {
        var currentTime = new Date()
        currentTime.setHours(-700)
        var month = currentTime.getMonth() + 1
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()

        var currentTime1 = new Date()
        var month1 = currentTime1.getMonth() + 1
        var day1 = currentTime1.getDate()
        var year1 = currentTime1.getFullYear()

        document.getElementById('txtBeginDate1').value = year + "-" + month + "-" + day + " " + '00' + ':' + '00' + ':' + '00';
        document.getElementById('txtEndDate1').value = year1 + "-" + month1 + "-" + day1 + " " + '23' + ':' + '59' + ':' + '00';
        document.getElementById('position').value = '<%=position%>';
        document.getElementById('siteid').value = '<%=siteid%>';
        document.getElementById('caption').value = 'Last month chart';
        document.getElementById('district').value = '<%=district%>';
        document.getElementById('sitename').value = '<%=sitename%>';
        document.getElementById('sitetype').value = '<%=sitetype%>';
        document.getElementById('v').value = '<%=version%>';
        form1.submit();

    }


</script>
