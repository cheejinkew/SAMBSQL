<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%	
	dim objConn
   	dim rsRecords
   	dim strConn
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
   	objConn.open(strConn)
	
	dim siteid as string
	dim sitename as string
	dim district as string
	
	dim unitid as string
	dim simno as string
	dim password as string
	dim pollmethod as string
	dim sitetype as string
	
    siteid = Request.QueryString("sid")
    'sitename = request.form("sitename")
    'district = request.Form("district")
    password = Request.Form("pwd")
    pollmethod = Request.QueryString("type1")
	
	rsRecords.Open("select unitid, sitetype from telemetry_site_list_table where siteid='" & siteid & "'",objConn)
   	if rsRecords.EOF = false then
		unitid = rsrecords.fields("unitid").value
		sitetype = rsrecords.fields("sitetype").value
	else
		rsrecords.close
		rsrecords = nothing
		objconn = nothing
		exit sub
	end if
	rsrecords.close
	rsRecords.Open("select simno from unit_list where unitid='" & unitid & "'",objConn)
	if rsrecords.eof = false then
		simno = rsrecords.fields("simno").value	
	else
		rsrecords.close
		rsrecords = nothing
		objconn = nothing
		exit sub
	end if
	dim tmpenddate as date
	tmpenddate = dateadd("d", 1, now)
	'RESPONSE.Write("Insert Into sms_outbox_Table (destination, startdate, enddate, priority, message, network, assign, insertdate, kn_source_id) Values ('" & simno & "', '" & Now & "', '" & tmpEndDate & "', '0', '(CGUS;20)', 'None', 'FALSE', '" & Now & "', '000')")
    objConn.execute("Insert Into sms_outbox_Table (destination, startdate, enddate, priority, message, network, assign, insertdate, kn_source_id) Values ('" & simno & "', '" & Now & "', '" & tmpenddate & "', '0', '(CGUS;20)', 'None', 'FALSE', '" & Now & "', '000')")
    Response.Write("ok")
%>

