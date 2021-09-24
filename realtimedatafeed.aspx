<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%
	dim SiteID = request.querystring("siteid")
	dim vIndex = request.QueryString("index")
	dim Position = request.QueryString("position")
	
	dim objConn
   	dim rsRecords
   	dim strConn
	'if SiteID = "" then exit sub

   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn = new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()
   	objConn.open(strConn)
	
	rsRecords.Open("select sequence, value from telemetry_equip_status_table where siteid='" & SiteID & "' and index='" & vIndex & "' and position='" & Position & "'",objConn)
   	if rsRecords.EOF = false then
		if DateDiff("n", rsrecords.fields("sequence").value, now) <= 30 then
			response.Write("&value=" & rsrecords.fields("value").value)
		else
			response.Write("&value=")
		end if
	else
		response.Write("&value=")
	end if
	rsRecords.close
	rsRecords = Nothing
	objConn.close
	objConn = Nothing
%>

