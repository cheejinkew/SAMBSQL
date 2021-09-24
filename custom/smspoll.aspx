<%@ Page Language="VB" Debug="true" %>
<script language="VB" runat="server">
Function GetSIM(strConn As String,SiteID As String) As String   
    Dim nOConn
    Dim RS
    nOConn = new ADODB.Connection()
    RS = new ADODB.Recordset()   
    nOConn.open(strConn)
	Dim unit_id

	RS.Open("select unitid from telemetry_equip_list_table where siteid='" & SiteID & "' order by position limit 1",nOConn)
	
	if RS.EOF then
		unit_id = ""
	else
		unit_id = RS("unitid").value
	end if
	
	RS.close	

	RS.Open("select simno from unit_list where unitid='" & unit_id & "' limit 1",nOConn)
		
	if RS.EOF then
		GetSIM = "+60133833550"
	else
		GetSIM = RS("simno").value
	end if	
		
	RS.close
	RS = nothing
   
End Function
Function GetAssociate(strConn As String,strSite As String) As String
   Dim nOConn
   Dim RS   
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select Associate from telemetry_site_list_table where siteid='" & strSite & "'",nOConn)   	   			
   			if not RS.EOF then					
				GetAssociate = RS("Associate").value
			else
				GetAssociate = ""
			end if

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing	
   
End Function
Function Polling(strConn As String,commStr As String,destination_num As String,startdate As String,enddate As String)' As String
    Dim nOConn
    Dim RS
    Dim sqlSp
    nOConn = new ADODB.Connection() 
    nOConn.open(strConn)
	
	sqlSp = "insert into sms_outbox_table (destination,startdate,enddate,priority,message,network,assign,insertdate,kn_source_id)" & _
			" values ('" & destination_num & "','" & startdate & "','" & enddate & "',0,'" & commStr & "','None','FALSE','" & startdate & "',0)"
	
	nOConn.Execute (sqlSp)
	nOConn.close	
	nOConn = nothing	
End Function
Function Format_Time_Parse(str As String,options As Integer)
	select case options
		case 1
			Format_Time_Parse = String.Format("{0:HH:mm}",Date.Parse(str))
		case 2
			Format_Time_Parse = String.Format("{0:yyyy/MM/dd}",Date.Parse(str))
		case else
			Format_Time_Parse = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(str))
	end select
End Function
</script>
<%
dim SiteID1 = trim(request.querystring("siteid"))
	
	dim strConn,fstrConn
	dim startdate = now().ToString ( "yyyy-MM-dd HH:mm:ss" )
	dim enddate = DateAdd(DateInterval.Day, 1, startdate).ToString ( "yyyy-MM-dd HH:mm:ss" )
	dim commStr = ""
	
	strConn = ConfigurationSettings.AppSettings("DSNPG")
	
	'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
	'fstrConn = "DSN=avls_telemetry;UID=tmp;PWD=tmp;"
	'fstrConn = "DSN=g1;UID=tmp;PWD=tmp;"

select case request.querystring("c")
case "poll"	

	Dim destination_num = GetSIM(strConn,SiteID1)
	commStr = "(CGUS;20)"
	'commStr = "TEST:[" & SiteID1 & "] " & destination_num

    call Polling(strConn,commStr,destination_num,startdate,enddate)
	
	response.write("Done")
case else
	response.write("Aborted")
end select
%>