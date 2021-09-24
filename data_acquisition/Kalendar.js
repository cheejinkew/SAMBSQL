var dCurrent = new Date();
var arryMonth = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
var arryEndMonth = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
var arryDay = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
var intCurrentYear = dCurrent.getFullYear();
var intCurrentMonth = dCurrent.getMonth();
var intCurrentDate = dCurrent.getDate();
//var frmTargetForm = "formX";
var frmTargetForm = "forms[0]";
var txtTargetDateField ="";

function DrawCalendarLayout()
{
  var strLayout = "<style>.SelectStyle{font-family:verdana;font-size:10pt;color:#3952F9;border-width:1px;border-style:solid;border-color:#3952F9;}</style><div id='divTWCalendar' style='position:absolute; left:-400; top:100; Z-INDEX: 5;border-width: 1px;border-style: solid;border-color: #4960F8;'>" +
                  "  <table border='0' cellpadding='3' cols='7' width='200' bgcolor='#FFFFFF' style='border-width: 1px;border-style: solid;border-color: #3952F9'>" +
                  "    <tr align=center valign=center bgcolor='#9FA2FF'>" +
                  "      <td colspan='7'>" +
                  "        <select name='cmbMonth' class='SelectStyle' onChange='javascript:SetCalendar(this.value, cmbYear.value)'>";

  for (var intI = 0; intI < arryMonth.length; intI++)
  {
    strLayout +=  "          <option value='" + intI + "'>" + arryMonth[intI] + "</option>";
  }

  strLayout += "        </select>" +
               "        <select name='cmbYear' class='SelectStyle' onChange='javascript:SetCalendar(cmbMonth.value, this.value)'>";

  for (var intI = intCurrentYear - 1; intI < intCurrentYear + 2; intI++)
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
      strLayout += "      <td id='tdDateSpot" + intDateSpot + "' align='center'><font face='verdana' size='1'><a style='text-decoration:none;' href='javascript:SetDate(" + intDateSpot + ");'><span id='spDateSpot" + intDateSpot + "'></span></a></font></td>";
      intDateSpot++;
    }

    strLayout += "    </tr>";
  }

  strLayout += "    <tr>" +
               "      <td colspan='7'><center><a href='javascript:HideCalendar();'><img src='../images/Close.jpg' border='0'></a></center></td>" +
               "    </tr>" +
               "  </table>" +
               "</div>";

  document.write(strLayout);
  eval ("document." + frmTargetForm + ".cmbMonth.value = intCurrentMonth");
  eval ("document." + frmTargetForm + ".cmbYear.value = intCurrentYear");
   
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
	  eval("document.getElementById('spDateSpot" + i + "').innerHTML = ''");
  }

  for(i = intMyCurrentDay, j = 1; j <= arryEndMonth[intMyCurrentMonth]; i++, j++)
  {
    if (j == intCurrentDate && intMonth == intCurrentMonth)
    {
      eval("document.getElementById('tdDateSpot" + i + "').bgColor = '#9FA2FF'");
    }
    else
    {
      eval("document.getElementById('tdDateSpot" + i + "').bgColor = '#FFFFFF'");
    }
    
    eval("document.getElementById('spDateSpot" + i + "').innerHTML = " + j);
  }

  for(i = parseInt(arryEndMonth[intMyCurrentMonth]) + intMyCurrentDay; i <= 41 ; i++)
  {
	  eval("document.getElementById('spDateSpot" + i + "').innerHTML = ''");
  }
}

function SetDate(intDateSpot)
{
  var strSelectedMonth = eval("parseInt(document." + frmTargetForm + ".cmbMonth.value) + 1");

  var strSelectedDate = eval("document.getElementById('spDateSpot" + intDateSpot + "').innerHTML");
  
  if (parseInt(strSelectedMonth) < 10)
  {
    strSelectedMonth = "0" + strSelectedMonth;
  }
  
  if (parseInt(strSelectedDate) < 10)
  {
    strSelectedDate = "0" + strSelectedDate;
  }

  var strSelectedDate = eval ("document." + frmTargetForm + ".cmbYear.value") + "-" + strSelectedMonth + "-" + strSelectedDate;

    eval("document.getElementById('" + txtTargetDateField + "').innerHTML = '" + strSelectedDate + "'");
  
  HideCalendar();
}

function HideCalendar()
{
  document.getElementById('divTWCalendar').style.visibility = 'hidden';
}