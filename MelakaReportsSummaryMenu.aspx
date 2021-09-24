<%@ Page Language="VB" AutoEventWireup="true" CodeFile="MelakaReportsSummaryMenu.aspx.vb"
    Inherits="MelakaReportsSummaryMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
    'StrSiteName = Request.QueryString("sitename")
    'Response.Write("From Reports Summary Source" & StrSiteName)
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reports Summary Menu</title>
<script type="text/javascript">
function gettip(txt)
{
document.getElementById('tip').innerHTML=txt;
}
function reset()
{
document.getElementById('tip').innerHTML="";
}

</script>

</head>
<body>
    <form id="form1" runat="server">
     <div align="center">
      <font face="Verdana"  size="2">&nbsp;<b>Report Menu</b><br /><u>Select Report Type</u></font>
       </div> 
              
              <table border="0" style="width: 220px; height: 130px; top:10px; color: white; font-family: Verdana; font-style: normal; background-image: none;" >
                  
                   &nbsp;
                   <tr><td style="background-color:#aab9fd; height: 20px;" >
                    <font face="Verdana" size="2" >&nbsp;&nbsp;
                        <a href="Melakasitereports1.aspx?root=dailySummary.aspx?&lab=Daily"  style="text-decoration: none;font-weight:bold; color:black">Daily Summary Reports</a></font>
                        </td>
                    </tr>
                    <tr>
                        <td  style="height:1px; background-color:#aab9fd" >&nbsp;
                            <font face="Verdana" size="2" > 
                            <a href="Melakasitereports1.aspx?root=WeeklySummary.aspx?&lab=Weekly" style="vertical-align: top; text-align: left; text-decoration: none; font-weight:bold; color:black " >Weekly Summary Reports</a></font></td>
                    </tr>
                    <tr>
                       <td  style="height:1px; background-color:#aab9fd"  >&nbsp;
                            <font face="Verdana" size="2"  style="vertical-align: top; text-align: left">
                            <a href="Melakasitereports1.aspx?root=MonthlySummary.aspx?&lab=Monthly" style="vertical-align: top; text-align: left; text-decoration: none;font-weight:bold; color:black">Monthly Summary Reports</a></font></td>
                    </tr>
                    <tr>
                        <td style="height:1px; background-color:#aab9fd"  >&nbsp;
                            <font face="Verdana" size="2"  style="vertical-align: top; text-align: left">
                            <a href="Melakasitereports1.aspx?root=AnnuallySummary.aspx?&lab=Annually" style="vertical-align: top; text-align: left; text-decoration: none;font-weight:bold; color:black">Annually Summary Reports</a></font></td>
                    </tr>
                   </table>
                    <br />
                    <br />
      
           <%-- <div border="0" style="width: 240px; height: 64px; left: 0px; position: absolute; top: 24px;">--%>
                    <br />
               
    </form>
</body>
</html>
<script type="text/javascript" language ="javascript" >
 function fr_change()
 {
 var strchange
 strchange="Melakasitereports1.aspx?&root=dailySummary.aspx?";
// strchange= strchange + "&lab=" + "daily";
 window.parent.frames[1].location=strchange; 
 }
 function fr_change1()
 {
 var strchange
 strchange="Melakasitereports1.aspx?&root=WeeklySummary.aspx?";
// strchange= strchange + "&lab=" + "Weekly";
 window.parent.frames[1].location=strchange; 
 }
 function fr_change2()
 {
 var strchange
 strchange="Melakasitereports1.aspx?&root=MonthlySummary.aspx?";
// strchange= strchange + "&lab=" + "Monthly";
 window.parent.frames[1].location=strchange; 
 }
 function fr_change3()
 {
 var strchange
 strchange="Melakasitereports1.aspx?&root=AnnuallySummary.aspx?";
// strchange= strchange + "&lab=" + "Annually";
 window.parent.frames[1].location=strchange; 
 }
</script>