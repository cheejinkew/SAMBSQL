<%@ Page Language="VB" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Cascade Diagram</title>
    <script src="Scripts/JSON.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="Scripts/CustomPump.js" type="text/javascript"></script>
    <style type="text/css">
        .indicator {
            background: transparent;
            font-family: verdana;
            font-size: 10px;
            color: darkviolet;
            z-index: 3;
        }

        .background {
            position: absolute;
            top: 1px;
            left: 3px;
            z-index: 1;
        }

        .legends {
            position: fixed;
            top: 5px;
            right: 5px;
            z-index: 5;
            border: 1px solid black;
            background-color: White;
        }

            .legends table {
                padding: 0;
                margin: 0;
            }

            .legends span {
                padding: 2px 2px 2px 2px;
                font-family: 'lucida grande',tahoma,verdana,arial,sans-serif;
                font-size: 11px;
            }
    </style>
    <script type="text/javascript">

        var url = "ajx/EDTDATA.aspx?ID=DA1M";
        var xmlhttp = new XMLHttpRequest();
        var ResSiteID = new Array("DA1M", "DA2M", "DA3M", "DA4M", "DA5M", "DA6M", "DA7M", "DA8M", "DA9M", "DA10", "DA11", "DA12");

        $(document).ready(function () {

            //Default All Tank Color to Orange
            //*************************************************************************

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')
                .attr('width', '65px').appendTo($("#DA1M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')
                .attr('width', '65px').appendTo($("#DA2M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')
                .attr('width', '45px').appendTo($("#DA3M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')
                .attr('width', '65px').appendTo($("#DA4M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA5M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA6M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA7M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA8M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA9M_tank1_bg"));


            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA10M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA11M_tank1_bg"));
            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA11M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '55px')

                .attr('width', '65px').appendTo($("#DA12M_tank1_bg"));
            GetData();
        });

        function GetData() {

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var data = xmlhttp.responseText;
                    var jdata = JSON.parse(data);
                    Fill_Data(jdata);
                }
            }
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
            //5 minutes
            var refreshInterval = 20;
            refreshInterval = refreshInterval * 60000;
            setTimeout('GetData()', refreshInterval);
        }

        function Fill_Data(data) {
            //alert(JSON.stringify(data, null, 4));
            //alert(JSON.stringify(data, null, "\t"));

            for (var i = 0; i < data.length;i++) {
                var ele = data[i];
                
                if (ele.SiteID == "DA1M") {

                    $("#DA1M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA1M_tank1_bg"));

                    $("#DA1M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA1M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA1M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                   
                }

                if (ele.SiteID == "DA2M") {

                    $("#DA2M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA2M_tank1_bg"));

                     $("#DA2M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA2M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA2M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                }

                if (ele.SiteID == "DA3M") {

                    $("#DA3M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA3M_tank1_bg"));

                     $("#DA3M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA3M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA3M_tank1_ac").html("A : "+ ele.acumulater + " m3");

                }

                if (ele.SiteID == "DA4M") {

                    $("#DA4M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA4M_tank1_bg"));
                    $("#DA4M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA4M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA4M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                     
                }

                if (ele.SiteID == "DA5M") {

                    $("#DA5M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA5M_tank1_bg"));
                     $("#DA5M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA5M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA5M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                    
                }

                if (ele.SiteID == "DA6M") {

                    $("#DA6M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA6M_tank1_bg"));

                      $("#DA6M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA6M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA6M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                }

                if (ele.SiteID == "DA7M") {

                    $("#DA7M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA7M_tank1_bg"));

                      $("#DA7M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA7M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA7M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                }

                if (ele.SiteID == "DA8M") {

                    $("#DA8M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA8M_tank1_bg"));
                     $("#DA8M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA8M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA8M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                     
                }

                if (ele.SiteID == "DA9M") {

                    $("#DA9M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA9M_tank1_bg"));
                    $("#DA9M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA9M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA9M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                    
                }

                if (ele.SiteID == "DA10") {

                    $("#DA10M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA10M_tank1_bg"));

                     $("#DA10M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA10M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA10M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                }

                if (ele.SiteID == "DA11") {

                    $("#DA11M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '55px')
                        .attr('width', '110px').appendTo($("#DA11M_tank1_bg"));
                     $("#DA11M_tank1").html("F : " + ele.flowrate+ " m3/hr");
                                    $("#DA11M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA11M_tank1_ac").html("A : "+ ele.acumulater + " m3");
                    
                }

                                if (ele.SiteID == "DA12") {

                                    $("#DA12M_tank1_bg").html("");

                                                $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                                    .attr('height', '55px')
                                    .attr('width', '110px').appendTo($("#DA12M_tank1_bg"));
                                    $("#DA12M_tank1").html("F : " + ele.flowrate + " m3/hr");
                                    $("#DA12M_tank1_dc").html("D : " + ele.daycounter + " m3");
                                    $("#DA12M_tank1_ac").html("A : " + ele.acumulater + " m3");

                                }


            }
        }

        function redirect(page) {
            var vUrl;
            if (page.id == "DA10M" || page.id == "DA11M" || page.id == "DA12M")
                vUrl = "TrendingM6.aspx?siteid=" + page.id.substring(0,4) + "&Pos=2";
            else
                vUrl = "TrendingM6.aspx?siteid=" + page.id + "&Pos=2";
            xmlhttp.abort();
            window.location = vUrl;
        }

    </script>
</head>
<body bgcolor="#0071bb">
    <form id="form1" runat="server">
        <div class="background">
            <img src="images/edv2.jpg?<%=DateTime.Now %>" alt="" style="width: 1280px;" />
        </div>
        <!--Legends-->
        <div class="legends">
            <table>
                <tr>
                    <td>
                        <div style="width: 10px; height: 10px; background-color: Red">
                        </div>
                    </td>
                    <td>
                        <span>Late Update</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="width: 10px; height: 10px; background-color: Orange">
                        </div>
                    </td>
                    <td>
                        <span>Inactive Data</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="width: 10px; height: 10px; background-color: #64FE2E">
                        </div>
                    </td>
                    <td>
                        <span>Live Data</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="width: 10px; height: 10px; background-color: #BDBDBD">
                        </div>
                    </td>
                    <td>
                        <span>Shut Down</span>
                    </td>
                </tr>
            </table>
        </div>
        <!--Legends-->
        <!--Pulau Enoe-->
        <div onclick="redirect(this);" id="DA1M" style="position: absolute; z-index: 4; top: 255px; left: 276px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA1M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
              <div id="DA1M_tank1_dc" style="position: absolute; top: 23px; left: 8px;" class="indicator">
                -
            </div>
              <div id="DA1M_tank1_ac" style="position: absolute; top: 35px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA1M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA2M" style="position: absolute; z-index: 4; top: 370px; left: 240px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA2M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA2M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA2M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA2M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA3M" style="position: absolute; z-index: 4; top: 338px; left:1165px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA3M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA3M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA3M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA3M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA4M" style="position: absolute; z-index: 4; top: 497px; left: 1130px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA4M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA4M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA4M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA4M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA5M" style="position: absolute; z-index: 4; top:155px; left: 416px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA5M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA5M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA5M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA5M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA6M" style="position: absolute; z-index: 4; top: 154px; left: 340px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA6M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA6M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA6M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA6M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA7M" style="position: absolute; z-index: 4; top: 400px; left: 1165px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA7M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA7M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA7M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA7M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA8M" style="position: absolute; z-index: 4; top: 330px; left:636px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA8M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA8M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA8M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA8M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA9M" style="position: absolute; z-index: 4; top: 485px; left: 570px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA9M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA9M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA9M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA9M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA10M" style="position: absolute; z-index: 4; top: 485px; left: 284px; cursor: pointer; height: 55px; width: 65px;">
            <div id="DA10M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA10M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA10M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA10M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA11M" style="position: absolute; z-index: 4; top: 286px; left: 954px; cursor: pointer; height: 55px; width:65px;">
            <div id="DA11M_tank1" style="position: absolute; top: 11px; left: 8px; width:100px;" class="indicator">
                -
            </div>
             <div id="DA11M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA11M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
            <div id="DA11M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
         <div onclick="redirect(this);" id="DA12M" style="position: absolute; z-index: 4; top: 444px;
        left: 866px; cursor: pointer; height: 45px; width: 45px;">
        <div id="DA12M_tank1" style="position: absolute; top: 11px; left: 8px;width:100px;" class="indicator">
            -
        </div>
         <div id="DA12M_tank1_dc" style="position: absolute; top: 23px; left: 8px; width:85px;" class="indicator">
                -
            </div>
              <div id="DA12M_tank1_ac" style="position: absolute; top: 35px; left: 8px; width:85px;" class="indicator">
                -
            </div>
        <div id="DA12M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
        </div> 

    </div>

     

        <!--Unknown Site-->
    </form>
</body>
</html>

