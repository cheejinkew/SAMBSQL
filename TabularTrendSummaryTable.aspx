<%@ Page Language="VB" Debug="true"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<style type="text/css">

div#tbl-container {
width: 100%;
height: 450px;
overflow:scroll;
scrollbar-color:#336699;
}

table {
table-layout:fixed;
border-collapse:collapse;
background-color: White;
}

div#tbl-container table th {
}

thead th, thead th.locked{
font-size: 14px;
font-weight: bold;
text-align: center;
color: white;
position:relative;
cursor: default; 
}
	
thead th {
top: expression(document.getElementById("tbl-container").scrollTop-2); /* IE5+ only */
z-index: 20;
}

thead th.locked {z-index: 30;
}

td.locked,  th.locked
{
background-color: White;
left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;
}

/*these styles have nothing to do with the locked column*/
body {
background-color: white;
color: black;
font-family: Verdana, Arial, Helvetica, sans-serif;
}

td 
{
padding: 1px 1px 1px 1px;
font-size: 11px;
border:1px solid #336699;
}

button {
width: 150px; 
font-weight: bold;
color: navy;
margin-bottom: 5px;
}

div.infobox {
position:absolute; 
top:110px; 
left:470px; 
right:5px; 
border: double 4px #6633ff;
padding:8px; 
font-size:12px; 
font-family:Arial, sans-serif; 
text-align:justify; 
text-justify:newspaper; 
background-color:white;
}

blockquote	{
font-family: Tahoma, Verdana, sans-serif;
font-size: 85%;
border: double 4px #6633ff;
padding: 8px 20px;
margin: 3% auto auto 0;
background-color: white;
width: 418px;
}

.sig	{
color:#6633ff;
font-style: italic;
letter-spacing: 2px;
}
</style>
<script runat="server">

	Public strConn = ConfigurationSettings.AppSettings("DSNPG")
	Public strConn1 = ConfigurationSettings.AppSettings("DSNPG1")
	Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
	Public StrDate, StrDate1, strSiteId, strBeginDate, strLastDate, strBeginDateTime, strEndDateTime
	Dim equipname
	Dim position
	Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

		position = Request.Form("position")
		equipname = Request.Form("equipname")
		Dim strSelectedDistrict = Request.Form("district")
		Dim intSiteID1 = Request.Form("ddSite1")
		Dim intSiteID2 = Request.Form("ddSite2")

		Dim strBeginDate = Request.Form("txtBeginDate")
		Dim strBeginHour = Request.Form("ddBeginHour")
		Dim strBeginMin = Request.Form("ddBeginMinute")

		'Dim strEndDate = Request.Form("txtEndDate1")
		Dim strEndDate = Request.Form("txtEndDate")
		Dim strEndHour = Request.Form("ddEndHour")
		Dim strEndMin = Request.Form("ddEndMinute")


		strBeginDateTime = Date.Parse(strBeginDate & " " & strBeginHour & ":" & strBeginMin)
		strEndDateTime = Date.Parse(strEndDate & " " & strEndHour & ":" & strEndMin)

		strLastDate = Request.Form("txtLastDate")
		Dim strLastDate1

		Dim lab = Request.QueryString("lab")
		Dim StrSiteName = Request.QueryString("sitename")
		strSiteId = Request.QueryString("siteid")

		StrDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strBeginDateTime))
		StrDate1 = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strEndDateTime))



		If strLastDate = "" Then
			strLastDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(strBeginDateTime))
		End If

		Dim z
		Dim dr1 As Data.Odbc.OdbcDataReader
		'Dim con1 As New Data.Odbc.OdbcConnection(strConn)
		Dim str9 As String = "SELECT address from telemetry_site_list_table where (sitename='" & StrSiteName & "') "

		Dim objConn
		strConn = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
		objConn = New SqlConnection(strConn)
		objConn.open()

		'Dim cmd1 As New Data.Odbc.OdbcCommand(str9, objConn)
		Dim cmd1 As New SqlCommand(str9, objConn)
		Dim reader As SqlDataReader = cmd1.ExecuteReader
		If reader.Read() Then
			z = reader(0)
			'If Not z = "" Then
			If IsDBNull(z) = False Then
				If z = "TM SERVER" Then
					strConn = strConn1
				Else
					strConn = strConn
				End If
			Else
				strConn = strConn
			End If
		End If
		'End If
		objConn.Close()
	End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>DailyDetailsSummaryTable</title>
    <script type="text/javascript" language="javascript">
    
  function submit()
  {
  document.form1.submit();  
  }
  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
  }
   </script>
    <style type="text/css" >
    .bodytxt 
  {
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  }
</style>
</head>
<body >
 <%--<a href="Trending.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&district=<%=request("dddistrict")%>&sitetype=<%=request("sitetype") %>&equipname=<%=equipname%>&position=<%=request("Position")%>" target="main">&nbsp;<img src="images/back.jpg" border="0" alt="" /></a>
<a href="javascript:print();">&nbsp;<img src="images/print.jpg" alt="" /></a>--%>

   
   <table border="0" cellspacing="0" cellpadding="0" style="position: absolute; font-family:Verdana; font-size:0.20in; width:90%; height:30%; color:white; font-weight:bolder ; left: 53px; top: 10px;">
        <tr>
      <td style=" font-size:0.20in; width: 30%; background-color:#aab9fd;"> 
         <p align="center">  
         <%=equipname%> For : <%=Request("sitename")%>    
        </p>
       </td>
    </tr> 
    <tr align="center">
      <td  style="width: 20%; font-size:0.15in; background-color:#aab9fd">
        <p align="center">
          Day from <%=StrDate%> to <%=StrDate1%>  
        </p></td>
       </tr> 
       <tr  >
         <td  style="border-top-style: none; height:20px;  border-right-style: none; border-left-style: none; border-bottom-style: none" >
       </td>
       </tr>
        
      <tr>
       <td align="center" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none"   >
        <a  href="Trending.aspx?siteid=<%=request("siteid")%>&sitename=<%=request("sitename")%>&district=<%=request("district")%>&sitetype=<%=request("sitetype") %>&equipname=<%=equipname%>&position=<%=request("Position")%>" target="main">
        <img src="images/back.jpg"   alt="" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none"/></a>
       <a  href="javascript:print();"  ><img src="images/print.jpg" alt="" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none"/></a>
       </td>
       </tr>
    </table>
  
       

   <%  If equipname = "Water Level Trending" Then%>
           <div >
           <table id="tbl" style="border: 1px; position:relative; left: 45px; top: 220px; width: 242px;">
           <tr align="center" >
			   <td style="font-weight: bold;width:131px; height: 17px;">No.Item</td>
			   <td style="font-weight: bold;width:151px; height: 17px;">Date & Time</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Average Level</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Max Level</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Min Level</td>
			   <td style="font-weight: bold; height: 17px; width: 91px;">Median Level</td>
           </tr>
               <%
				   'Dim con As New Data.Odbc.OdbcConnection(strConn)
				   'Dim dr As Data.Odbc.OdbcDataReader

				   strConn = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
				   Dim objConn = New SqlConnection(strConn)
				   Dim number As Integer = 1

				   Do While strLastDate <= String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(strEndDateTime))
					   'Dim ds As Data.Odbc.OdbcDataAdapter
					   'Dim str1 As String = "SELECT dtimestamp,value FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & strLastDate & ":00' and '" & strLastDate & ":59' and position='" & position & " ' group by dtimestamp,value order by dtimestamp"
					   Dim str2 As String = "Select CAST(AVG(value) AS DECIMAL(10,2)) AS 'Average Level',max(value) As 'Max Level',min(value) As 'Min Level', ( SELECT((SELECT MAX(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & strSiteId & "' And position in ('" & position & "', '0') and dtimestamp between '" & strLastDate & " 00:00:00' and '" & strLastDate & " 23:59:59' ORDER by value )AS BottomHalf)+(SELECT MIN(value) FROM(SELECT TOP 50 PERCENT value,dtimestamp FROM telemetry_log_table where siteid='" & strSiteId & "' And position in ('" & position & "', '0') and dtimestamp between '" & strLastDate & " 00:00:00' and '" & strLastDate & " 23:59:59' ORDER by value DESC) AS TopHalf)) / 2 )AS 'Median Level' From telemetry_log_table Where siteid ='" & strSiteId & "' And position In ('" & position & "', '0') and dtimestamp between '" & strLastDate & " 00:00:00' and '" & strLastDate & " 23:59:59' "
					   objConn.Open()
					   'Dim cmd As New Data.Odbc.OdbcCommand(str, objConn)
					   'dr = cmd.ExecuteReader()
					   'While (dr.Read())
					   Dim cmd1 As New SqlCommand(str2, objConn)
					   Dim reader As SqlDataReader = cmd1.ExecuteReader
					   While (reader.Read())
						   Response.Write("<tr><td align=center><font color='Black'>" & number & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & strLastDate & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & reader(0) & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & reader(1) & "</td>")
						   Response.Write("<td align=center><font color='Black'>" & reader(2) & "</td>")
						   Response.Write("<td align=center><font color=Black>" & reader(3) & "</font></td> </tr>")
					   End While
					   objConn.Close()

					   strLastDate = String.Format("{0:yyyy/MM/dd}", Date.Parse(strLastDate).AddDays(1))
					   number = number + 1
				   Loop
           %>                                
          </table> 
           </div>
    <%end if %>
    
    
     <%  If equipname = "Pressure" Then%>
           <div>
           <table id="Table1"  style="border: 1px; position:absolute; left: 256px; top: 108px; width: 216px;">
           <tr align="center" ><td style="font-weight: bold; height: 29px; width:82px">Time</td>
           <td style="font-weight: bold; width:60px; height: 29px;">Pressure(bar)</td></tr>
               <%
               Dim con As New Data.Odbc.OdbcConnection(strConn)
               Dim dr As Data.Odbc.OdbcDataReader
               'Dim ds As Data.Odbc.OdbcDataAdapter
                   Dim str As String = "SELECT dtimestamp, value as minpressure FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='1' group by dtimestamp,value order by dtimestamp"
               ' "SELECT  distinct(to_char(dtimestamp, 'HH24:mm:ss')) AS dtimestamp, value as minval, value as minpressure, position as position1, position as position2 FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and to_char(dtimestamp, 'yyyy/MM/dd') ='" & StrDate & "' and position='2' group by to_char(dtimestamp, 'HH24:mm:ss'),value,position order by to_char(dtimestamp, 'HH24:mm:ss') desc "
               con.Open()
               Dim cmd As New Data.Odbc.OdbcCommand(str, con)
               dr = cmd.ExecuteReader()
               While (dr.Read())
                       Response.Write("<tr><td align=center><font color='Black'>" & dr(0) & "</td>")
                       Response.Write("<td align=center><font color=Fuchsia>" & dr(1) & " </font></td> </tr>")
                   End While
                   con.Close()
           %>                                
            </table>  
           </div>
    <%end if %>
    
    
     <%  If equipname = "Flowmeter" Then%>
           <div>
           <table id="Table2"  style="border: 1px; position:absolute; left: 259px; top: 115px; width: 200px;">
           <tr align="center" ><td style="font-weight: bold; height: 16px; width:77px">Time</td>
           <td align="center" style="font-weight: bold; width:60px">Flow(m3/h)</td></tr>
               <%
               Dim con As New Data.Odbc.OdbcConnection(strConn)
               Dim dr As Data.Odbc.OdbcDataReader
               'Dim ds As Data.Odbc.OdbcDataAdapter
                   Dim str As String = "SELECT dtimestamp, value as minval FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='1' group by dtimestamp,value order by dtimestamp"
                   ' "SELECT  distinct(to_char(dtimestamp, 'HH24:mm:ss')) AS dtimestamp, value as minval, value as minpressure, position as position1, position as position2 FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and to_char(dtimestamp, 'yyyy/MM/dd') ='" & StrDate & "' and position='2' group by to_char(dtimestamp, 'HH24:mm:ss'),value,position order by to_char(dtimestamp, 'HH24:mm:ss') desc "
               con.Open()
               Dim cmd As New Data.Odbc.OdbcCommand(str, con)
               dr = cmd.ExecuteReader()
               While (dr.Read())
                       Response.Write("<tr><td align=center><font color='Black'>" & dr(0) & "</td>")
                       Response.Write("<td align=center><font color=Fuchsia>" & dr(1) & " m </font></td> </tr>")
                   End While
                   con.Close()
           %>                                         
              </table>         
           </div>
    <%end if %>
    
    
         <%--<div>
           <table id="tbl"  style="border: 1px; position:absolute; left: 8px; top: 100px;">
           <tr align="center" ><td style="font-weight: bold; height: 16px; width:60px">Time</td>
           <%
               Dim con As New Data.Odbc.OdbcConnection(strConn)
               Dim dr As Data.Odbc.OdbcDataReader
               'Dim ds As Data.Odbc.OdbcDataAdapter
               Dim str As String = "SELECT dtimestamp,value,value as minpressure FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='2' group by dtimestamp,value order by dtimestamp"
               ' "SELECT  distinct(to_char(dtimestamp, 'HH24:mm:ss')) AS dtimestamp, value as minval, value as minpressure, position as position1, position as position2 FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and to_char(dtimestamp, 'yyyy/MM/dd') ='" & StrDate & "' and position='2' group by to_char(dtimestamp, 'HH24:mm:ss'),value,position order by to_char(dtimestamp, 'HH24:mm:ss') desc "
               con.Open()
               Dim cmd As New Data.Odbc.OdbcCommand(str, con)
               dr = cmd.ExecuteReader()
               While (dr.Read())
                   Response.Write("<td style=width:60px;font-weight: bold>" & dr(0) & "</td>")
               End While
               con.Close()
           %>
           </tr>           
            <% If equipname = "Water Level Trending" Then%>       
           <tr align="center" ><td style="font-weight: bold; width:60px">Level</td>           
           <% end if %>           
           <%  con.Open()      
               dr = cmd.ExecuteReader()
               While (dr.Read())
                     If equipname = "Water Level Trending" Then  
                   Response.Write("<td style=width:60px><font color='Fuchsia'>" & dr(1) & " m </font></td>")
                   end if 
               End While
               con.Close()
            %></tr>
            <% If equipname = "Pressure" Then%>            
           <tr align="center" ><td style="font-weight: bold; width:60px">Pressure(bar)</td>
           <% end if %>            
           <%  Dim aaa = "-"
               str = "SELECT dtimestamp, value as minval, value as minpressure FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='1' group by dtimestamp,value order by dtimestamp"
               con.Open()
               cmd = New Data.Odbc.OdbcCommand(str, con)
               dr = cmd.ExecuteReader()
               While (dr.Read())
                   If equipname = "Pressure" Then
                       Response.Write("<td style=width:60px><font color='Fuchsia'>" & dr(2) & "</font></td>")
                   End If
               End While
               If dr.HasRows = False Then
                   If equipname = "Pressure" Then
                       Response.Write("<td style=width:60px><font color='Fuchsia'>" & aaa & "</font></td>")
                   End If
               End If
               con.Close()
           %>                   
          <% If equipname = "Flowmeter" Then%>            
           <tr align="center" ><td style="font-weight: bold; width:60px">Flow(m3/h)</td>
           <%
               Dim aaaa = "-"
               str = "SELECT dtimestamp, value as minval, value as minpressure FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and dtimestamp between '" & StrDate & "' and '" & StrDate1 & "' and position='1' group by dtimestamp,value order by dtimestamp"
               con.Open()
               cmd = New Data.Odbc.OdbcCommand(str, con)
               dr = cmd.ExecuteReader()
               While (dr.Read())
                   If equipname = "Pressure" Then
                       Response.Write("<td style=width:60px><font color='Fuchsia'>" & dr(1) & "</font></td>")
                   End If
               End While
               If dr.HasRows = False Then
                   If equipname = "Pressure" Then
                       Response.Write("<td style=width:60px><font color='Fuchsia'>" & aaaa & "</font></td>")
                   End If
               End If
               con.Close()
           %>                      
          <% end if %>--%>           
    <%-- <div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
     </div>--%>
     <input type="hidden" name="txtSubmit" value="" />

</body>
</html>
