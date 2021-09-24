<script language="VB" runat="server">
Function makeHTMLHeader_Open()
	Dim txt As String
	txt = "<!DOCTYPE html PUBLIC " & chr(34) & "-//W3C//DTD XHTML 1.0 Transitional//EN" & chr(34) & _
	      vbcrlf & chr(34) & "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" & chr(34) & ">" & _
		  "<html xmlns=" & chr(34) & "http://www.w3.org/1999/xhtml" & chr(34) & ">" & _
		  "<head><title></title>" & vbcrlf		  
	response.write(txt)	
End Function

Function makeHTMLHeader_Close()
	response.write("</head>")
End Function

Function szParseString(szString As String, szDelimiter As String, nSegmentNumber As Integer) 
    Dim nIndex  As Integer
    Dim szTemp  As String
    Dim nPos    As Integer

    szTemp = szString

    For nIndex = 1 To nSegmentNumber - 1
        nPos = InStr(szTemp, szDelimiter)
        If nPos Then
            szTemp = Mid$(szTemp, nPos + 1)
        Else
            Exit Function
        End If
    Next
    nPos = InStr(szTemp, szDelimiter)

    If nPos Then
        szParseString = Left$(szTemp, nPos - 1)
    Else
        szParseString = szTemp
    End If

End Function

Function DifferString(szFirst As date, szSecond As date) As Integer
    Dim nDiffer  As Integer    
    select case DateDiff(DateInterval.Minute,szFirst,szSecond)
		case <119
			DifferString = 5
		case 120 to 719
			DifferString = 10
		case 720 to 1439
			DifferString = 15
		case 1440 to 2880
			DifferString = 20
		case > 2880
			DifferString = 30
    end select
	'dim t  as datetime=cDate('2006-11-01 00:00:00')	
End Function

Function Differ4Value(szFirst As date, szSecond As date) As Integer
    Dim nDiffer  As Integer    
    select case DateDiff(DateInterval.Minute,szFirst,szSecond)
		case <119
			Differ4Value = 5
		case 120 to 719
			Differ4Value = 10
		case 720 to 1439
			Differ4Value = 15
		case 1440 to 2880
			Differ4Value = 20
		case else
			Differ4Value = 30
    end select	
End Function

Function DifferStringAsDate(szFirst As date, szSecond As date) As Boolean
    Dim nDiffer  As Integer
    'Convert.ToDateTime(XL.RowField.Trim)
    'DifferStringAsDate = DateDiff(DateInterval.Minute,szFirst,szSecond)
    if szFirst<szSecond then
		DifferStringAsDate = 1
    else
		DifferStringAsDate = 0
    end if
End Function

Function GetLastSequence(strConn As String,strSite As String,nPos As Integer) As String   
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select sequence from telemetry_log_table where siteid='" & _
	        strSite & "' and position ='" & nPos & "' order by sequence desc limit 1", nOConn)

   if RS.eof then
		GetLastSequence = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(now))
   else
		GetLastSequence = RS("sequence").value
   end if   
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function GetDistrict(strConn As String,strUser As String,nPos As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select control_district from telemetry_user_table where userid='" & _
	        strUser & "'", nOConn)
   
   if not RS.eof then   
		do until RS.EOF
				Words = RS("control_district").value
				RS.MoveNext
		loop
		Words = Words.Replace(",", "|,|")
   end if
   
   GetDistrict = "|" & Words & "|"
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

    Function Get_Current_Value(strConn As String, strUser As String, nPos As Integer, decimal_points As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select value from telemetry_equip_status_table where siteid='" & _
              strUser & "' and position=" & nPos, nOConn)
   
        If Not RS.eof Then
            If IsDBNull(RS("value").value) Then
                Words = "-"
            Else
                Words = Math.Round(RS("value").value, decimal_points)
            End If
        Else
            Words = "-"
        End If
   
        Get_Current_Value = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

Function Get_Current_Timestamp(GetCOn as String,strConn As String,strUser As String,nPos As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   if GetCOn = 0 Then
    
          RS.open("select sequence from telemetry_equip_status_table where siteid='" & _
         strUser & "' and position=" & nPos, nOConn)

           if not RS.eof then
            If IsDBNull(RS("sequence").value) Then
                Words = "-"
            Else
                Words = RS("sequence").value
            End If
         else
	    	Words = "-"
        end if
   
   else

        RS.open("select dtimestamp from telemetry_equip_status_table where siteid='" & _
         strUser & "' and position=" & nPos, nOConn)
   
        if not RS.eof then
            If IsDBNull(RS("dtimestamp").value) Then
                Words = "-"
            Else
                Words = RS("dtimestamp").value
            End If
        else
	    	Words = "-"
        end if
   
   end if
   Get_Current_Timestamp = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Rainfall_Since_Midnight(strConn As String,strUser As String,nPos As Integer,decimal_points As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select value from telemetry_equip_status_table where siteid='" & _
	        strUser & "' and position=" & nPos, nOConn)
   
   if not RS.eof then
		if IsDBNull(RS("value").value) then
			Words = "-"
		else
			Words = math.round(RS("value").value,decimal_points)
		end if
   else
		Words = "-"
   end if
   
   Rainfall_Since_Midnight = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Get_readings(strConn As String,strSite As String,nPos As Integer,startdate As String,pilih As String) As String
   Dim nOConn
   Dim RS
   Dim Words
   Dim enddate
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   select case pilih
		case "hour"
			enddate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(startdate).AddMinutes(59))
			words = "select avg(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
					" and sequence between '" & startdate & "' and '" & enddate & "'"
		case "day"
			enddate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(startdate).AddMinutes(1439))
			words = "select avg(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
					" and sequence between '" & startdate & "' and '" & enddate & "'"
   end select
   
   RS.open(words, nOConn)   
   
   If IsDBNull(RS("nilai").value)Then
		Get_readings = "-"
   else
		Get_readings = math.round(RS("nilai").value,2)
   end if   
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing   
End Function

Function Get_readings_per_hour(GetCon as integer,strConn As String,strSite As String,nPos As Integer,startdate As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(startdate).AddMinutes(15))
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   if GetCon = 0 then
   
            RS.open("select value  from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
           " and sequence between '" & startdate & "' and '" & enddate & "'", nOConn)
   
        If RS.EOF And RS.BOF Then
            Get_readings_per_hour = "-"
        Else
            Get_readings_per_hour = Math.Round(RS("value").value, 2)
        End If
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing

   else

        RS.open("select value  from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
   " and dtimestamp between '" & startdate & "' and '" & enddate & "'", nOConn)
   
        'If IsDBNull(RS("value").value) = Nothing Then
        '    Get_readings_per_hour = "-"
        'Else
        '    Get_readings_per_hour = Math.Round(RS("value").value, 2)
            'End Ifrf
        If RS.EOF And RS.BOF Then
            Get_readings_per_hour = "-"
        Else
            Get_readings_per_hour = Math.Round(RS("value").value, 2)
        End If
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing

    end if
    End Function

 
    
Function Get_RF_per_hour(strConn As String,strSite As String,nPos As Integer,startdate As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(startdate).AddMinutes(59))
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select avg(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
			" and sequence between '" & startdate & "' and '" & enddate & "'", nOConn)   
   
   If IsDBNull(RS("nilai").value)Then
		Get_RF_per_hour = "-"
   else			
		Get_RF_per_hour = math.round(RS("nilai").value,1)
   end if   
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Get_readings_maxoravg(strConn As String,strsite as String,nPos As Integer) As Double
   Dim nOConn
   Dim RS
   Dim Words
  
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
 
		
			words = "select value as nilai from telemetry_equip_status_table where siteid='" & strSite & "' and position=" & nPos 
					
   
   RS.open(words, nOConn)   
   
   if not RS.EOF then
'	   If IsDBNull(RS("nilai").value)Then
'			Get_readings_maxoravg = "-"
'	   else
			Get_readings_maxoravg = math.round(RS("nilai").value,2)
'	   end if
   else
		Get_readings_maxoravg = "0"
   end if
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Get_daily_RF(strConn As String,strSite As String,nPos As Integer,startdate As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(startdate).AddHours(24))
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select sum(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
			" and sequence between '" & startdate & "' and '" & enddate & "'", nOConn)   
   
   If IsDBNull(RS("nilai").value)Then
		Get_daily_RF = "-"
   else	
		Get_daily_RF = FormatNumber(math.round(RS("nilai").value,1),1,0,0,0)
   end if   
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function GetSite(strConn As String,str As String,nPos As Integer) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select siteid from telemetry_site_list_table where sitedistrict IN (" & _
	        str & ")", nOConn)

   do until RS.EOF
		Words = Words & "," & RS("siteid").value
		RS.MoveNext
   loop
   
   GetSite = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function GetSiteName(strConn As String,str As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select sitename from telemetry_site_list_table where siteid='" & _
	        str & "'", nOConn)

   if not RS.eof then
		Words = UCase(RS("sitename").value)
   else
		Words = ""
   end if   
   
   GetSiteName = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function GetSIM(strConn As String,strSite As String) As String
   Dim nOConn
   Dim RS
   Dim unitid
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
		
			RS.Open("select unitid from telemetry_site_list_table where siteid='" & strSite & "'",nOConn)
   			if not RS.EOF then
				unitid = RS("unitid").value
			else
				unitid = ""
			end if

			RS.close
			
			RS.Open("select simno from unit_list where unitid='" & unitid & "'",nOConn)
   			if not RS.EOF then
				GetSIM = RS("simno").value
			else
				GetSIM = ""
			end if

			RS.close
			
			nOConn.close
			RS = nothing
			nOConn = nothing
   
End Function

Function GetURL4SiteType(strConn As String,str As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select sitetype from telemetry_site_list_table where siteid='" & _
	        str & "'", nOConn)

   if not RS.eof then
		Words = RS("sitetype").value
   else
		Words = ""
   end if
   
   select case Words
		case "LEVEL"
			GetURL4SiteType = "datatable_lvl.aspx"
		case "LEVEL_RAIN"
			GetURL4SiteType = "datatable_lvlrf.aspx"
		case "RAIN"
			GetURL4SiteType = "datatable_rf.aspx"
		case else
			GetURL4SiteType = "dummy.aspx"
   end select   
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function

Function Format_Full_Time(str As String,options As Integer)
	select case options
		case 1
			Format_Full_Time = String.Format("{0:HH:mm}",Date.Parse(str))
		case 2
			Format_Full_Time = String.Format("{0:dd/MM/yyyy}",Date.Parse(str))
		case 3
			Format_Full_Time = String.Format("{0:dd/MM/yyyy HH:mm}",Date.Parse(str))
		case else
			Format_Full_Time = String.Format("{0:dd/MM}",Date.Parse(str))
	end select
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
