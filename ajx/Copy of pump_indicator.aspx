<%
	dim SiteID = request.querystring("siteid")
	dim c = request.querystring("c")

   	dim objConn
   	dim rsRecords
   	dim strConn
	dim str2parse,str2parseII
	dim calculator = 0	
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()           

   	objConn.open(strConn)

	dim equiplist(0) as string
	dim equipname(0) as string
	dim equipdesc(0) as string
	dim position(0)

   	dim i as integer

	rsRecords.Open("select " & chr(34) & "desc" & chr(34) & ", equipname, equiptype, position from telemetry_equip_list_table where siteid='" & SiteID & "' order by position",objConn)
   	
   	do while not rsRecords.EOF
		equiplist(i) = rsrecords.fields("equiptype").value 
		equipname(i) = rsrecords.fields("equipname").value
		equipdesc(i) = rsrecords.fields("desc").value
		position(i) = rsrecords.fields("position").value

		i = i + 1
		redim preserve equiplist(i)
		redim preserve equipname(i)
		redim preserve equipdesc(i)
		redim preserve position(i)
		
		rsRecords.MoveNext
	loop
	rsRecords.close

	dim readings(2) as string

	rsRecords.Open("select sequence, value, event from telemetry_equip_status_table where siteid='" & SiteID & "' order by position",objConn)
   	if rsrecords.eof = false then
		i = 2
		do while not rsRecords.EOF
			readings(i) = rsrecords.fields("value").value
			if readings(i) < 0 then readings(i) = 0
			i = i + 1

			redim preserve readings(i)
			rsrecords.movenext
		loop
	else
		response.Write("Data Not Available")
		exit sub
	end if
	rsrecords.close

'for i = 0 to ubound(equiplist)
'if equiplist(i)= "PUMP CONTROL" then
'						str2parse = str2parse & left(equipdesc(i),6) & ","
'						calculator = calculator + 1
'				if readings(i) = 0 then
'					if equipname(i) = "Pump Control Status" then
'						'AUTO
'						str2parse = str2parse & "Auto!"
'					else
'						'LIGHT ON
'						str2parse = str2parse & "Light On!"
'					end if
'				else 
'					if equipname(i) = "Pump Control Status" then
'						'MANUAL					
'						str2parse = str2parse & "Manual!"
'					else
'						'LIGHT OFF
'						str2parse = str2parse & "Light Off!"
'					end if
'				end if
'end if
'next i
'str2parse = Left(str2parse,Len(str2parse)-1)

for i = 0 to ubound(equiplist)
if equiplist(i)= "PUMP CONTROL" then
						if calculator mod 3 = 0 then str2parse = str2parse & "|" '& left(equipdesc(i),6) & ","
						calculator = calculator + 1
				if readings(i) = 0 then
					if equipname(i) = "Pump Control Status" then
						'AUTO
						str2parse = str2parse & "AUTO"
					else
						'LIGHT ON
						str2parse = str2parse & "ON,"
						str2parseII = str2parseII & "ON,"
					end if
				else 
					if equipname(i) = "Pump Control Status" then
						'MANUAL					
						str2parse = str2parse & "MANUAL"						
					else
						'LIGHT OFF
						str2parse = str2parse & "OFF,"
						str2parseII = str2parseII & "OFF,"
					end if
				end if
end if
next i
'str2parse = Left(str2parse,Len(str2parse)-1)
str2parse = Right(str2parse,Len(str2parse)-1)
str2parseII = Left(str2parseII,Len(str2parseII)-1)

select case c
	case "feed"
		response.write(str2parse)
	case "bphambs"
		response.write(str2parse & "#")
		dim inSiteID = 9012
		dim SQLString = "select value from telemetry_equip_status_table where siteid='" & inSiteID & "' and position=2 order by position"
		rsRecords.Open(SQLString, objConn)
		   
		dim x 

		do until rsRecords.EOF		
			for each x in rsRecords.Fields
				response.write(FormatNumber(x.value, 3, , , TriState.False))				
			next
			rsRecords.MoveNext
		loop
		  
		rsRecords.Close()
		response.write(",")
		SiteID = 9003

		SQLString = "select value from telemetry_equip_status_table where siteid='" & SiteID & "' and position=2 order by position"
		rsRecords.Open(SQLString, objConn) 
			
			do until rsRecords.EOF
				for each x in rsRecords.Fields
					response.write(FormatNumber(x.value, 3, , , TriState.False))					
				next
				rsRecords.MoveNext
			loop
	case 1
		str2parseII = str2parseII.split(",")		
		
		if (str2parseII(0)=str2parseII(1))					
			if (str2parseII(0)="ON") then response.write("&value=80")
			if (str2parseII(0)="OFF") then response.write("&value=20")
		else			
			response.write("&value=50")
		end if		
		
	case 2 to 20
		dim mplier = c*2
		str2parseII = str2parseII.split(",")

		if (str2parseII(mplier-2)=str2parseII(mplier-1))
			if (str2parseII(mplier-2)="ON") then response.write("&value=80")
			if (str2parseII(mplier-2)="OFF") then response.write("&value=20")
		else			
			response.write("&value=50")
		end if
		
	case else
			response.write("sedkha deri foer!!")	
end select

rsrecords = nothing
objConn.close
objConn = Nothing
%>