<%@ Page Language="VB" Debug="true" %>
<%
   	dim objConn
   	dim rsRecords
   	dim strConn
	dim str2parse,timestamp
	dim calculator = 0

	dim SiteID = request.querystring("siteid")
	dim c = request.querystring("c")
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset() 
   	objConn.open(strConn)
	dim i,url,tempo_count,counter,tempo_value

select case c
	case "feed"
		
		for i = 1 to 36	' 37 RTUs hardcoded
				counter = 0
				rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & i & "' and position between 2 and 27 order by position asc",objConn)
				select case i
					case 1						
						url = "custom/_enoe.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 13
									if rsRecords("value").value = 0 then tempo_count = 1
								case 14
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 16
									if rsRecords("value").value = 0 then tempo_count = 1
								case 17
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 2
						url = "custom/_sgi.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 3
						url = "custom/pohon.aspx.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 4
						url = "custom/layang.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 5
						url = "custom/_rmaf.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 6
						url = "custom/_rmaf.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 7
						url = "custom/_jkolam_1.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 13
									if rsRecords("value").value = 0 then tempo_count = 1
								case 14
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 16
									if rsRecords("value").value = 0 then tempo_count = 1
								case 17
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 19
									if rsRecords("value").value = 0 then tempo_count = 1
								case 20
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 22
									if rsRecords("value").value = 0 then tempo_count = 1
								case 23
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 8
						url = "custom/sungai_pagar_wtp.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 9
						url = "custom/_bktkuda.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 10
						url = "custom/_kerupang.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 11
						url = "custom/kiamsam.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select							
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 12
						url = "custom/_.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 13
						url = "custom/ips_bukit_kallambooster.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 13
									if rsRecords("value").value = 0 then tempo_count = 1
								case 14
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 16
									if rsRecords("value").value = 0 then tempo_count = 1
								case 17
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 19
									if rsRecords("value").value = 0 then tempo_count = 1
								case 20
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 22
									if rsRecords("value").value = 0 then tempo_count = 1
								case 23
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 25
									if rsRecords("value").value = 0 then tempo_count = 1
								case 26
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 14
						url = "custom/_arsat.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
					case 15
						url = "custom/_GovernmentQtrs_UMs.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
' ==========================================================
 					case 16
   						url = "custom/_pressure.aspx?site_id=16&site_name=Kg%20Bebuluh"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 17
   						url = "custom/_pressure.aspx?site_id=17&site_name=Kg%20Sg%20Beduan"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 18
   						url = "custom/_pressure.aspx?site_id=18&site_name=Kg%20Sg%20Lada"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 19
   						url = "custom/_pressure.aspx?site_id=19&site_name=Bkt%20Telekom"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 20
   						url = "custom/_pressure.aspx?site_id=20&site_name=Jabatan%20Pertanian"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 21
   						url = "custom/_pressure.aspx?site_id=21&site_name=Amsteel%20Mill"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 22
   						url = "custom/_pressure.aspx?site_id=22&site_name=Patau%20Patau"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 23
   						url = "custom/_pressure.aspx?site_id=23&site_name=Taman%20Sintee"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 24
   						url = "custom/_pressure.aspx?site_id=24&site_name=Taman%20Kian%20Yap"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 25
   						url = "custom/_pressure.aspx?site_id=25&site_name=IPS%20Bukit%20Kallam"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 26
   						url = "custom/_pressure.aspx?site_id=26&site_name=Masjid%20Negeri"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 27   					
   						url = "custom/_pressure.aspx?site_id=27&site_name=Town%20Center"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 28
   						url = "custom/_pressure.aspx?site_id=28&site_name=Pernama"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 29
   						url = "custom/_pressure.aspx?site_id=29&site_name=Kg%20Nagalang"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 30
   						url = "custom/_pressure.aspx?site_id=30&site_name=Kg%20Tg%20Aru"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 31
   						url = "custom/_pressure.aspx?site_id=31&site_name=Kg%20Lanjau"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 32
   						url = "custom/_pressure.aspx?site_id=32&site_name=Lubuk%20Termiang"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 33
   						url = "custom/_pressure.aspx?site_id=33&site_name=Jalan%20Batu%20Manikar"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 34
   						url = "custom/_pressure.aspx?site_id=34&site_name=Tennis%20Court"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
   					case 35
   						url = "custom/_pressure.aspx?site_id=35&site_name=Sek%20Vokasional"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
' ==========================================================
					case 36
						url = "custom/_.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						str2parse = str2parse & i & "," & counter & "|"
		end select
				rsRecords.close		
		next i
		
		str2parse = Left(str2parse,Len(str2parse)-1)
		timestamp = String.Format("{0:dd/M/yyyy}", Now) & " " & FormatDateTime(Now,3)	
		response.write(timestamp & "," & calculator & "|" & str2parse)
		
	case "marquee"

		for i = 1 to 36	' 37 RTUs hardcoded
				counter = 0
				rsRecords.Open("select position,sequence,value from telemetry_equip_status_table where siteid='RTU" & i & "' and position between 2 and 27 order by position asc",objConn)
				select case i
					case 1						
						url = "custom/_enoe.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 13
									if rsRecords("value").value = 0 then tempo_count = 1
								case 14
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 16
									if rsRecords("value").value = 0 then tempo_count = 1
								case 17
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 2
						url = "custom/_sgi.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 3
						url = "custom/pohon.aspx.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 4
						url = "custom/layang.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 5
						url = "custom/_rmaf.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 6
						url = "custom/_rmaf.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 7
						url = "custom/_jkolam_1.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 13
									if rsRecords("value").value = 0 then tempo_count = 1
								case 14
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 16
									if rsRecords("value").value = 0 then tempo_count = 1
								case 17
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 19
									if rsRecords("value").value = 0 then tempo_count = 1
								case 20
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 22
									if rsRecords("value").value = 0 then tempo_count = 1
								case 23
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 8
						url = "custom/sungai_pagar_wtp.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 9
						url = "custom/_bktkuda.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 10
						url = "custom/_kerupang.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 11
						url = "custom/kiamsam.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select							
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 12
						url = "custom/_.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 13
						url = "custom/ips_bukit_kallambooster.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
								case 4
									if rsRecords("value").value = 0 then tempo_count = 1
								case 5
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 7
									if rsRecords("value").value = 0 then tempo_count = 1
								case 8
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 10
									if rsRecords("value").value = 0 then tempo_count = 1
								case 11
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 13
									if rsRecords("value").value = 0 then tempo_count = 1
								case 14
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 16
									if rsRecords("value").value = 0 then tempo_count = 1
								case 17
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 19
									if rsRecords("value").value = 0 then tempo_count = 1
								case 20
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 22
									if rsRecords("value").value = 0 then tempo_count = 1
								case 23
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
								case 25
									if rsRecords("value").value = 0 then tempo_count = 1
								case 26
									if rsRecords("value").value = 1 then
										if tempo_count = 0 then	counter = counter + 1		
									end if
									tempo_count = 0
							end select
							counter = counter + tempo_count
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 14
						url = "custom/_arsat.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
					case 15
						url = "custom/_GovernmentQtrs_UMs.aspx"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
' ==========================================================
 					case 16
   						url = "custom/_pressure.aspx?site_id=16&site_name=Kg%20Bebuluh"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 17
   						url = "custom/_pressure.aspx?site_id=17&site_name=Kg%20Sg%20Beduan"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 18
   						url = "custom/_pressure.aspx?site_id=18&site_name=Kg%20Sg%20Lada"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 19
   						url = "custom/_pressure.aspx?site_id=19&site_name=Bkt%20Telekom"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 20
   						url = "custom/_pressure.aspx?site_id=20&site_name=Jabatan%20Pertanian"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 21
   						url = "custom/_pressure.aspx?site_id=21&site_name=Amsteel%20Mill"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 22
   						url = "custom/_pressure.aspx?site_id=22&site_name=Patau%20Patau"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 23
   						url = "custom/_pressure.aspx?site_id=23&site_name=Taman%20Sintee"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 24
   						url = "custom/_pressure.aspx?site_id=24&site_name=Taman%20Kian%20Yap"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 25
   						url = "custom/_pressure.aspx?site_id=25&site_name=IPS%20Bukit%20Kallam"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 26
   						url = "custom/_pressure.aspx?site_id=26&site_name=Masjid%20Negeri"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 27   					
   						url = "custom/_pressure.aspx?site_id=27&site_name=Town%20Center"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 28
   						url = "custom/_pressure.aspx?site_id=28&site_name=Pernama"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 29
   						url = "custom/_pressure.aspx?site_id=29&site_name=Kg%20Nagalang"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 30
   						url = "custom/_pressure.aspx?site_id=30&site_name=Kg%20Tg%20Aru"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "	
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 31
   						url = "custom/_pressure.aspx?site_id=31&site_name=Kg%20Lanjau"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 32
   						url = "custom/_pressure.aspx?site_id=32&site_name=Lubuk%20Termiang"
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 33
   						url = "custom/_pressure.aspx?site_id=33&site_name=Jalan%20Batu%20Manikar"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 34
   						url = "custom/_pressure.aspx?site_id=34&site_name=Tennis%20Court"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
   					case 35
   						url = "custom/_pressure.aspx?site_id=35&site_name=Sek%20Vokasional"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "	
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
' ==========================================================
					case 36
						url = "custom/_.aspx"						
						tempo_count = 0
   						do while not rsRecords.EOF			   			
   							calculator = calculator + 1
   							select case rsRecords("position").value
   								case 2
   									if rsRecords("value").value = 1 then counter = counter + 1
   								case 3
									if rsRecords("value").value = 1 then counter = counter + 1
							end select
							rsRecords.MoveNext
						loop
						'if counter > 0 then	str2parse = str2parse & "<a href=" & url & ">RTU" & i & " : " & counter & " events</a> "
						str2parse = str2parse & "&bull; <a href=" & url & " target=main>RTU" & i & " : " & counter & " events</a> "
		end select
				rsRecords.close		
		next i
				
		'timestamp = String.Format("{0:dd/M/yyyy}", Now) & " " & FormatDateTime(Now,3)
		if str2parse = "" then
			str2parse = "&bull; No Events &bull;"
		else
			str2parse = str2parse & " &bull;"
		end if
		response.write(str2parse)
		
	case else
		response.write("sedkha deri foer!!")
end select

objConn.close
rsRecords = nothing
objConn = nothing
%>