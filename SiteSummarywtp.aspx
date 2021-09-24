<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim Tmconn = "DSN=TM;UID=tmp;PWD=tmp;"
    Dim district = Request("district")
    Dim sitetype = Request("Type")
    Dim strSiteName
    Dim siteid
    Dim sqlRs1
    Dim total = "Totalizer"
           %>
<!--#include file="report_head.aspx"-->
<html>
<body topmargin="0" leftmargin="0">
<style>
 a {text-decoration: none;} 

.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:right}
div#preload{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold}
div#trends {position:absolute;width:750px;height:440px;top:10px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
div#below {position:absolute;width:700px;height:100px;top:370px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
div#footnote{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#CBD6E4;font-weight:bold}
.td_label1{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:center}

.inputStyle
{
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  font-family: Verdana;
  font-size: 10pt;
  color: #3952F9;
  height: 20px
}
</style>
<title>Site Summary</title>
<div>
<br />
 <div align="center">
      <table border ="0"  cellpadding="0" cellspacing="0" width="50%">
        <tr>
          <td width="100%" height="30" colspan="4">
            <p align="center"><img border="0" src="images/SiteSummary.jpg">
         </td>
        </tr>
      </table>
    </div>
  <table width="240" border="0">
  
  <tr>
    <td class="td_label">District : </td>
    <td><input type="text" name="siteid" class="inputStyle" value="<%=district%>" readonly>
	<tr>
    <td class="td_label">SiteType : </td>
    <td><input type="text" name="position" class="inputStyle" value="<%=sitetype%>" readonly></td>
  </tr>
</table>
<br />
	  	<div style="padding-left:18">
	<table border= 1 align="center" style="border:solid 1 black;font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8;border:solid 1 black;color: #FFFFFF">
            <th style ="border:solid 1 black;" width = 160px>Site Name</th>
            <th style ="border:solid 1 black;" width = 160px>Type</th>
            <th style ="border:solid 1 black;" width = 160px>Time Stamp</th>
            <th style ="border:solid 1 black;" width = 160px>Value</th>
         </tr>
     <%
    Dim intNum = "0"
    Dim i = 2
    strConn = ConfigurationSettings.AppSettings("DSNPG")
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        sqlRs1 = New ADODB.Recordset()
    objConn.open(strConn)
    sqlRs.Open("SELECT sitename, siteid from telemetry_site_list_table where sitedistrict = '" & district & "' and sitetype = '" & sitetype & "' siteid NOT IN ("& strKontID &") order by sitename", objConn)
                                               
    Do While Not sqlRs.EOF
        strSiteName = sqlRs("sitename").value
        siteid = sqlRs("siteid").value
                           
             If intNum = "0" Then%>
                    <tr style ="border:solid 1 black;" bgcolor="#FFFFFF">
            <%  End If  
                If intNum = "1" Then%>
                    <tr style ="border:solid 1 black;" bgcolor="#E7E8F8">
               <% End If %>            
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a><%=strSiteName%></a></font></td>
					
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a>TREATED FLOW METER</a></font></td>
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><%=GetLastSequence(Tmconn, siteid, 2)%></font></td>
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a href="javascript:submit1('2','TREATED FLOW METER TRENDING')" title="Trending"><%=Get_Current_Value_Flow(Tmconn, siteid, 2, 2)%></a></font></td>
					
                    <tr style ="border:solid 1 black;"><td></td><td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue">CLEAR WATER TANK LEVEL</font></td>
				   <td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><%=GetLastSequence(Tmconn, siteid, 3)%></font></td>
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a href="javascript:submit1('3','CLEAR WATER TANK LEVEL')" title="Trending"><%=Get_Current_Value_Total(Tmconn, siteid, 3, 2)%></a></font></td>
		           </tr>
		           
		           <tr style ="border:solid 1 black;"><td></td><td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue">1.25MG RESERVOIR</font></td>
				   <td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><%=GetLastSequence(Tmconn, siteid, 4)%></font></td>
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a href="javascript:submit1('4','1.25MG RESERVOIR TRENDING')" title="Trending"><%=Get_Current_Value_Total(Tmconn, siteid, 4, 2)%></a></font></td>
		           </tr>
		           
		           <tr style ="border:solid 1 black;"><td></td><td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue">2.5MG RESEVOIR</font></td>
				   <td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><%=GetLastSequence(Tmconn, siteid, 5)%></font></td>
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a href="javascript:submit1('5','2.5MG RESEVOIR TRENDING')" title="Trending"><%=Get_Current_Value_Total(Tmconn, siteid, 5, 2)%></a></font></td>
		           </tr>
		           
		            <tr style ="border:solid 1 black;"><td></td><td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue">TREATED PH ANALYSER</font></td>
				   <td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><%=GetLastSequence(Tmconn, siteid, 6)%></font></td>
					<td class="td_label1" style="font-family: Verdana;" align="center"><font color="blue"><a href="javascript:submit1('6','TREATED PH ANALYSER TRENDING')" title="Trending"><%=Get_Current_Value_Total(Tmconn, siteid, 6, 2)%></a></font></td>
		           </tr>
						  
				    <%
				        If intNum = 1 Then
				            intNum = 0
				        Else
				            intNum = 1
				        End If
				        i = i + 1
				        sqlRs.movenext()
                Loop
               sqlRs.close() %>
     </table>
</div>
</div>
</body>
</html>

<script>
function submit1(pos,equip)
{

var url = "Trending.aspx?district=<%=district%>&siteid=<%=siteid%>&sitename=<%=strSiteName%>&position=" + pos + "&equipname=" + equip + "&sitetype=WTP";

top.main.location = url;

}
</script>