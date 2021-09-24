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
  border-width: 1px;
  border-style: solid;
  border-color: #CBD6E4;
  }

</style>

</head>
<body bgcolor="#FFFFFF">

<form name="frmAdmin" method="POST">

<div align="center">
<br>
<p ><img border="0" src="images/GraphicalAnalysis.jpg">
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
      <td width="100%" style="border-width: 1px;border-style: solid;border-color: #3952F9">
        <div align="center">
          <table border="0" cellspacing="1" width="100%">
            <tr>
              <td width="110%" colspan="4">&nbsp;</td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Page</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select class="FormDropdown" onchange="goPages(this.value);" size="1" name="ddPage">
                  <option value="0">- Select Utility -</option>
                  <option value="TrendComparison">Multiple Trends Analysis Chart</option>
                  <option value="TrendAnalysis">Water Level Trending Analysis Chart</option>
               
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
<input type="hidden" name="txtSiteName" value="">
</form>
<p>&nbsp;</p>

</body>

</html>

<script language="javascript">  

  function goPages(strPage)
  {
    if (strPage=="TrendComparison")
    {
      document.frmAdmin.action="MelakaTrendSelection.aspx";
    }
    else if(strPage=="TrendAnalysis")
    {
      document.frmAdmin.action="MelakaWTAnalysis.aspx";
    }
    document.frmAdmin.submit();
  }

  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }

</script>