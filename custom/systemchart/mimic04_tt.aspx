<%@ Page Language="VB" Debug="true" %>

<%
	dim imgpath = "http://www.g1.com.my/telemetrymgmt_selangor/custom/imej/"
	dim bgcolor = "#ADD8E6"
	dim oricolor = "#ADD8E6"
    Dim siteid() As String = {"8540", "8582", "8585", "8566", "8515", "8627", "8527", "8528", "8562", _
							  "KOLAM INDUSTRI LONDANG", "TANGKI TMN TG BIDARA INDAH", "8554", "8611", "8530", "8560", "TMN KESIDANG", "8616", "8615", "8512", "8511", "8550", "8543", "8542", "8545", _
							  "8590", "TANGKI TMN GAMILAN", "POWERTECK", "8559", "TANGKI TG DAHAN", "8551", "8625", "8624", "8626"}
%>
<html>
<head>
    <meta content="text/html; charset=iso-8859-1" http-equiv="Content-Type">
    <title>mimic 04</title>
    <meta name="Microsoft Border" content="none, default" />
    <!--#include file="style.inc"-->
</head>
<body>
    <div id="header">
        EMPANGAN JUS</div>
    <div class="mainbox">
        <div class="childbox" style="left: 0px;">
            <div class="lagenda" style="position: relative; top: 545px; left: 2px;">
                <div id="sitename" class="titlebox" style="background: <%=oricolor%>">
                    LOJI BERTAM</div>
                <div class="lineDIV">
                    <div id="timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 5px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(30)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(30)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(30)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(30)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 95px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(31)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(31)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(31)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(31)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 185px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(32)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(32)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(32)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(32)%>_status" class="textbox">
                    </div>
                </div>
            </div>
        </div>
        <div class="Vline" style="height: 1450px; top: 40px; left: 225px;">
        </div>
        <div class="childbox" style="left: 250px;">
            <div class="lagenda" style="position: absolute; top: 5px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(0)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(0)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(0)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(0)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 95px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(1)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(1)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(1)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(1)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 185px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(2)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(2)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(2)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(2)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 275px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(3)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(3)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(3)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(3)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 365px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(4)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(4)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(4)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(4)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 455px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(5)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(5)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(5)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(5)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 545px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(6)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(6)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(6)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(6)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1085px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(7)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(7)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(7)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(7)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1445px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(8)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(8)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(8)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(8)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
        </div>
        <div class="Vline" style="height: 640px; top: 220px; left: 475px;">
        </div>
        <div class="Vline" style="height: 190px; top: 1030px; left: 475px;">
        </div>
        <div class="Vline" style="height: 460px; top: 1300px; left: 475px;">
        </div>
        <div class="childbox" style="left: 500px;">
            <div class="lagenda" style="position: absolute; top: 185px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(9)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(9)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(9)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(9)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 275px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(10)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(10)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(10)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(10)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 365px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(11)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(11)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(11)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(11)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 545px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(12)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(12)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(12)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(12)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 725px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(13)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(13)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(13)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(13)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 815px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(14)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(14)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(14)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(14)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 995px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(15)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(15)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(15)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(15)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1085px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(16)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(16)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(16)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(16)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1175px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(17)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(17)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(17)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(17)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <!-- ======================================================================= -->
            <div class="lagenda" style="position: absolute; top: 1265px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(18)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(18)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(18)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(18)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1355px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(19)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(19)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(19)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(19)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1445px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(20)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(20)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(20)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(20)%>_status" class="textbox">
                    </div>
                </div>
                <div class="right" style="top: 29px; left: 199px;">
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1535px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(21)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(21)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(21)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(21)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1625px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(22)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(22)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(22)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(22)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1715px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(23)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(23)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(23)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(23)%>_status" class="textbox">
                    </div>
                </div>
            </div>
        </div>
        <div class="Vline" style="height: 190px; top: 490px; left: 725px;">
        </div>
        <div class="childbox" style="left: 750px;">
            <div class="lagenda" style="position: absolute; top: 365px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(24)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(24)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(24)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(24)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 455px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(25)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(25)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(25)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(25)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 545px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(26)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(26)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(26)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(26)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 635px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(27)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(27)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(27)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(27)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 725px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(28)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(28)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(28)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(28)%>_status" class="textbox">
                    </div>
                </div>
            </div>
            <div class="lagenda" style="position: absolute; top: 1445px; left: 2px;">
                <div class="right" style="top: 29px; left: -25px;">
                </div>
                <div id="<%=siteid(29)%>_sitename" class="titlebox" style="background: <%=oricolor%>">
                    <%=siteid(29)%></div>
                <div class="lineDIV">
                    <div id="<%=siteid(29)%>_timestamp" class="textbox">
                    </div>
                </div>
                <div class="lineDIV">
                    <div id="<%=siteid(29)%>_status" class="textbox">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <p style="padding-left: 50px; text-align: left; font: italic 900 10px verdana; color: #3366FF">
        * Click on the values for the trendings.</p>
</body>
<script language="JavaScript" src="../pump_control.js"></script>
</html>
<script>
var xmlHttpfeed;
var xmlHttpfeed_2;
var HTTP_commission;

var strSession = '<%=session("login")%>';
if (strSession != "true")
{
//alert("Session Timeout !");
//self.close();
}

var lstSiteID = "";

function show_indicator()
{ 
//var url="feeds.aspx?sid=" + Math.random()
var url="feeds_ts.aspx?lstSiteID=" + lstSiteID
xmlHttpfeed=GetXmlHttpObject(ChangingState)
xmlHttpfeed.open("GET", url , true)
xmlHttpfeed.send(null)

setTimeout('show_indicator()', 10000);

}

function ChangingState() 
{
if (xmlHttpfeed.readyState==4 || xmlHttpfeed.readyState=="complete")
{
var total_feed = xmlHttpfeed.responseXML.documentElement;

	if (total_feed.hasChildNodes()){
		var arr_data = total_feed.getElementsByTagName("site");
		var a_src = '';
<%
	dim i
	for i= LBound(siteid) to UBound(siteid)
%>
	if (get_values(arr_data,"id","<%=siteid(i)%>","textContent")==undefined){		
		sv_element('<%=siteid(i)%>_timestamp','Not Installed!')
	}else{
		sv_element('<%=siteid(i)%>_timestamp',get_values(arr_data,"id","<%=siteid(i)%>","timestamp"))		
		if (get_values(arr_data,"id","<%=siteid(i)%>","status")==''){
			sv_element('<%=siteid(i)%>_sitename','<a style="color:white" href="' + summary('<%=siteid(i)%>',get_values(arr_data,"id","<%=siteid(i)%>","textContent"),get_values(arr_data,"id","<%=siteid(i)%>","district"),get_values(arr_data,"id","<%=siteid(i)%>","type")) + '">' + get_values(arr_data,"id","<%=siteid(i)%>","textContent") + '</a>')
			sv_element('<%=siteid(i)%>_status',get_values(arr_data,"id","<%=siteid(i)%>","value") + ' m')
		}else{
			sv_element('<%=siteid(i)%>_sitename','<a style="color:black" href="' + summary('<%=siteid(i)%>',get_values(arr_data,"id","<%=siteid(i)%>","textContent"),get_values(arr_data,"id","<%=siteid(i)%>","district"),get_values(arr_data,"id","<%=siteid(i)%>","type")) + '">' + get_values(arr_data,"id","<%=siteid(i)%>","textContent") + '</a>')
			sv_element('<%=siteid(i)%>_status',get_values(arr_data,"id","<%=siteid(i)%>","value") + ' m (' + get_values(arr_data,"id","<%=siteid(i)%>","status") + ')')
		}
		eval("document.getElementById('<%=siteid(i)%>_sitename').style.background='#" + get_values(arr_data,"id","<%=siteid(i)%>","color") + "'");
	}
<%
	next
%>
	}else{		
		sv_element('header','Status: under maintenance')
	}
	sv_element('header',pageheader);	
} 
}

function init_the_show(){

<%
	dim iindex
	for iindex= LBound(siteid) to UBound(siteid)
%>
lstSiteID += "'" + '<%=siteid(iindex)%>' + "',"
<%
	next
%>

	loader_dia();
	show_indicator();	
}

function summary(id,name,dist,type){
  var url='../../Summary.aspx?';
  url = url + 'siteid=' + id + '&sitename=' + twentypercent(name) + '&district=' + dist + '&sitetype=' + twentypercent(type) + '&did=' + Math.random();
  return url;
}

window.onload = init_the_show;
</script>
