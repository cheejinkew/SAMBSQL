<%@ Page Language="VB" AutoEventWireup="false" CodeFile="bph_s1Bph1.aspx.vb" Inherits="custom_bph_s1bph1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link type="text/css" href="_objects.css" rel="stylesheet" />
     <link type="text/css" href="../css/Reservoir.css" rel="stylesheet" />
    <script type ="text/javascript" src="../js/jquery-1.8.2.min.js"></script>
    <script type ="text/javascript"  >
   $(document).ready(function () {
            GetData();
        });

        function GetData() {

            //This Site Have Two RTU(J4 and J5)
            var SiteID = '<%=strsiteid%>';
            var SiteID_1 = '<%=strsiteid1%>';


            var url_1 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID;
            var url_2 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_1;
            var xmlhttp_1;
            var xmlhttp_2;
            var xmlhttp_23;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp_1 = new XMLHttpRequest();
                xmlhttp_2 = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp_1 = new ActiveXObject("Microsoft.XMLHTTP");
                xmlhttp_2 = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlhttp_1.onreadystatechange = function () {
                if (xmlhttp_1.readyState == 4 && xmlhttp_1.status == 200) {

                    var data = xmlhttp_1.responseText;
                    Fill_Data_1(data);
                }
            }
            xmlhttp_2.onreadystatechange = function () {
                if (xmlhttp_2.readyState == 4 && xmlhttp_2.status == 200) {

                    var data = xmlhttp_2.responseText;
                    Fill_Res_Data(data, 1);
                }
            }


            xmlhttp_1.open("GET", url_1, true);
            xmlhttp_1.send();

            xmlhttp_2.open("GET", url_2, true);
            xmlhttp_2.send();
            //5 minutes
            var refreshInterval = 20;
            refreshInterval = refreshInterval * 60000;
            setTimeout('GetData()', refreshInterval);
        }


        function Fill_Res_Data(data, sno) {
            var arrdata = data.split("|");
            if (sno == 1) {
                $("#l_level3_value").html(arrdata[2] + ' m');

                $("#rtu_stat3_title").html(arrdata[0]);
                $("#rtu_stat3_tag").html(arrdata[3]);

                //Water Level 1
                var MaxHeight = $("#water_level2").height();
                var CurrentHeight = MaxHeight / 10 * (arrdata[2] == 0 ? 1 : arrdata[2]);

                if (CurrentHeight > MaxHeight) {
                    CurrentHeight = MaxHeight;
                    $("#water_level2").css('background-color', 'red');
                }
                else if (CurrentHeight == 0) {
                    CurrentHeight = 5;
                }
                $("#show_level2color").height(CurrentHeight + 'px');


            }
        }

        function Fill_Data_1(data) {

            var arrdata = data.split("|");

            if (arrdata.length > 2) {

                $("#rtu_stat1_title").html(arrdata[0]);

                if (parseFloat(arrdata[1].toString()) >= 58) {

                    if (arrdata[2] == "0") {
                        $("#rtu_stat1_power").attr('class', 'ok').html("OK");
                    }
                    else {
                        $("#rtu_stat1_power").attr('class', 'fail').html("FAIL");
                    }

                    if (arrdata[3] == "0") {
                        $("#rtu_stat1_batt").attr('class', 'ok').html("OK");
                    }
                    else {
                        $("#rtu_stat1_batt").attr('class', 'fail').html("FAIL");
                    }
                    $("#pressure_meter1").html("N/A bar");
                   // $("#pressure_meter1").html(arrdata[52] + " bar");
                    // $("#FlowRate1_2").html(cubic_meter_per_hour2litre_per_sec(arrdata[52]));
                    // $("#TotalFlowRate1").html(arrdata[56]);

                    //Water Level 1
                    $("#l_level2_value").html(arrdata[56] + ' m');
                    var MaxHeight = $("#water_level1").height();
                    var CurrentHeight = MaxHeight / 10 * (arrdata[56]);

                    if (CurrentHeight > MaxHeight) {
                        CurrentHeight = MaxHeight;
                        $("#water_level1").css('background-color', 'red');
                    }
                    else if (CurrentHeight == 0) {
                        CurrentHeight = 5;
                    }
                    $("#show_level1color").height(CurrentHeight + 'px');
                   


                    if (arrdata[4] == 1) {
                        $("#pump1").attr('class', 'pump_run');
                    }
                    else {
                        $("#pump1").attr('class', 'pump_stop');
                    }
                    if (arrdata[5] == 1) {
                        $("#pump1").attr('class', 'pump_trip');
                    }

                    if (arrdata[7] == 1) {
                        $("#pump2").attr('class', 'pump_run');
                    }
                    else {
                        $("#pump2").attr('class', 'pump_stop');
                    }
                    if (arrdata[8] == 1) {
                        $("#pump2").attr('class', 'pump_trip');
                    }

                    if (arrdata[10] == 1) {
                        $("#pump3").attr('class', 'pump_run');
                    }
                    else {
                        $("#pump3").attr('class', 'pump_stop');
                    }
                    if (arrdata[11] == 1) {
                        $("#pump3").attr('class', 'pump_trip');
                    }

                }
            }
        }

        function s_trend(id, pos) {
            window.location = "../Trending_bph.aspx?siteid=" + id + "&position=" + pos;
        }
        function R_trend(id, name, pos, district) {
            window.location = "../Trending.aspx?siteid=" + id + "&sitename=" + name + "&district=" + district + "&position=" + pos + "&sitetype=RESERVOIR&equipname=Water%20Level%20Trending";
        }
        </script>
</head>
<body  bgcolor="#0071bb">
    <form id="form1" runat="server">
    <div>
    
    </div>
    <div style ="background-image :url(img/BPH-rasah-kemayan.png);height:552px;width :852px;" >
    
    </div>
    <div id="header" onclick="de_active();"> BPH RASAH KEMAYAN(S1-H1)</div>
    <div id="water_level1" title="Suction Tank" style="position:absolute;z-index:2;top:337px;left:161px;width:129px;height:50px;background:transparent">
		<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="128" height="10"></div>
	</div>
     <div id="water_level2" title="Suction Tank" style="position:absolute;z-index:2;top:166px;;left:656px;;width:129px;;height:50px;background:transparent">
		<div id="show_level2color" class="waterlevel"><img id="show_level2" src="../images/blank.gif" width="128" height="10"></div>
	</div>
    <div class="indicator" title="Pressure Meter Trending" 
        style="position:absolute;width:100px;height:33px;top:262px;left:461px; z-index:2;text-align:center;cursor:pointer;background-image:url('../images/default_indicator.png'); background-repeat:no-repeat;" 
        onclick="s_trend('s1h1','52')">
	<div style="position:absolute;top:2px;left:10px;" class="labelingW">Pressure</div>
	<div  style="position:absolute;top:16px;left:10px;" id="pressure_meter1" class="indicator">???</div>
	</div>

   
    <div class="indicator" title="Suction Tank" style="position:absolute;width:100px;height:33px;top:425px;left:200px;z-index:2;text-align:center;cursor:pointer;background-image:url(../images/default_indicator.png);background-repeat:no-repeat;" onclick="R_trend('S1-H1','BPH RASAH KEMAYAN','56','Negeri Sembilan')">
	<div style="position:absolute;top:2px;left:10px;" class="labelingW">Level</div>
	<div style="position:absolute;top:16px;left:10px;" id="l_level2_value" class="indicator">???</div>
	</div>
    
    <div class="indicator" title="Storage Tank" style="position:absolute;width:100px;height:33px;top:255px;left:687px;z-index:2;text-align:center;cursor:pointer;background-image:url(../images/default_indicator.png);background-repeat:no-repeat;" onclick="R_trend('1001','ELEVATED TANK RASAH KEMAYAN','2','Negeri Sembilan')">
	<div style="position:absolute;top:2px;left:10px;" class="labelingW">Level</div>
	<div style="position:absolute;top:16px;left:10px;" id="l_level3_value" class="indicator">???</div>
</div>

  <div id="pump1" class="pump_stop" style="position: absolute; z-index: 3; top: 239px;
        left: 364px">
    </div>
    <div id="pump2" class="pump_stop" style="position: absolute; z-index: 3; top: 286px;
        left: 364px">
    </div>
    <div id="pump3" class="pump_stop" style="position: absolute; z-index: 3; top: 336px;
        left: 364px">
    </div>
    <div id="rtu_stat3" style="position:absolute;z-index:3;top:295px;left:657px;height:16px;" class="rtu_island">
	<div id="rtu_stat3_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=strsiteid1%></div>
	<div id="rtu_stat3_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat3_power" style="position:absolute;top:16px;left:62px;visibility:hidden;" class="ok">???</div>
	<div id="rtu_stat3_batt" style="position:absolute;top:16px;left:172px;visibility:hidden;" class="ok">???</div>
</div>
<div id="rtu_stat1" style="position:absolute;z-index:3;top:440px;left:426px" class="rtu_island">
	<div id="rtu_stat1_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=strsiteid%></div>
	<div id="rtu_stat1_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat1_power" 
        style="position:absolute;top:16px;left:62px; right: 130px;" class="ok">???</div>
	<div id="rtu_stat1_batt" style="position:absolute;top:16px;left:172px" class="ok">???</div>
</div>
    </form>
</body>
</html>
