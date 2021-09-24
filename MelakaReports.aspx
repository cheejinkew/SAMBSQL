<%@ Page Language="VB" Debug="true" %>
<!--#include file="../kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>

<script language="VB" runat="server">
    Function GetSiteAddress(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
		
        RS.Open("select address from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
        If Not RS.EOF Then
            GetSiteAddress = Server.HtmlEncode(RS("address").value)
        Else
            GetSiteAddress = ""
        End If

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function
    Function GetSiteType(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
		
        RS.Open("select sitetype from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
        If Not RS.EOF Then
            GetSiteType = Server.HtmlEncode(RS("sitetype").value)
        Else
            GetSiteType = ""
        End If

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function
</script>

<%
    Dim objConn
    Dim sqlRs
    Dim sqlRs1
    Dim sqlSp
    Dim strConn, lcl_Conn, TM_Conn
    Dim strDateTime
    Dim intAlarmCount
    Dim arr As New ArrayList()

    Dim strSelectedReport = Request.Form("ddReport")
    Dim strSelectedSite = Request.Form("ddSite")
    Dim strSelectedAlertType = Request.Form("ddAlert")
    Dim strSubmit = Request.Form("txtSubmit")
      
    Dim strBeginDate = Request.Form("txtBeginDate")
    Dim strBeginHour = Request.Form("ddBeginHour")
    Dim strBeginMin = Request.Form("ddBeginMinute")
   
    Dim strEndDate = Request.Form("txtEndDate")
    Dim strEndHour = Request.Form("ddEndHour")
    Dim strEndMin = Request.Form("ddEndMinute")
   
    Dim i
    Dim strControlDistrict

    Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1) Then
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
            Else
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
    End If

    If strBeginHour = "" Then
        strBeginHour = "00"
    End If

    If strBeginMin = "" Then
        strBeginMin = "00"
    End If

    If strEndHour = "" Then
        strEndHour = "23"
    End If

    If strEndMin = "" Then
        strEndMin = "59"
    End If
   
    If strBeginDate = "" Then
        strBeginDate = Now().ToString("yyyy/MM/dd")
    End If
 
    If strEndDate = "" Then
        strEndDate = Now().ToString("yyyy/MM/dd")
    End If
   
    Dim strBeginDateTime = strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00"
    Dim strEndDateTime = strEndDate & " " & strEndHour & ":" & strEndMin & ":59"
   
    If strSelectedReport = "" Then
        strSelectedReport = "0"
    End If
   
    If strSelectedSite = "" Then
        strSelectedSite = "0"
    End If

    If strSelectedAlertType = "" Then
        strSelectedAlertType = "0"
    End If

    lcl_Conn = ConfigurationSettings.AppSettings("DSNPG")
    strConn = lcl_Conn
    TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"

    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
    sqlRs1 = New ADODB.Recordset()
   
%>
<html>
<head>
    <style>

.bodytxt 
  {
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  }

 a {text-decoration: none;} 
.FormDropdown 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 180px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }
.FormDropdown1
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 295px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }
.FormDropdown2 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 50px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }

</style>
</head>
<body bgcolor="#FFFFFF">

    <script language="JavaScript" src="TWCalendar.js"></script>

    <form name="formX" action="MelakaReports.aspx" method="POST">

        <script language="javascript">DrawCalendarLayout();</script>

        <div align="center">
            <br>
            <p>
                <img border="0" src="images/TelemetryHistoryReport.jpg">
                <br>
                <br>
                <div align="center">
                    <center>
                        <table border="0" cellpadding="0" cellspacing="0" width="60%">
                            <tr>
                                <td width="100%" bgcolor="#465AE8" height="20">
                                    <b><font color="#FFFFFF" size="1" face="Verdana">&nbsp;Report Criteria :</font></b></td>
                            </tr>
                            <tr>
                                <td width="100%" style="border-width: 1px; border-style: solid; border-color: #3952F9">
                                    <div align="center">
                                        <table border="0" cellspacing="1" width="100%">
                                            <tr>
                                                <td width="110%" colspan="4">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="4%">
                                                </td>
                                                <td width="16%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font></td>
                                                <td width="3%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
                                                <td width="87%">
                                                    <font class="bodytxt">
                                                        <input type="text" name="txtBeginDate" size="12" style="border-width: 1px; border-style: solid;
                                                            border-color: #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9;
                                                            height: 20" value="<%=strBeginDate%>" readonly>&nbsp; </font><a href="javascript:ShowCalendar('txtBeginDate', 190, 243);">
                                                                <img border="1" src="images/Calendar.jpg" width="19" height="14">
                                                                &nbsp; </a>&nbsp; <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
                                                    <select size="1" name="ddBeginHour" class="FormDropdown2">
                                                        <option value="00">00</option>
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                    </select>
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>Min:</b></font>
                                                    <select size="1" name="ddBeginMinute" class="FormDropdown2">
                                                        <option value="00">00</option>
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                        <option value="24">24</option>
                                                        <option value="25">25</option>
                                                        <option value="26">26</option>
                                                        <option value="27">27</option>
                                                        <option value="28">28</option>
                                                        <option value="29">29</option>
                                                        <option value="30">30</option>
                                                        <option value="31">31</option>
                                                        <option value="32">32</option>
                                                        <option value="33">33</option>
                                                        <option value="34">34</option>
                                                        <option value="35">35</option>
                                                        <option value="36">36</option>
                                                        <option value="37">37</option>
                                                        <option value="38">38</option>
                                                        <option value="39">39</option>
                                                        <option value="40">40</option>
                                                        <option value="41">41</option>
                                                        <option value="42">42</option>
                                                        <option value="43">43</option>
                                                        <option value="44">44</option>
                                                        <option value="45">45</option>
                                                        <option value="46">46</option>
                                                        <option value="47">47</option>
                                                        <option value="48">48</option>
                                                        <option value="49">49</option>
                                                        <option value="40">50</option>
                                                        <option value="51">51</option>
                                                        <option value="52">52</option>
                                                        <option value="53">53</option>
                                                        <option value="54">54</option>
                                                        <option value="55">55</option>
                                                        <option value="56">56</option>
                                                        <option value="57">57</option>
                                                        <option value="58">58</option>
                                                        <option value="59">59</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="4%">
                                                </td>
                                                <td width="16%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>End Date </b></font>
                                                </td>
                                                <td width="3%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
                                                <td width="87%">
                                                    <input type="text" name="txtEndDate" size="12" style="border-width: 1px; border-style: solid;
                                                        border-color: #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9;
                                                        height: 20" value="<%=strEndDate%>" readonly>&nbsp; <a href="javascript:ShowCalendar('txtEndDate', 190, 243);">
                                                            <img border="1" src="images/Calendar.jpg" width="19" height="14">
                                                            &nbsp; </a>&nbsp; <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
                                                    <select size="1" name="ddEndHour" class="FormDropdown2">
                                                        <option value="00">00</option>
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                    </select>
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>Min:</b></font>
                                                    <select size="1" name="ddEndMinute" class="FormDropdown2">
                                                        <option value="00">00</option>
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                        <option value="24">24</option>
                                                        <option value="25">25</option>
                                                        <option value="26">26</option>
                                                        <option value="27">27</option>
                                                        <option value="28">28</option>
                                                        <option value="29">29</option>
                                                        <option value="30">30</option>
                                                        <option value="31">31</option>
                                                        <option value="32">32</option>
                                                        <option value="33">33</option>
                                                        <option value="34">34</option>
                                                        <option value="35">35</option>
                                                        <option value="36">36</option>
                                                        <option value="37">37</option>
                                                        <option value="38">38</option>
                                                        <option value="39">39</option>
                                                        <option value="40">40</option>
                                                        <option value="41">41</option>
                                                        <option value="42">42</option>
                                                        <option value="43">43</option>
                                                        <option value="44">44</option>
                                                        <option value="45">45</option>
                                                        <option value="46">46</option>
                                                        <option value="47">47</option>
                                                        <option value="48">48</option>
                                                        <option value="49">49</option>
                                                        <option value="40">50</option>
                                                        <option value="51">51</option>
                                                        <option value="52">52</option>
                                                        <option value="53">53</option>
                                                        <option value="54">54</option>
                                                        <option value="55">55</option>
                                                        <option value="56">56</option>
                                                        <option value="57">57</option>
                                                        <option value="58">58</option>
                                                        <option value="59">59</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="4%">
                                                </td>
                                                <td width="16%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>Site</b></font></td>
                                                <td width="3%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
                                                <td width="87%">
                                                    <select size="1" name="ddSite" class="FormDropdown1" onchange="javascript:gotoSubmit('Site')">
                                                        <option value="0">- Select Site -</option>
                                                        <%
                                                            Dim intSiteID
                                                            Dim strSites

                                                            objConn.open(strConn)

                                                            sqlRs.Open("SELECT siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as sites " & _
                                                                                            "from telemetry_site_list_table where siteid IN ("& strKontID &") order by sitedistrict, sitetype, sitename", objConn)
                                    
                    
                                                            Do While Not sqlRs.EOF
                                                                intSiteID = sqlRs("siteid").value
                                                                strSites = sqlRs("Sites").value
                     
                                                        %>
                                                        <option value="<%=intSiteID%>">
                                                            <%=strSites%>
                                                        </option>
                                                        <%

                                                            sqlRs.movenext()
                                                        Loop
                                                       
                                                            sqlRs.close()
                                                            objConn.close()
                                                            objConn = Nothing
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="4%">
                                                </td>
                                                <td width="16%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>Report</b></font></td>
                                                <td width="3%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
                                                <td width="87%">
                                                    <select size="1" name="ddReport" class="FormDropdown" onchange="javascript:gotoSubmit('Report')">
                                                        <option value="0">- Select Report -</option>
                                                        <option value="1">Alarm Report</option>
                                                        <option value="2">Event Report</option>
                                                        <option value="3">Log Report</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="4%">
                                                </td>
                                                <td width="16%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>Alert Type</b></font></td>
                                                <td width="3%">
                                                    <font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
                                                <td width="87%">
                                                    <select size="1" name="ddAlert" class="FormDropdown">
                                                        <option value="0">- Select Alert Type -</option>
                                                        <%
                                                            Dim strLog
                                                            Dim strAlertType
                    
                                                            objConn = New ADODB.Connection()
                                                            objConn.open(strConn)
                    
                                                            If strSelectedReport = "1" Then
                                                                sqlRs.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & strSelectedSite & "' and alarmmode='ALARM'", objConn)
                                                            ElseIf strSelectedReport = "2" Then
                                                                sqlRs.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & strSelectedSite & "' and alarmmode='EVENT'", objConn)
                                                            Else
                                                                sqlRs.Open("Select 'None' as alarmtype", objConn)
                    
                                                            End If
                                                            If strSelectedReport <> "3" And Not sqlRs.EOF Then
                    
                                                        %>
                                                        <option value="-1">ALL Types </option>
                                                        <%
                                                        End If
                                                        Do While Not sqlRs.EOF
                                                            If sqlRs("alarmtype").value <> "None" Then
                                                                strAlertType = sqlRs("alarmtype").value

                                                        %>
                                                        <option value="<%=strAlertType%>">
                                                            <%=strAlertType%>
                                                        </option>
                                                        <%
                                                        End If
                                                        sqlRs.movenext()
                                                    Loop
                
                                                    sqlRs.close()
                                                    objConn.close()
                                                    sqlRs = Nothing
                                                    objConn = Nothing
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="110%" colspan="4">
                                                    &nbsp;</td>
                                            </tr>
                    </center>
                    </table>
                </div>
            </td> </tr> </table>
        </div>
        </div>
        <p align="center">
            <a href="javascript:gotoSubmit('Submit');">
                <img border="0" src="images/Submit_s.jpg"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:save2Excel();"><img
                    border="0" src="images/SaveExcel.jpg"></a></p>
        <div align="center">
            <center>
                <!-*******************************************************************************************************
                ALARM REPORT GENERATION *******************************************************************************************************!>
                <%If strSelectedReport = "1" And strSubmit = "YES" Then%>
                <table border="0" cellpadding="0" cellspacing="0" width="95%">
                    <tr>
                        <td width="60%" align="center" valign="top">
                            <div align="center">
                                <table border="0" cellspacing="1" width="100%">
                                    <tr style="background-color: #465AE8; color: #FFFFFF">
                                        <td align="center" height="20" width="60%">
                                            <font face="Verdana" size="1"><b>DateTime</b></font></td>
                                        <td align="center" height="20" width="40%">
                                            <font face="Verdana" size="1"><b>Alarm Type</b></font></td>
                                    </tr>
                                    <%
                                        Dim intNum = 0
                                        Dim strAlarmType
             
                                        objConn = New ADODB.Connection()
                                        sqlRs = New ADODB.Recordset()
             
                                        objConn.open(strConn)
                                        If strSelectedAlertType = "-1" Then
                                            sqlRs.Open("select sequence, alarm from telemetry_alarm_history_table " & _
                                                       " where siteid ='" & strSelectedSite & "' " & _
                                                       " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)
                                        Else
                                            sqlRs.Open("select sequence, alarm from telemetry_alarm_history_table " & _
                                                       " where siteid ='" & strSelectedSite & "' " & _
                                                       " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                                                       " and alarm ='" & strSelectedAlertType & "'", objConn)
             
                                        End If
                                        Do While Not sqlRs.EOF
              
                                            strDateTime = sqlRs("sequence").value
                                            strAlarmType = sqlRs("alarm").value
                                            If intNum = 0 Then
                                                intNum = 1

                                    %>
                                    <tr bgcolor="#FFFFFF">
                                        <%
                                        ElseIf intNum = 1 Then
                                            intNum = 0
                                        %>
                                        <tr bgcolor="#E7E8F8">
                                            <%
                                            End If
                                            %>
                                            <td style="margin-left: 5" width="17%">
                                                <font class="bodytxt">
                                                    <%=strDateTime%>
                                                </font>
                                            </td>
                                            <td style="margin-left: 5">
                                                <font class="bodytxt">
                                                    <%=strAlarmType%>
                                                </font>
                                            </td>
                                        </tr>
                                        <%

                                            sqlRs.movenext()
                                        Loop
                
                                        sqlRs.close()
                                        objConn.close()
                                        sqlRs = Nothing
                                        objConn = Nothing
                                        %>
                                </table>
                            </div>
                        </td>
                        <td width="40%" align="right" valign="top">
                            <div align="center">
                                <table border="0" cellspacing="1" width="90%">
                                    <tr style="background-color: #465AE8; color: #FFFFFF">
                                        <td align="center" height="20" width="60%">
                                            <font face="Verdana" size="1"><b>Alarm Type</b></font></td>
                                        <td align="center" height="20" width="40%">
                                            <font face="Verdana" size="1"><b># Alert</b></font></td>
                                    </tr>
                                    <%
                                        intNum = 0
             
                                        objConn = New ADODB.Connection()
                                        sqlRs = New ADODB.Recordset()
             
                                        objConn.open(strConn)
            
                                        If strSelectedAlertType = "-1" Then
                                            sqlRs1.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & _
                                                         strSelectedSite & "' and alarmmode='ALARM'", objConn)
                                        Else
                                            sqlRs1.Open("Select '" & strSelectedAlertType & "' as alarmtype", objConn)
                                        End If
                                        Do While Not sqlRs1.EOF
                                            sqlRs.Open("select count(alarm) as AlarmCount from telemetry_alarm_history_table " & _
                                                       " where siteid ='" & strSelectedSite & "' " & _
                                                       " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                                                       " and alarm ='" & sqlRs1("alarmtype").value & "'", objConn)
                                            If Not sqlRs.EOF Then
                                                intAlarmCount = sqlRs("AlarmCount").value
                                            End If
                                            sqlRs.close()
                                            If intNum = 0 Then
                                                intNum = 1

                                    %>
                                    <tr bgcolor="#FFFFFF">
                                        <%
                                        ElseIf intNum = 1 Then
                                            intNum = 0
                                        %>
                                        <tr bgcolor="#E7E8F8">
                                            <%
                                            End If
                                            %>
                                            <td style="margin-left: 5" width="17%">
                                                <font class="bodytxt"><b>
                                                    <%=sqlRs1("alarmtype").value%>
                                                </b></font>
                                            </td>
                                            <td style="margin-left: 5">
                                                <font class="bodytxt">
                                                    <%=intAlarmCount%>
                                                </font>
                                            </td>
                                        </tr>
                                        <%
                
                                            sqlRs1.movenext()
                                        Loop
                                        sqlRs1.close()
                                        objConn.close()
                                        sqlRs1 = Nothing
                                        sqlRs = Nothing
                                        objConn = Nothing
                                        %>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
        </div>
        <!-*******************************************************************************************************
        EVENT REPORT GENERATION *******************************************************************************************************!>
        <%ElseIf strSelectedReport = "2" And strSubmit = "YES" Then%>
        <table border="0" cellpadding="0" cellspacing="0" width="99%">
            <tr>
                <td width="80%" align="center" valign="top">
                    <div align="center">
                        <table border="0" cellspacing="1" width="100%">
                            <tr style="background-color: #465AE8; color: #FFFFFF">
                                <td align="center" height="20" width="25%">
                                    <font face="Verdana" size="1"><b>DateTime</b></font></td>
                                <td align="center" height="20" width="8%">
                                    <font face="Verdana" size="1"><b>Index</b></font></td>
                                <td align="center" height="20" width="49%">
                                    <font face="Verdana" size="1"><b>Equipment</b></font></td>
                                <td align="center" height="20" width="8%">
                                    <font face="Verdana" size="1"><b>Value</b></font></td>
                                <td align="center" height="20" width="10%">
                                    <font face="Verdana" size="1"><b>Event</b></font></td>
                            </tr>
                            <%
                                Dim intNum = 0
                                Dim intIndex
                                Dim intPosition
                                Dim intValue
                                Dim strEvent

                                objConn = New ADODB.Connection()
                                sqlRs = New ADODB.Recordset()
                                objConn.open(strConn)
       
      
                                If strSelectedAlertType = "-1" Then
                                    sqlRs.Open("select ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _
                                               "from telemetry_event_history_table l, telemetry_equip_list_table e " & _
                                               "where l.siteid ='" & strSelectedSite & "' and l.siteid = e.siteid " & _
                                               "  and l.position = e.position " & _
                                               "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                                               "' and equipname not in ('DATE','TIME')", objConn)

                                Else
                                    sqlRs.Open("select ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _
                                               "from telemetry_event_history_table l, telemetry_equip_list_table e " & _
                                               "where l.siteid ='" & strSelectedSite & "' and l.siteid = e.siteid " & _
                                               "  and l.position = e.position " & _
                                               "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                                               "' and event='" & strSelectedAlertType & "'", objConn)
      
                                End If
       
                                Do While Not sqlRs.EOF
              
                                    strDateTime = sqlRs("sequence").value
                                    intIndex = sqlRs("index").value
                                    intPosition = sqlRs("desc").value & " : " & sqlRs("equipname").value
                                    intValue = sqlRs("value").value
                                    strEvent = sqlRs("event").value
        
                                    If intNum = 0 Then
                                        intNum = 1

                            %>
                            <tr bgcolor="#FFFFFF">
                                <%
                                ElseIf intNum = 1 Then
                                    intNum = 0
                                %>
                                <tr bgcolor="#E7E8F8">
                                    <%
                                    End If
                                    %>
                                    <td style="margin-left: 5">
                                        <font class="bodytxt">
                                            <%=strDateTime%>
                                        </font>
                                    </td>
                                    <td style="margin-left: 5">
                                        <font class="bodytxt">
                                            <%=intIndex%>
                                        </font>
                                    </td>
                                    <td style="margin-left: 5">
                                        <font class="bodytxt">
                                            <%=intPosition%>
                                        </font>
                                    </td>
                                    <td style="margin-left: 5">
                                        <font class="bodytxt">
                                            <%=FormatNumber(intValue, 3)%>
                                        </font>
                                    </td>
                                    <td style="margin-left: 5">
                                        <font class="bodytxt">
                                            <%=strEvent%>
                                        </font>
                                    </td>
                                </tr>
                                <%

                                    sqlRs.movenext()
                                Loop
                
                                sqlRs.close()
                                objConn.close()
                                objConn = Nothing
                                %>
                        </table>
                </td>
                <td width="20%" align="right" valign="top">
                    <div align="center">
                        <table border="0" cellspacing="1" width="90%">
                            <tr style="background-color: #465AE8; color: #FFFFFF">
                                <td align="center" height="20" width="60%">
                                    <font face="Verdana" size="1"><b>Alarm Type</b></font></td>
                                <td align="center" height="20" width="40%">
                                    <font face="Verdana" size="1"><b># Alert</b></font></td>
                            </tr>
                            <%
                                Dim intEventCount
                                intNum = 0
             
                                objConn = New ADODB.Connection()
                                sqlRs1 = New ADODB.Recordset()
                                objConn.open(strConn)
            
                                If strSelectedAlertType = "-1" Then
                                    sqlRs1.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & _
                                                 strSelectedSite & "' and alarmmode='EVENT'", objConn)
                                Else
                                    sqlRs1.Open("Select '" & strSelectedAlertType & "' as alarmtype", objConn)
                                End If
                                Do While Not sqlRs1.EOF
                                    sqlRs.Open("select count(event) as EventCount from telemetry_event_history_table " & _
                                               " where siteid ='" & strSelectedSite & "' " & _
                                               " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                                               " and event ='" & sqlRs1("alarmtype").value & "'", objConn)
                                    If Not sqlRs.EOF Then
                                        intEventCount = sqlRs("EventCount").value
                                    End If
                                    sqlRs.close()
                                    If intNum = 0 Then
                                        intNum = 1

                            %>
                            <tr bgcolor="#FFFFFF">
                                <%
                                ElseIf intNum = 1 Then
                                    intNum = 0
                                %>
                                <tr bgcolor="#E7E8F8">
                                    <%
                                    End If
                                    %>
                                    <td style="margin-left: 5" width="17%">
                                        <font class="bodytxt"><b>
                                            <%=sqlRs1("alarmtype").value%>
                                        </b></font>
                                    </td>
                                    <td style="margin-left: 5">
                                        <font class="bodytxt">
                                            <%=intEventCount%>
                                        </font>
                                    </td>
                                </tr>
                                <%
                
                                    sqlRs1.movenext()
                                Loop
                                sqlRs1.close()
                                objConn.close()
                                sqlRs = Nothing
                                sqlRs1 = Nothing
                                objConn = Nothing
                                %>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        </div> <!-*******************************************************************************************************
        LOG REPORT GENERATION *******************************************************************************************************!>
        <%ElseIf strSelectedReport = "3" And strSubmit = "YES" Then%>
        <table border="0" cellspacing="1" width="70%">
            <tr style="background-color: #465AE8; color: #FFFFFF">
                <td align="center" height="20" width="20%">
                    <font face="Verdana" size="1"><b>Date</b></font></td>
                <td align="center" height="20" width="20%">
                    <font face="Verdana" size="1"><b>Time</b></font></td>
                <td align="center" height="20" width="50%">
                    <font face="Verdana" size="1"><b>Equipment</b></font></td>
                <td align="center" height="20" width="10%">
                    <font face="Verdana" size="1"><b>Value m<sup>3</sup>/h</b></font></td>
                <td align="center" height="20" width="10%">
                    <font face="Verdana" size="1"><b>TotalFlow m<sup>3</sup>/h</b></font></td>
            </tr>
            <%
                Dim intNum = 0
                Dim strEquip
                Dim intValue
                Dim strDate
                Dim strTime
                Dim totval
       
                If GetSiteAddress(strConn, strSelectedSite) = "TM SERVER" Then
                    strConn = TM_Conn
                End If
       
                objConn = New ADODB.Connection()
                sqlRs = New ADODB.Recordset()
                Dim objConn2 = New ADODB.Connection()
                Dim sqlRs2 = New ADODB.Recordset()
                objConn.open(strConn)
       
                'if strSelectedAlertType <> "0" then 

       
                sqlRs.Open("select ""desc"", equipname, sequence, value  " & _
                           "from telemetry_log_table l, telemetry_equip_list_table e " & _
                           "where l.siteid ='" & strSelectedSite & "' and l.siteid = e.siteid " & _
                           "  and l.position = e.position " & _
                           "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)
                Dim cont As Integer = 0
                Do While Not sqlRs.EOF
              
                    strDateTime = sqlRs("sequence").value
                    strDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(strDateTime))
                    strTime = String.Format("{0:hh:mm:ss tt}", Date.Parse(strDateTime))

                    strEquip = sqlRs("desc").value & " : " & sqlRs("equipname").value
                    intValue = sqlRs("value").value
        
                    If intNum = 0 Then
                        intNum = 1

            %>
            <tr bgcolor="#FFFFFF">
                <%
                ElseIf intNum = 1 Then
                    intNum = 0
                %>
                <tr bgcolor="#E7E8F8">
                    <%
                    End If
    
                    objConn2.open(strConn)
                    sqlRs2.open("select (round(cast(SUM(value) as numeric),3)) AS TotVal " & _
                               "from telemetry_log_table l, telemetry_equip_list_table e " & _
                               "where l.siteid ='" & strSelectedSite & "' and l.siteid = e.siteid " & _
                               "  and l.position = e.position " & _
                               "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "' ", objConn2)
    
                    Do While Not sqlRs2.EOF
                        totval = sqlRs2("TotVal").value
                        arr.Add(totval)
                        sqlRs2.movenext()
                    Loop
                    sqlRs2.close()
                    objConn2.close()

                    %>
                    <td style="margin-left: 5">
                        <font class="bodytxt">
                            <%=strDate%>
                        </font>
                    </td>
                    <td style="margin-left: 5">
                        <font class="bodytxt">
                            <%=strTime%>
                        </font>
                    </td>
                    <% If strEquip = "- : -" Then%>
                    <td style="margin-left: 5">
                        <font class="bodytxt">
                            <%=GetSiteType(lcl_Conn,strSelectedSite)%>
                        </font>
                    </td>
                    <% Else%>
                    <td style="margin-left: 5">
                        <font class="bodytxt">
                            <%=strEquip%>
                        </font>
                    </td>
                    <% End If%>
                    <td style="margin-left: 5">
                        <font class="bodytxt">
                            <%=intValue%>
                        </font>
                    </td>
                    <td style="margin-left: 5">
                        <font class="bodytxt">
                            <%=arr(cont)%>
                        </font>
                    </td>
                </tr>
                <%

                    tval.Value = arr(cont)
                    sqlRs.movenext()
                    cont += 1
                Loop
       
                sqlRs.close()
                'end if
                objConn.close()
                sqlRs = Nothing
                objConn = Nothing
                %>
        </table>
        <%End If%>
        </center> </div>
        <p align="center">
            &nbsp;</p>
        <input type="hidden" name="txtSubmit" value="">
        <input type="hidden" name="txtSiteName" value="">
        <input type="hidden" runat="server" id="tval" name="tval" value="" />
        <p align="center" style="margin-bottom: 15">
            <font size="1" face="Verdana" color="#5373A2">Copyright © <%=Now.ToString("yyyy")%> Gussmann Technologies
                Sdn Bhd. All rights reserved. </font>
        </p>
    </form>
    <p>
        <iframe id="_excel" name="_excel" style="width: 0px; height: 0px; position: absolute;
            top: 20; left: 40; display: inline;" frameborder="0" scrolling="no" marginwidth="0"
            src="about:blank" marginheight="0"></iframe>
    </p>
</body>
</html>

<script language="javascript">
  var totval=document.getElementById("tval").value;   
  var test;
  document.formX.ddReport.value="<%=strSelectedReport%>";
  document.formX.ddSite.value="<%=strSelectedSite%>";
  document.formX.txtSiteName.value="<%=strSelectedSite%>";
  document.formX.ddBeginHour.value="<%=strBeginHour%>";
  document.formX.ddBeginMinute.value="<%=strBeginMin%>";
  document.formX.ddEndHour.value="<%=strEndHour%>";
  document.formX.ddEndMinute.value="<%=strEndMin%>";
  document.formX.ddAlert.value="<%=strSelectedAlertType%>";

  function gotoSubmit(intStatus)
  {
    if (intStatus == 'Submit')
    {
      document.formX.txtSubmit.value="YES";
    }
    else if (intStatus == 'Site' || intStatus == 'Report')
    {
      document.formX.ddAlert.value="0";
      document.formX.txtSubmit.value="NO";     
    }
    document.formX.submit();
  }

  frmTargetForm = "formX";
  
  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    document.getElementById("divTWCalendar").style.visibility = 'visible';
    document.getElementById("divTWCalendar").style.left = intLeft;
    document.getElementById("divTWCalendar").style.top = intTop;
  }

  function goCreateExcel() 
  {
    var strURL;
    var strSite=document.formX.ddSite.value;    
	var strSiteName = document.getElementById("ddSite")(document.formX.ddSite.selectedIndex).innerHTML;	
    var strReport=document.formX.ddReport.value;
    var strAlert=document.formX.ddAlert.value;
    var strBeginDate=document.formX.txtBeginDate.value;
    var strBeginHour=document.formX.ddBeginHour.value;
    var strBeginMin=document.formX.ddBeginMinute.value;
    var strEndDate=document.formX.txtEndDate.value;
    var strEndHour=document.formX.ddEndHour.value;
    var strEndMin=document.formX.ddEndMinute.value;

    if (strReport=="1")
    {
      strURL = "ExcelAlarmReport.aspx?"
    }
    if (strReport=="2")
    {
      strURL = "ExcelEventReport.aspx?"
    }
    if (strReport=="3")
    {
      strURL = "ExcelLogReport.aspx?"
    }

    strURL = strURL + "ddSite=" + strSite  + "&ddSiteName=" + strSiteName + "&ddAlert=" + strAlert 
    strURL = strURL + "&ddBeginHour=" + strBeginHour + "&ddBeginMinute=" + strBeginMin
    strURL = strURL + "&txtBeginDate=" + strBeginDate + "&txtEndDate=" + strEndDate
    strURL = strURL + "&ddEndHour=" + strEndHour + "&ddEndMinute=" + strEndMin
    test = window.open(strURL, "Report",'height=10, width=10, Left=5000, Top=5000,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');

    setTimeout('CloseMe()',20000);

  }

  function save2Excel() // modification 4 mozilla, May 15 2006
  {
	
    var strURL;
        
	sel = document.formX.ddSite.selectedIndex;
	strSite = document.formX.ddSite.options[sel].value;
	strSiteName = document.formX.ddSite.options[sel].text;
    
    var strReport=document.formX.ddReport.value;
    var strAlert=document.formX.ddAlert.value;
    var strBeginDate=document.formX.txtBeginDate.value;
    var strBeginHour=document.formX.ddBeginHour.value;
    var strBeginMin=document.formX.ddBeginMinute.value;
    var strEndDate=document.formX.txtEndDate.value;
    var strEndHour=document.formX.ddEndHour.value;
    var strEndMin=document.formX.ddEndMinute.value;

    if (strReport=="1")
    {
      strURL = "ExcelAlarmReport.aspx?";
    }
    if (strReport=="2")
    {
      strURL = "ExcelEventReport.aspx?";
    }
    if (strReport=="3")
    {
      strURL = "ExcelLogReport.aspx?";
    }

    strURL = strURL + "ddSite=" + strSite  + "&ddSiteName=" + strSiteName + "&ddAlert=" + strAlert + "&totval=" + totval;
    strURL = strURL + "&ddBeginHour=" + strBeginHour + "&ddBeginMinute=" + strBeginMin;
    strURL = strURL + "&txtBeginDate=" + strBeginDate + "&txtEndDate=" + strEndDate;
    strURL = strURL + "&ddEndHour=" + strEndHour + "&ddEndMinute=" + strEndMin;
    
	document.getElementById("_excel").src = strURL;    
    setTimeout('document.getElementById("_excel").src = "about:blank";',20000);

  }

  function CloseMe()
  {
    test.close();
  }


  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }
  
</script>

