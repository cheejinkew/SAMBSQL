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
            font-size: 12px;
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
        var ResSiteID = new Array("DA1M", "DA2M", "DA3M", "DA4M", "DA5M", "DA6M", "DA7M", "DA8M", "DA9M", "DA10", "DA11");

        $(document).ready(function () {

            //Default All Tank Color to Orange
            //*************************************************************************

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')
                .attr('width', '45px').appendTo($("#DA1M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')
                .attr('width', '45px').appendTo($("#DA2M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')
                .attr('width', '45px').appendTo($("#DA3M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')
                .attr('width', '45px').appendTo($("#DA4M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA5M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA6M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA7M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA8M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA9M_tank1_bg"));


            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA10M_tank1_bg"));

            $('<img />').attr('src', 'images/Tank/box-orange.png')
                .attr('height', '45px')

                .attr('width', '45px').appendTo($("#DA11M_tank1_bg"));
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

            $.each(data, function (idx, ele) {

                var index = ResSiteID.indexOf(ele.SiteID);
                if (index > -1) {
                    ResSiteID.splice(index, 1);
                }


                if (ele.SiteID == "DA1M") {

                    $("#DA1M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA1M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA1M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA2M") {

                    $("#DA2M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA2M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA2M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA3M") {

                    $("#DA3M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA3M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA3M_tank1").html(ele);
                        }

                    })

                }

                if (ele.SiteID == "DA4M") {

                    $("#DA4M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA4M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA4M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA5M") {

                    $("#DA5M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA5M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA5M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA6M") {

                    $("#DA6M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA6M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA6M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA7M") {

                    $("#DA7M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA7M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA7M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA8M") {

                    $("#DA8M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA8M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA8M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA9M") {

                    $("#DA9M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA9M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA9M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA10") {

                    $("#DA10M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA10M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA10M_tank1").html(ele);
                        }

                    })
                }

                if (ele.SiteID == "DA11") {

                    $("#DA11M_tank1_bg").html("");

                    $('<img />').attr('src', ele.Delay == "1" ? 'images/Tank/box-red.png' : 'images/Tank/box-green.png')
                        .attr('height', '45px')
                        .attr('width', '45px').appendTo($("#DA11M_tank1_bg"));

                    $.each(ele.Level, function (idx, ele) {

                        switch (idx) {
                            case 0: $("#DA11M_tank1").html(ele);
                        }

                    })
                }



            })
        }

        function redirect(page) {
            var vUrl;
            if (page.id == "DA10M" || page.id == "DA11M")
                vUrl = "Custom/DA1M.aspx?ID=" + page.id.substring(0, 4);
            else
                vUrl = "Custom/DA1M.aspx?ID=" + page.id;
            xmlhttp.abort();
            window.location = vUrl;
        }

    </script>
</head>
<body bgcolor="#0071bb">
    <form id="form1" runat="server">
        <div class="background">
            <img src="images/edtv1.png?<%=DateTime.Now %>" alt="" style="width: 1280px;" />
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
        <div onclick="redirect(this);" id="DA1M" style="position: absolute; z-index: 4; top: 532px; left: 330px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA1M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA1M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA2M" style="position: absolute; z-index: 4; top: 450px; left: 370px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA2M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA2M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA3M" style="position: absolute; z-index: 4; top: 523px; left: 500px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA3M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA3M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA4M" style="position: absolute; z-index: 4; top: 460px; left: 500px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA4M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA4M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA5M" style="position: absolute; z-index: 4; top: 400px; left: 520px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA5M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA5M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>

        <div onclick="redirect(this);" id="DA6M" style="position: absolute; z-index: 4; top: 323px; left: 590px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA6M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA6M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA7M" style="position: absolute; z-index: 4; top: 250px; left: 425px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA7M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA7M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA8M" style="position: absolute; z-index: 4; top: 78px; left: 470px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA8M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA8M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA9M" style="position: absolute; z-index: 4; top: 158px; left: 837px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA9M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA9M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA10M" style="position: absolute; z-index: 4; top: 225px; left: 1000px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA10M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA10M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <div onclick="redirect(this);" id="DA11M" style="position: absolute; z-index: 4; top: 456px; left: 871px; cursor: pointer; height: 45px; width: 45px;">
            <div id="DA11M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
                -
            </div>
            <div id="DA11M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
            </div>
        </div>
        <%-- <div onclick="redirect(this);" id="DA12M" style="position: absolute; z-index: 4; top: 615px;
        left: 965px; cursor: pointer; height: 45px; width: 45px;">
        <div id="DA12M_tank1" style="position: absolute; top: 11px; left: 8px;" class="indicator">
            -
        </div>
        <div id="DA12M_tank1_bg" style="position: absolute; top: 0px; left: 1px; z-index: 2;">
        </div> 
    </div>--%>

        <div class="indicator" title="Suction Tank" style="position: absolute; width: 100px; height: 33px; top: 402px; left: 175px; z-index: 2; text-align: center; cursor: pointer; background-image: url(../images/DamInfo.png); background-repeat: no-repeat;" onclick="R_trend('S1H3','SUCTION LENDU','50','Alor Gajah')">
            <div style="position: absolute; top: 2px; left: 10px;" class="labelingW">Level</div>
            <div style="position: absolute; top: 16px; left: 10px;" id="l_level3_value" class="indicator">???</div>
        </div> 

        <!--Unknown Site-->
    </form>
</body>
</html>

