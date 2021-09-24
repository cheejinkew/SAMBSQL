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

Function GetXMLString(strConn As String,strSite As String) As String   
   dim str2parse,timestamp,timing
   dim calculator = 0
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select sequence,value,position from telemetry_equip_status_table where siteid='" & strSite & "' order by position",nOConn)   	
			if not RS.EOF then
				timestamp = String.Format("{0:dd/M/yyyy}", RS("sequence").value)
				timing = FormatDateTime(RS("sequence").value,3)
			end if
   			do while not RS.EOF
		   			
   					calculator = calculator + 1
   					select case RS("position").value
						case 15 to 20
							str2parse = str2parse & "<equipment pos=*" &RS("position").value & "*>" & math.round(RS("value").value) & "</equipment>" & vbcrlf
						case else
							str2parse = str2parse & "<equipment pos=*" & RS("position").value & "*>" & decimal.round(RS("value").value,3) & "</equipment>" & vbcrlf
					end select
				
				RS.MoveNext
			loop

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing
	
	GetXMLString = "<site id=*" & strSite & "* name=*" & GetSiteName(strConn,strSite) & "* timestamp=*" & timestamp & "* timing=*" & timing & "*>" & vbcrlf & str2parse & "</site>"
   
End Function

Function GetString(strConn As String,strSite As String) As String   
   dim str2parse,str2parseII,timestamp
   dim calculator = 0
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
	select case strSite
		case "9045B"
			response.write("Test...")
		case else
		
			RS.Open("select sequence,value,position from telemetry_equip_status_table where siteid='" & strSite & "' order by position",nOConn)   	
   			timestamp = String.Format("{0:dd/M/yyyy}", RS("sequence").value) & "*" & FormatDateTime(RS("sequence").value,3)
   			do while not RS.EOF
		   			
   					calculator = calculator + 1
   					select case RS("position").value
						case 15 to 20
							str2parse = str2parse & math.round(RS("value").value) & "|"
						case else
							str2parse = str2parse & decimal.round(RS("value").value,3) & "|"
					end select
				
				RS.MoveNext
			loop

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing			
		
	end select
	str2parse = Left(str2parse,Len(str2parse)-1)
	GetString = " " & strSite & "*" & timestamp & "|" & str2parse & "|" & calculator & "*" & GetSiteName(strConn,strSite)
   
End Function

Function GetAssociate(strConn As String,strSite As String) As String
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select Associate from telemetry_site_list_table where siteid='" & strSite & "'",nOConn)   	   			
   			if not RS.EOF then					
				GetAssociate = RS("Associate").value
			else
				GetAssociate = ""
			end if

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing	
   
End Function
Function GetSiteName(strConn As String,strSite As String) As String
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select sitename from telemetry_site_list_table where siteid='" & strSite & "'",nOConn)   	   			
   			if not RS.EOF then					
				GetSiteName = server.htmlencode(RS("sitename").value)				
			else
				GetSiteName = ""
			end if

			RS.close
			nOConn.close
			RS = nothing
			nOConn = nothing	
   
End Function
Function Format_Time_Parse(str As String,options As Integer)
	select case options
		case 1
			Format_Time_Parse = String.Format("{0:HH:mm}",Date.Parse(str))
		case 2
			Format_Time_Parse = String.Format("{0:yyyy/MM/dd}",Date.Parse(str))
		case else
			Format_Time_Parse = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(str))
	end select
End Function
</script>
<%
   	dim strConn,TM_Conn

	dim SiteID = request.querystring("siteid")
	dim c = request.querystring("c")
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
'  		strConn = "DSN=avls_telemetry;UID=tmp;PWD=tmp;"
	TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"
'   		strConn = "DSN=g1;UID=tmp;PWD=tmp;"

select case c
	case "feed"
		response.write(GetString(strConn,SiteID))		
	case "tepusclass"
		dim siteid2 = GetAssociate(strConn,SiteID)
		response.write(GetString(TM_Conn,SiteID) & "~" & GetString(strConn,SiteID2))
	case "xml"	
		dim siteid2 = GetAssociate(strConn,SiteID)
		Response.ContentType = "text/xml"		
		response.write("<?xml version=" & chr(34) & "1.0" & chr(34) & " ?>"  & vbcrlf)
		response.write("<mapping sitename=" & chr(34) & GetSiteName(strConn,SiteID) & chr(34) & " status=" & chr(34) & GetSiteComment(strConn,SiteID) & chr(34) & ">" & vbcrlf)
		response.write(GetXMLString(strConn,SiteID).Replace("*", chr(34)))				
		response.write(vbcrlf & "</mapping>" & vbcrlf)		
	case else
		response.write("sedkha deri foer!!")
end select
%>