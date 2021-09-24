<%@ Page Language="VB" Debug="true" %>
<%
   	dim objConn
   	dim rsRecords
   	dim strConn
	dim str2parse,str2parseII,timestamp
	dim calculator = 0

	dim SiteID = request.querystring("siteid")
	dim c = request.querystring("c")
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset() 
   	objConn.open(strConn)
	dim i,tempo_value
	
if c = "feed" then

				select case SiteID
					case 1
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & " &bull;AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & " &bull;DC FAIL<br>"
								case 4								
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5								
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 10
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 3 Stopped<br>"
								case 11
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 3 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 13
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 4 Stopped<br>"
								case 14
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 4 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 16
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 5 Stopped<br>"
								case 17
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 5 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 2
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 3
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 4
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 5
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 6
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 7
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 10
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 3 Stopped<br>"
								case 11
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 3 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 13
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 4 Stopped<br>"
								case 14
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 4 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 16
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 5 Stopped<br>"
								case 17
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 5 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 19
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 6 Stopped<br>"
								case 20
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 6 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 22
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 7 Stopped<br>"
								case 23
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 7 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close						
					case 8
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 10
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 3 Stopped<br>"
								case 11
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 3 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 9
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 10
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 3 Stopped<br>"
								case 11
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 3 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 10
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 10
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 3 Stopped<br>"
								case 11
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 3 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 11
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 12
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 13
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
								case 4
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 1 Stopped<br>"
								case 5
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 1 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 7
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 2 Stopped<br>"
								case 8
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 2 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 10
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 3 Stopped<br>"
								case 11
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 3 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 13
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 4 Stopped<br>"
								case 14
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 4 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 16
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 5 Stopped<br>"
								case 17
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 5 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 19
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 6 Stopped<br>"
								case 20
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 6 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 22
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 7 Stopped<br>"
								case 23
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 7 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
								case 25
									if rsRecords("value").value = 0 then tempo_value = "&bull; Pump 8 Stopped<br>"
								case 26
									if rsRecords("value").value = 1 then tempo_value = "&bull; Pump 8 Tripped<br>"
									str2parse = str2parse & tempo_value
									tempo_value = ""
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 14
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
					case 15
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close

' ==========================================================
					case 36
						tempo_value = ""
						rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & SiteID & "' and position between 2 and 27 order by position asc",objConn)
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; AC FAIL<br>"
   								case 3
									if rsRecords("value").value = 1 then str2parse = str2parse & "&bull; DC FAIL<br>"
   								case else
									'str2parse = str2parse & "," & rsRecords("position").value & "-" &  rsRecords("value").value
							end select
							rsRecords.MoveNext
						loop					
						rsRecords.close
		end select
		
		if str2parse = "" then str2parse = "&bull; No Event!"
		'str2parse = Left(str2parse,Len(str2parse)-1)
		'timestamp = String.Format("{0:dd/M/yyyy}", Now) & " " & FormatDateTime(Now,3)	
		'response.write(timestamp & "," & calculator & "|" & str2parse)
		response.write(str2parse)
else
		response.write("sedkha deri foer!!")
end if

objConn.close
rsRecords = nothing
objConn = nothing
%>