<html>
<head>
<title>Reports Analysis</title>
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
  width: 295px;
  border: 1 solid #CBD6E4;
  }

</style>
<script language=javascript>
//function loadleft()
//{
//// var obj=document.polling;
//// obj.action="left.aspx";
//// obj.target="contents";
//// obj.submit();
// window.parent.frames[1].location="left.aspx";
//}
</script>

</head>
<body bgcolor="#FFFFFF" >
<script language="JavaScript" src="event.js"></script>
<script language="JavaScript" src="TWCalendar.js"></script>

<form name="frmAdmin" method="POST" >
<script lanaguage="javascript">DrawCalendarLayout();</script>

<div align="center">
<br>
<p ><img border="0" src="images/ReportsAnalysis.jpg">
<br>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="60%">
    <tr>
      <td width="100%" bgcolor="#465AE8" height="20"><b><font color="#FFFFFF" size="1" face="Verdana">
        &nbsp;Report Analysis Utilities:</font></b></td>
    </tr>
    <tr>
      <td width="100%" style="border: 1 solid #3952F9">
        <div align="center">
          <table border="0" cellspacing="1" width="100%">
            <tr>
              <td width="110%" colspan="4">&nbsp;</td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Report</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%">
                <select size="1" name="ddPage" class="FormDropdown" onchange="javascript:goPages(this.value)">
                  <option value="0">- Select Report -</option>
                  <option value="report">Telemetry History Reports</option>
				  <%--<option value="acq">Level Log Data Acquisition Reports</option>--%>
                 <!--  <option value="Alarm">Alarm Report</option>-->
                <!--   <option value="Event">Event Report</option>-->
                 <!--  <option value="Log">Log Report</option>-->
                    <!-- <option value="GPRS">GPRS Data Report</option> -->
                   <%-- <option value="summ">Flow and Pressure Reports</option>--%>
                    <option value="inout">Sites In-Out flow</option>
                  <option value="res">Reservoir Info Reports</option>
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
<div align="center">
  <center>
  
  </center>
</div>
<p align="center">&nbsp;</p>
</form>
<p>&nbsp;</p>

</body>

</html>

<script language="javascript">  

  function goPages(strPage)
  {
    if (strPage=="acq")
    {
      popup('http://www.g1.com.my/extension/data_acquisition/Melakadatatable_selection.aspx?uid=1',getwinsize('width'),getwinsize('height'));
      return false;
    }
    if (strPage=="report")
    {
      document.forms[0].action="MelakaReports.aspx";
    }
    else if (strPage=="Alarm")
    {
      document.forms[0].action="AlarmReport.aspx";
    }
    else if (strPage=="Event")
    {
      document.forms[0].action="EventReport.aspx";
    }
    else if (strPage=="Log")
    {
      document.forms[0].action="LogReport.aspx";
    }
    else if (strPage=="GPRS")
    {
      document.forms[0].action="GPRS.aspx";
    }
    else if (strPage=="summ")
    {
     window.parent.frames[1].location="Melakareportssummarymenu.aspx";

    }
    else if (strPage=="inout")
    {
     document.forms[0].action="Melakainoutflow.aspx";

    }
    else if (strPage=="res")
    {
      document.forms[0].action="Melakareserinforeport.aspx";
    }
    document.forms[0].submit();
  }

  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }

function goPages1(strPage)
  {
 
      
       if (document.formX.ddSite.value=="0")
      {
        alert("Please select equipments !");
      }
      else if(document.formX.ddAlert.value=="0")
	{
        alert("Please select time !");
      }
else

      {
 var strSiteName1 = document.getElementById("ddSite")(document.formX.ddSite.selectedIndex).value;

 if (strPage=="Acknowledgment")
    {
     document.forms[0].action="AcknowledgementReport.aspx";
    }
     
    else if (strPage=="Alarm")
    {
      document.forms[0].action="AlarmReport.aspx";
    }
    else if (strPage=="Event")
    {
      document.forms[0].action="EventReport.aspx";
    }
    else if (strPage=="Log")
    {
      document.forms[0].action="LogReport.aspx";
    }
    else if (strPage=="GPRS")
    {
      document.forms[0].action="GPRS.aspx";
    }
    else if (strPage=="Dispatch")
    {
      document.forms[0].action="DispatchReport.aspx";
    }
    document.forms[0].submit();
    }
  }  

</script>

