<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<script language="VB" runat="server">

    Function GetAlarmType(ByVal strConn As String, ByVal str As String, ByVal _pos As Integer, ByVal _value As Double) As String
        Dim minima, maksima, rules
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select * from telemetry_rule_list_table where siteid='" & str & "' and position=" & _pos & " order by sequence asc", nOConn)

        If Not RS.eof Then
		
            Do Until RS.EOF
                Words = UCase(RS("multiplier").value)
                Words = Split(Words, ";")
                If (_value >= Convert.ChangeType(Words(1), GetType(Double))) And (_value <= Convert.ChangeType(Words(2), GetType(Double))) Then
                    rules = RS("alarmtype").value
                    GetAlarmType = rules
                    Exit Do
                End If
                RS.MoveNext()
            Loop
        Else
            GetAlarmType = ""
        End If
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

Function Format_Full_Time(str As String,options As Integer)
	select case options
		case 1
			Format_Full_Time = String.Format("{0:HH:mm}",Date.Parse(str))
		case 2
			Format_Full_Time = String.Format("{0:dd/MM/yyyy}",Date.Parse(str))
		case 3
			Format_Full_Time = String.Format("{0:dd/MM/yyyy HH:mm}",Date.Parse(str))
		case else
			Format_Full_Time = String.Format("{0:dd/MM}",Date.Parse(str))
	end select
End Function

Function Format_Time_Parse(str As String,options As Integer)
	select case options
		case 1
			Format_Time_Parse = String.Format("{0:HH:mm}",Date.Parse(str))
		case 2
			Format_Time_Parse = String.Format("{0:yyyy/MM/dd}",Date.Parse(str))
		case else
			Format_Time_Parse = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(str))
	end select
End Function
</script>
<%
    Dim val
    
    
   dim objConn
   dim sqlRs
   dim sqlRs1
   dim sqlSp
   dim strConn
   dim strDateTime
   dim intAlarmCount

   dim strSelectedReport = request.form("ddReport")
   dim strSelectedSite = request.form("ddSite")
   dim strSelectedAlertType = request.form("ddAlert")
   dim strSubmit = request.form("txtSubmit") 
      
   dim strBeginDate = request.form("txtBeginDate")
   dim strBeginHour= request.form("ddBeginHour")
   dim strBeginMin = request.form("ddBeginMinute")
   
   dim strEndDate = request.form("txtEndDate")
   dim strEndHour = request.form("ddEndHour")
   dim strEndMin = request.form("ddEndMinute")
   
   dim i
   dim strControlDistrict

   dim arryControlDistrict = split(request.cookies("Telemetry")("ControlDistrict"), ",")
   if arryControlDistrict.length() > 1 then
     for i = 0 to (arryControlDistrict.length() - 1)
       if i <> (arryControlDistrict.length() - 1)
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "', "
       else
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "'"
       end if
     next i
   else
     strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
   end if

   if strBeginHour ="" then
     strBeginHour ="00"
   end if

   if strBeginMin ="" then
     strBeginMin ="00"
   end if

   if strEndHour ="" then
     strEndHour ="23"
   end if

   if strEndMin ="" then
     strEndMin ="59"
   end if
   
   if strBeginDate ="" then
     strBeginDate = Now().ToString("yyyy/MM/dd")
   end if
 
   if strEndDate ="" then
     strEndDate = Now().ToString("yyyy/MM/dd")
   end if
   
   dim strBeginDateTime = strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00"   
   dim strEndDateTime = strEndDate & " " & strEndHour & ":" & strEndMin & ":59"   
   
   if strSelectedReport="" then
     strSelectedReport ="0"
   end if
   
   if strSelectedSite="" then
     strSelectedSite ="0"
   end if

   if strSelectedAlertType="" then
     strSelectedAlertType ="0"
   end if

   strConn = ConfigurationSettings.AppSettings("DSNPG")
   'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   sqlRs1 = new ADODB.Recordset()
   
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
  width: 90%;
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

<form name="formX" action="Reports.aspx" method="POST">
<script language="javascript">DrawCalendarLayout();</script>

<div align="center">
<br>
<p ><img border="0" src="images/TelemetryHistoryReport.jpg">
<br>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="80%">
    <tr>
      <td width="100%" bgcolor="#465AE8" height="20"><b><font color="#FFFFFF" size="1" face="Verdana">&nbsp;Report
        Criteria :</font></b></td>
    </tr>
    <tr>
      <td width="100%" style="border-width: 1px; border-style: solid; border-color: #3952F9">
        <div align="center">
          <table border="0" cellspacing="1" width="100%">
            <tr>
              <td width="110%" colspan="4">&nbsp;</td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><font class="bodytxt">
              <input type="text" name="txtBeginDate" size="12" style="border-width: 1px; border-style: solid; border-color: #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9; height: 20" 
               value="<%=strBeginDate%>" readonly>&nbsp; </font>
                 <a href="javascript:ShowCalendar('txtBeginDate', 190, 243);">
                   <img border="1" src="images/Calendar.jpg" width="19" height="14">
                   &nbsp;
                 </a>
                &nbsp;
                 <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
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
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>End Date </b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><input type="text" name="txtEndDate" size="12" style="border-width: 1px; border-style: solid; border-color: #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9; height: 20"
                 value="<%=strEndDate%>" readonly>&nbsp;
                <a href="javascript:ShowCalendar('txtEndDate', 190, 243);"><img border="1" src="images/Calendar.jpg" width="19" height="14">
                &nbsp;
                </a>
                &nbsp;
                 <font face="Verdana" size="1" color="#5F7AFC"><b>Hour:</b></font>
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
                </select></td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Site</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select size="1" name="ddSite" class="FormDropdown1" onchange="javascript:gotoSubmit('Site')">
                  <option value="0">- Select Site -</option>
                  <%
                    dim intSiteID
                    dim strSites

                    objConn.open(strConn)

                    if arryControlDistrict(0) <> "ALL" then
                          sqlRs.Open("select siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as Sites " & _
                                     "from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ")" & _
                                     "and siteid not in ('8511','8512','8619','8620','8621','8643','8546') order by sitedistrict, sitetype, sitename", objConn)
                    else
                          sqlRs.Open("select siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as Sites " & _
                                     "from telemetry_site_list_table " & _
                                     "where siteid not in ('8511','8512','8619','8620','8621','8643','8546') order by sitedistrict, sitetype, sitename", objConn)
                    end if
                    
                    do while not sqlRs.EOF
                      intSiteID = sqlRs("siteid").value 
                      strSites = sqlRs("Sites").value
                     
                  %>
                  <option value="<%=intSiteID%>"><%=strSites%></option>
                  <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    objConn = nothing
                  %>
                  
                </select>
              </td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Report</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select size="1" name="ddReport" class="FormDropdown" onchange="javascript:gotoSubmit('Report')">
                  <option value="0">- Select Report -</option>
                  
                  <option value="1">Alarm Report</option>
                  <option value="2">Event Report</option>
                  <option value="3">Log Report</option>
                </select>
              </td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Alert Type</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select size="1" name="ddAlert" class="FormDropdown">
                  <option value="0">- Select Alert Type -</option>
                  <%
                    dim strLog
                    dim strAlertType
                    
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    
                    if strSelectedReport ="1"
                      sqlRs.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & strSelectedSite & "' and alarmmode='ALARM'", objConn)
                    else if strSelectedReport ="2"
                      sqlRs.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & strSelectedSite & "' and alarmmode='EVENT'", objConn)
                    else 
                      sqlRs.Open("Select 'None' as alarmtype", objConn)
                    
                    end if
                    if strSelectedReport <>"3" and not sqlRs.EOF then
                    
                  %>
                  <option value="-1">ALL Types </option>
                  <%
                    end if
                    do while not sqlRs.EOF
                      if sqlRs("alarmtype").value <> "None" then
                        strAlertType = sqlRs("alarmtype").value 

                  %>
                  <option value="<%=strAlertType%>"><%=strAlertType%></option>
                  <%
                      end if
                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    sqlRs = nothing
                    objConn =nothing
                  %>
                </select>
              </td>
            </tr>
            <tr>
              <td width="110%" colspan="4">&nbsp;</td>
            </tr>
  </center>
          </table>
        </div>
      </td>
    </tr>
  </table>
</div>
</div>
<p align="center"><a href="javascript:gotoSubmit('Submit');"><img border="0" src="images/Submit_s.jpg"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:save2Excel();"><img border="0" src="images/SaveExcel.jpg"></a></p>




<div align="center">
  <center>
<!-*******************************************************************************************************
  ALARM REPORT GENERATION
  *******************************************************************************************************!>

  <%if strSelectedReport = "1" and strSubmit ="YES" then%>
  <table border="0" cellpadding="0" cellspacing="0" width="95%">
    <tr>
      <td width="60%" align="center" valign="top">
        <div align="center">
  
        <table border="0" cellspacing="1" width="100%">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <td align="center" height="20" width="60%"><font face="Verdana" size="1"><b>DateTime</b></font></td>
            <td align="center" height="20" width="40%"><font face="Verdana" size="1"><b>Alarm Type</b></font></td>
          </tr>

          <%
             dim intNum = 0
             dim strAlarmType
             
             objConn = new ADODB.Connection()
             sqlRs = new ADODB.Recordset()
             
             objConn.open(strConn)
             if strSelectedAlertType="-1" then
               sqlRs.Open("select sequence, alarm from telemetry_alarm_history_table " & _
                          " where siteid ='" & strSelectedSite  & "' " & _
                          " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" , objConn)
             else
               sqlRs.Open("select sequence, alarm from telemetry_alarm_history_table " & _
                          " where siteid ='" & strSelectedSite  & "' " & _
                          " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                          " and alarm ='" & strSelectedAlertType  & "'", objConn)
             
             end if
             do while not sqlRs.EOF
              
               strDateTime = sqlRs("sequence").value
               strAlarmType = sqlRs("alarm").value
               if intNum = 0 then
                 intNum = 1

           %>

          <tr bgcolor="#FFFFFF">
          <%
               elseif intNum = 1 then
                 intNum = 0
          %>
          <tr bgcolor="#E7E8F8">
          <%
               end if
          %>
    
            <td style="margin-left: 5" width="17%"><font class="bodytxt"><%=strDateTime%></font></td>
            <td style="margin-left: 5"><font class="bodytxt"><%=strAlarmType%></font></td>
      
          </tr>
          <%

               sqlRs.movenext
             Loop
                
             sqlRs.close()
             objConn.close()
             sqlRs = nothing
             objConn = nothing
          %>      
        </table>
        </div>
      </td>
      <td width="40%" align="right" valign="top">
        <div align="center">
          <table border="0" cellspacing="1" width="90%">
            <tr style="background-color: #465AE8; color: #FFFFFF">
              <td align="center" height="20" width="60%"><font face="Verdana" size="1"><b>Alarm Type</b></font></td>
              <td align="center" height="20" width="40%"><font face="Verdana" size="1"><b># Alert</b></font></td>
            </tr>
          <%
             intNum = 0
             
             objConn = new ADODB.Connection()
             sqlRs = new ADODB.Recordset()
             
             objConn.open(strConn)
            
             if strSelectedAlertType="-1" then
               sqlRs1.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & _
                            strSelectedSite & "' and alarmmode='ALARM'", objConn)
             else
               sqlRs1.Open("Select '" & strSelectedAlertType & "' as alarmtype", objConn)
             end if
             do while not sqlRs1.EOF
               sqlRs.Open("select count(alarm) as AlarmCount from telemetry_alarm_history_table " & _
                          " where siteid ='" & strSelectedSite  & "' " & _
                          " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                          " and alarm ='" & sqlRs1("alarmtype").value  & "'", objConn)
               if not sqlRs.EOF
                 intAlarmCount = sqlRs("AlarmCount").value
               end if
               sqlRs.close()
               if intNum = 0 then
                 intNum = 1

           %>

          <tr bgcolor="#FFFFFF">
          <%
               elseif intNum = 1 then
                 intNum = 0
          %>
          <tr bgcolor="#E7E8F8">
          <%
               end if
          %>
    
            <td style="margin-left: 5" width="17%"><font class="bodytxt"><b><%=sqlRs1("alarmtype").value%></b></font></td>
            <td style="margin-left: 5"><font class="bodytxt"><%=intAlarmCount%></font></td>
      
          </tr>
          <%
                
               sqlRs1.movenext
             Loop
           sqlRs1.close()
           objConn.close()
           sqlRs1 = nothing
           sqlRs = nothing
           objConn = nothing
           %>      
          </table>
        </div>
      </td>
    </tr>
  </table>
</div>
<!-*******************************************************************************************************
  EVENT REPORT GENERATION
  *******************************************************************************************************!>
  
  <%else if strSelectedReport="2"  and strSubmit ="YES" then%>

  <table border="0" cellpadding="0" cellspacing="0" width="99%">
    <tr>
      <td width="80%" align="center" valign="top">
        <div align="center">
  <table border="0" cellspacing="1" width="100%">
    <tr style="background-color: #465AE8; color: #FFFFFF">
      <td align="center" height="20" width="25%"><font face="Verdana" size="1"><b>DateTime</b></font></td>
      <td align="center" height="20" width="8%"><font face="Verdana" size="1"><b>Index</b></font></td>
      <td align="center" height="20" width="49%"><font face="Verdana" size="1"><b>Equipment</b></font></td>
      <td align="center" height="20" width="8%"><font face="Verdana" size="1"><b>Value</b></font></td>
      <td align="center" height="20" width="10%"><font face="Verdana" size="1"><b>Event</b></font></td>
    </tr>

    <%
       dim intNum = 0
       dim intIndex
       dim intPosition
       dim intValue
       dim strEvent

       objConn = new ADODB.Connection()    
       sqlRs = new ADODB.Recordset()
       objConn.open(strConn)
       
      
       if strSelectedAlertType="-1" then
       sqlRs.Open("select ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _  
                  "from telemetry_event_history_table l, telemetry_equip_list_table e " & _ 
                  "where l.siteid ='" & strSelectedSite  & "' and l.siteid = e.siteid " & _
                  "  and l.position = e.position " & _
                  "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                  "' and equipname not in ('DATE','TIME')", objConn)

       else
       sqlRs.Open("select ""desc"", equipname, l.index, l.sequence, l.value, l.event " & _  
                  "from telemetry_event_history_table l, telemetry_equip_list_table e " & _ 
                  "where l.siteid ='" & strSelectedSite  & "' and l.siteid = e.siteid " & _
                  "  and l.position = e.position " & _ 
                  "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & _
                  "' and event='"& strSelectedAlertType & "'", objConn)
      
       end if
       
       do while not sqlRs.EOF
              
         strDateTime = sqlRs("sequence").value
         intIndex = sqlRs("index").value
         intPosition = sqlRs("desc").value & " : " & sqlRs("equipname").value
         intValue = sqlRs("value").value
         strEvent = sqlRs("event").value
        
        if intNum = 0 then
           intNum = 1

     %>

    <tr bgcolor="#FFFFFF">
    <%
         elseif intNum = 1 then
           intNum = 0
    %>
    <tr bgcolor="#E7E8F8">
    <%
         end if
    %>
    
      <td style="margin-left: 5"><font class="bodytxt"><%=strDateTime%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=intIndex%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=intPosition%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=FormatNumber(intValue, 3)%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=strEvent%></font></td>

    </tr>
    <%

         sqlRs.movenext
       Loop
                
       sqlRs.close()
       objConn.close()
       objConn = nothing
    %>      
  </table>
      </td>
      <td width="20%" align="right" valign="top">
        <div align="center">
          <table border="0" cellspacing="1" width="90%">
            <tr style="background-color: #465AE8; color: #FFFFFF">
              <td align="center" height="20" width="60%"><font face="Verdana" size="1"><b>Alarm Type</b></font></td>
              <td align="center" height="20" width="40%"><font face="Verdana" size="1"><b># Alert</b></font></td>
            </tr>
          <%
             dim intEventCount
             intNum = 0
             
             objConn = new ADODB.Connection()
             sqlRs1 = new ADODB.Recordset()
             objConn.open(strConn)
            
             if strSelectedAlertType="-1" then
               sqlRs1.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & _
                            strSelectedSite & "' and alarmmode='EVENT'", objConn)
             else
               sqlRs1.Open("Select '" & strSelectedAlertType & "' as alarmtype", objConn)
             end if
             do while not sqlRs1.EOF
               sqlRs.Open("select count(event) as EventCount from telemetry_event_history_table " & _
                          " where siteid ='" & strSelectedSite  & "' " & _
                          " and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'" & _
                          " and event ='" & sqlRs1("alarmtype").value  & "'", objConn)
               if not sqlRs.EOF
                 intEventCount = sqlRs("EventCount").value
               end if
               sqlRs.close()
               if intNum = 0 then
                 intNum = 1

           %>

          <tr bgcolor="#FFFFFF">
          <%
               elseif intNum = 1 then
                 intNum = 0
          %>
          <tr bgcolor="#E7E8F8">
          <%
               end if
          %>
    
            <td style="margin-left: 5" width="17%"><font class="bodytxt"><b><%=sqlRs1("alarmtype").value%></b></font></td>
            <td style="margin-left: 5"><font class="bodytxt"><%=intEventCount%></font></td>
      
          </tr>
          <%
                
               sqlRs1.movenext
             Loop
           sqlRs1.close()
           objConn.close()
           sqlRs = nothing
           sqlRs1 = nothing
           objConn =nothing
           %>      
          </table>
        </div>
      </td>
    </tr>
  </table>
</div>
<!-*******************************************************************************************************
  LOG REPORT GENERATION
  *******************************************************************************************************!>
  <%else if strSelectedReport="3"  and strSubmit ="YES" then%>

  <table border="0" cellspacing="1" width="70%">
    <tr style="background-color: #465AE8; color: #FFFFFF">
      <td align="center" height="20" width="15%"><font face="Verdana" size="1"><b>Date</b></font></td>
      <td align="center" height="20" width="15%"><font face="Verdana" size="1"><b>Time</b></font></td>
      <td align="center" height="20" width="50%"><font face="Verdana" size="1"><b>Equipment</b></font></td>
      <td align="center" height="20" width="10%"><font face="Verdana" size="1"><b>Value</b></font></td>
      <td align="center" height="20" width="10%"><font face="Verdana" size="1"><b>Rule</b></font></td>
    </tr>

    <%
       dim intNum = 0
       dim strEquip
       dim intValue
       dim strRule
       dim strDate
       dim strTime
       
       objConn = new ADODB.Connection()
       sqlRs = new ADODB.Recordset()
       objConn.open(strConn)
       
       'if strSelectedAlertType <> "0" then
       
         sqlRs.Open("select ""desc"", equipname, sequence, value  " & _
                    "from telemetry_log_table l, telemetry_equip_list_table e " & _
                    "where l.siteid ='" & strSelectedSite  & "' and l.siteid = e.siteid " & _
                    "  and l.position = e.position " & _
                    "  and sequence >= '" & strBeginDateTime & "' and sequence <= '" & strEndDateTime & "'", objConn)
         do while not sqlRs.EOF
              
           strDateTime = sqlRs("sequence").value
           strDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(strDateTime))
           strTime = String.Format("{0:hh:mm:ss tt}", Date.Parse(strDateTime))

           strEquip = sqlRs("desc").value & " : " & sqlRs("equipname").value
           intValue = sqlRs("value").value
        
            val = FormatNumber(intValue)
           if intNum = 0 then
             intNum = 1

     %>

    <tr bgcolor="#FFFFFF">
    <%
           elseif intNum = 1 then
             intNum = 0
    %>
    <tr bgcolor="#E7E8F8">
    <%
           end if
    %>
    
      <td style="margin-left: 5"><font class="bodytxt"><%=strDate%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=strTime%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=strEquip%></font></td>
      <td style="margin-left: 5"><font class="bodytxt"><%=intValue%></font></td>
	  <td style="margin-left: 5"><font class="bodytxt"><%=GetAlarmType(strConn,strSelectedSite,2,intValue)%></font></td>
    </tr>
    <%

         sqlRs.movenext
       Loop
       
       sqlRs.close()
       'end if
       objConn.close()
       sqlRs = nothing
       objConn = nothing
    %>      
  </table>
  
  <%end if%>
  </center>
</div>
<p align="center">&nbsp;</p>
<input type="hidden" name="txtSubmit" value="">
<input type="hidden" name="txtSiteName" value="">
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
<p>
<IFRAME id="_excel" name="_excel" style="width:0px;height:0px;position:absolute;top:20;left:40;display:inline;" frameborder=0 scrolling=no marginwidth=0 src="about:blank" marginheight=0></iframe>
</p>
</body>
</html>

<script language="javascript">
    
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
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
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

    strURL = strURL + "ddSite=" + strSite  + "&ddSiteName=" + strSiteName + "&ddAlert=" + strAlert;
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
    top.location.href = "login.aspx";
  }
  
</script>