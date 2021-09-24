<%@ Page Language="VB" Debug="true"  %>
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
    Public StrDate, StrDate1, strSiteId, strBeginDate
    Dim equipname
    Dim position
    
   
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        
        'position = Request.Form("position")
       
        
        
        
        equipname = Request.Form("equipname")
        Dim strSelectedDistrict = Request.Form("ddDistrict")
        'Dim intSiteID1 = Request.Form("ddSite1")
        Dim intSiteID2 = Request.Form("ddSite2")
        Dim intSiteID1 = Request("ddSite1")

        '======================================
        Dim arrySiteID1 = Split(intSiteID1, ",")

        '======================================    
   
        If arrySiteID1(0) <> "0" Then
            strSiteId = arrySiteID1(0)
            position = arrySiteID1(1)
        End If
       
        
      
        ' Response.Write(position)
        Dim strBeginDate = Request.Form("txtBeginDate")
        Dim strBeginHour = Request.Form("ddBeginHour")
        Dim strBeginMin = Request.Form("ddBeginMinute")
   
        Dim strEndDate = Request.Form("txtEndDate")
        Dim strEndHour = Request.Form("ddEndHour")
        Dim strEndMin = Request.Form("ddEndMinute")
   
   
        Dim strBeginDateTime = Date.Parse(strBeginDate & " " & strBeginHour & ":" & strBeginMin)
        Dim strEndDateTime = Date.Parse(strEndDate & " " & strEndHour & ":" & strEndMin)
   
        Dim strLastDate = Request.Form("txtLastDate")
        Dim strLastDate1
       
        Dim lab = Request.QueryString("lab")
        Dim StrSiteName = Request.QueryString("sitename")
        strSiteId = Request.QueryString("siteid")
        position = Request.QueryString("position")
       
        StrDate = strBeginDateTime
        StrDate1 = strEndDateTime
        Dim z
        Dim dr1 As Data.Odbc.OdbcDataReader
        Dim con1 As New Data.Odbc.OdbcConnection(strConn)
        Dim str9 As String = "SELECT address from telemetry_site_list_table where (sitename='" & StrSiteName & "') "
      
        con1.Open()
        Dim cmd1 As New Data.Odbc.OdbcCommand(str9, con1)
        dr1 = cmd1.ExecuteReader()
        If dr1.Read() Then
            z = dr1(0)
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
        con1.Close()
        'Response.Write(position & "<br/> " & strSiteId & "<br/><br/><br/><br/><br/><br/><br/><br/><br/> " & strConn & "<br/> " & StrSiteName & "<br/><br/><br/> " & equipname)
    End Sub
       
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>DailyDetailsOne</title>
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
 
   
   <table border="0" cellspacing="0" cellpadding="0" style="position: absolute; font-family:Verdana; font-size:0.20in; width:90%; height:30%; color:white; font-weight:bolder ; left: 53px; top: 10px;">
        <tr>
      <td style=" font-size:0.20in; width: 30%; background-color:#aab9fd;"> 
         <p align="center">  
      <% 
          If equipname = "Flow Meter" Then%>
       f2 <%=equipname%>
          <%Else%>
    <%=equipname%> <%end if %>Trending </p></td></tr> 
        <tr>  <td style=" font-size:0.15in; width: 30%; background-color:#aab9fd;"> <p align="center"> &nbsp Site Name : <%=Request("sitename")%> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Site ID: <%=Request("siteid")%>&nbsp
        </p>
       </td>
    </tr> 
    <tr align="center">
      <td  style="width: 20%; font-size:0.10in; background-color:#aab9fd; height: 27px;">
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
        <a  href="javascript:history.back();" target="main">
        <img src="../images/back.jpg"   alt="" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none"/></a>
       <a  href="javascript:print();"  ><img src="../images/print.jpg" alt="" style="border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none"/></a>
       </td>
       </tr>
    </table>
    
    
     <%  If equipname = "Flow Meter" Or equipname = "Totalizer" Then
                    
             
             Dim con As New Data.Odbc.OdbcConnection(strConn)
             Dim dr As Data.Odbc.OdbcDataReader
             'Dim ds As Data.Odbc.OdbcDataAdapter
             ' Dim str As String = "SELECT sequence, value as minval FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and sequence between '" & StrDate & "' and '" & StrDate1 & "' and position='2' group by sequence,value order by sequence"
             Dim str As String = "SELECT sequence, value as minval FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and sequence between '" & StrDate & "' and '" & StrDate1 & "' and position='" & position & "' group by sequence,value order by sequence"
             ' "SELECT  distinct(to_char(sequence, 'HH24:mm:ss')) AS sequence, value as minval, value as minpressure, position as position1, position as position2 FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and to_char(sequence, 'yyyy/MM/dd') ='" & StrDate & "' and position='2' group by to_char(sequence, 'HH24:mm:ss'),value,position order by to_char(sequence, 'HH24:mm:ss') desc "
             con.Open()
             Dim cmd As New Data.Odbc.OdbcCommand(str, con)
             dr = cmd.ExecuteReader()
             If dr.Read = False Then
                      %>
                        <div align="center"  style="border: 1 solid; width: 400; height: 300;top:500;">
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                             <br/>
                              <br/>
                            <font style="font-family: Verdana; color: #3D62F8;top:500px;"><b>No Data To Be Displayed !</b></font>
                        </div>
                        <%
                        Else
                          %> 
                          <div>
                            <table id="Table2"  style="border: 1px; position:absolute; left: 259px; top: 150px; width: 220px;">
           <tr align="center" ><td style="font-weight: bold; height: 16px; width:150px">Time</td>
           <%If position = "2" Then%>
           <td align="center" style="font-weight: bold; width:100px">Flow (m3/h)</td>
              <% End If
              If position = "3" Then%>
                <td align="center" style="font-weight: bold; width:110px">Totalizer (m3)</td></tr>
               <%  
               End If
               While (dr.Read())
                   Response.Write("<tr><td align=center><font color='Black'>" & dr(0) & "</td>")
                   Response.Write("<td align=center><font color=Fuchsia>" & dr(1) & "  </font></td> </tr>")
               End While
                   
               con.Close()
           End If
       End If%>                                         
              </table>         
           </div>
    
    
    
       
     <input type="hidden" name="txtSubmit" value="" />

</body>
</html>
