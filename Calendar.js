function DrawCalendarLayout()
{
  var strLayout = "<style>.SelectStyle{font-family:verdana;}</style><div id='divTWCalendar' style='position:absolute; left:-400; top:100; Z-INDEX: 5'>" +
                  "  <table id='tabCal' border='0' cellpadding='3' cols='7' width='200' bgcolor='#FFFFFF' style='border: 1 solid #3952F9'>" +
                  "    <tr align=center valign=center bgcolor='#9FA2FF'>" +
                  "      <td colspan='7'>" +
                  "        <select name='cmbMonth' class='SelectStyle' onChange='javascript:SetCalendar(this.value, cmbYear.value)'>";

  for (var intI = 0; intI < arryMonth.length; intI++)
  {
    strLayout +=  "          <option value='" + intI + "'>" + arryMonth[intI] + "</option>";
  }

  strLayout += "        </select>" +
               "        <select name='cmbYear' class='SelectStyle' onChange='javascript:SetCalendar(cmbMonth.value, this.value)'>";

  for (var intI = intCurrentYear - 2; intI < intCurrentYear + 2; intI++)
  {
    strLayout +=  "          <option value='" + intI + "'>" + intI + "</option>";
  }

  strLayout += "        </select>" +
               "      </td>" +
               "    </tr>" +
               "    <tr>";

  for (var intI = 0; intI < arryDay.length; intI++)
  {
    strLayout +=  "      <td><b><font face='Tahoma' size='2'>" + arryDay[intI] + "</font></b></td>";
  }

  strLayout += "    </tr>";

  var intDateSpot = 0;

  for (var intI = 0; intI <= 5; intI++)
  {
    strLayout += "    <tr>";

    for (var intJ = 0; intJ <= 6; intJ++)
    {
      strLayout += "      <td id='tdDateSpot" + intDateSpot + "' align='center'><font face='verdana' size='1'><a style='text-decoration:none;' href='javascript:SetDate(" + intDateSpot + ")'><span id='spDateSpot" + intDateSpot + "'></span></a></font></td>";
      intDateSpot++;
    }

    strLayout += "    </tr>";
  }

  strLayout += "    <tr>" +
               "      <td colspan='7'><center><a href='javascript:HideCalendar();'><img src='../TelemetryMgmt_Terengganu/Images/Close.jpg' border='0'></a></center></td>" +
               "    </tr>" +
               "  </table>" +
               "</div>";

  document.write(strLayout);
  document.alias.cmbMonth.value = intCurrentMonth;
  document.alias.cmbYear.value = intCurrentYear;
   
  SetCalendar(intCurrentMonth, intCurrentYear);	
}

function SetCalendar(intMonth, intYear)
{
  var boolLeap = (intYear % 4 == 0) ? true : false;

  dCurrent.setYear(intYear);
  dCurrent.setMonth(intMonth, 1);

  var intMyCurrentDay = dCurrent.getDay();
  var intMyCurrentMonth = dCurrent.getMonth();

  if (boolLeap)
  {
    arryEndMonth[1] = "29";
  }
  else
  {
    arryEndMonth[1] = "28";
  }

  for(i = 0; i < intMyCurrentDay; i++)
  {
    eval("spDateSpot" + i).innerHTML = "";
  }

  for(i = intMyCurrentDay, j = 1; j <= arryEndMonth[intMyCurrentMonth]; i++, j++)
  {
    if (j == intCurrentDate && intMonth == intCurrentMonth)
    {
      eval("tdDateSpot" + i).bgColor = "9FA2FF";
    }
    else
    {
      eval("tdDateSpot" + i).bgColor = "#FFFFFF";
    }
    
    eval("spDateSpot" + i).innerHTML = j;
  }

  for(i = parseInt(arryEndMonth[intMyCurrentMonth]) + intMyCurrentDay; i <= 41 ; i++)
  {
    eval("spDateSpot" + i).innerHTML = "";
  }
  window.parent.ResizeFrame(tabCal.offsetWidth, tabCal.offsetHeight);
}

function SetDate(intDateSpot)
{
  var strSelectedMonth = parseInt(document.alias.cmbMonth.value) + 1;
  var strSelectedDate = eval("spDateSpot" + intDateSpot).innerHTML;
  
  if (parseInt(strSelectedMonth) < 10)
  {
    strSelectedMonth = "0" + strSelectedMonth;
  }
  
  if (parseInt(strSelectedDate) < 10)
  {
    strSelectedDate = "0" + strSelectedDate;
  }

  var strSelectedDate = document.alias.cmbYear.value + "-" + strSelectedMonth + "-" + strSelectedDate;  
  
  eval("window.parent." + frmTargetForm + "." + txtTargetDateField + ".value = '" + strSelectedDate + "'");
  
  HideCalendar();
}

function HideCalendar()
{
  //divTWCalendar.style.visibility = 'hidden';
  window.parent.HideCal();
}