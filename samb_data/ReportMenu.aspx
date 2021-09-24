<html>
<head>
<title>Graphical Analysis</title>
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
  border: 1px solid #CBD6E4;
  }

</style>

</head>
<body bgcolor="#FFFFFF">
<script type="text/javascript" src="event.js"></script>

<form name="frmAdmin" method="POST">
<div align="center">
<br>
<p ><img border="0" src="../images/report.jpg" onclick="popup('../helpfiles/default.aspx?c=pump_indicator',500,500);return false;">
<br>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="60%">
    <tr>
      <td width="100%" bgcolor="#465AE8" height="20"><b><font color="#FFFFFF" size="1" face="Verdana">
        &nbsp;Graphical Analysis Utilities:</font></b></td>
    </tr>
    <tr>
      <td width="100%" style="border: 1px solid #3952F9">
        <div align="center">
          <table border="0" cellspacing="1" width="100%">
            <tr>
              <td width="110%" colspan="4">&nbsp;</td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Page</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select size="1" name="ddPage" class="FormDropdown" onchange="javascript:goPages(this.value)">
                  <option value="0">- Select Report -</option>
                  <!--<option value="TrendComparison">Multiple Trends Analysis Chart</option>-->
                  <option value="Level">Water Level & Rainfall Report</option>
                  <option value="History">History Log Report</option>
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
<input type="hidden" name="txtSiteName" value="">
</form>
<br>
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>
</body>
</html>
<script language="javascript"> 

  function goPages(strPage)
  {
    if (strPage=="Level")
    {
      popup('datatable_selection.aspx',window.parent.getwinsize('width'),window.parent.getwinsize('height'));
      return false;
    }
    else if (strPage=="Event")
    {
      document.forms[0].action="EventChart.aspx";
    }
    else if (strPage=="History")
    {
      document.forms[0].action="../admin/logview.aspx";
    }
    document.forms[0].submit();
  }

</script>
<!--#include file="session.inc"-->