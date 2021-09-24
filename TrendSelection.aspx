<!-- #Include file="FC_Color.aspx" -->
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
   dim objConn
   dim sqlRs
   dim strConn
   dim strDateTime

   dim intCounter
   dim strXMLData = ""
   dim intNoData = "NO"
   
   dim strSelectedDistrict = request.form("ddDistrict")
   dim intSelectedSite1ID = request.form("ddSite1")
   dim intSelectedSite2ID = request.form("ddSite2")
   dim intSelectedSite3ID = request.form("ddSite3")
   dim intSelectedSite4ID = request.form("ddSite4")
   
   dim strSiteName = request.form("txtSiteName")
      
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

   if strSelectedDistrict="" then
     strSelectedDistrict ="0"
   end if

   if intSelectedSite1ID="" then
     intSelectedSite1ID ="0"
   end if

   if intSelectedSite2ID="" then
     intSelectedSite2ID ="0"
   end if

   if intSelectedSite3ID="" then
     intSelectedSite3ID ="0"
   end if

   if intSelectedSite4ID="" then
     intSelectedSite4ID ="0"
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
     strEndMin ="45"
   end if
   
   if strBeginDate ="" then
     strBeginDate = Now().ToString("yyyy/MM/dd")
   end if
 
   if strEndDate ="" then
     strEndDate = Now().ToString("yyyy/MM/dd")
   end if
   
   dim strBeginDateTime = strBeginDate & " " & strBeginHour & ":" & strBeginMin & ":00"   
   dim strEndDateTime = strEndDate & " " & strEndHour & ":" & strEndMin & ":59"   
   

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()

' Set combo #2 and above visibility
	dim Visibiliti2, Visibiliti3, Visibiliti4
	if (Request.Browser.Browser="Netscape") or ((Request.Browser.Browser)="Opera") Then
		if intSelectedSite1ID <> 0 then
			Visibiliti2 = "visible"
		else
			Visibiliti2 = "hidden"
		end if
		if intSelectedSite2ID <> 0 then
			Visibiliti3 = "visible"
		else
			Visibiliti3 = "hidden"
		end if
		if intSelectedSite3ID <> 0 then
			Visibiliti4 = "visible"
		else
			Visibiliti4 = "hidden"
		end if
	else		
		Visibiliti2 = "hidden"
		Visibiliti3 = "hidden"
		Visibiliti4 = "hidden"
	end if

%>
<html>
<head>
<title>Trend Comparison Selection</title>
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
  width: 200px;
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }
.FormDropdown1
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 450px;
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

<form name="formX" action="MultipleTrendAnalysisChart.aspx" method="POST">
<script language="javascript">DrawCalendarLayout();</script>

<div align="center">
<br>
<p ><img border="0" src="images/MultipleTrend.jpg">
<br>
<br>
<div align="center">
  <table border="0" cellspacing="1" width="80%">
    <tr>
      <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font></td>
      <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
      <td width="77%" colspan="2"><font class="bodytxt">
        <input type="text" name="txtBeginDate" size="12" style="border-width: 1px; border-style: solid; border-color: #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9; height: 20" 
         value="<%=strBeginDate%>" readonly>&nbsp; </font>
        <a href="javascript:ShowCalendar('txtBeginDate', 170, 225);">
          <img border="1" src="images/Calendar.jpg" width="19" height="14">
           &nbsp;</a>&nbsp;
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
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="45">45</option>
          </select>              

      </td>
    </tr>
    <tr>
      <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>End Date </b></font></td>
      <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
      <td width="77%" colspan="2"><input type="text" name="txtEndDate" size="12" style="border-width: 1px; border-style: solid; border-color: #5F7AFC; font-family: Verdana; font-size: 10pt; color: #3952F9; height: 20"
       value="<%=strEndDate%>" readonly>&nbsp;
        <a href="javascript:ShowCalendar('txtEndDate', 170, 225);"><img border="1" src="images/Calendar.jpg" width="19" height="14">
         &nbsp;</a>&nbsp;
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
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="45">45</option>
          </select></td>
        </tr>

        <tr>
          <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>District</b></font></td>
          <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
          <td width="77%" colspan="2"><select size="1" name="ddDistrict" class="FormDropdown" onchange="javascript:gotoSubmit(1);">
                  <option value="0">- Select District -</option>
                  <%
                    dim strDistrict
                   
                     objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    
                    if arryControlDistrict(0) <> "ALL" then
                      sqlRs.Open("select distinct sitedistrict from telemetry_site_list_table " & _
                                 " where sitedistrict in (" & strControlDistrict & ") order by sitedistrict", objConn)
                    else
                      sqlRs.Open("select distinct sitedistrict from telemetry_site_list_table where sitedistrict not in('','Dismantle','Hidden')  order by sitedistrict", objConn)
                    end if

                    if not sqlRs.EOF then
                     %>
                    <option value="ALL">ALL</option>
                    <%
                    end if

                    do while not sqlRs.EOF
                      strDistrict = sqlRs("sitedistrict").value  
                      %>
                      <option value="<%=strDistrict%>"><%=strDistrict%></option>
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
          <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>1st Equipment</b></font></td>
          <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
          <td width="77%" colspan="2"><select size="1" name="ddSite1" class="FormDropdown1" onchange="javascript:HideShowSites(this.value, 1);">
                  <option value="0">- Select Equipment -</option>
                  <%
                    dim intSiteID1
                    dim strSites1
                    dim intPosition1

                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    if strSelectedDistrict="ALL" then
                     sqlRs.Open("select s.siteid, s.sitedistrict + ' : ' + s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where " & _
		               "s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitedistrict , s.sitetype, s.sitename, e.sdesc", objConn) 
                    else
                    sqlRs.Open("select s.siteid, s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where s.sitedistrict = '" & strSelectedDistrict & "' " & _
		               " and s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitetype, s.sitename, e.sdesc", objConn)
                    end if
                    do while not sqlRs.EOF
                      intSiteID1 = sqlRs("siteid").value 
                      strSites1 = sqlRs("sites").value
                      intPosition1 = sqlRs("position").value
                  %>
                  <option value="<%=intSiteID1%>,<%=intPosition1%>"><%=strSites1%></option>
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
            
              <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>2nd Equipment</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="77%" colspan="2">
              <div id ="divSite2" style="visibility:<%=visibiliti2%>;">
              <select size="1" name="ddSite2" class="FormDropdown1" onchange="javascript:HideShowSites(this.value, 2);">
                  <option value="0">- Select Equipment -</option>
                  <%
                    dim intSiteID2
                    dim strSites2
                    dim intPosition2

                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    if strSelectedDistrict="ALL" then
                     sqlRs.Open("select s.siteid, s.sitedistrict + ' : ' + s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where " & _
		               "s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitedistrict , s.sitetype, s.sitename, e.sdesc", objConn) 
                    else
                    sqlRs.Open("select s.siteid, s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where s.sitedistrict = '" & strSelectedDistrict & "' " & _
		               " and s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitetype, s.sitename, e.sdesc", objConn)
                    end if
                    do while not sqlRs.EOF
                      intSiteID2 = sqlRs("siteid").value 
                      strSites2 = sqlRs("sites").value
                      intPosition2 = sqlRs("position").value
                     
                  %>
                  <option value="<%=intSiteID2%>,<%=intPosition2%>"><%=strSites2%></option>
                  <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    objConn = nothing
                  %>
                  
                </select>
                </div>
              </td>
              
            </tr>
            
            <tr>
              <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>3rd Equipment</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="77%" colspan="2">
              <div id ="divSite3" style="visibility:<%=visibiliti3%>;">
                <select size="1" name="ddSite3" class="FormDropdown1" onchange="javascript:HideShowSites(this.value, 3);">
                  <option value="0">- Select Equipment -</option>
                  <%
                    dim intSiteID3
                    dim strSites3
                    dim intPosition3

                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    if strSelectedDistrict="ALL" then
                     sqlRs.Open("select s.siteid, s.sitedistrict + ' : ' + s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where " & _
		               "s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitedistrict , s.sitetype, s.sitename, e.sdesc", objConn) 
                    else
                    sqlRs.Open("select s.siteid, s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where s.sitedistrict = '" & strSelectedDistrict & "' " & _
		               " and s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitetype, s.sitename, e.sdesc", objConn)
                    end if
                    do while not sqlRs.EOF
                      intSiteID3 = sqlRs("siteid").value 
                      strSites3 = sqlRs("sites").value
                      intPosition3 = sqlRs("position").value
                     
                  %>
                  <option value="<%=intSiteID3%>,<%=intPosition3%>"><%=strSites3%></option>
                  <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    objConn = nothing
                  %>
                </div>  
                </select>
              </td>
            </tr>
          <tr>
              <td width="20%"><font face="Verdana" size="1" color="#5F7AFC"><b>4th Equipment</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="77%" colspan="2">
               <div id ="divSite4" style="visibility:<%=visibiliti4%>;">
                <select size="1" name="ddSite4" class="FormDropdown1">
                  <option value="0">- Select Equipment -</option>
                  <%
                    dim intSiteID4
                    dim strSites4
                    dim intPosition4

                    objConn = new ADODB.Connection()
                    objConn.open(strConn)
                    if strSelectedDistrict="ALL" then
                     sqlRs.Open("select s.siteid, s.sitedistrict + ' : ' + s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		               "from telemetry_site_list_table s, telemetry_equip_list_table e where " & _
		               "s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		               " and s.siteid NOT IN ("& strKontID &") order by s.sitedistrict , s.sitetype, s.sitename, e.sdesc", objConn) 
                    else
                    sqlRs.Open("select s.siteid, s.sitetype + ' : ' + s.sitename + ' : ' + sdesc  as sites, position " & _
		                 "from telemetry_site_list_table s, telemetry_equip_list_table e where s.sitedistrict = '" & strSelectedDistrict & "' " & _
		                 " and s.siteid = e.siteid and sdesc not in ('DATE','TIME','-') " & _
		                 " and s.siteid NOT IN ("& strKontID &") order by s.sitetype, s.sitename, e.sdesc", objConn)
                    end if
                    do while not sqlRs.EOF
                      intSiteID4 = sqlRs("siteid").value 
                      strSites4 = sqlRs("sites").value
                      intPosition4 = sqlRs("position").value
                     
                  %>
                  <option value="<%=intSiteID4%>,<%=intPosition4%>"><%=strSites4%></option>
                  <%

                      sqlRs.movenext
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    objConn = nothing
                  %>
                </div>
                </select>
              </td>
            </tr>

            <tr>
              <td valign="bottom" colspan=4 align="right">
                <a href="javascript:gotoSubmit(2);"><img border="0" src="images/Submit_s.jpg"></a>
              </td>
            </tr>
          </table>
        </div>
 
<br>

</div>

<input type="hidden" name="txtSiteName1" value="">
<input type="hidden" name="txtSiteName2" value="">
<input type="hidden" name="txtSiteName3" value="">
<input type="hidden" name="txtSiteName4" value="">
</form>
</body>
</html>

<script language="javascript">
  
  document.formX.ddBeginHour.value="<%=strBeginHour%>";
  document.formX.ddBeginMinute.value="<%=strBeginMin%>";
  document.formX.ddEndHour.value="<%=strEndHour%>";
  document.formX.ddEndMinute.value="<%=strEndMin%>";
  document.formX.ddDistrict.value="<%=strSelectedDistrict%>";
  document.formX.ddSite1.value="<%=intSelectedSite1ID%>";
  document.formX.ddSite2.value="<%=intSelectedSite2ID%>";
  document.formX.ddSite3.value="<%=intSelectedSite3ID%>";
  document.formX.ddSite4.value="<%=intSelectedSite4ID%>";
  
  var strSiteName1 = document.getElementById("ddSite1")(document.formX.ddSite1.selectedIndex).innerHTML;
  var strSiteName2 = document.getElementById("ddSite2")(document.formX.ddSite2.selectedIndex).innerHTML;
  var strSiteName3 = document.getElementById("ddSite3")(document.formX.ddSite3.selectedIndex).innerHTML;
  var strSiteName4 = document.getElementById("ddSite4")(document.formX.ddSite4.selectedIndex).innerHTML;
   
 if (document.formX.ddSite1.value != "0")
 {
   divSite2.style.visibility = 'visible';
 }
 if (document.formX.ddSite2.value != "0")
 {
   divSite3.style.visibility = 'visible';
 }
 if (document.formX.ddSite3.value != "0")
 {
   divSite4.style.visibility = 'visible';
 } 

frmTargetForm = "formX";
var strSession = 'true';
if (strSession != "true")
{
   top.location.href = "login.aspx";
} 

</script>
<script language="javascript">
  function gotoSubmit(intStatus)
  {
    if (intStatus == "2")
    {
      
      if (document.formX.ddDistrict.value =="0")
      {
        alert("Please select a District !");
      }
      else if (document.formX.ddSite1.value=="0" || document.formX.ddSite2.value=="0")
      {
        alert("Please select at least 2 equipments for trend comparison !");
      }
      else
      {
       document.formX.txtSiteName1.value = strSiteName1;
       document.formX.txtSiteName2.value = strSiteName2;
       document.formX.txtSiteName3.value = strSiteName3;
       document.formX.txtSiteName4.value = strSiteName4;
       document.formX.submit();
      }
    }
    else
    {
	  // Reselect the district, resetting the combos below
      document.formX.ddSite1.value ="0";      
      document.formX.ddSite2.value ="0";
      divSite2.style.visibility = 'hidden';
      document.formX.ddSite3.value ="0";
      divSite3.style.visibility = 'hidden';
      document.formX.ddSite4.value ="0";
      divSite4.style.visibility = 'hidden';
      document.formX.action ="TrendSelection.aspx";
      document.formX.submit();   
    }
  }  
  
  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
  }

  function HideShowSites(intValue, strField)
  {
    if (strField == 1)
    {    
      if (intValue != "0")
      {
        document.formX.ddSite2.value="0";
        divSite2.style.visibility = 'visible';
      }
      else
      {
        divSite2.style.visibility = 'hidden';
        document.formX.ddSite2.value="0";
        divSite3.style.visibility = 'hidden';
        document.formX.ddSite3.value="0";
        divSite4.style.visibility = 'hidden';
        document.formX.ddSite4.value="0";
      }
    }
    if (strField == 2)
    {    
      if (intValue != "0")
      {
        document.formX.ddSite3.value="0";
        divSite3.style.visibility = 'visible';
      }
      else
      {
        divSite3.style.visibility = 'hidden';
        document.formX.ddSite3.value="0";
        divSite4.style.visibility = 'hidden';
        document.formX.ddSite4.value="0";
      }
    }  
    if (strField == 3)
    {    
      if (intValue != "0")
      {
        document.formX.ddSite4.value="0";
        divSite4.style.visibility = 'visible';
      }
      else
      {
        divSite4.style.visibility = 'hidden';
        document.formX.ddSite4.value="0";
      }
    }  
  }
</script>