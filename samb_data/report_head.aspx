<script language="VB" runat="server">
Function makeHTMLHeader_Open()
	Dim txt As String
        txt = "<!DOCTYPE html PUBLIC " & Chr(34) & "-//W3C//DTD XHTML 1.0 Transitional//EN" & Chr(34) & _
              vbCrLf & Chr(34) & "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" & Chr(34) & ">" & _
           "<html xmlns=" & Chr(34) & "http://www.w3.org/1999/xhtml" & Chr(34) & ">" & _
           "<head><title></title>" & vbCrLf
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
   
   RS.open("select top1 dtimestamp from telemetry_log_table where siteid='" & _
	        strSite & "' and position ='" & nPos & "' order by dtimestamp desc", nOConn)

   if RS.eof then
		GetLastSequence = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(now))
   else
		GetLastSequence = RS("dtimestamp").value
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

Function Get_Current_Value(strConn As String,strUser As String,nPos As Integer,decimal_points As Integer) As String   
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
   
   Get_Current_Value = Words
   
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
					" and dtimestamp between '" & startdate & "' and '" & enddate & "'"
		case "day"
			enddate = String.Format("{0:yyyy/MM/dd HH:mm}",Date.Parse(startdate).AddMinutes(1439))
			words = "select avg(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
					" and dtimestamp between '" & startdate & "' and '" & enddate & "'"
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

    Function Get_readings_per_hour(ByVal strConn As String, ByVal strSite As String, ByVal nPos As Integer, ByVal startdate As String, ByVal stype As String) As String
        Dim nOConn
        Dim RS
        Dim Words
        Dim enddate = String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(startdate).AddMinutes(-30))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim t = "select top 1 tl.value  from telemetry_log_table tl, telemetry_site_list_table ts where tl.siteid='" & strSite & "' and  tl.siteid=ts.siteid and ts.sitetype='" & stype & "' and position=" & nPos & _
        " and dtimestamp between '" & enddate & "' and '" & startdate & "' order by dtimestamp desc"
        RS.open(t, nOConn)
   
        'If IsDBNull(RS("value").value) = Nothing Then
        '    Get_readings_per_hour = "-"
        'Else
        '    Get_readings_per_hour = Math.Round(RS("value").value, 2)
        'End If
        If RS.EOF And RS.BOF Then
            
            Get_readings_per_hour = "No"
            
        Else
            Get_readings_per_hour = "Yes"
        End If
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function
    
   
    Function Get_Current_Time_Stamp(ByVal strConn As String, ByVal strSite As String, ByVal nPos As Integer, ByVal startdate As String, ByVal stype As String) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        RS.open("select current_timestamp as flag", nOConn)
        Get_Current_Time_Stamp = RS("flag").value
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function

    
    Function Get_readings_latest(ByVal strConn As String, ByVal strSite As String, ByVal nPos As Integer) As String
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strconn)
   
        RS.open("select top 1 dtimestamp  from telemetry_equip_status_table where siteid='" & strSite & "' and position=" & nPos & _
   " order by dtimestamp ", nOConn)
   
        
        If RS.EOF And RS.BOF Then
            Get_readings_latest = "-"
        Else
            Get_readings_latest = RS("dtimestamp").value
        End If
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function
    
    
    Function get_unitid(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
      
        RS.open("select top 1 unitid  from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
    
        If RS.EOF And RS.BOF Then
            get_unitid = "0000"
            
        Else
            get_unitid = RS("unitid").value
        End If
        nOConn.close()
        nOConn = Nothing
    End Function
    
    Function get_Simunitid(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
      
        RS.open("select top 1 unitid  from unit_list where simno in('" & strSite & "','+6019" & strSite & "') ", nOConn)
    
        If RS.EOF And RS.BOF Then
            get_Simunitid = "0000"
            
        Else
            get_Simunitid = RS("unitid").value
        End If
        nOConn.close()
        nOConn = Nothing
    End Function
    Function get_SimNo(ByVal strConn As String, ByVal strSite As String) As String
        Dim unitid
        unitid = get_unitid(strConn, strSite)
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim text = "select simno from unit_list where unitid='" & unitid & "'"
        RS.open(text, nOConn)
           
        If RS.EOF And RS.BOF Then
            get_SimNo = "+6019"
            
        Else
            Dim simno = RS("simno").value
            If simno.Length() < 8 Then
                get_SimNo = simno.Concat("+6019", simno)
            Else
                get_SimNo = simno
            End If
            
            'If Not simno.StartsWith("+6019") Then
            '    get_SimNo = simno.Concat("+6019", simno)
            'Else
            '    get_SimNo = simno
            'End If
            
        End If
        nOConn.close()
        nOConn = Nothing
    End Function
    Function get_Remark(ByVal strConn As String, ByVal strSite As String) As String
        
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim text = "select comment from telemetry_remarks where siteid='" & strSite & "'"
        RS.open(text, nOConn)
           
        If RS.EOF And RS.BOF Then
            get_Remark = "-"
            
        Else
            
            get_Remark = RS("comment").value
          
        End If
            
        nOConn.close()
        nOConn = Nothing
        
    End Function
    Sub set_Remark(ByVal strConn As String, ByVal strSimno As String, ByVal remark As String)
        
        Dim nOConn
       
        Dim strSite = get_SiteId(strConn, strSimno)
        nOConn = New ADODB.Connection()
        'RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim text = "update telemetry_remarks set comment='" & remark & "' where siteid='" & strSite & "'"
        nOConn.Execute(text)
        nOConn.close()
        nOConn = Nothing
        
    End Sub
    Sub set_SiteIdRemark(ByVal strConn As String, ByVal strSite As String, ByVal remark As String)
        
        Dim nOConn
       
        ' Dim strSite = get_SiteId(strConn, strSimno)
        nOConn = New ADODB.Connection()
        'RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim text = "update telemetry_remarks set comment='" & remark & "' where siteid='" & strSite & "'"
        nOConn.Execute(text)
        nOConn.close()
        nOConn = Nothing
        
    End Sub
    Function get_SiteId(ByVal strConn As String, ByVal strSimno As String) As String
        Dim unitid
        strSimno = strSimno.Substring(5)
        unitid = get_Simunitid(strConn, strSimno)
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim text = "select top 1 siteid  from telemetry_site_list_table where unitid='" & unitid & "' "
        RS.open(text, nOConn)
       
        get_SiteId = RS("siteid").value
        nOConn.close()
        nOConn = Nothing
        
    End Function
        
    Function get_datastring(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        ' Dim Words
        ' Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-15))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
                
        RS.open("select top 1 data  from gprs_inbox_table where unitid='" & strSite & "' order by dtimestamp", nOConn)
   
        
        If RS.EOF And RS.BOF Then
            get_datastring = "-"
        Else
            get_datastring = RS("data").value
        End If
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function
    Function Get_RF_per_hour(ByVal strConn As String, ByVal strSite As String, ByVal nPos As Integer, ByVal startdate As String) As String
        Dim nOConn
        Dim RS
        Dim Words
        Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(59))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select avg(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
        " and dtimestamp between '" & startdate & "' and '" & enddate & "'", nOConn)
   
        If IsDBNull(RS("nilai").value) Then
            Get_RF_per_hour = "-"
        Else
            Get_RF_per_hour = Math.Round(RS("nilai").value, 1)
        End If
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

    Function Get_readings_maxoravg(ByVal strConn As String, ByVal strsite As Integer, ByVal nPos As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
  
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
 
		
        Words = "select value as nilai from telemetry_equip_status_table where siteid='" & strsite & "' and position=" & nPos
					
   
        RS.open(Words, nOConn)
   
        If RS.EOF Then
            Get_readings_maxoravg = "-"
        Else
            Get_readings_maxoravg = Math.Round(RS("nilai").value, 2)
        End If
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

    Function Get_daily_RF(ByVal strConn As String, ByVal strSite As String, ByVal nPos As Integer, ByVal startdate As String) As String
        Dim nOConn
        Dim RS
        Dim Words
        Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddHours(24))
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select sum(value) as nilai from telemetry_log_table where siteid='" & strSite & "' and position=" & nPos & _
        " and dtimestamp between '" & startdate & "' and '" & enddate & "'", nOConn)
   
        If IsDBNull(RS("nilai").value) Then
            Get_daily_RF = "-"
        Else
            Get_daily_RF = FormatNumber(Math.Round(RS("nilai").value, 1), 1, 0, 0, 0)
        End If
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

    Function GetSite(ByVal strConn As String, ByVal str As String, ByVal nPos As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select siteid from telemetry_site_list_table where sitedistrict IN (" & _
              str & ")", nOConn)

        Do Until RS.EOF
            Words = Words & "," & RS("siteid").value
            RS.MoveNext()
        Loop
   
        GetSite = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

    Function GetSiteName(ByVal strConn As String, ByVal str As String) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select sitename from telemetry_site_list_table where siteid='" & _
              str & "'", nOConn)

        If Not RS.eof Then
            Words = UCase(RS("sitename").value)
        Else
            Words = ""
        End If
   
        GetSiteName = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

    Function GetURL4SiteType(ByVal strConn As String, ByVal str As String) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select sitetype from telemetry_site_list_table where siteid='" & _
              str & "'", nOConn)

        If Not RS.eof Then
            Words = RS("sitetype").value
        Else
            Words = ""
        End If
   
        Select Case Words
            Case "LEVEL"
                GetURL4SiteType = "datatable_lvl.aspx"
            Case "LEVEL_RAIN"
                GetURL4SiteType = "datatable_lvlrf.aspx"
            Case "RAIN"
                GetURL4SiteType = "datatable_rf.aspx"
            Case Else
                GetURL4SiteType = "dummy.aspx"
        End Select
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
   
    End Function

    Function Format_Full_Time(ByVal str As String, ByVal options As Integer)
        Select Case options
            Case 1
                Format_Full_Time = String.Format("{0:HH:mm}", Date.Parse(str))
            Case 2
                Format_Full_Time = String.Format("{0:dd/MM/yyyy}", Date.Parse(str))
            Case 3
                Format_Full_Time = String.Format("{0:dd/MM/yyyy }", Date.Parse(str))
            Case Else
                Format_Full_Time = String.Format("{0:dd/MM}", Date.Parse(str))
        End Select
    End Function

    Function Format_Time_Parse(ByVal str As String, ByVal options As Integer)
        Select Case options
            Case 1
                Format_Time_Parse = String.Format("{0:HH:mm}", Date.Parse(str))
            Case 2
                Format_Time_Parse = String.Format("{0:yyyy/MM/dd}", Date.Parse(str))
            Case Else
                Format_Time_Parse = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(str))
        End Select
    End Function
    Sub btn_Submit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim constr
        constr = ConfigurationSettings.AppSettings("DSNPG1")
        
        Try
            set_Remark(constr, txt_simno.value, txt_comment.value)
            txt_simno.value = ""
            txt_comment.value = ""
            lbl_error.Text = ""
          
        Catch ex As Exception
            lbl_error.Text = "Comment Not Updated Check The SimNo"
           
        End Try
       
    End Sub
   
</script>
