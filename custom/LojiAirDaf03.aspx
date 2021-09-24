<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LojiAirDaf03.aspx.vb" Inherits="LojiAirDaf03" %>

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
         
           var url_1 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID;
           var url_2 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_1;
           var url_3 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_2;
           var url_4 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_3;
           var url_5 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_4; 
           var xmlhttp_1;
           var xmlhttp_2;
           var xmlhttp_3;
           var xmlhttp_4;
           var xmlhttp_5;
          
           if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
               xmlhttp_1 = new XMLHttpRequest();
               xmlhttp_2 = new XMLHttpRequest();
               xmlhttp_3 = new XMLHttpRequest();
               xmlhttp_4 = new XMLHttpRequest();
               xmlhttp_5 = new XMLHttpRequest();
             }
           else {// code for IE6, IE5
               xmlhttp_1 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_2 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_3 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_4 = new ActiveXObject("Microsoft.XMLHTTP");
               xmlhttp_5 = new ActiveXObject("Microsoft.XMLHTTP");
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
           window.location =page+".aspx";
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
        <div style="background-image: url(imej/LojiAirDaf1-03.png?r=199182392); height: 745px; width: 1050px;">
        </div>

        <div id="water_level1" title="Suction Tank"   
            style="position: absolute; z-index: 2; top: 322px; left: 87px; width: 48px; height: 27px; background:transparent; margin-bottom: 3px;">
            <div id="show_level1color" class="waterlevel">
                <img id="show_level1" src="../images/blank.gif" width="48" height="10" /></div>
        </div>
        <div id="water_level2" title="Suction Tank" 
            style="position: absolute; z-index: 2; top: 547px; left: 303px; width: 48px; height: 27px; background: transparent">
            <div id="show_level2color" class="waterlevel">
                <img id="show_level2" src="../images/blank.gif" width="48" height="10"></div>
        </div>
        <div id="water_level3" title="Suction Tank" style="position: absolute; z-index: 2; top:357px; left: 484px; width: 48px; height: 27px; background: transparent">
            <div id="show_level3color" class="waterlevel">
                <img id="show_level3" src="../images/blank.gif" width="48" height="10"></div>
        </div>
        <div id="water_level4" title="Suction Tank" style="position: absolute; z-index: 2; top: 444px; left: 484px; width: 48px; height: 27px; background: transparent">
            <div id="show_level4color" class="waterlevel">
                <img id="show_level4" src="../images/blank.gif" width="48" height="10"></div>
        </div>
        <div id="water_level5" title="Suction Tank" style="position: absolute; z-index: 2; top: 170px; left: 497px; width: 25px; height: 27px; background: transparent">
            <div id="show_level5color" class="waterlevel">
                <img id="show_level5" src="../images/blank.gif" width="25" height="10"></div>
        </div>
        <div id="water_level6" title="Suction Tank" style="position: absolute; z-index: 2; top: 266px; left: 497px; width: 25px; height: 27px; background: transparent">
            <div id="show_level6color" class="waterlevel">
                <img id="show_level6" src="../images/blank.gif" width="25" height="10"></div>
        </div>
         <div id="water_level7" title="Suction Tank" style="position: absolute; z-index: 2; top: 359px; left: 617px; width: 25px; height: 26px; background: transparent">
            <div id="show_level7color" class="waterlevel">
                <img id="show_level7" src="../images/blank.gif" width="25" height="10"></div>
        </div>
         <div id="water_level8" title="Suction Tank" style="position: absolute; z-index: 2; top:445px; left: 617px; width: 25px; height: 26px; background: transparent">
            <div id="show_level8color" class="waterlevel">
                <img id="show_level8" src="../images/blank.gif" width="25" height="10"></div>
        </div>
        <div style="position: absolute; top: 322px; left: 94px; z-index: 2; height: 11px; width: 20px;">
            <div id="l_level2_value" class="black_box">???</div>
        </div>

        <div style="position: absolute; top:547px; left: 310px; z-index: 2;">
            <div id="l_level3_value" class="black_box">???</div>
        </div>

        <div style="position: absolute; top: 357px; left: 491px; z-index: 2;">
            <div id="l_level4_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 444px; left:491px; z-index: 2;">
            <div id="l_level5_value" class="black_box">???</div>
        </div>
        <div style="position: absolute; top: 170px; left: 504px; z-index: 2;">
            <div id="l_level6_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top:266px; left: 504px; z-index: 2;">
            <div id="l_level7_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top: 359px; left: 614px; z-index: 2;">
            <div id="l_level8_value" class="black_box">???</div>
        </div>
          <div style="position: absolute; top:445px; left: 614px; z-index: 2;">
            <div id="l_level9_value" class="black_box">???</div>
        </div>

        <div id="link" title="Loji Air Gadek 2" style="position: absolute; z-index: 2; top: 508px; left: 877px; width: 110px; height: 50px; background: transparent" onclick="showextend('LojiAirDaf04')">
             <img id="next" src="../images/next2.png" width="48" height="30"/> 
         </div>
     <div id="link" title="Loji Air Gadek 2" style="position: absolute; z-index: 2; top: 590px; left: 77px; width: 110px; height: 50px; background: transparent" onclick="showextend('LojiAirDaf02')">
             <img id="prev" src="../images/sprev 1.png" width="48" height="30"/> 
         </div>
         </form>
</body>
</html>
