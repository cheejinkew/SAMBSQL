﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="bph_LAD1_43_11.aspx.vb" Inherits="custom_LAD1_43_11" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link type="text/css" href="_objects.css" rel="stylesheet" />
    <%--<link type="text/css" href="../css/Reservoir.css" rel="stylesheet" />--%>
    <script type="text/javascript" src="../js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            GetData();
        });

        function GetData() {

            //This Site Have Two RTU(J4 and J5)
            var SiteID = '<%=strsiteid%>';
           var SiteID_1 = '<%=strsiteid1%>';
           var SiteID_2 = '<%=strsiteid2%>';
           var SiteID_3 = '<%=strsiteid3%>';
           var SiteID_4 = '<%=strsiteid4%>';
           var SiteID_5 = '<%=strsiteid5%>';
           var SiteID_6 = '<%=strsiteid6%>';
           var SiteID_7 = '<%=strsiteid7%>';
           var SiteID_8 = '<%=strsiteid8%>';
           var SiteID_9 = '<%=strsiteid9%>';
         


           var url_1 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID;
           var url_2 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_1;
           var url_3 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_2;
           var url_4 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_3;
           var url_5 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_4;
           var url_6 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_5;
           var url_7 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_6;
           var url_8 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_7;
           var url_9 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_8;
           var url_10 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_9;
         

           var xmlhttp_1;
           var xmlhttp_2;
           var xmlhttp_3;
           var xmlhttp_4;
           var xmlhttp_5;
           var xmlhttp_6;
           var xmlhttp_7;
           var xmlhttp_8;
           var xmlhttp_9;
           var xmlhttp_10;
        

           if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
               xmlhttp_1 = new XMLHttpRequest();
               xmlhttp_2 = new XMLHttpRequest();
               xmlhttp_3 = new XMLHttpRequest();
               xmlhttp_4 = new XMLHttpRequest();
               xmlhttp_5 = new XMLHttpRequest();
               xmlhttp_6 = new XMLHttpRequest();
               xmlhttp_7 = new XMLHttpRequest();
               xmlhttp_8 = new XMLHttpRequest();
               xmlhttp_9 = new XMLHttpRequest();
               xmlhttp_10 = new XMLHttpRequest();
            
           }
           else {// code for IE6, IE5
               xmlhttp_1 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_2 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_3 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_4 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_5 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_6 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_7 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_8 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_9 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_10 = new ActiveXObject("Microsoft.XMLHTTP");
              
           }

           xmlhttp_1.onreadystatechange = function () {
               if (xmlhttp_1.readyState == 4 && xmlhttp_1.status == 200) {
                   var data = xmlhttp_1.responseText;
                   Fill_Res_Data(data, 1);
               }
           }

           xmlhttp_2.onreadystatechange = function () {
               if (xmlhttp_2.readyState == 4 && xmlhttp_2.status == 200) {
                   var data = xmlhttp_2.responseText;
                   Fill_Res_Data(data, 2);
               }
           }

           xmlhttp_3.onreadystatechange = function () {
               if (xmlhttp_3.readyState == 4 && xmlhttp_3.status == 200) {

                   var data = xmlhttp_3.responseText;
                   Fill_Res_Data(data, 3);
               }
           }
           xmlhttp_4.onreadystatechange = function () {
               if (xmlhttp_4.readyState == 4 && xmlhttp_4.status == 200) {

                   var data = xmlhttp_4.responseText;
                   Fill_Res_Data(data, 4);
               }
           }
           xmlhttp_5.onreadystatechange = function () {
               if (xmlhttp_5.readyState == 4 && xmlhttp_5.status == 200) {

                   var data = xmlhttp_5.responseText;
                   Fill_Res_Data(data, 5);
               }
           }
           xmlhttp_6.onreadystatechange = function () {
               if (xmlhttp_6.readyState == 4 && xmlhttp_6.status == 200) {

                   var data = xmlhttp_6.responseText;
                   Fill_Res_Data(data, 6);
               }
           }
           xmlhttp_7.onreadystatechange = function () {
               if (xmlhttp_7.readyState == 4 && xmlhttp_7.status == 200) {
                   var data = xmlhttp_7.responseText;
                   Fill_Res_Data(data, 7);
               }
           }
           xmlhttp_8.onreadystatechange = function () {
               if (xmlhttp_8.readyState == 4 && xmlhttp_8.status == 200) {
                   var data = xmlhttp_8.responseText;
                   Fill_Res_Data(data, 8);
               }
           }
           xmlhttp_9.onreadystatechange = function () {
               if (xmlhttp_9.readyState == 4 && xmlhttp_9.status == 200) {
                   var data = xmlhttp_9.responseText;
                   Fill_Res_Data(data, 9);
               }
           }
           xmlhttp_10.onreadystatechange = function () {
               if (xmlhttp_10.readyState == 4 && xmlhttp_10.status == 200) {
                   var data = xmlhttp_10.responseText;
                   Fill_Res_Data(data, 10);
               }
           }
         

           xmlhttp_1.open("GET", url_1, true);
           xmlhttp_1.send();

           xmlhttp_2.open("GET", url_2, true);
           xmlhttp_2.send();

           xmlhttp_3.open("GET", url_3, true);
           xmlhttp_3.send();

           xmlhttp_4.open("GET", url_4, true);
           xmlhttp_4.send();

           xmlhttp_5.open("GET", url_5, true);
           xmlhttp_5.send();

           xmlhttp_6.open("GET", url_6, true);
           xmlhttp_6.send();

           xmlhttp_7.open("GET", url_7, true);
           xmlhttp_7.send();

           xmlhttp_8.open("GET", url_7, true);
           xmlhttp_8.send();

           xmlhttp_9.open("GET", url_7, true);
           xmlhttp_9.send();

           xmlhttp_10.open("GET", url_7, true);
           xmlhttp_10.send();

           

           //5 minutes
           var refreshInterval = 20;
           refreshInterval = refreshInterval * 60000;
           setTimeout('GetData()', refreshInterval);
       }


       function Fill_Res_Data(data, sno) {
           var arrdata = data.split("|");
           $("#l_level" + (sno + 1) + "_value").html(arrdata[2] + ' m');
           //Water Level 1
           var MaxHeight = $("#water_level" + sno + "").height();
           var CurrentHeight = MaxHeight / 10 * (arrdata[2] == 0 ? 1 : arrdata[2]);

           if (CurrentHeight > MaxHeight) {
               CurrentHeight = MaxHeight;
               $("#water_level" + sno + "").css('background-color', 'red');
           }
           else if (CurrentHeight == 0) {
               CurrentHeight = 5;
           }
           $("#show_level" + sno + "color").height(CurrentHeight + 'px');
       }



        function s_trend(id, pos) {
            window.location = "../Trending_bph.aspx?siteid=" + id + "&position=" + pos;
        }
        function R_trend(id, name, pos, district) {
            window.location = "../Trending.aspx?siteid=" + id + "&sitename=" + name + "&district=" + district + "&position=" + pos + "&sitetype=RESERVOIR&equipname=Water%20Level%20Trending";
        }
    </script>
    <style>
        table {
            font-family: verdana;
            font-size: 10px;
            border-collapse: collapse;
            border: 1px solid white;
        }

        th, td {
            text-align: left;
            padding: 5px;
            color: white;
            border: 1px solid white;
        }

        th {
            background-color: #4CAF50;
            font-size: 12px;
            color: white;
        }
    </style>
</head>
<body bgcolor="#0071bb">
    <form id="form1" runat="server">
        <div>
        </div>
        <div style="background-image: url(imej/LAD1_43_11.png?r=199182392); height: 745px; width: 1050px;">
        </div>

        <div id="water_level1" title="Suction Tank" style="position: absolute; z-index: 2; top: 530px; left: 107px; width: 110px; height: 50px; background: transparent;">
            <div id="show_level1color" class="waterlevel">
                <img id="show_level1" src="../images/blank.gif" width="62" height="10" /></div>
        </div>
        <div id="water_level2" title="Suction Tank" style="position: absolute; z-index: 2; top: 455px; left: 199px; width: 110px; height: 50px; background: transparent">
            <div id="show_level2color" class="waterlevel">
                <img id="show_level2" src="../images/blank.gif" width="62" height="10"></div>
        </div>
        <div id="water_level3" title="Suction Tank" style="position: absolute; z-index: 2; top: 530px; left: 290px; width: 110px; height: 50px; background: transparent">
            <div id="show_level3color" class="waterlevel">
                <img id="show_level3" src="../images/blank.gif" width="62" height="10"></div>
        </div>
        <div id="water_level4" title="Suction Tank" style="position: absolute; z-index: 2; top: 535px; left: 382px; width: 110px; height: 50px; background: transparent">
            <div id="show_level4color" class="waterlevel">
                <img id="show_level4" src="../images/blank.gif" width="62" height="10"></div>
        </div>
        <div id="water_level5" title="Suction Tank" style="position: absolute; z-index: 2; top: 566px; left: 473px; width: 110px; height: 50px; background: transparent">
            <div id="show_level5color" class="waterlevel">
                <img id="show_level5" src="../images/blank.gif" width="62" height="10"></div>
        </div>
          <div id="water_level6" title="Suction Tank" style="position: absolute; z-index: 2; top: 524px; left: 566px; width: 110px; height: 50px; background: transparent">
            <div id="show_level6color" class="waterlevel">
                <img id="show_level6" src="../images/blank.gif" width="62" height="10"></div>
        </div>
          <div id="water_level7" title="Suction Tank" style="position: absolute; z-index: 2; top: 566px; left: 656px; width: 110px; height: 50px; background: transparent">
            <div id="show_level7color" class="waterlevel">
                <img id="show_level7" src="../images/blank.gif" width="62" height="10"></div>
        </div>

        <div id="water_level8" title="Suction Tank" style="position: absolute; z-index: 2; top: 572px; left: 749px; width: 110px; height: 50px; background: transparent">
            <div id="show_level8color" class="waterlevel">
                <img id="show_level8" src="../images/blank.gif" width="62" height="10"></div>
        </div>
          <div id="water_level9" title="Suction Tank" style="position: absolute; z-index: 2; top: 567px; left:840px; width: 110px; height: 50px; background: transparent">
            <div id="show_level9color" class="waterlevel">
                <img id="show_level9" src="../images/blank.gif" width="62" height="10"></div>
        </div>
          <div id="water_level10" title="Suction Tank" style="position: absolute; z-index: 2; top: 568px; left: 932px; width: 110px; height: 50px; background: transparent">
            <div id="show_level10color" class="waterlevel">
                <img id="show_level10" src="../images/blank.gif" width="62" height="10"></div>
        </div>
           
        <div style="position: absolute; top: 550px; left: 107px; z-index: 2;">
            <div id="l_level2_value" class="black_box">???</div>
        </div>

        <div style="position: absolute; top: 474px; left: 199px; z-index: 2;">
            <div id="l_level3_value" class="black_box">???</div>
        </div>

        <div style="position: absolute; top: 550px; left: 290px; z-index: 2;">
            <div id="l_level4_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 555px; left: 382px; z-index: 2;">
            <div id="l_level5_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 586px; left: 473px; z-index: 2;">
            <div id="l_level6_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 544px; left:566px; z-index: 2;">
            <div id="l_level7_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 586px; left: 656px; z-index: 2;">
            <div id="l_level8_value" class="black_box">???</div>
        </div>
         <div style="position: absolute; top: 592px; left: 749px; z-index: 2;">
            <div id="l_level9_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 587px; left:840px; z-index: 2;">
            <div id="l_level10_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 588px; left: 932px; z-index: 2;">
            <div id="l_level11_value" class="black_box">???</div>
        </div>

        <%--<div style="position:absolute;z-index:2;top:422px;left:745px;height:18px;" class="siteid_box" id="rtu_stat2_sitename"></div>
<div id="rtu_stat2" style="position:absolute;z-index:3;top:422px;left:740px;height:16px;" class="rtu_island">
	<div id="rtu_stat2_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=strsiteid1%></div>
	<div id="rtu_stat2_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat2_power" style="position:absolute;top:16px;left:62px;visibility:hidden;" class="ok">???</div>
	<div id="rtu_stat2_batt" style="position:absolute;top:16px;left:172px;visibility:hidden;" class="ok">???</div>
</div>

 <div style="position:absolute;z-index:2;top:422px;left:545px;height:18px;" class="siteid_box" id="rtu_stat4_sitename"></div>
<div id="rtu_stat4" style="position:absolute;z-index:3;top:422px;left:540px;height:16px;" class="rtu_island">
	<div id="rtu_stat4_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=strsiteid2%></div>
	<div id="rtu_stat4_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat4_power" style="position:absolute;top:16px;left:62px;visibility:hidden;" class="ok">???</div>
	<div id="rtu_stat4_batt" style="position:absolute;top:16px;left:172px;visibility:hidden;" class="ok">???</div>
</div>

<div style="position:absolute;z-index:2;top:422px;left:340px;height:18px;" class="siteid_box" id="rtu_stat3_sitename"></div>
<div id="rtu_stat3" style="position:absolute;z-index:3;top:422px;left:340px;height:16px;" class="rtu_island">
	<div id="rtu_stat3_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=strsiteid3%></div>
	<div id="rtu_stat3_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat3_power" style="position:absolute;top:16px;left:62px;visibility:hidden;" class="ok">???</div>
	<div id="rtu_stat3_batt" style="position:absolute;top:16px;left:172px;visibility:hidden;" class="ok">???</div>
</div>
        <div style="position:absolute;z-index:2;top:422px;left:120px;height:18px;" class="siteid_box" id="rtu_stat5_sitename"></div>
<div id="rtu_stat5" style="position:absolute;z-index:3;top:422px;left:120px;height:16px;" class="rtu_island">
	<div id="rtu_stat5_tag" style="position:absolute;top:2px;left:7px" class="tag"><%=strsiteid%></div>
	<div id="rtu_stat5_title" style="position:absolute;top:2px;left:44px" class="labelhead">RTU#</div>
	<div id="rtu_stat5_power" 
        style="position:absolute;top:16px;left:62px; right: 130px;visibility:hidden;" class="ok">???</div>
	<div id="rtu_stat5_batt" style="position:absolute;top:16px;left:172px;visibility:hidden;" class="ok">???</div>
</div>--%>
    </form>
</body>
</html>