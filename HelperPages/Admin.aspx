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
  width: 158px;
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
  width: 40px;
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
<p ><img border="0" src="images/AdminMgmt.jpg">
<br>
<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="60%">
    <tr>
      <td width="100%" bgcolor="#465AE8" height="20"><b><font color="#FFFFFF" size="1" face="Verdana">&nbsp;Admin
        Management Utilities:</font></b></td>
    </tr>
    <tr>
      <td width="100%" style="border-width: 1px; border-style: solid; border-color: #3952F9;">
        <div align="center">
          <table border="0" cellspacing="1" width="100%">
            <tr>
              <td width="110%" colspan="4">&nbsp;</td>
            </tr>
            <tr>
              <td width="4%"></td>
              <td width="16%"><font face="Verdana" size="1" color="#5F7AFC"><b>Page</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="87%"><select size="1" name="ddPage" class="FormDropdown1" onchange="javascript:goPages(this.value)">
                  <option value="0">- Select Utility -</option>
                  <option value="Dispatch">Dispatch Management</option>
                  <option value="Equip">Equipment Management</option>
                  <option value="Site">Site Management</option>
                  <option value="Rule">Rule Management</option>
                  <option value="UnitConfig">Unit Configuration</option>
                  <option value="Unit">Unit Management</option>
                  <option value="User">User Management</option>
<option value="data">Dispatch Entry</option>
<option value="poi">POI Management</option>
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
     Copyright � 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</body>

</html>

<script language="javascript">
  

  function goPages(strPage)
  {
    if (strPage=="Dispatch")
    {
      document.frmAdmin.action="Dispatch.aspx";
    }
    else if (strPage=="UnitConfig")
    {
      document.frmAdmin.action="UnitConfig.aspx";
    }
    else if (strPage=="Unit")
    {
      document.frmAdmin.action="Unit.aspx";
    }
    else if (strPage=="Rule")
    {
      document.frmAdmin.action="Rule.aspx";
    }
    else if (strPage=="Site")
    {
      document.frmAdmin.action="Site.aspx";
    }
    else if (strPage=="Equip")
    {
      document.frmAdmin.action="Equipment.aspx";
    }
    else if (strPage=="User")
    {
      document.frmAdmin.action="User.aspx";
    }
 else if (strPage=="data")
    {
      document.frmAdmin.action="dispatchdata.aspx";
    }
     else if (strPage=="poi")
    {
      document.frmAdmin.action="poi.aspx";
    }
    document.frmAdmin.submit();
  }

  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>