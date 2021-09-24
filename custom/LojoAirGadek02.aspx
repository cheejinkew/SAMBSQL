<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LojoAirGadek02.aspx.vb" Inherits="LojoAirGadek02" %>

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
           var SiteID_10 = '<%=strsiteid10%>';
           var SiteID_11 = '<%=strsiteid11%>';
           var SiteID_12 = '<%=strsiteid12%>';
           var SiteID_13 = '<%=strsiteid13%>';
           var SiteID_14 = '<%=strsiteid14%>';
           var SiteID_15 = '<%=strsiteid15%>';
           var SiteID_16 = '<%=strsiteid16%>';
           var SiteID_17 = '<%=strsiteid17%>';
          




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
           var url_11 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_10;
           var url_12 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_11;
           var url_13 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_12;
           var url_14 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_13;
           var url_15 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_14;
           var url_16 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_15;
           var url_17 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_16;
           var url_18 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_17;
          

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
           var xmlhttp_11;
           var xmlhttp_12;
           var xmlhttp_13;
           var xmlhttp_14;
           var xmlhttp_15;
           var xmlhttp_16;
           var xmlhttp_17;
           var xmlhttp_18;
         

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
               xmlhttp_11 = new XMLHttpRequest();
               xmlhttp_12 = new XMLHttpRequest();
               xmlhttp_13 = new XMLHttpRequest();
               xmlhttp_14 = new XMLHttpRequest();
               xmlhttp_15 = new XMLHttpRequest();
               xmlhttp_16 = new XMLHttpRequest();
               xmlhttp_17 = new XMLHttpRequest();
               xmlhttp_18 = new XMLHttpRequest();
             
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
               xmlhttp_11 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_12 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_13 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_14 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_15 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_16 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_17 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_18 = new ActiveXObject("Microsoft.XMLHTTP");
              

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
           xmlhttp_11.onreadystatechange = function () {
               if (xmlhttp_11.readyState == 4 && xmlhttp_11.status == 200) {
                   var data = xmlhttp_11.responseText;
                   Fill_Res_Data(data, 11);
               }
           }
           xmlhttp_12.onreadystatechange = function () {
               if (xmlhttp_12.readyState == 4 && xmlhttp_12.status == 200) {
                   var data = xmlhttp_12.responseText;
                   Fill_Res_Data(data, 12);
               }
           }
           
           xmlhttp_13.onreadystatechange = function () {
               if (xmlhttp_13.readyState == 4 && xmlhttp_13.status == 200) {
                   var data = xmlhttp_13.responseText;
                   Fill_Res_Data(data, 13);
               }
           }
           xmlhttp_14.onreadystatechange = function () {
               if (xmlhttp_14.readyState == 4 && xmlhttp_14.status == 200) {
                   var data = xmlhttp_14.responseText;
                   Fill_Res_Data(data, 14);
               }
           }
           xmlhttp_15.onreadystatechange = function () {
               if (xmlhttp_15.readyState == 4 && xmlhttp_15.status == 200) {
                   var data = xmlhttp_15.responseText;
                   Fill_Res_Data(data, 15);
               }
           }
           xmlhttp_16.onreadystatechange = function () {
               if (xmlhttp_16.readyState == 4 && xmlhttp_16.status == 200) {
                   var data = xmlhttp_16.responseText;
                   Fill_Res_Data(data, 16);
               }
           }
           xmlhttp_17.onreadystatechange = function () {
               if (xmlhttp_17.readyState == 4 && xmlhttp_17.status == 200) {
                   var data = xmlhttp_17.responseText;
                   Fill_Res_Data(data, 17);
               }
           }
           xmlhttp_18.onreadystatechange = function () {
               if (xmlhttp_18.readyState == 4 && xmlhttp_18.status == 200) {
                   var data = xmlhttp_18.responseText;
                   Fill_Res_Data(data, 18);
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

           xmlhttp_8.open("GET", url_8, true);
           xmlhttp_8.send();

           xmlhttp_9.open("GET", url_9, true);
           xmlhttp_9.send();

           xmlhttp_10.open("GET", url_10, true);
           xmlhttp_10.send();

           xmlhttp_11.open("GET", url_11, true);
           xmlhttp_11.send();

           xmlhttp_12.open("GET", url_12, true);
           xmlhttp_12.send();

           xmlhttp_13.open("GET", url_13, true);
           xmlhttp_13.send();

           xmlhttp_14.open("GET", url_14, true);
           xmlhttp_14.send();

           xmlhttp_15.open("GET", url_15, true);
           xmlhttp_15.send();

           xmlhttp_16.open("GET", url_16, true);
           xmlhttp_16.send();

           xmlhttp_17.open("GET", url_17, true);
           xmlhttp_17.send();

           xmlhttp_18.open("GET", url_18, true);
           xmlhttp_18.send();
 


           //5 minutes
           var refreshInterval = 20;
           refreshInterval = refreshInterval * 60000;
           setTimeout('GetData()', refreshInterval);
       }


       function Fill_Res_Data(data, sno) {
           var arrdata = data.split("|");
           if (data == "Data No Available")
               $("#l_level" + (sno + 1) + "_value").html('N/A');
           else
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

       function showextend(page) {
           window.location = page + ".aspx";
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
        .black_box {
            font-size: 7px; 
            padding: 0px;
            padding-left: 4px;
            background: transparent url(../images/black_bg1.png) no-repeat 0px 0px;
        }
    </style>
</head>
<body bgcolor="#0071bb">
    <form id="form1" runat="server">
        <div>
        </div>
        <div style="background-image: url(imej/LAG02.png?r=199182392); height: 745px; width: 1050px;">
        </div>

        <div id="water_level1" title="Suction Tank" style="position: absolute; z-index: 2; top: 286px; left: 451px; width: 35px; height: 20px; background: transparent;">
            <div id="show_level1color" class="waterlevel">
                <img id="show_level1" src="../images/blank.gif" width="48" height="20" /></div>
        </div>
        <div id="water_level2" title="Suction Tank" style="position: absolute; z-index: 2; top:375px; left: 451px; width: 35px; height: 20px; background: transparent">
            <div id="show_level2color" class="waterlevel">
                <img id="show_level2" src="../images/blank.gif" width="48" height="20"></div>
        </div>
        <div id="water_level3" title="Suction Tank" style="position: absolute; z-index: 2; top: 466px; left: 451px; width: 35px; height: 20px; background: transparent">
            <div id="show_level3color" class="waterlevel">
                <img id="show_level3" src="../images/blank.gif" width="48" height="10"></div>
        </div>
        <div id="water_level4" title="Suction Tank" style="position: absolute; z-index: 2; top: 557px; left: 451px; width: 35px; height: 20px; background: transparent">
            <div id="show_level4color" class="waterlevel">
                <img id="show_level4" src="../images/blank.gif" width="48" height="10"></div>
        </div>
        <div id="water_level5" title="Suction Tank" style="position: absolute; z-index: 2; top: 557px; left: 593px; width: 35px; height: 20px; background: transparent">
            <div id="show_level5color" class="waterlevel">
                <img id="show_level5" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level6" title="Suction Tank" style="position: absolute; z-index: 2; top: 494px; left: 593px; width: 35px; height: 20px; background: transparent">
            <div id="show_level6color" class="waterlevel">
                <img id="show_level6" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level7" title="Suction Tank" style="position: absolute; z-index: 2; top: 446px; left: 593px; width: 35px; height: 20px; background: transparent">
            <div id="show_level7color" class="waterlevel">
                <img id="show_level7" src="../images/blank.gif" width="48" height="10"></div>
        </div>

        <div id="water_level8" title="Suction Tank" style="position: absolute; z-index: 2; top: 286px; left: 593px; width: 35px; height: 20px; background: transparent">
            <div id="show_level8color" class="waterlevel">
                <img id="show_level8" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level9" title="Suction Tank" style="position: absolute; z-index: 2; top: 163px; left:786px; width: 35px; height: 20px; background: transparent">
            <div id="show_level9color" class="waterlevel">
                <img id="show_level9" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level10" title="Suction Tank" style="position: absolute; z-index: 2; top: 226px; left: 786px; width: 35px; height: 20px; background: transparent">
            <div id="show_level10color" class="waterlevel">
                <img id="show_level10" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level11" title="Suction Tank" style="position: absolute; z-index: 2; top: 287px; left: 786px; width: 35px; height: 20px; background: transparent">
            <div id="show_level11color" class="waterlevel">
                <img id="show_level11" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level12" title="Suction Tank" style="position: absolute; z-index: 2; top: 345px; left: 786px; width: 35px; height: 20px; background: transparent">
            <div id="show_level12color" class="waterlevel">
                <img id="show_level12" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level13" title="Suction Tank" style="position: absolute; z-index: 2; top: 427px; left: 786px; width: 35px; height: 20px; background: transparent">
            <div id="show_level13color" class="waterlevel">
                <img id="show_level13" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level14" title="Suction Tank" style="position: absolute; z-index: 2; top: 490px; left: 786px; width: 35px; height: 20px; background: transparent">
            <div id="show_level14color" class="waterlevel">
                <img id="show_level14" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level15" title="Suction Tank" style="position: absolute; z-index: 2; top: 163px; left: 930px; width: 35px; height: 20px; background: transparent">
            <div id="show_level15color" class="waterlevel">
                <img id="show_level15" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level16" title="Suction Tank" style="position: absolute; z-index: 2; top: 227px; left: 930px; width: 35px; height: 20px; background: transparent">
            <div id="show_level16color" class="waterlevel">
                <img id="show_level16" src="../images/blank.gif" width="48" height="10"></div>
        </div>
          <div id="water_level17" title="Suction Tank" style="position: absolute; z-index: 2; top: 287px; left: 930px; width: 35px; height: 20px; background: transparent">
            <div id="show_level17color" class="waterlevel">
                <img id="show_level17" src="../images/blank.gif" width="48" height="10"></div>
        </div>
   
          


           
        <div style="position: absolute; top: 286px; left: 458px; z-index: 2;">
            <div id="l_level2_value" class="black_box">???</div>
        </div>

        <div style="position: absolute; top: 375px; left: 458px; z-index: 2;">
            <div id="l_level3_value" class="black_box">???</div>
        </div>

        <div style="position: absolute; top: 466px; left: 458px; z-index: 2;">
            <div id="l_level4_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 557px; left: 458px; z-index: 2;">
            <div id="l_level5_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 557px; left: 600px; z-index: 2;">
            <div id="l_level6_value" class="black_box">???</div>
        </div>
           <div style="position: absolute; top: 494px; left:600px; z-index: 2;">
            <div id="l_level7_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 446px; left:600px; z-index: 2;">
            <div id="l_level8_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 287px; left: 600px; z-index: 2;">
            <div id="l_level9_value" class="black_box">???</div>
        </div>
         <div style="position: absolute; top:163px; left: 793px; z-index: 2;">
            <div id="l_level10_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 226px; left:793px; z-index: 2;">
            <div id="l_level11_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 287px; left: 793px; z-index: 2;">
            <div id="l_level12_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 345px; left: 793px; z-index: 2;">
            <div id="l_level13_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 427px; left: 793px; z-index: 2;">
            <div id="l_level14_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 490px; left: 793px; z-index: 2;">
            <div id="l_level15_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 163px; left: 937px; z-index: 2;">
            <div id="l_level16_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 227px; left: 937px; z-index: 2;">
            <div id="l_level17_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 287px; left: 937px; z-index: 2;">
            <div id="l_level18_value" class="black_box">???</div>
        </div>
                  <div id="link" title="Loji Air Gadek 2" style="position: absolute; z-index: 2; top: 590px; left: 877px; width: 110px; height: 50px; background: transparent" onclick="showextend('LojoAirGadek03')">
             <img id="next" src="../images/next2.png" width="48" height="30"/> 
         </div>
                <div id="link" title="Loji Air Gadek 2" style="position: absolute; z-index: 2; top: 590px; left: 77px; width: 110px; height: 50px; background: transparent" onclick="showextend('LojiAirGadek01')">
             <img id="prev" src="../images/sprev 1.png" width="48" height="30"/> 
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
