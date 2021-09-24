<%@ Page Language="VB" Debug="true" %>

<% Response.ContentType = "text/xml"%>
<script language="VB" runat="server">

    Function Get_Status(strConn As String, strSite As String, nPos As Integer, nvalue As String) As String
        Dim nOConn
        Dim RS
        Dim Words, Status
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)
        Dim nColor = "000080"
        Dim nBottom, nTop, nStatus
        Dim value

        If Not nvalue = "-" Then
            value = Convert.ChangeType(Trim(nvalue), GetType(Double))
	   
            RS.open("select alarmtype,multiplier,colorcode from telemetry_rule_list_table where siteid='" & _
              strSite & "' and position=" & nPos & " order by sequence asc", nOConn)

            If Not RS.eof Then
                Do While Not RS.EOF
                    If Not IsDBNull(RS("multiplier").value) Then
                        Words = RS("multiplier").value
                        Words = Split(Words, ";")
                        If Words(0) = "RANGE" Then
                            nBottom = Convert.ChangeType(Words(1), GetType(Double))
                            nTop = Convert.ChangeType(Words(2), GetType(Double))
                            If value >= nBottom And value <= nTop Then
                                nStatus = RS("alarmtype").value
                                'nColor = RS("colorcode").value
                                Select Case nStatus
                                    Case "HH"
                                        nColor = "FF0000"
                                    Case "H"
                                        nColor = "FF8C00"
                                    Case "NN"
                                        nColor = "00BFFF"
                                    Case "L"
                                        nColor = "D87093"
                                    Case "LL"
                                        nColor = "CD853F"
                                End Select
                            End If
                        End If
                    End If
                    RS.MoveNext()
                Loop
            End If

		
            RS.close()
        End If

        Get_Status = " status=" & Chr(34) & nStatus & Chr(34) & " color=" & Chr(34) & nColor & Chr(34)

        nOConn.close()
        RS = Nothing
        nOConn = Nothing
    End Function
    
</script>
<%
    Try
        Dim arrSiteID As String = Request.QueryString("lstSiteID")
        arrSiteID = arrSiteID.Substring(0, arrSiteID.Length - 1)
        
        Dim strConn As String = ConfigurationSettings.AppSettings("DSNPG")
        Dim objConn As New ADODB.Connection()
        Dim rsSites As New ADODB.Recordset()
        objConn.Open(strConn)
        
        Dim calculator As Integer = 0
        Dim nstatus As String = ""
        Dim str2parse As String = ""
        
        rsSites.Open("SELECT es.siteid, sl.sitedistrict, sl.sitetype, es.value, es.dtimestamp, sl.sitename FROM telemetry_equip_status_table es left outer join telemetry_site_list_table sl on es.siteid = sl.siteid Where es.siteid in (" & arrSiteID & ") order by siteid", objConn)
        If Not rsSites.EOF Then
            While (Not rsSites.EOF)
                If Not IsDBNull(rsSites("sitename").Value) Then
                    calculator = calculator + 1
                    nstatus = Get_Status(strConn, rsSites("siteid").Value, 2, rsSites("value").Value)
                    str2parse = str2parse & "	<site id=" & Chr(34) & rsSites("siteid").Value & Chr(34) & " district=" & Chr(34) & rsSites("sitedistrict").Value & Chr(34) & " type=" & Chr(34) & rsSites("sitetype").Value & Chr(34) & " value=" & Chr(34) & rsSites("value").Value & Chr(34) & " timestamp=" & Chr(34) & rsSites("dtimestamp").Value & Chr(34) & " " & nstatus & ">" & Server.HtmlEncode(rsSites("sitename").Value) & "</site>" & vbCrLf
                End If
                rsSites.MoveNext()
            End While
        End If
        
        Response.Write("<?xml version=" & Chr(34) & "1.0" & Chr(34) & " ?>" & vbCrLf & "<site_status recordcount=" & Chr(34) & calculator & Chr(34) & ">" & vbCrLf & str2parse & "</site_status>")

    Catch ex As Exception
        Response.Write(ex.Message)
    End Try
%>
