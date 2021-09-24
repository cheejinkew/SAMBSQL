<script language="Javascript">
  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>


<html>

<head>
<title>Gussmann Vehicle Tracking System</title>
<style>
.FormDropdown 
  {
      font-family: Verdana, Arial, Helvetica, sans-serif;
      font-size: 12px;
      width: 130px;
      border: 1 solid #CBD6E4;
  }

.fontStyle 
  {
   font-family: Verdana, Arial;
   font-size: 11px;
   color: #4960F8
  }
</style>
</head>

<body>
<form method="post" action="AVLSUnitConfig.aspx" id="ctl00" style="font-family: Verdana; font-size: 6pt; color: #4960F8">
<div>
<input type="hidden" name="__EVENTTARGET" value="" />
<input type="hidden" name="__EVENTARGUMENT" value="" />
<input type="hidden" name="__LASTFOCUS" value="" />
<input type="hidden" name="__VIEWSTATE" value="/wEPDwUKMTIxMzMxMTczMQ9kFgJmD2QWAmYPDw8WBh4ORGF0YVZhbHVlRmllbGQFA0tleR4NRGF0YVRleHRGaWVsZAUFVmFsdWUeC18hRGF0YUJvdW5kZ2QQFQ0SLSBTZWxlY3QgVmVoaWNsZSAtBkpIRTczNwZPRkZJQ0UHV0ZUMTI2OAdXRlQ1MTI0B1dKUTYyODgHV0tHNjE5NwdXS0w4ODg4B1dMRTg5MTIGV01HMTEzB1dNTDg4MzMHV01XOTI1MQdXTkYxNzk4FQ0BMBBKSEU3MzcsMDAxMSxHN1YzEE9GRklDRSwwMDA4LEc3VjMRV0ZUMTI2OCwwMDA1LEc3VjMRV0ZUNTEyNCwwMDAyLEc3VjMRV0pRNjI4OCwwMDA2LEc3VjMRV0tHNjE5NywwMDEwLEc3VjMTV0tMODg4OCwxMjM0NTcsRzdHMhFXTEU4OTEyLDAwMDQsRzdWMxBXTUcxMTMsMDAwMSxHN1YzEVdNTDg4MzMsMDAwMyxHN1YzEVdNVzkyNTEsMDAwNyxHN1YzE1dORjE3OTgsMTIzNDU2LEc3RzIUKwMNZ2dnZ2dnZ2dnZ2dnZ2QYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgkFCWNoa05vdGlmeQULY2hrQ2VudGVyTm8FCmNoa05ld1Bhc3MFCWNoa1JlbGF5MQUHY2hrRnVlbAUMY2hrRWF2ZXNkcm9wBQZjaGtHZW8FCWNoa1NlbnNvcgUFY3RsMDFp0ADPGVjOsjcV+xz5Y09NmN4Ylw==" />
</div>

<script type="text/javascript">
<!--
var theForm = document.forms['ctl00'];
function __doPostBack(eventTarget, eventArgument) {
    if (theForm.onsubmit == null || theForm.onsubmit()) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
// -->
</script>


<br>
<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="90%" height="26">
    <tr>
      <td width="100%" valign="top" height="6">
        <p align="center">&nbsp;<img border="0" src="images/AVLSConfig.jpg" width="242" height="24"></p>
        <div align="center" id="Error"><font color="" size="2" face="Verdana"><b>&nbsp;</b></font></div>
        <div align="center">
          <table border="0" cellpadding="0" cellspacing="0" width="30%" style="border: 1 solid #9BA7FB">
            <tr>
              <td width="100%">
                <div align="center">
                  <table border="0" width="100%" cellpadding="2">
                    <tr>
                      <td width="100%" bgcolor="#9BA7FB" colspan="3">
                        <p align="center"><b><font color="#000000" size="2">Threshold</font></b></td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
        <input id="chkCenterNo0" type="checkbox" name="chkHH" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>HH</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtHH" type="text" id="txtCenterNo0" disabled="disabled" size="10" style="border: 1 solid #4960F8" />
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
        <input id="chkCenterNo0" type="checkbox" name="chkH" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>H</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtH" type="text" id="txtCenterNo0" disabled="disabled" size="10" style="border: 1 solid #4960F8" />
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
        <input id="chkCenterNo0" type="checkbox" name="chkL" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>L</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtL" type="text" id="txtCenterNo0" disabled="disabled" size="10" style="border: 1 solid #4960F8" />
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                    <tr>
                      <td width="5%" height="25">
        <input id="chkCenterNo0" type="checkbox" name="chkLL" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
                      </td>
                      <td width="30%" height="25"><font class="fontStyle"><b>LL</b></font></td>
                      <td width="65%" height="25">
                        <font size="2"><input name="txtLL" type="text" id="txtCenterNo0" disabled="disabled" size="10" style="border: 1 solid #4960F8" />
                        </font><font class="fontStyle">m</font>
                      </td>
                    </tr>
                  </table>
                </div>
              </td>
            </tr>
          </table>
        </div>
        <br></td>
    </tr>
    <tr>
      <td width="100%" valign="top" height="25">
        <div align="center">
          <table border="0" cellpadding="0" cellspacing="0" width="60%" style="border: 1 solid #9BA7FB">
            <tr>
              <td width="100%">
<div align="center">
  <table border="0" cellpadding="2" width="100%">
    <tr>
      <td width="100%" height="25" colspan="4" bgcolor="#9BA7FB">
        <p align="center"><b><font color="#000000" size="2">Re-Poll Log Data</font></b></td>
    </tr>
    <tr>
      <td width="41%" height="25" align="center" colspan="2">
        <font class="fontStyle"><b>Today's Log</b></font>
      </td>
      <td width="49%" height="25" colspan="2">
        <p align="center"><font class="fontStyle"><b>Yesterday's Log</b></font></td>
    </tr>
    <tr>
      <td width="5%" height="25" align="center">
        <input id="chkCenterNo" type="checkbox" name="chkLog22" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
      </td>
      <td width="36%" height="25"><font class="fontStyle">12:00 am - 07:45 am</font></td>
      <td width="6%" height="25"><input id="chkCenterNo1" type="checkbox" name="chkLog25" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
      </td>
      <td width="43%" height="25"><font class="fontStyle">12:00 am - 07:45 am</font></td>
    </tr>
    <tr>
      <td width="5%" height="25" align="center">
        <input id="chkNewPass" type="checkbox" name="chkLog23" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkNewPass&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
      </td>
      <td width="36%" height="25"><font class="fontStyle">08:00 am - 03:45 pm</font> </td>
      <td width="6%" height="25"><input id="chkCenterNo2" type="checkbox" name="chkLog26" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
      </td>
      <td width="43%" height="25"><font class="fontStyle">08:00 am - 03:45 pm</font></td>
    </tr>
    <tr>
      <td width="5%" height="25" align="center">
        <input id="chkSensor" type="checkbox" name="chkLog24" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkSensor&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
      </td>
      <td width="36%" height="25"><font class="fontStyle">03:45 pm - 11:45
        pm&nbsp;</font></td>
      <td width="1%" height="25"><input id="chkCenterNo3" type="checkbox" name="chkLog27" onclick="javascript:setTimeout('WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;chkCenterNo&quot;, &quot;&quot;, false, &quot;&quot;, &quot;&quot;, true, true))', 0)" value="ON" />
      </td>
      <td width="23%" height="25"><font class="fontStyle">03:45 pm - 11:45 pm</font>
      </td>
    </tr>
  </table>
</div>
              </td>
            </tr>
          </table>
        </div>
        <center>
        <p>
        <input src="images/Submit_s.jpg" name="ctl01" type="image" /> &nbsp;&nbsp;&nbsp;
        </p>  
        </td>
    </tr>
  </table>
  </center>
</div>
<input name="txtStatus" type="hidden" id="txtStatus" value="N" />

<script src="WebResource.axd?a=s&amp;r=WebForms.js&amp;t=632391474998983968" type="text/javascript"></script>
</form>
</body>

</html>
