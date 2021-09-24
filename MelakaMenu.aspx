<%@ Page Language="VB" Debug="true" %>

<script language="javascript">

var strSession = '<%=session("login")%>';
if (strSession != "true")
{
     
    alert("Session Timeout !");
    top.location.href = "Melakalogin.aspx";
}  

</script>

<%  
    If Session("login") <> True Then
        Dim strUser
        strUser = Request.Cookies("Telemetry")("UserName")
        Dim counterid As String
        counterid = strUser.ToString()
        Session("CounterTemp_" & counterid) = False
    End If
%>
<html>
<head>
    <title>Gussmann Telemetry Management System</title>
    <style>
 a {text-decoration: none;}
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
                    <td height="35" colspan="7" align="right">
                        &nbsp;&nbsp; <font face="Verdana" size="1" color="#3366FF">
                            <%
                                Dim strUsername
         
                                strUsername = Request.Cookies("Telemetry")("UserName")
                                Response.Write("<b>Hello " & strUsername & " !</b>")
                                Response.Write("<br>")
                                Response.Write(Now().ToString("yyyy/MM/dd hh:mm:ss tt"))
     
                            %>
                        </font>
                        <!-- <a href="http://xyz.freeweblogger.com/stats/b/bendahari/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=bendahari&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=bendahari></script> -->
                        <!--<%--<% Select Case strUsername
	case "SATU"
%><a href="http://xyz.freeweblogger.com/stats/1/1181639850/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1181639850&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1181639850></script><%
	case "BST07"
%><a href="http://xyz.freeweblogger.com/stats/1/1182397384/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1182397384&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1182397384></script><%
	case "DGN07"
%><a href="http://xyz.freeweblogger.com/stats/1/1182397518/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1182397518&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1182397518></script><%
	case "HT07"
%><a href="http://xyz.freeweblogger.com/stats/1/1182397700/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1182397700&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1182397700></script><%
	case "KMN07"
%><a href="http://xyz.freeweblogger.com/stats/1/1182397775/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1182397775&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1182397775></script><%
	case "KT07"
%><a href="http://xyz.freeweblogger.com/stats/1/1182397846/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1182397846&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1182397846></script><%
	case "STU07"
%><a href="http://xyz.freeweblogger.com/stats/1/1182397909/" target="_top"><img border="0" alt="free web counter" src="http://xyz.freeweblogger.com/counter/index.php?u=1182397909&s=amini" ALIGN="middle" HSPACE="4" VSPACE="2"></a><script src=http://xyz.freeweblogger.com/counter/script.php?u=1182397909></script><%
	case else
End Select %>--%>-->
                    </td>
                </tr>
                <tr>
                    <td width="10%" bgcolor="#AAB9FD" align="center" style="height: 20px">
                        <b><font face="Verdana" size="1">
                            <!--      <a href="Summary.aspx"  target="main" onclick="javascript:loadleft();">Site Summary</a></font></b></td> -->
                            <a href="MelakaSiteSummary.aspx" target="main" onclick="window.parent.loadleft();">Home</a></font></b></td>
                    <td width="5%" bgcolor="#AAB9FD" align="center" style="height: 20px">
                        <b><font face="Verdana" size="1"><a href="MelakaDisplayMap.aspx?Command=MAP&c=0" target="main">
                            GIS</a></font></b></td>
                    <td width="15%" bgcolor="#AAB9FD" align="center" style="height: 20px">
                        <b><font face="Verdana" size="1"><a href="Melakaalarmselection.aspx" target="main">Alarm
                            Notification</a></font></b></td>
                    <td width="5%" bgcolor="#AAB9FD" align="center" style="height: 20px">
                        <b><font face="Verdana" size="1"><a href="MelakaGraphicalAnalysis.aspx" target="main">
                            Analysis</a></font></b></td>
                    <td width="5%" bgcolor="#AAB9FD" align="center" style="height: 20px">
                        <b><font face="Verdana" size="1"><a href="MelakaReports.aspx" target="main">Report</a></font></b></td>
                    <td width="5%" bgcolor="#AAB9FD" align="center" style="height: 20px">
                        <b><font face="Verdana" size="1"><a onclick="formLogout()" target="_top" style="cursor: pointer;">
                            Logout</a></font></b></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

<script language="javascript">
function formLogout(){
window.parent.location="Melakalogin.aspx";
}
</script>

