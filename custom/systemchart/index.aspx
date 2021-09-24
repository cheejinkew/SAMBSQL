<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
    <title>System View</title>
    <style>
body{background-image:url(../../images/Logo_small.jpg);background-repeat:no-repeat;}
h1{
	margin-left:5px;
	font-family:verdana;font-weight:normal;font-size:20px;
	width:100%;text-align:left;
}
iframe#display{
	width:100%;height:92%;BACKGROUND-COLOR:red;border:0px;
}
.mainan {
	width:100%;text-align:vertical-align:top;center;
}
.table_top{
	width:100%;height:8%;cell-Padding:0px;cell-Spacing:0px;border-collapse:collapse;
}
.menu {
	margin:0px 0px 0px 2px;float:right;padding-top:2px;
	BACKGROUND-COLOR:dodgerblue;color:white;font-family:verdana;font-weight:bold;font-size:13px;
	width:150px;height:20px;text-align:center;cursor:pointer;
}
a{text-decoration:none;color:black;}
	a#legendlink{text-decoration:none;}
	a .legendbox {height:40px;filter:alpha(opacity=75);-moz-opacity:.75;opacity:.75;}
	a:hover .legendbox {height:250px;filter:alpha(opacity=89);-moz-opacity:.89;opacity:.89;}
	a .l_lineDIV {display:none}
	a:hover .l_lineDIV {display:block}
	a .l_arrow {display:block}
	a:hover .l_arrow {display:none}
	
	.legendbox
	{
		position: absolute;
		top:15px;
		left:137px;
		height:130px;
		width:95px;
		border: 1px solid darkgray;
		padding: 2px 2px 2px 2px;
		background:white;
		color:black;
		z-index:10;
	}
	.l_arrow{float:right;width:15%;margin-top:0px;background-image:url(../../images/white.gif);background-repeat:no-repeat;}
	.l_titlebox{float:left;width:85%;padding:0px 0px 2px 2px;font: bold 900 12px verdana; }
	.l_titleDIV{float:top;width:100%;margin-bottom:2px;padding-left:5px}
	.l_lineDIV{float:top;width:100%;margin-bottom:5px;padding-left:5px;}
	.l_colorbox{border: 1px solid #000000;height:22px;width:22px;float:left}
	.l_textbox{height:20px;width:50px;font: bold 500 10px verdana;padding: 5px 0px 0px 5px;float:left}
</style>
    <script language="javascript">
        var page_title = 'System View';

        function gts(id, url, _title) {
            document.getElementById('display').src = url;
            document.title = page_title + ' :: ' + _title;
            reset_menu();
            eval("document.getElementById('" + id + "').style.backgroundColor='#104584'");
        }

        function reset_menu() {
            for (var i = 1; i < 7; i++) {
                eval("document.getElementById('" + i + "m').style.backgroundColor='dodgerblue'");
            }
        }
    </script>
</head>
<body topmargin="40" scroll="NO">
    <table class="table_top">
        <tr>
            <td align="right" valign="bottom" width="100%">
                <div class="mainan">
                    <div id="1m" class="menu" onclick="gts(this.id,'mimic01.aspx',this.innerHTML);" style="background-color: #104584">
                        Loji Merlimau</div>
                    <div id="2m" class="menu" onclick="gts(this.id,'mimic02.aspx',this.innerHTML);">
                        Loji Air Bkt Sebukor</div>
                    <div id="3m" class="menu" onclick="gts(this.id,'mimic03.aspx',this.innerHTML);">
                        Loji Asahan</div>
                    <div id="4m" class="menu" onclick="gts(this.id,'mimic04.aspx',this.innerHTML);">
                        Loji Bertam</div>
                    <div id="5m" class="menu" onclick="gts(this.id,'mimic05.aspx',this.innerHTML);">
                        Loji Gadek</div>
                    <div id="6m" class="menu" onclick="gts(this.id,'mimic06.aspx',this.innerHTML);">
                        Loji DAF</div>
                </div>
            </td>
        </tr>
    </table>
    <iframe id="display" src="mimic01.aspx" frameborder="0"></iframe>
    <!--#include file="include.html"-->
</body>
</html>
