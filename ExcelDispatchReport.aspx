<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB"%>
<%@ Import Namespace="System.IO" %>
<!--#include file="kont_id.aspx"-->
<%   
  dim objConn
  dim sqlRs 
  dim sqlRs1 
  dim sqlRs2 
dim sqlRs3
  dim strConn
  dim sbrHTML as StringBuilder
  dim swXLS as StreamWriter
 
  dim strSite

  dim strAlert
  dim strBeginHour
  dim strBeginMin
  dim strBeginDateTime
  dim strEndDate 
  dim strEndHour
  dim strEndMin
  dim strEndDateTime
  dim intCount = 5
  dim j =0
  
   
    dim strSelectedDistrict = request.querystring("strSelectedDistrict")
dim strBeginDate = request.querystring("strBeginDate")
   
   dim strBeginHour1= "06"
   dim strBeginMin1 = "59"
   dim strEndHour1 = "07"
   dim strEndMin1 = "03"



   dim strBeginHour2= "14"
   dim strBeginMin2 = "59"
   dim strEndHour2 = "15"
   dim strEndMin2 = "03"


    Dim strBeginHour3 = "17"
   dim strBeginMin3 = "59"
    Dim strEndHour3 = "19"
   dim strEndMin3 = "03"


   dim strBeginDateTime1 = strBeginDate & " " & strBeginHour1 & ":" & strBeginMin1 & ":00"   
   dim strEndDateTime1 = strBeginDate & " " & strEndHour1 & ":" & strEndMin1 & ":59"

   dim strBeginDateTime2 = strBeginDate & " " & strBeginHour2 & ":" & strBeginMin2 & ":00"   
   dim strEndDateTime2 = strBeginDate & " " & strEndHour2 & ":" & strEndMin2 & ":59"  

   dim strBeginDateTime3 = strBeginDate & " " & strBeginHour3 & ":" & strBeginMin3 & ":00"   
   dim strEndDateTime3 = strBeginDate & " " & strEndHour3 & ":" & strEndMin3 & ":59" 
   strConn = ConfigurationSettings.AppSettings("DSNPG")

    objConn = new ADODB.Connection()
    sqlRs = new ADODB.Recordset()
    sqlRs1 = new ADODB.Recordset()
    sqlRs2 = new ADODB.Recordset()

    objConn.Open(strConn)

       dim intNum = 0
       dim strEquip
       dim intValue
	dim intValue1
	dim intValue2
       dim strAlarmType
       dim strSiteName
        
       objConn = new ADODB.Connection()
       sqlRs = new ADODB.Recordset()
       sqlRs1 = new ADODB.Recordset()
       sqlRs2 = new ADODB.Recordset()
       sqlRs3 = new ADODB.Recordset()
       objConn.open(strConn)

    sbrHTML = new StringBuilder()
  sbrHTML.Append("<TABLE Border=1>")

       sbrHTML.Append("<TABLE Border=1>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & "><Font Size=5><center>Dispatch Report</center></Font></TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'><b>District :</b> " & strSelectedDistrict & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'> <b>Report Date :</b> " & strBeginDate & "</TD><TR>")
     sbrHTML.Append("<TR><TD ColSpan=" & intCount & " align='left'>&nbsp;</TD><TR>")
     sbrHTML.Append("<TR><TH style='background-color: #465AE8; color: #FFFFFF'>Site Name</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>7 a.m</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>3 p.m</TH>")
     sbrHTML.Append("  <TH style='background-color: #465AE8; color: #FFFFFF'>9 p.m</TH>")


'sqlRs.Open("select distinct sitename  from telemetry_dispatch_history_table", objConn) 



	sqlRs.Open("SELECT distinct sitename from telemetry_site_list_table where sitedistrict='" & strSelectedDistrict & "' and siteid NOT IN ("& strKontID &") order by sitename", objConn) 

       do while not sqlRs.EOF
		strSiteName = sqlRs("sitename").value
		sqlRs3.Open("select  max(value) AS v  from telemetry_dispatch_history_table where sequence between ('" & StrBeginDateTime1 & "') and ('" & strEndDateTime1 & "') and sitename='" & strSiteName & "' ", objConn)
		sqlRs1.Open("select  max(value) AS v1 from telemetry_dispatch_history_table where sequence between ('" & StrBeginDateTime2 & "') and ('" & strEndDateTime2 & "') and sitename='" & strSiteName & "' ", objConn)
		sqlRs2.Open("select  max(value) AS v2 from telemetry_dispatch_history_table where sequence between ('" & StrBeginDateTime2 & "') and ('" & strEndDateTime2 & "') and sitename='" & strSiteName & "' ", objConn)


	'intValue = sqlRs3("v").value & "m"
	'intValue1 = sqlRs1("v1").value & "m"
	'intValue2 = sqlRs2("v2").value & "m"


    
           if  iSdbnULL(sqlRs3("v").value) THEN

		intValue = "-"

	    	ELSE

  		intValue = sqlRs3("v").value & "m"
		 
	     END IF

 	   if  iSdbnULL(sqlRs1("v1").value) THEN

		intValue1 ="-"
	   	ELSE
 
	   	IntValue1 = sqlRs1("v1").value & "m"
	  
           END IF


 	if  iSdbnULL(sqlRs2("v2").value) THEN

		intValue2= "-"

		ELSE

	   	intValue2 = sqlRs2("v2").value & "m"
	 END IF


 	 sbrHTML.Append("<TR><TD align='left'>" & strSiteName & "</TD><TD TD align='center'>" & _
		      intValue & "</TD><TD align='center'>" & _
		      intValue1 & "</TD><TD align='center'>" & _
		      intValue2 & "</TD><TD></TR>")



         'sbrHTML.Append("<TR><TD align='left'>" & sqlRs1(0).value & "</TD><TD>" & sqlRs2(0).value & "</TD></TR>")
	       
	sqlRs1.close()
	sqlRs2.close()
	sqlRs3.close()

        sqlRs.movenext()

       loop
	sqlRs.close()
       'end if
       objConn.close()
       sqlRs = nothing
       objConn = nothing
  
	sbrHTML.Append("<TR> <td></td></TR>") 
     
     sbrHTML.Append("</TABLE>")
        
     Response.Buffer =true
     Response.ContentType = "application/vnd.ms-excel"
     Response.AddHeader("Content-Disposition", "attachment; filename=DispatchHistoryReport.xls;")
    
     Response.Write(sbrHTML.ToString) 

%>

