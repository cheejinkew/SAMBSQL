<%@ Page Language="VB" Debug="true" %>
<% Response.ContentType = "text/xml" %>
<script language="VB" runat="server">
Function Get_Current_Value(strConn As String,strUser As String,nPos As Integer,decimal_points As Integer) As String
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select value from telemetry_equip_status_table where siteid='" & _
	        strUser & "' and position=" & nPos, nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("value").value) then
			Words = "-"
		else
			Words = math.round(RS("value").value,decimal_points)
		end if
   else
		Words = "-"
   end if
   
   Get_Current_Value = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Get_Current_Time(strConn As String,strUser As String,nPos As Integer,decimal_points As Integer) As String
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select dtimestamp from telemetry_equip_status_table where siteid='" & _
	        strUser & "' and position=" & nPos, nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("dtimestamp").value) then
			Words = "-"
		else
			'Words = Format_Full_Time(RS("dtimestamp").value,4)
			Words = RS("dtimestamp").value
		end if
   else
		Words = "-"
   end if
   
   Get_Current_Time = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function
	
Function Get_Status(strConn As String,strSite As String,nPos As Integer,nvalue As string) As String
	Dim nOConn
	Dim RS
	Dim Words,Status
	nOConn = new ADODB.Connection()
	RS = new ADODB.Recordset()   
	nOConn.open(strConn)
	Dim nColor = "000080"
	Dim nBottom,nTop,nStatus
	Dim value

	if not nvalue = "-" then
		value = Convert.ChangeType(trim(nvalue), GetType(double))
	   
		RS.open("select alarmtype,multiplier,colorcode from telemetry_rule_list_table where siteid='" & _
				strSite & "' and position=" & nPos & " order by sequence asc", nOConn)

		if not RS.eof then
			do while not RS.EOF
				if not IsDBNull(RS("multiplier").value) then
					Words = RS("multiplier").value
					Words = Split(Words, ";")
					if Words(0)="RANGE" then
						nBottom = Convert.ChangeType(Words(1), GetType(double))
						nTop = Convert.ChangeType(Words(2), GetType(double))
						if value >= nBottom and value <= nTop then
							nStatus = RS("alarmtype").value
							'nColor = RS("colorcode").value
							select case nStatus
								case "HH"
									nColor = "FF0000"
								case "H"
									nColor = "FF8C00"
								case "NN"
									nColor = "00BFFF"
								case "L"
									nColor = "D87093"
								case "LL"
									nColor = "CD853F"
							end select
						end if
					end if
				end if
				RS.MoveNext
			Loop
		end if

		
	RS.close		
	end if

	Get_Status = " status=" & chr(34) & nStatus  & chr(34) & " color=" & chr(34) & nColor & chr(34)

	nOConn.close
	RS = nothing
	nOConn = nothing
End Function

Function Format_Full_Time(str As String,options As Integer)
	select case options
		case 1
			Format_Full_Time = String.Format("{0:HH:mm}",Date.Parse(str))
		case 2
			Format_Full_Time = String.Format("{0:dd/MM/yyyy}",Date.Parse(str))
		case 3
			Format_Full_Time = String.Format("{0:dd/MM/yyyy HH:mm}",Date.Parse(str))
		case 4
			Format_Full_Time = String.Format("{0:dd/MM/yyyy}",Date.Parse(str))
		case else
			Format_Full_Time = String.Format("{0:dd/MM}",Date.Parse(str))
	end select
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
   	dim objConn   	
	dim rsSites
   	dim strConn
	dim str2parse,ntimestamp,nvalue,nstatus,nTime
	dim calculator = 0

	dim controldistrict = "Melaka Tengah,Jasin,Alor Gajah"
	
   	strConn = ConfigurationSettings.AppSettings("DSN=sambsql;UID=gussbee28;PWD=$mango#17;")
   	objConn =  new ADODB.Connection()
   	rsSites = new ADODB.Recordset()	
   	objConn.open(strConn)
	
	rsSites.Open("select siteid,sitetype,sitename,sitedistrict from telemetry_site_list_table where sitedistrict in ('" & controldistrict.replace(",","','") & "') order by siteid",objConn)
	if not rsSites.EOF then
		While (Not rsSites.EOF)
			calculator = calculator + 1
			nvalue = Get_Current_Value(strConn,rsSites("siteid").value,2,2)
			nstatus = Get_Status(strConn,rsSites("siteid").value,2,nvalue)
			nTime = Get_Current_Time(strConn,rsSites("siteid").value,2,2)
			str2parse = str2parse & "	<site id=" & chr(34) & rsSites("siteid").value & chr(34) & " district=" & chr(34) & rsSites("sitedistrict").value & chr(34) & " type=" & chr(34) & rsSites("sitetype").value & chr(34) & " value=" & chr(34) & nvalue & chr(34) & " timestamp=" & chr(34) & nTime & chr(34) & " " & nstatus & ">" & Server.HTMLEncode(rsSites("sitename").value) & "</site>" & vbcrlf
			rsSites.MoveNext()
		End While	
	end if
			
	response.write("<?xml version=" & chr(34) & "1.0" & chr(34) & " ?>" & vbcrlf & "<site_status recordcount=" & chr(34) & calculator & chr(34) & ">" & vbcrlf & str2parse & "</site_status>")


'objConn.close
'rsRecords = nothing
'objConn = nothing
%>