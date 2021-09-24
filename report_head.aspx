<script language="VB" runat="server">

    Function GetLastSequence(strConn As String, strSite As String, nPos As Integer) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.open("select dtimestamp from telemetry_equip_status_table where siteid='" & strSite & "' and position ='" & nPos & "'", nOConn)

        If RS.eof Then
            GetLastSequence = "-"
        Else
            GetLastSequence = Format(RS("dtimestamp").value, "dd/MM/yyyy HH:mm:ss")
        End If

        RS.close
        nOConn.close
        RS = Nothing
        nOConn = Nothing

    End Function

    Function GetLastSequenceM6(strConn As String, strSite As String, nPos As Integer) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.open("select dtimestamp from telemetry_equip_status_table_m6 where siteid='" & _
         strSite & "' and position ='" & nPos & "'", nOConn)

        If RS.eof Then
            GetLastSequenceM6 = "-"
        Else
            GetLastSequenceM6 = Format(RS("dtimestamp").value, "dd/MM/yyyy HH:mm:ss")
        End If

        RS.close
        nOConn.close
        RS = Nothing
        nOConn = Nothing
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

        RS.open("select dtimestamp from telemetry_equip_status_table where siteid='" & strUser & "' and position=" & nPos, nOConn)

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

    Function Get_Current_Value_summary_m6(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.open("select value from telemetry_equip_status_table_m6 where siteid='" & strUser & "' and position=" & nPos, nOConn)

        If Not RS.eof Then
            Words = Math.Round(RS("value").value, 2)
        Else
            Words = "-"
        End If

        Get_Current_Value_summary_m6 = Words

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function

    Function Get_Current_CounterValue_summary_m6(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.open("select counter from telemetry_equip_status_table_m6 where siteid='" & strUser & "' and position=" & nPos, nOConn)

        If Not RS.eof Then
            Words = Math.Round(RS("counter").value, 2)
        Else
            Words = "-"
        End If

        Get_Current_CounterValue_summary_m6 = Words

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function

    Function Get_Current_sequence_summary_m6(ByVal strConn As String, ByVal strUser As String, ByVal nPos As Integer, ByVal decimal_points As Integer) As String
        Dim nOConn
        Dim RS
        Dim Words
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.open("select dtimestamp from telemetry_equip_status_table_m6 where siteid='" & strUser & "' and position=" & nPos, nOConn)

        If RS.eof Then
            Words = "-"
        Else
            Words = Format(RS("dtimestamp").value, "dd/MM/yyyy HH:mm:ss")
        End If

        Get_Current_sequence_summary_m6 = Words

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function

    Function Get_Dam_inoutstatus_m6(ByVal strUser As String) As String
        Dim Words = ""
        Select Case strUser
            Case "DA1M"
                Words = "Outlet"
            Case "DA2M"
                Words = "Outlet"
            Case "DA3M"
                Words = "Outlet"
            Case "DA4M"
                Words = "Inlet"
            Case "DA5M"
                Words = "Outlet"
            Case "DA6M"
                Words = "Inlet"
            Case "DA7M"
                Words = "Outlet"
            Case "DA8M"
                Words = "Inlet"
            Case "DA9M"
                Words = "Outlet"
            Case "DA10"
                Words = "Outlet"
            Case "DA11"
                Words = "Inlet"
            Case "DA12"
                Words = "Inlet"
        End Select
        Get_Dam_inoutstatus_m6 = Words
    End Function

</script>