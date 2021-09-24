<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DA1M.aspx.vb" Inherits="custom_DA1M" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Intake System of Loji Air Jalan Kolam</title>
    <link href="../css/Reservoir.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../Scripts/CustomPump.js" type="text/javascript"></script>
    <script type="text/javascript">

        var SiteID = '<%=strSiteID%>';
        var url = "../ajx/CustomFeedData1M6.aspx?ID=" + SiteID;
        var xmlhttp;

        $(document).ready(function () {
            GetData();
        });

        function GetData() {

            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var data = xmlhttp.responseText;
                    Fill_Data(data);
                }
            }

            xmlhttp.open("GET", url, true);
            xmlhttp.send();

            //5 minutes
            var refreshInterval = 20;
            refreshInterval = refreshInterval * 60000;
            setTimeout('GetData()', refreshInterval);
        }

        //For Unit JA
        function Fill_Data(data) {

            var arrdata = data.split("|");

            if (arrdata.length > 2) {

                $("#RTU_timestamp").html(arrdata[0]);

                if (parseFloat(arrdata[1].toString()) == 2) {

                    //if (arrdata[2] == "0") {
                    //    $("#RTU_power").attr('class', 'ok').html("OK");
                    //}
                    //else {
                    //    $("#RTU_power").attr('class', 'fail').html("FAIL");
                    //}

                    //if (arrdata[3] == "0") {
                    //    $("#RTU_battery").attr('class', 'ok').html("OK");
                    //}
                    //else {
                    //    $("#RTU_battery").attr('class', 'fail').html("FAIL");
                    //}

                    $("#flowrate").html(arrdata[2]+" m3/hr" );
                    $("#totaliser").html(arrdata[3]);
                  

                }
            }
        }

        function redirect(page) {

            var vUrl =   "DA1M.aspx?id=" + page;

            xmlhttp.abort();
            window.location = vUrl;
        }

        function redirectTrending(SiteID, Position, Description) {

            var vUrl = "../Trending.aspx?siteid=" + SiteID + "&Pos=" + Position + "&Desc=" + Description;

            xmlhttp.abort();
            window.location = vUrl;
        }

    </script>
</head>
<body bgcolor="#0071bb">
    <form id="form1" runat="server">
    <div class="background">
        <img src="imej/dam1.png" alt="" />
    </div>
    <div id="header">
      <%=damsitename %></div>
    <!-- indicator -->
        
    <div id="rtu_stat1" style="position: absolute; z-index: 3; top: 425px; left: 21px"
        class="rtu_island">
        <div id="rtu_stat1_tag" style="position: absolute; top: 1px; left: 1px" class="tag">
            <%=strSiteID%>
        </div>
        <div id="RTU_timestamp" style="position: absolute; top: 0px; left: 51px" class="labelhead">
            Data No Available
        </div>
        <div id="RTU_power" style="position: absolute; top: 18px; left: 62px" class="ok">
            -
        </div>
        <div id="RTU_battery" style="position: absolute; top: 18px; left: 172px" class="ok">
            -
        </div>
    </div>

   <div title="Dam Level Trending" id="empangan" style="position: absolute; z-index: 3;
        top: 73px; left: 112px; cursor: pointer" onclick="redirectTrending('<%=strSiteID%>', '2', 'Kerupang Dam Level')">
        <div id="flowrate" class="indicator" style ="padding-top :8px;">
            -</div>
        <div id="totaliser" class="indicator" style ="padding-top :8px;">
            -</div>
    </div> 
    
   
    <div id="footer">
        <div class="foot_copy">
            Copyright ©
            <%=DateTime.Now.ToString("yyyy")%>
            Gussmann Technologies Sdn Bhd. All rights reserved.</div>
        <div class="foot_note">
            * Click on clickable values to show trending option.</div>
    </div>

    </form>
</body>
</html>
