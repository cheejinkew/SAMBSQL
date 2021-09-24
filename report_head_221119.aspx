<script language="VB" runat="server">
      
Function GetLastSequence(strConn As String,strSite As String,nPos As Integer) As String   
   Dim nOConn
   Dim RS
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
        RS.open("select dtimestamp from telemetry_equip_status_table where siteid='" & _
         strSite & "' and position ='" & nPos & "'", nOConn)

   if RS.eof then
            GetLastSequence = "-"
   else
            GetLastSequence = Format(RS("dtimestamp").value, "dd/MM/yyyy HH:mm:ss")
   end if   
   
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
                Words = Math.Round(RS("value").value, 2)
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
    Function Get_Current_Value_Flow(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
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
                Words = Math.Round(RS("value").value, 2) & "m^3/hour"
            End If
        Else
            Words = "-"
        End If
   
        Get_Current_Value_Flow = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function
    Function Get_Current_Value_Total(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
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
                Words = Math.Round(RS("value").value, 2) & "m^3"
            End If
        Else
            Words = "-"
        End If
   
        Get_Current_Value_Total = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function
    Function Get_Current_Value_summary(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select value from telemetry_equip_status_table where siteid='" & _
              strUser & "' and position=" & nPos, nOConn)
   
        If Not RS.eof Then
            Words = Math.Round(RS("value").value, 2)
        Else
            Words = "-"
        End If
   
        Get_Current_Value_summary = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function
    Function Get_Current_sequence_summary(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
   
        RS.open("select dtimestamp from telemetry_equip_status_table where siteid='" & _
              strUser & "' and position=" & nPos, nOConn)
   
        If RS.eof Then
            Words = "-"
        Else
            Words = Format(RS("dtimestamp").value, "dd/MM/yyyy HH:mm:ss")
        End If
                  
        Get_Current_sequence_summary = Words
   
        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function
</script>