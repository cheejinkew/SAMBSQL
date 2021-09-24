<%@ Page Language="VB" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial;}

/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #0071bb;
  background-color: #0071bb;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 8px 16px;
  transition: 0.3s;
  font-size: 12px;
  color:#ffffff;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #1528ae;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #1528ae;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #0071bb;
  border-top: none;
}
</style>
</head>
<body> 
<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'dashboard')">Dash Board</button>
  <button class="tablinks" onclick="openCity(event, 'scematic')">Scematic View</button>
  <button class="tablinks" onclick="openCity(event, 'tablereport')">Table Report</button>
  <button class="tablinks" onclick="openCity(event, 'barchart')">Chart Report</button>
    <button class="tablinks" onclick="openCity(event, 'dayReport')">Totalizer Daily Report</button>
</div>

<div id="dashboard" class="tabcontent">
 <iframe src ="dashboard/EDTDashboard.aspx"  style="width:100%;height:800px;border :none ;"  ></iframe> 
</div>

<div id="scematic" class="tabcontent active" style ="display :block ;">
 <iframe src ="EDT2.aspx" style="width:100%;height:800px;border :none ;" ></iframe>
</div>

<div id="tablereport" class="tabcontent">
<iframe src ="DAMSambSummary.aspx"  style="width:100%;height:800px;border :none ;"  ></iframe>
</div>
<div id="barchart" class="tabcontent">
<iframe src ="dashboard/ChartReport.aspx"  style="width:100%;height:800px;border :none ;"  ></iframe>
</div>
<div id="dayReport" class="tabcontent">
<iframe src ="TotalaiserDayLogReport.aspx"  style="width:100%;height:800px;border :none ;"  ></iframe>
</div>
<script>
function openCity(evt, cityName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
}
</script>
   
</body>
</html> 

