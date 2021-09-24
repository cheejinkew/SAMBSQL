﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="bph_LAC_43_1.aspx.vb" Inherits="custom_bph_LAC_43_1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link type="text/css" href="_objects.css" rel="stylesheet" />
      <%--<link type="text/css" href="../css/Reservoir.css" rel="stylesheet" />--%>
    <script type ="text/javascript" src="../js/jquery-1.8.2.min.js"></script>
    <script type ="text/javascript"  >
   $(document).ready(function () {
            GetData();
        });

   function GetData() {

       //This Site Have Two RTU(J4 and J5)
       var SiteID = '<%=strsiteid%>';
            var SiteID_1 = '<%=strsiteid1%>';
            var SiteID_2 = '<%=strsiteid2%>';
           

            var url_1 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID;
            var url_2 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_1;
            var url_3 = "../ajx/CustomFeedData1.aspx?ID=" + SiteID_2;
         
            var xmlhttp_1;
            var xmlhttp_2;
            var xmlhttp_3;
           
           

            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp_1 = new XMLHttpRequest();
                xmlhttp_2 = new XMLHttpRequest();
                xmlhttp_3 = new XMLHttpRequest();
                 
               
            }
            else {// code for IE6, IE5
                xmlhttp_1 = new ActiveXObject("Microsoft.XMLHTTP");
                xmlhttp_2 = new ActiveXObject("Microsoft.XMLHTTP");
                xmlhttp_3 = new ActiveXObject("Microsoft.XMLHTTP");
                
            
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
           
            
          

            xmlhttp_1.open("GET", url_1, true);
            xmlhttp_1.send();

            xmlhttp_2.open("GET", url_2, true);
            xmlhttp_2.send();

            xmlhttp_3.open("GET", url_3, true);
            xmlhttp_3.send();

   

            
         
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
            window.location = "../Trending_bph.aspx?siteid="+id+"&position="+pos;
        }
        function R_trend(id,name,pos,district) {
            window.location = "../Trending.aspx?siteid=" + id + "&sitename=" + name + "&district=" + district + "&position=" + pos + "&sitetype=RESERVOIR&equipname=Water%20Level%20Trending";
        }
        </script>
         <style>
        table
        {
            font-family: verdana;
            font-size: 10px;
            border-collapse: collapse;
            border: 1px solid white;
        }
        
        th, td
        {
            text-align: left;
            padding: 5px;
            color: white;
            border: 1px solid white;
        }
        th
        {
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
<body  bgcolor="#0071bb">
    <form id="form1" runat="server">
    <div>
    
    </div>
    <div style ="background-image :url(imej/LAC_43_1.png?r=199182392);height:745px;width :1050px;" >
    
    </div>
    
    <div id="water_level1" title="Suction Tank" style="position:absolute;z-index:2;top:621px;left:294px;width:48px;height:25px;background:transparent">
		<div id="show_level1color" class="waterlevel"><img id="show_level1" src="../images/blank.gif" width="48" height="10"></div>
	</div>
     <div id="water_level2" title="Suction Tank" style="position:absolute;z-index:2;top:529px;left:419px;width:48px;height:25px;background:transparent">
		<div id="show_level2color" class="waterlevel"><img id="show_level2" src="../images/blank.gif" width="48" height="10"></div>
	</div>
      <div id="water_level3" title="Suction Tank" style="position:absolute;z-index:2;top:555px;left:543px;width:48px;height:25px;background:transparent">
		<div id="show_level3color" class="waterlevel"><img id="show_level3" src="../images/blank.gif" width="48" height="10"></div>
	</div>
          
       
        

   <div style="position:absolute;top:621px;left:304px;z-index:2;"> 
      <div id="l_level2_value"  class="black_box">???</div> 
    </div> 
     <div style="position:absolute;top:529px;left:429px;z-index:2;"> 
      <div id="l_level3_value"  class="black_box">???</div> 
    </div> 
      <div style="position:absolute;top:555px;left:553px;z-index:2;"> 
      <div id="l_level4_value"  class="black_box">???</div> 
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
