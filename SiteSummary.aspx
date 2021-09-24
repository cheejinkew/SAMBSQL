<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%      
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim district = Request("district")
    Dim sitetype = Request("Type")
    'Dim division = Request("division")
    Dim strSiteName
    Dim siteid
    Dim sqlRs1
    
%>
<!--#include file="report_head.aspx"-->
<html>
<body>
    <style>

.bodytxt 
   {
   font-weight: normal;
   font-size: 11px;
   color: #333333;
   line-height: normal;
   font-family: Verdana, Arial, Helvetica, sans-serif;
   }

 a {text-decoration: none;} 

.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:right}
div#preload{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#5F7AFC;font-weight:bold}
div#trends {position:absolute;width:750px;height:440px;top:10px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
div#below {position:absolute;width:700px;height:100px;top:370px;left:250px;background-color:white;z-index:1;border-width:1px;border-style:solid;border-color:#5F7AFC;text-align:center}
div#footnote{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:10px;color:#CBD6E4;font-weight:bold}
.td_label1{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:center}
.td_label2{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:11px;color:#5F7AFC;font-weight:bold;text-align:left}

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
    <div>
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="70%">
                <tr>
                    <td width="100%" height="30" colspan="4">
                        <p align="center">
                            <img border="0" src="images/SiteSummary.jpg">
                    </td>
                </tr>
            </table>
        </div>
        <table width="240" border="0">
            <tr>
                <td class="td_label">
                    District :
                </td>
                <td>
                    <input type="text" name="siteid" class="inputStyle" value="<%=district%>" readonly>
                <tr>
                    <td class="td_label">
                        SiteType :
                    </td>
                    <td>
                        <input type="text" name="position" class="inputStyle" value="<%=sitetype%>" readonly></td>
                </tr>
        </table>
        <table border="1" align="center" style="font-family: Verdana; font-size: 8pt">
            <tr style="background-color: #465AE8; color: #FFFFFF">
                <th width="50px">
                    Sl No</th>
                <th width="160px">
                    Site Name</th>
                <th width="160px">
                    Time Stamp</th>
                <th width="160px">
                    Last Value (m)</th>
            </tr>
            <%
                Dim intNum = "0"
                Dim i = 1
                strConn = ConfigurationSettings.AppSettings("DSNPG")
                Dim strConn1 = ConfigurationSettings.AppSettings("DSNPG1")
                objConn = New ADODB.Connection()
                sqlRs = New ADODB.Recordset()
                sqlRs1 = New ADODB.Recordset()
                objConn.open(strConn)
                Dim position = 2
                Dim ok = False
                Dim aa = "SELECT sitename, siteid from telemetry_site_list_table where sitedistrict = '" & district & "' and sitetype = '" & sitetype & "' and siteid NOT IN ("& strKontID &") order by sitename"
                sqlRs.Open("SELECT sitename, siteid,sitetype from telemetry_site_list_table where sitedistrict = '" & district & "' and sitetype = '" & sitetype & "' and siteid NOT IN ("& strKontID &") order by sitename", objConn)
                                               
                Do While Not sqlRs.EOF
                                                    
                    strSiteName = sqlRs("sitename").value
                    siteid = sqlRs("siteid").value
                    sitetype = sqlRs("sitetype").value
                    
                    If intNum = "0" Then%>
            <tr bgcolor="#FFFFFF">
                <%  End If
                    If intNum = "1" Then%>
                <tr bgcolor="#E7E8F8">
                    <%End If%>
                    <td class="td_label2" align="center">
                        <font color="blue">
                            <%=i%>
                        </font>
                    </td>
                    <td class="td_label2" align="left">
                        <font color="blue">
                            <%=strSiteName%>
                        </font>
                    </td>
                    <td class="td_label1" align="center">
                        <font color="blue">
                            <%=Get_Current_sequence_summary(strConn, siteid, 2, 2)%>
                        </font>
                    </td>
                    
                    <td class="td_label1" align="center">
                        <font color="blue"><a href="javascript:submit1('2','Water Level Trending','<%=siteid%>','<%=strSiteName%>','<%=sitetype%>','<%=district%>')" title="Trending">
                            <%=Get_Current_Value_summary(strConn, siteid, 2, 2)%>
                        </a></font>
                    </td>
                    
                    
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
            sqlRs.close()%>
        </table>
    </div>
</body>
</html>

<script>
function submit1(pos,equip,siteid,sitename,sitetype,district)
{
if(sitetype=="RESERVOIR")
{
var url = "Trending.aspx?district=<%=district%>&siteid=" + siteid + "&sitename=" + sitename + "&position=" + pos + "&equipname=" + equip + "&sitetype=RESERVOIR";
}
if(sitetype=="DAM")
{
var url = "custom/Trending.aspx?district=" + district + "&siteid=" +siteid + "&sitename=" + sitename + "&position=" + pos + "&equipname=Level 1&sitetype=DAM";
}
top.main.location = url;

}
</script>

