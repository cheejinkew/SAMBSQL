<%@ Page Language="VB" Debug="true" %>

<script language="javascript">
    var mimicView;
    var strSession = '<%=session("login")%>';
//    if (strSession != "true") {
//        alert("Session Timeout !");
//        top.location.href = "login.aspx";
//    }
    function popwin(url) {
        //	if (null==mimicView){
        //	mimicView = window.open(url)
        window.open(url);
        //	}else{
        //		mimicView.close();
        //		mimicView = window.open(url)
        //	}	
    }
    function logout() {
        if (null != mimicView) {
            mimicView.close();
        }
        top.location.href = 'login.aspx';
    }
</script>
<html>
<head>
    <title>Gussmann Telemetry Management System</title>
    <style>
        a
        {
            text-decoration: none;
        }
        .dropdown ul {display:none}
.dropdown:hover ul {display:block;}
    </style>
    <base target="contents">
</head>
<body topmargin="0" leftmargin="0" bgcolor="#FFFFFF">
    <form>
    <div align="right">
        <table border="0" cellspacing="1" width="100%" cellpadding="3" height="62">
            <tr>
                <td width="242" rowspan="2" height="62" valign="middle">
                    <img border="0" src="images/Logo_small.jpg" align="left">
                </td>
                <td height="35" colspan="11" align="right">
                    &nbsp;&nbsp; <font face="Verdana" size="1" color="#3366FF">
                        <%
                            Dim strUsername
         
                            strUsername = Request.Cookies("Telemetry")("UserName")
                            Response.Write("<b>Hello " & strUsername & " !</b>")
                            Response.Write("<br>")
                            Response.Write(Now().ToString("yyyy/MM/dd hh:mm:ss tt"))
     
                        %>
                    </font>
                </td>
            </tr>
           
            <tr>
                <td width="10%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="dashboard/dashboard.aspx" target="_blank">Dash
                        Board</a></font></b>
                </td>
                 
                <td width="10%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="dashboard/SchematicDashBoard.aspx" target="main">
                        Schematic</a></font></b>
                </td>
                <td width="10%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="custom/LojiAirGadek01.aspx" target="main">
                        Loji Air Gadek</a></font></b>
                </td>
                <td width="10%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="custom/LojiAirDaf01.aspx" target="main">
                        Loji Air Daf</a></font></b>
                </td>
                <td width="10%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="custom/systemchart/index.aspx" target="_blank"
                        onclick="popwin('custom/systemchart/index.aspx');return false;">System View</a></font></b>
                </td>
                <td width="10%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1">
                        <%--<a href="user.aspx" target="main">User Summary</a></font></b></td>--%>
                        <a href="MelakaSambSummary.aspx" target="main">Site Summary</a></font></b>
                </td>
                <td width="5%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="DisplayMap.aspx?Command=MAP&c=0" target="main">
                        GIS</a></font></b>
                </td>
                <td width="15%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="alarmselection.aspx" target="main">Alarm Notification</a></font></b>
                </td>
                <td width="5%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="GraphicalAnalysis.aspx" target="main">Analysis</a></font></b>
                </td>
                <td width="5%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="ReportsMenu.aspx" target="main">Report</a></font></b>
                </td>
                <td width="5%" bgcolor="#AAB9FD" height="20" align="center">
                    <b><font face="Verdana" size="1"><a href="login.aspx" target="_top">Logout</a></font></b>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
