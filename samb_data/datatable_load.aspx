<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%
if request.querystring("ekspot")="yes" then
%>
<!--#include file="save2excel.aspx"-->
<%
end if
%>
<!--#include file="report_head.aspx"-->
<%

dim objConn,strconn, strConn1
dim sqlRs,sqlRs1

dim table = "00"
dim start_date = "2007-08-21"
dim end_date
dim time ="00"
dim level_read, RF_read, cumRainfall, maya, tempoh
dim total_rainfall

dim i
dim dist as string
    strConn = ConfigurationSettings.AppSettings("DSNPG1")
    strConn1 = ConfigurationSettings.AppSettings("DSNPG2")
'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
objConn = new ADODB.Connection()
sqlRs = new ADODB.Recordset()
sqlRs1 = new ADODB.Recordset()
makeHTMLHeader_Open()
%>
<!--#include file="report_style.inc"-->
<%

makeHTMLHeader_Close()
response.write("<body>")

time=time & ":00:00"


dim k as integer=0


dim text,x
		
tempoh = 8

Dim districts="Batu Pahat,Johor Bahru,Kluang,Kota Tinggi,Mersing,Muar,Pontian,Segamat"
districts = Split(districts, ",")

For index As Integer = 0 To districts.Length()-1
'For index As Integer = 0 To 1

dist=districts(index)

response.write("<center><h1><b>SAJ INCOMING DATA REPORT</b></h1><b>District : <font color='blue' size=4>" & dist & "</font></b><br/>" & vbcrlf)
objConn.open(strConn)
		
dim text1 = "select distinct(sitetype) from telemetry_site_list_table where sitedistrict='" & dist & "'"
sqlRs1.Open(text1, objConn)
      
		
do while not sqlRs1.EOF
      
    response.write("<table class=" & chr(34) & "tbl_1" & chr(34) & " align=" & chr(34) & "center" & chr(34) & ">")
   
    dim strdate=start_date &" " & time
	strdate=String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strdate))
	end_date = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strdate).AddMinutes(-55))
        
   	''response.write("<tr><td class='tdo' colspan='3'>")
	''response.write("Date : " & Format_Full_Time(start_date,3) & "</td>")
	response.write("<td class='tdo'>")
	response.write("<b>Site Type : <font color='blue' size='2'>" & sqlRs1("sitetype").value & "</font></b></td></tr>")

	response.write("<tr><td class='tdc'><b>Site No</b></td><td class='tdc'><b>Site Name</b></td>")
	response.write("<td class='tdc'><b>" & String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(strdate)) & "</b></td>")
	response.write("<td class='tdc'><b> Latest Data </b></td></tr>")
    'response.write("<td class='tdc'><b> GPRS Data </b></td></tr>")

    text = "select siteid,sitename from telemetry_site_list_table where sitedistrict='" & dist & "' and sitetype='" & sqlRs1("sitetype").value & "'  order by siteid"
    sqlRs.Open(text, objConn)

	do until sqlRs.EOF
    	response.write("<tr><td class='tdc'>" & sqlRs("siteid").value & "</td><td class='tdc'>" & GetSiteName(strConn,sqlRs("siteid").value) & "</td>")
	    
        level_read = Get_readings_per_hour(strConn,sqlRs("siteid").value,2,String.Format("{0:yyyy-MM-dd HH:mm}",Date.Parse(strdate)),sqlRs1("sitetype").value)
		
		if Not level_read = "No" then
		    level_read = "Yes"
		end if
						
		response.write("<td class='tdc' align='center'>" & level_read & "</td>")
	
		dim clevel=Get_readings_latest(strConn,sqlRs("siteid").value,2)
		response.write("<td class='tdc' align='center'>" & clevel &"</td></tr>" & vbcrlf)
		dim unitid as string=get_unitid(strConn,sqlRs("siteid").value)
		'dim str as string=get_datastring(strConn1,unitid)
		'response.write("<td class='tdc' align='center'>" & str &"</td></tr>" & vbcrlf)
	    sqlRs.movenext()
	loop
	
    sqlRs.Close()

	response.write("</table><br/><br/>")
	sqlRs1.MoveNext()
loop
response.write("</center>")

objConn.close()

        Next

 
sqlRs = nothing
objConn = nothing         
    
%>
<!--#include file="report_foot.aspx"-->
