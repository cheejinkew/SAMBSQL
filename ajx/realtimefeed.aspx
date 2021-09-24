<%@ Page Language="VB" Debug="true" %>
<script language="VB" runat="server">
Function GetSiteComment(strConn As String,strSite As String) As String
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select comment from telemetry_site_list_table where siteid='" & strSite & "'",nOConn)   	   			
   			if not RS.EOF then
				GetSiteComment = server.htmlencode(RS("comment").value)
			else
				GetSiteComment = ""
			end if

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing	
   
End Function
</script>
<% 	dim objConn
   	dim rsRecords
   	dim strConn
	dim str2parse,str2parseII,timestamp,timing
	dim calculator = 0

	dim SiteID = request.querystring("siteid")
	dim c = request.querystring("c")
	
	if SiteID="S1A9" then	
   		strConn = ConfigurationSettings.AppSettings("DSNPG")
   	else
   		strConn = ConfigurationSettings.AppSettings("DSNPG")
   		'strConn = "DSN=tm;UID=tmp;PWD=tmp;"
   	end if
   	
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset() 
   	objConn.open(strConn)

   	
	select case siteid			
		case "1"		'S101 Mas Sepang - P M L A F S
		
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 2 and 3 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position=48",objConn)
						   
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close					
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position=54",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position=51" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position=56 order by position",objConn)
   			do while not rsRecords.EOF
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.close
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 28 and 39 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
			objConn.close			
			rsRecords = nothing
			objConn = nothing
			
		case "2"		'S102 Bandar Bukit Puchong - P M L A F S
		
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 2 and 3 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 48 and 49 order by position",objConn)
						   
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close					
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 54 and 55 order by position",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position=51" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position=56 order by position",objConn)
   			do while not rsRecords.EOF
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.close
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 28 and 39 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing
			
		case "3"		'S103 Pulau Indah Pump House - P M L A F S
		
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 2 and 3 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 4 and 21" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 40 and 45 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close

			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 48 and 50 order by position",objConn)
						   
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close					
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position = 54",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 51 and 53" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 56 and 58 order by position",objConn)
   			do while not rsRecords.EOF
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.close
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 28 and 39 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing
	
		case "4"		'S103 Jalan Beringin, Bukit Damansara - P M L A F S
		
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 2 and 3 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 4 and 9" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 40 and 41 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close

			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 48 and 49 order by position",objConn)
						   
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close					
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position = 54",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 51 and 52" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 56 and 57 order by position",objConn)
   			do while not rsRecords.EOF
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.close
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & _
						   "' and position between 28 and 39 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing

		case "S1A8_"		'S1A8 Prima Pelangi, Kuala Lumpur - P M L A F S
		
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 2 and 3 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 4 and 12" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 40 and 42 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close

			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 48 and 53 order by position",objConn)
						   
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close					
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 56 and 57 order by position",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.Close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 28 and 31 order by position",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing
			
		case "S1A9_"		'S1A8 Sunway Kayangan, Bukit Jelutong - P M L A F S
		
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 2 and 3 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
					
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 4 and 24" & _
						   " union " & _
  						   "select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 40 and 46 order by position",objConn)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "&nbsp;" & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close

			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 48 and 54 order by position",objConn)
						   
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
			
			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 56 and 59 order by position",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
			
			rsRecords.close

			rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' and position between 28 and 31 order by position",objConn)
   			do while not rsRecords.EOF				   			
   				calculator = calculator + 1   							
   				str2parse = str2parse & rsRecords("value").value & ","						
				rsRecords.MoveNext
			loop					
			str2parse = Left(str2parse,Len(str2parse)-1)
			str2parse = str2parse & "|"
					
			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing
		
		case "else"
	
			rsRecords.Open("select sequence,value from telemetry_equip_status_table where siteid='S10" & SiteID & "' order by position",objConn)
   			'timestamp = String.Format("{0:dd/MM/yyyy hh:mm:ss}", rsRecords("sequence").value)
   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & " " & FormatDateTime(rsRecords("sequence").value,3)
   			do while not rsRecords.EOF
		   			
   					calculator = calculator + 1
					str2parse = str2parse & rsRecords("value").value & "|"	
				
				rsRecords.MoveNext
			loop

			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing
			
		case else
			
			rsRecords.Open("select position,sequence,value,event from telemetry_equip_status_table where siteid='" & SiteID & _
						   "' order by position",objConn)
			if not rsRecords.EOF then
	   			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value)
				timing = FormatDateTime(rsRecords("sequence").value,3)
	   			do while not rsRecords.EOF				   			
	   				calculator = calculator + 1
	   				str2parse = str2parse & "<equipment no=" & chr(34) & rsRecords("position").value & chr(34) & " value=" & chr(34) & rsRecords("value").value & chr(34) & ">" & rsRecords("event").value & "</equipment>" & vbcrlf
					rsRecords.MoveNext
				loop
			end if
			
			if Len(str2parse)>0 then
				str2parse = Left(str2parse,Len(str2parse)-1)
			end if
			str2parse = str2parse & "|"			
			
			rsRecords.close
			objConn.close
			rsRecords = nothing
			objConn = nothing
		
	end select	

select case c
	case "feed"
		str2parse = Left(str2parse,Len(str2parse)-1)
		'response.write("RTU " & SiteID & ": " & timestamp & "|" & calculator & "|" & str2parse)
		response.write(timestamp & "|" & calculator & "|" & str2parse & "|RTU " & SiteID)
	case "feeds"
		str2parse = Left(str2parse,Len(str2parse)-1)		
		'response.write("RTU " & SiteID & ": " & timestamp & "|" & str2parse)
		response.write(timestamp & "|" & str2parse & "|RTU " & SiteID)
	case "xml"	
		Response.ContentType = "text/xml"
		str2parse = Left(str2parse,Len(str2parse)-1)
		response.write("<?xml version=" & chr(34) & "1.0" & chr(34) & " ?>"  & vbcrlf)
		response.write("<mapping sitename=" & chr(34) & SiteID & chr(34) & " timestamp=" & chr(34) & timestamp & chr(34) & " timing=" & chr(34) & timing & chr(34) & " status=" & chr(34) & GetSiteComment(strConn,SiteID) & chr(34) & ">" & vbcrlf & str2parse & "</mapping>" & vbcrlf)
	case else
		response.write("sedkha deri foer!!")
end select
%>