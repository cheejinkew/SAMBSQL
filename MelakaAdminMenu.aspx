<%@ Page Language="VB" Debug="true" %>
<script language="javascript">

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    alert("Session Timeout !");
    top.location.href = "Melakalogin.aspx";
  }

</script>



<html>

<head>
<title>Gussmann Telemetry Management System</title>
<style>
 a {text-decoration: none;}
</style>
<base target="contents">
</head>

<body topmargin="0" leftmargin="0">
<form>
<div align="right">
  <table border="0" cellspacing="1" width="100%" cellpadding="3" height="62">
    <tr>
      <td width="242" rowspan="2" height="62" valign="middle"><img border="0" src="images/Logo_small.jpg" align="left" > </td>
      <td height="35" colspan="7" align="right">&nbsp;&nbsp;
      <font face="Verdana" size="1" color="#3366FF">
        <%
         dim strUsername
         
         strUsername = request.cookies("Telemetry")("UserName")
         response.write("<b>Hello " & strUsername & " !</b>")
         response.write("<br>")
         response.write(Now().ToString("yyyy/MM/dd hh:mm:ss tt"))
     
        %>
      
        </font>      
      </td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
       <a href="MelakaSiteSummary.aspx"  target="main" onclick="window.parent.loadleft();">Home</a></font></b></td>
<!--      <td width="10%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
       <a href="Summary.aspx"  target="main" onclick="javascript:loadleft();">Site Summary</a></font></b></td> -->
     
      <td width="13%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
      <a href="MelakaAdmin.aspx"  target="main">Admin Management</a></font></b></td>
     
      <td width="5%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
      <a href="DisplayMap.aspx?Command=MAP&c=1"  target="main">GIS</a></font></b></td>

      <td width="13%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
      <a href="Melakaalarmselection.aspx"  target="main">Alarm Notification</a></font></b></td>

      <td width="5%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
      <a href="MelakaGraphicalAnalysis.aspx"  target="main">Analysis</a></font></b></td>

      <td width="5%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
      <a href="MelakaReports.aspx"  target="main">Report</a></font></b></td>

      <td width="5%" bgcolor="#AAB9FD" height="20" align="center"><b><font face="Verdana" size="1">
      <a  onclick="formLogout()"  target="_top" style="cursor:pointer;">Logout</a></font></b></td>
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