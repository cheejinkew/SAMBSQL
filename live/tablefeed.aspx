<%@ Page Language="VB" Debug="true" %>
<script language="VB" runat="server">
Function Get_LastNite_Value(strConn As String,strSite As String,nPos As Integer,decimal_points As Integer,period As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   Dim Time_s
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
  dim today
   
  select case period
		case 1
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddHours(-1))
			today = String.Format("{0:yyyy/MM/dd}",Date.Parse(today) & " 23:45:00")
		case 2
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddDays(-1) & " 07:45:00")
		case 3
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddDays(-1) & " 15:45:00")
   end select
   
   RS.open("select value from telemetry_log_table where siteid='" & _
	        strSite & "' and position=" & nPos & " and sequence ='" & today & "' order by sequence desc limit 1", nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("value").value) then
			Words = 0 ' Put ZERO for compatibilities
		else
			Words = math.round(RS("value").value,decimal_points)
		end if
   else
		Words = 0
   end if
   
   Get_LastNite_Value = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing   
End Function

Function Get_LastNite_Timestamp(strConn As String,strSite As String,nPos As Integer,period As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
'			Dim today As DateTime =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddHours(-1))
  dim today
   
  select case period
		case 1
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddHours(-1))
			today = String.Format("{0:yyyy/MM/dd}",Date.Parse(today) & " 23:45:00")
		case 2
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddDays(-1) & " 07:45:00")
		case 3
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddDays(-1) & " 15:45:00")
   end select
	        
   RS.open("select sequence from telemetry_log_table where siteid='" & _
	        strSite & "' and sequence ='" & today & "' order by sequence desc limit 1", nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("sequence").value) then
			Words = "#"
		else			
			'Words = String.Format("{0:dd/MM/yyyy HH:mm}",Date.Parse(RS("sequence").value))
			'Words = String.Format("{0:dd/MM/yyyy}",Date.Parse(RS("sequence").value)) & " " & Format(Date.Parse(RS("sequence").value),"Medium Time")
			'Words = Format(Date.Parse(RS("sequence").value),"dd/MM/yyyy") & " " & Format(Date.Parse(RS("sequence").value),"Medium Time")
			Words = Format(Date.Parse(RS("sequence").value),"MM/dd/yyyy") & " " & Format(Date.Parse(RS("sequence").value),"Medium Time")
		end if
   else
		Words = "#"
   end if
   
   Get_LastNite_Timestamp = Words.replace("-","/") 'For Compatibility with javascript
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing   
End Function

Function GetDistrict(strConn As String,strUser As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select control_district from telemetry_user_table where userid='" & _
	        strUser & "'", nOConn)
   
   if not RS.eof then   
		do until RS.EOF
				Words = RS("control_district").value
				RS.MoveNext
		loop
		Words = Words.Replace(",", "|,|")
   end if
   
   GetDistrict = "|" & Words & "|"
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Get_Current_Value(strConn As String,strSite As String,nPos As Integer,decimal_points As Integer,period As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   Dim Time_s
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
  dim today
   
  select case period
		case 1
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddHours(-1))
			today = String.Format("{0:yyyy/MM/dd}",Date.Parse(today) & " 23:45:00")
		case 2
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today & " 07:45:00")
		case 3
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today & " 15:45:00")
   end select
   
   RS.open("select value from telemetry_log_table where siteid='" & _
	        strSite & "' and position=" & nPos & " and sequence ='" & today & "' order by sequence desc limit 1", nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("value").value) then
			Words = 0 ' Put ZERO for compatibilities
		else
			Words = math.round(RS("value").value,decimal_points)
		end if
   else
		Words = 0
   end if
   
   Get_Current_Value = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing   
End Function

Function Get_Current_Timestamp(strConn As String,strSite As String,nPos As Integer,period As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
'			Dim today As DateTime =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddHours(-1))
  dim today
   
  select case period
		case 1
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today.AddHours(-1))
			today = String.Format("{0:yyyy/MM/dd}",Date.Parse(today) & " 23:45:00")
		case 2
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today & " 07:45:00")
		case 3
			today =  String.Format("{0:yyyy/MM/dd}",System.DateTime.Today & " 15:45:00")
   end select
	        
   RS.open("select sequence from telemetry_log_table where siteid='" & _
	        strSite & "' and sequence ='" & today & "' order by sequence desc limit 1", nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("sequence").value) then
			Words = "#"
		else			
			'Words = String.Format("{0:dd/MM/yyyy HH:mm}",Date.Parse(RS("sequence").value))
			'Words = String.Format("{0:dd/MM/yyyy}",Date.Parse(RS("sequence").value)) & " " & Format(Date.Parse(RS("sequence").value),"Medium Time")
			'Words = Format(Date.Parse(RS("sequence").value),"dd/MM/yyyy") & " " & Format(Date.Parse(RS("sequence").value),"Medium Time")
			Words = Format(Date.Parse(RS("sequence").value),"MM/dd/yyyy") & " " & Format(Date.Parse(RS("sequence").value),"Medium Time")
		end if
   else
		Words = "#"
   end if
   
   Get_Current_Timestamp = Words.replace("-","/") 'For Compatibility with javascript
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing   
End Function

Function Get_Status(strConn As String,strSite As String,nPos As Integer,value As double) As String
   Dim nOConn
   Dim RS
   Dim Words,Status
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)   
   
   RS.open("select alarmtype,multiplier,colorcode from telemetry_rule_list_table where siteid='" & _
	        strSite & "' and position=" & nPos & " order by sequence asc", nOConn)
   
   if not RS.eof then
		do while not RS.EOF
			if not IsDBNull(RS("multiplier").value) then
				Words = RS("multiplier").value
				Words = Split(Words, ";")
				if Words(0)="RANGE" then
					if Convert.ChangeType(value, GetType(double))>Convert.ChangeType(Words(1), GetType(double)) and Convert.ChangeType(value, GetType(double))<Convert.ChangeType(Words(2), GetType(double)) then
						Status = RS("alarmtype").value & "," & RS("colorcode").value
					end if
				end if
			end if
			RS.MoveNext
		Loop
   end if   

   Get_Status = Status

   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
End Function
</script>
<%
   	dim objConn
   	dim rsRecords
   	dim strConn
	dim str2parse,lcl_str2parse,timestamp
	dim calculator = 0
	dim _events

	dim uid = request.querystring("uid")
	dim c = request.querystring("c")
	dim district = request.querystring("d")
	dim selected_period = request.querystring("p")
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	'strConn = "DSN=g1;UID=tmp;PWD=tmp;"
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset() 
   	objConn.open(strConn)
	
	dim text,i,_count,counter,tempo_value

select case c
	case "feed"		
		if district = "All" Then
			district = GetDistrict(strConn,uid).replace("|","'")
		else
			district = "'" & district & "'"
		end if
	
		text = "select siteid from telemetry_site_list_table where sitedistrict in (" & district & ") and sitetype='RESERVOIR' order by siteid"
		rsRecords.Open(text, objConn)
		

		do while not rsRecords.EOF
			_count = _count + 1
			lcl_str2parse = lcl_str2parse & rsRecords("siteid").value & ","
			lcl_str2parse = lcl_str2parse & Get_Current_Timestamp(strConn,rsRecords("siteid").value,2,selected_period) & ","
			tempo_value = Get_Current_Value(strConn,rsRecords("siteid").value,2,2,selected_period)			
   			lcl_str2parse = lcl_str2parse & FormatNumber(tempo_value,2) & "," & Get_Status(strConn,rsRecords("siteid").value,2,tempo_value) & "|"   			
			rsRecords.MoveNext
		loop
					lcl_str2parse = Left(lcl_str2parse,Len(lcl_str2parse)-1)					
					str2parse = lcl_str2parse & "|" & _count
					
'		str2parse = Left(str2parse,Len(str2parse)-1)
		response.write(str2parse)
		
	case "feed_all"
		if district = "All" Then
			district = GetDistrict(strConn,uid).replace("|","'")
		else
			district = "'" & district & "'"
		end if
	
		text = "select siteid from telemetry_site_list_table where sitedistrict in (" & district & ") and sitetype='RESERVOIR' order by siteid"
		rsRecords.Open(text, objConn)		

		if Convert.ChangeType(selected_period, GetType(integer))= 1 then
			for i = 1 to 3
				lcl_str2parse = ""
				do while not rsRecords.EOF
					_count = _count + 1
					lcl_str2parse = lcl_str2parse & rsRecords("siteid").value & ","
					lcl_str2parse = lcl_str2parse & Get_LastNite_Timestamp(strConn,rsRecords("siteid").value,2,i) & ","
					tempo_value = Get_LastNite_Value(strConn,rsRecords("siteid").value,2,2,i)			
   					lcl_str2parse = lcl_str2parse & FormatNumber(tempo_value,2) & "," & Get_Status(strConn,rsRecords("siteid").value,2,tempo_value) & "|"   			
					rsRecords.MoveNext
				loop
				lcl_str2parse = Left(lcl_str2parse,Len(lcl_str2parse)-1)
				str2parse = str2parse & lcl_str2parse & "|" & _count & "^"							
				rsRecords.MoveFirst
				_count = 0
			next i		
		else
			for i = 2 to Convert.ChangeType(selected_period, GetType(integer))
				lcl_str2parse = ""
				do while not rsRecords.EOF
					_count = _count + 1
					lcl_str2parse = lcl_str2parse & rsRecords("siteid").value & ","
					lcl_str2parse = lcl_str2parse & Get_Current_Timestamp(strConn,rsRecords("siteid").value,2,i) & ","
					tempo_value = Get_Current_Value(strConn,rsRecords("siteid").value,2,2,i)			
   					lcl_str2parse = lcl_str2parse & FormatNumber(tempo_value,2) & "," & Get_Status(strConn,rsRecords("siteid").value,2,tempo_value) & "|"   			
					rsRecords.MoveNext
				loop
				lcl_str2parse = Left(lcl_str2parse,Len(lcl_str2parse)-1)
				str2parse = str2parse & lcl_str2parse & "|" & _count & "^"							
				rsRecords.MoveFirst
				_count = 0
			next i
		end if
		str2parse = Left(str2parse,Len(str2parse)-1)
		response.write(str2parse)

	case "alert"
		rsRecords.Open("select comment from telemetry_site_list_table where siteid in ('R104','R105') order by siteid",objConn)
		
		lcl_str2parse = ""
   		do while not rsRecords.EOF
'  			if Len(timestamp)=0 then
'  				timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & " " & FormatDateTime(rsRecords("sequence").value,3)
'  			end if
			if UCase(rsRecords("comment").value) = "NONE" then
				lcl_str2parse = lcl_str2parse & UCase(rsRecords("comment").value) & "*"
			else
				timestamp = split(UCase(rsRecords("comment").value), ";")				
				timestamp(0) = String.Format("{0:dd/M/yyyy}", CDate(timestamp(0))) & " " & FormatDateTime(timestamp(0),3)
				lcl_str2parse = lcl_str2parse & timestamp(0) & ";" & timestamp(1) & "*"
			end if
			rsRecords.MoveNext
		loop
		if Len(lcl_str2parse)> 1 then
			lcl_str2parse = Left(lcl_str2parse,Len(lcl_str2parse)-1)					
		end if
		str2parse = lcl_str2parse
		response.write(str2parse)
	case else
		response.write("sedkha deri foer!!")
end select

objConn.close
rsRecords = nothing
objConn = nothing
%>