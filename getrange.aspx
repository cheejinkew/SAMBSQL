<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%
	dim startdate = request.querystring("startdate")
	dim enddate = request.QueryString("enddate")
	dim unitid = request.QueryString("unitid")
   	dim objConn
   	dim rsRecords
   	dim strConn

	if startdate = "" then exit sub
	if enddate = "" then exit sub
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
   	objConn.open(strConn)
	
	rsRecords.Open("SELECT sequence, data FROM gprs_inbox_table Where unitid Like '" & unitid & "' And sequence Between '" & startdate & "' And '" & enddate & "' Order By unitid, Sequence, data asc",objConn)
	dim i as integer
   	do while not rsRecords.EOF
		response.Write(rsrecords.fields("sequence").value & ";" & rsrecords.fields("data").value & "|")
		rsRecords.MoveNext
		i = i + 1
	loop
	response.write("^" & i)
	rsRecords.close
	rsrecords = nothing
	objconn = nothing
%>