<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
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
   
   
   if strSelectedSite="" then
     strSelectedSite ="0"
   end if

   if strSelectedAlertType="" then
     strSelectedAlertType ="0"
   end if

   strConn = ConfigurationSettings.AppSettings("DSNPG")
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
  border: 1px solid #CBD6E4;
  }
.FormDropdown1
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 295px;
  border: 1px solid #CBD6E4;
  }
.FormDropdown2 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 50px;
  border: 1px solid #CBD6E4;
  }

</style>

</head>
<body bgcolor="#FFFFFF">
<script language="JavaScript" src="TWCalendar.js"></script>

<form name="frmReport" action="AlarmReport.aspx" method="POST">
<script language="javascript">DrawCalendarLayout();</script>

<div align="center">
<br>
<p ><img border="0" src="images/AlarmReport.jpg">
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="70%">
    <tr>
      <td width="100%">
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
              <input type="text" name="txtBeginDate" size="12" style="border: 1px solid #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9; height: 20px" 
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
              <td width="87%"><input type="text" name="txtEndDate" size="12" style="border: 1px solid #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9; height: 20px"
                 value="<%=strEndDate%>" readonly>&nbsp;
                <a href="javascript:javascript:ShowCalendar('txtEndDate', 190, 243);"><img border="1" src="images/Calendar.jpg" width="19" height="14">
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
                                 "and siteid NOT IN ("& strKontID &") order by sitedistrict, sitetype, sitename",objConn)
                    else
                      sqlRs.Open("select siteid, sitedistrict || ' : ' || sitetype || ' : ' || sitename as Sites " & _
                                 "from telemetry_site_list_table " & _
                                 "where siteid NOT IN ("& strKontID &") order by sitedistrict, sitetype, sitename",objConn)
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
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Alarm Type</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select size="1" name="ddAlert" class="FormDropdown">
                  <option value="0">- Select Alert Type -</option>
                  <%
                    dim strLog
                    dim strAlertType
                    
                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    
                    sqlRs.Open("Select alarmtype from telemetry_rule_list_table where siteid ='" & strSelectedSite & "' and alarmmode='ALARM'", objConn)

                    if not sqlRs.EOF then
                    
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
                </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <a href="javascript:gotoSubmit('Submit');">
                  <img border="0" src="images/Submit_s.jpg" align="absbottom">
                </a>&nbsp;&nbsp;&nbsp;
                
                <a href="javascript:goCreateExcel()">
                  <img border="0" src="images/SaveExcel.jpg" align="absbottom">
                </a>
               
              </td>
            </tr>
            <td>&nbsp;
            </td>
            </center>
          </table>
        </div>
      </td>
    </tr>
  </table>
</div>
</div>
<div align="center" id="divWait" style="font-family:Verdana; font-size:8pt; color:red;">&nbsp;</div>
<!-*******************************************************************************************************
  ALARM REPORT GENERATION
  *******************************************************************************************************!>

<div align="center">
 <center>
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
               strDateTime = String.Format("{0:yyyy/MM/dd hh:mm:ss tt}", Date.Parse(strDateTime))
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
    
            <td style="margin-left: 5px" width="17%"><font class="bodytxt"><%=strDateTime%></font></td>
            <td style="margin-left: 5px"><font class="bodytxt"><%=strAlarmType%></font></td>
      
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
    
            <td style="margin-left: 5px" width="17%"><font class="bodytxt"><b><%=sqlRs1("alarmtype").value%></b></font></td>
            <td style="margin-left: 5px"><font class="bodytxt"><%=intAlarmCount%></font></td>
      
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


<p align="center">&nbsp;</p>
<input type="hidden" name="txtSubmit" value="">
<input type="hidden" name="txtSiteName" value="">
<p align="center" style="margin-bottom: 15px">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
<p>&nbsp;</p>

</body>

</html>

<script language="javascript">
  
  var test;
  document.forms[0].ddSite.value="<%=strSelectedSite%>";
  document.forms[0].txtSiteName.value="<%=strSelectedSite%>";
  document.forms[0].ddBeginHour.value="<%=strBeginHour%>";
  document.forms[0].ddBeginMinute.value="<%=strBeginMin%>";
  document.forms[0].ddEndHour.value="<%=strEndHour%>";
  document.forms[0].ddEndMinute.value="<%=strEndMin%>";
  document.forms[0].ddAlert.value="<%=strSelectedAlertType%>";

  function gotoSubmit(intStatus)
  {


   divWait.innerHTML = "<b>Loading, please wait...";
   document.forms[0].submit();

  }

  frmTargetForm = "frmReport";
  
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
    var strSite=document.forms[0].ddSite.value;
    var strSiteName = document.getElementById("ddSite")(document.forms[0].ddSite.selectedIndex).innerHTML;
    var strAlert=document.forms[0].ddAlert.value;
    var strBeginDate=document.forms[0].txtBeginDate.value;
    var strBeginHour=document.forms[0].ddBeginHour.value;
    var strBeginMin=document.forms[0].ddBeginMinute.value;
    var strEndDate=document.forms[0].txtEndDate.value;
    var strEndHour=document.forms[0].ddEndHour.value;
    var strEndMin=document.forms[0].ddEndMinute.value;

    strURL = "ExcelAlarmReport.aspx?"
    strURL = strURL + "ddSite=" + strSite  + "&ddSiteName=" + strSiteName + "&ddAlert=" + strAlert 
    strURL = strURL + "&ddBeginHour=" + strBeginHour + "&ddBeginMinute=" + strBeginMin
    strURL = strURL + "&txtBeginDate=" + strBeginDate + "&txtEndDate=" + strEndDate
    strURL = strURL + "&ddEndHour=" + strEndHour + "&ddEndMinute=" + strEndMin
    test = window.open(strURL, "Report",'height=10, width=10, Left=5000, Top=5000,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');

    setTimeout('CloseMe()',20000);

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