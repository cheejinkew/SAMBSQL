<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%
	dim SiteID = request.querystring("siteid")
	dim vIndex = request.QueryString("index")
	dim Position = request.QueryString("position")
	
	dim objConn
   	dim rsRecords
   	dim strConn as string
	dim sequence as string
	'if SiteID = "" then exit sub

   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn = new ADODB.Connection()
    rsRecords = New ADODB.Recordset()
    Try
        objConn.open(strConn)
	
        rsRecords.Open("select value, sequence from telemetry_equip_status_table where siteid='" & SiteID & "' and index='" & vIndex & "' and position='" & Position & "'", objConn)
        If rsRecords.EOF = False Then
            sequence = Mid(rsRecords.fields("sequence").value, 11, 12)
		
            If DateDiff("n", rsRecords.fields("sequence").value, Now) <= 30 Then
                Response.Write(rsRecords.fields("value").value & " l")
                Response.Write("&name=" & sequence & "&value=" & rsRecords.fields("value").value)
            Else
                Response.Write("&name=" & Mid(Now, 11, 12) & "&value=")
            End If
        Else
            Response.Write("&name=" & Mid(Now, 11, 12) & "&value=")
        End If
    Catch ex As Exception
        rsRecords.close()
        rsRecords = Nothing
        objConn.close()
        objConn = Nothing
    End Try
  
	
%>

