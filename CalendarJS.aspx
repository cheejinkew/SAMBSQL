<%@ Page Language="vb" Debug="true" %>
<%
dim MotherForm = request("frm")
dim MotherElement = request("e")
%>
<html>
<head>
<title>Showing The Calender</title>
<script language="javascript">
	var dCurrent = new Date();
	var arryMonth = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
	var arryEndMonth = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
	var arryDay = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
	var intCurrentYear = dCurrent.getFullYear();
	var intCurrentMonth = dCurrent.getMonth();
	var intCurrentDate = dCurrent.getDate();
	var frmTargetForm = "<%=MotherForm%>";
	var txtTargetDateField ="<%=MotherElement%>";

  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
  }

  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
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
  
  //eval("document." + frmTargetForm + "." + txtTargetDateField + ".value = '" + strSelectedDate + "'");
  window.parent.AlternateSet(strSelectedDate,frmTargetForm)
  
  //HideCalendar();
  window.parent.HideCal();
}

function HideCalendar()
{
  divTWCalendar.style.visibility = 'hidden';
  window.parent.HideCal();
}  
</script>
</head>
<body onload="javascript:ShowCalendar('<%=MotherElement%>', 0, 0);">
<script language="JavaScript" src="Calendar.js"></script>
<form name="alias">
<script lanaguage="javascript">DrawCalendarLayout();</script>
</form>
</body>
</html>