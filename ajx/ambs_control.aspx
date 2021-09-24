<%@ Page Language="VB" Debug="true" %>
<%
   	dim objConn
   	dim rsRecords
   	dim strConn
	dim str2parse,str2parseII
	dim calculator = 0
	dim timestamp,position
	
	dim inSiteID = 9012
	dim SiteID
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()           

   	objConn.open(strConn)

	dim arr_value(20)	

   	dim i as integer
	
	rsRecords.Open("select value,sequence,position from telemetry_equip_status_table where siteid='" & inSiteID & "' order by position",objConn)
   	
   	do while not rsRecords.EOF
   		position = rsrecords.fields("position").value
		arr_value(position) = rsrecords.fields("value").value
		rsRecords.movenext
	loop

	rsRecords.close
	
	for i = 3 to arr_value.length - 1
		str2parse = str2parse & arr_value(i) & ","
	next i
	
'str2parse = Right(str2parse,Len(str2parse)-1)
str2parse = Left(str2parse,Len(str2parse)-1)
'str2parseII = Left(str2parseII,Len(str2parseII)-1)

		response.write(str2parse & "#")
		
		dim SQLString = "select value,sequence from telemetry_equip_status_table where siteid='" & inSiteID & "' and position=2 order by position"
		rsRecords.Open(SQLString, objConn)
		   
		dim x 

		do until rsRecords.EOF
			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "  " & FormatDateTime(rsRecords("sequence").value,3)
			response.write(timestamp  & ",")
			response.write(FormatNumber(rsRecords("value").value, 3, , , TriState.False))
			rsRecords.MoveNext
		loop
		  
		rsRecords.Close()
		response.write(",")
		SiteID = 9003

		SQLString = "select sequence,value from telemetry_equip_status_table where siteid='" & SiteID & "' and position=2 order by position"
		rsRecords.Open(SQLString, objConn) 
			
		do until rsRecords.EOF
			timestamp = String.Format("{0:dd/M/yyyy}", rsRecords("sequence").value) & "  " & FormatDateTime(rsRecords("sequence").value,3)
			response.write(timestamp  & ",")
			response.write(FormatNumber(rsRecords("value").value, 3, , , TriState.False))
			rsRecords.MoveNext
		loop

rsrecords = nothing
objConn.close
objConn = Nothing
%>