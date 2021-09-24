Imports System.Data, System.Data.Odbc, ADODB

Partial Class dailySummary1
    Inherits System.Web.UI.Page
    Public StrSiteId As String
    Public StrSiteName As String
    Public lab As String
    Public rk
    Public strConn = ConfigurationSettings.AppSettings("DSNPG")
    'Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        StrSiteName = Request.QueryString("sitename")
        StrSiteId = Request.QueryString("siteid")
        lab = Request.QueryString("lab")

        If Page.IsPostBack = False Then
            Dim i As Integer
            For i = 1 To 12
                dd2.Items.Add(New ListItem(i, i))
                dd5.Items.Add(New ListItem(i, i))
            Next
            Dim j As Integer
            For j = 2005 To Now.Year()
                dd1.Items.Add(New ListItem(j, j))
                dd4.Items.Add(New ListItem(j, j))
            Next
            Dim k As Integer
            For k = 1 To 31
                dd3.Items.Add(New ListItem(k, k))
                dd6.Items.Add(New ListItem(k, k))
            Next
        End If

        If opt1.Checked = False Then
            Dim dt As New DataTable
            Dim dr As OdbcDataReader
            Dim RW As DataRow


            dt.Columns.Add("Date")
            dt.Columns.Add("Min Flow Rate (m3 /h)")
            dt.Columns.Add("Max Flow Rate (m3 /h)")
            dt.Columns.Add("Total Inflow (m3)")
            'dt.Columns.Add("Min pressure(bar)")
            'dt.Columns.Add("Max pressure(bar)")
            dt.Columns.Add("Trending")

            'If GetSiteComment(strConn, StrSiteId) = "TM SERVER" Then
            '    strConn = TM_Conn
            'End If


            Dim con As New OdbcConnection(strConn)

            Dim str As String = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,position FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "')  and position='2'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position order by sequence desc "
            con.Open()
            Dim cmd As New OdbcCommand(str, con)
            dr = cmd.ExecuteReader()
            Dim i As Integer
            For i = 1 To 15
                If dr.Read() = True Then
                    RW = dt.NewRow()
                    RW(0) = dr(0)
                    RW(1) = dr(1)
                    RW(2) = dr(2)
                    RW(3) = dr(3)
                    'RW(4) = "0"
                    'RW(5) = "0"
                    RW(4) = "<a href='DailyTrendDetails.aspx?date=" & dr(0) & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Graphical</a>" & "  " & "<a href='DailyDetailsOne.aspx?date=" & dr(0) & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Tabular</a>"
                    dt.Rows.Add(RW)
                End If
            Next
            con.Close()

            'If GetSiteComment(strConn, StrSiteId) = "TM SERVER" Then
            '    strConn = TM_Conn
            'End If

            'Dim objConn
            'Dim str2
            'objConn = New ADODB.Connection()
            'str2 = New ADODB.Recordset()
            'objConn.open(strConn)
            'str2.open("select max(value)as press1,min(value) as press2 from telemetry_log_table where (siteid = '" & StrSiteId & "') and position='1'", objConn)
            'rk = str2("press1").value
            'str2.close()
            'objConn.close()

            'If IsDBNull(rk) = False Then
            '    If rk >= 0 Then
            '        str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            '        con.Open()
            '        cmd = New OdbcCommand(str, con)
            '        dr = cmd.ExecuteReader()
            '        Dim count As Int16 = 0
            '        For i = 1 To 15
            '            If dr.Read() = True Then
            '                dt.Rows(count)(4) = dr(4)
            '                dt.Rows(count)(5) = dr(5)
            '            End If
            '            count += 1
            '        Next
            '    Else
            '        str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            '        con.Open()
            '        cmd = New OdbcCommand(str, con)
            '        dr = cmd.ExecuteReader()
            '        Dim count As Int16 = 0
            '        For i = 1 To 15
            '            If dr.Read() = True Then
            '                dt.Rows(count)(4) = ""
            '                dt.Rows(count)(5) = ""
            '            End If
            '            count += 1
            '        Next
            '        Text1.Text = "Pressure Is Not Hosted"

            '    End If
            'Else
            '    str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            '    con.Open()
            '    cmd = New OdbcCommand(str, con)
            '    dr = cmd.ExecuteReader()
            '    Dim count As Int16 = 0
            '    For i = 1 To 15
            '        If dr.Read() = True Then
            '            dt.Rows(count)(4) = ""
            '            dt.Rows(count)(5) = ""
            '        End If
            '        count += 1
            '    Next
            '    Text1.Text = "Pressure Is Not Hosted"

            'End If
            'con.Close()

            Me.GridView1.DataSource = dt
            GridView1.DataBind()


            If Me.GridView1.Rows.Count = 0 Then
                Text1.Visible = False
                imgdata.Visible = True
                Label2.Visible = False
            ElseIf GridView1.Rows.Count > 0 Then
                imgdata.Visible = False
                Label2.Visible = True
            End If
            dd1.Text = Now.Year()
            dd2.Text = Now.Month()
            dd3.Text = Now.Day()
            dd4.Text = Now.Year()
            dd5.Text = Now.Month()
            dd6.Text = Now.Day()
        End If

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        If opt1.Checked = True Then
            Dim begindate As String
            Dim enddate As String
            begindate = dd1.SelectedValue & " / " & dd2.SelectedValue & " / " & dd3.SelectedValue
            Dim s As Date = begindate
            Dim a As String = s.Day
            Dim b As String = s.Month
            If b.Length = 2 Then
                If a.Length = 1 Then
                    begindate = dd1.SelectedValue & " / " & dd2.SelectedValue & " / " & "0" & dd3.SelectedValue & " " & "00:00:00"
                Else
                    begindate = dd1.SelectedValue & " / " & dd2.SelectedValue & " / " & dd3.SelectedValue & " " & "00:00:00"
                End If
            ElseIf a.Length = 1 Then
                begindate = dd1.SelectedValue & " / " & "0" & dd2.SelectedValue & " / " & "0" & dd3.SelectedValue & " " & "00:00:00"
            ElseIf a.Length = 2 Then
                begindate = dd1.SelectedValue & " / " & "0" & dd2.SelectedValue & " / " & dd3.SelectedValue & " " & "00:00:00"
            End If

            enddate = dd4.SelectedValue & " / " & dd5.SelectedValue & " / " & dd6.SelectedValue
            Dim r As Date = enddate
            Dim c As String = r.Day
            Dim d As String = r.Month

            If d.Length = 2 Then
                If c.Length = 1 Then
                    enddate = dd4.SelectedValue & " / " & dd5.SelectedValue & " / " & "0" & dd6.SelectedValue & " " & "23:59:59"
                Else
                    enddate = dd4.SelectedValue & " / " & dd5.SelectedValue & " / " & dd6.SelectedValue & " " & "23:59:59"
                End If
            ElseIf c.Length = 1 Then
                enddate = dd4.SelectedValue & " / " & "0" & dd5.SelectedValue & " / " & "0" & dd6.SelectedValue & " " & "23:59:59"
            ElseIf c.Length = 2 Then
                enddate = dd4.SelectedValue & " / " & "0" & dd5.SelectedValue & " / " & dd6.SelectedValue & " " & "23:59:59"
            End If

            Dim dt As New DataTable
            Dim dr As OdbcDataReader
            Dim RW As DataRow
            dt.Columns.Add("Date")
            dt.Columns.Add("Min Flow Rate (m3 /h)")
            dt.Columns.Add("Max Flow Rate (m3 /h)")
            dt.Columns.Add("Total Inflow (m3)")
            'dt.Columns.Add("Min pressure(bar)")
            'dt.Columns.Add("Max pressure(bar)")
            dt.Columns.Add("Trending")

            'If GetSiteComment(strConn, StrSiteId) = "TM SERVER" Then
            '    strConn = TM_Conn
            'End If

            Dim con As New OdbcConnection(strConn)

            Dim str As String = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,position FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and  sequence between '" & begindate & "' and '" & enddate & "' and position='2'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position order by sequence desc"
            con.Open()
            Dim cmd As New OdbcCommand(str, con)
            dr = cmd.ExecuteReader()
            While (dr.Read())
                RW = dt.NewRow()
                RW(0) = dr(0)
                RW(1) = dr(1)
                RW(2) = dr(2)
                RW(3) = dr(3)
                'RW(4) = "0"
                'RW(5) = "0"
                RW(4) = "<a href='DailyTrendDetails.aspx?date=" & dr(0) & "&minFlow=" & dr(1) & "&maxFlow=" & dr(2) & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Graphical</a>" & "  " & "<a href='dailydetailsone.aspx?date=" & dr(0) & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Tabular</a>"
                dt.Rows.Add(RW)
            End While
            con.Close()

            ' ''If GetSiteComment(strConn, StrSiteId) = "TM SERVER" Then
            ' ''    strConn = TM_Conn
            ' ''End If

            'Dim objConn
            'Dim str2
            'objConn = New ADODB.Connection()
            'str2 = New ADODB.Recordset()
            'objConn.open(strConn)
            'str2.open("select max(value)as press1,min(value) as press2 from telemetry_log_table where (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate & "' and position='1'", objConn)
            'rk = str2("press1").value
            'str2.close()
            'objConn.close()

            'If IsDBNull(rk) = False Then
            '    If rk >= 0 Then
            '        str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate & "' and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            '        con.Open()
            '        cmd = New OdbcCommand(str, con)
            '        dr = cmd.ExecuteReader()
            '        Dim count As Int16 = 0
            '        While (dr.Read())
            '            dt.Rows(count)(4) = dr(4)
            '            dt.Rows(count)(5) = dr(5)
            '            count += 1
            '        End While
            '    Else
            '        str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate & "' and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            '        con.Open()
            '        cmd = New OdbcCommand(str, con)
            '        dr = cmd.ExecuteReader()
            '        Dim count As Int16 = 0
            '        While (dr.Read())
            '            dt.Rows(count)(4) = ""
            '            dt.Rows(count)(5) = ""
            '            count += 1
            '        End While
            '        Text1.Text = "Pressure Is Not Hosted"
            '        'Response.Write("Pressure Is Not Hosted")
            '    End If
            'Else
            '    str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate & "' and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            '    con.Open()
            '    cmd = New OdbcCommand(str, con)
            '    dr = cmd.ExecuteReader()
            '    Dim count As Int16 = 0
            '    While (dr.Read())
            '        dt.Rows(count)(4) = ""
            '        dt.Rows(count)(5) = ""
            '        count += 1
            '    End While
            '    Text1.Text = "Pressure Is Not Hosted"
            '    'Response.Write("<b>Pressure IsNot Hosted</b>")
            'End If




            ' ''str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate & "' and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence desc"
            ' ''con.Open()
            ' ''cmd = New OdbcCommand(str, con)
            ' ''dr = cmd.ExecuteReader()
            ' ''Dim count As Int16 = 0
            ' ''While (dr.Read())
            ' ''    Dim j As Integer = dr(4)
            ' ''    Dim k As Integer = dr(5)
            ' ''    If Val(j) <= 0 Then
            ' ''        dt.Rows(count)(4) = "Preasure is Not Hosted"
            ' ''        dt.Rows(count)(5) = "Preasure is Not Hosted"
            ' ''    Else
            ' ''        dt.Rows(count)(4) = dr(4)
            ' ''        dt.Rows(count)(5) = dr(5)
            ' ''    End If
            ' ''    'dt.Rows(count)(4) = dr(4)
            ' ''    'dt.Rows(count)(5) = dr(5)
            ' ''    count += 1
            ' ''End While
            ' ''con.Close()

            Me.GridView1.DataSource = dt
            GridView1.DataBind()

            If Me.GridView1.Rows.Count = 0 Then
                imgdata.Visible = True
                Label2.Visible = False
                Text1.Visible = False
            ElseIf GridView1.Rows.Count > 0 Then
                imgdata.Visible = False
                Label2.Visible = False
            End If
        End If
        opt1.Checked = False
    End Sub

    'Function GetSiteComment(ByVal strConn As String, ByVal strSite As String) As String
    '    Dim nOConn
    '    Dim RS
    '    nOConn = New ADODB.Connection()
    '    RS = New ADODB.Recordset()
    '    nOConn.open(strConn)

    '    RS.Open("select address from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
    '    If Not RS.EOF Then
    '        If IsDBNull(RS("address").value) = False Then
    '            GetSiteComment = Server.HtmlEncode(RS("address").value)
    '        Else
    '            GetSiteComment = ""
    '        End If
    '    Else
    '        GetSiteComment = ""
    '    End If


    '    RS.close()
    '    nOConn.close()
    '    RS = Nothing
    '    nOConn = Nothing

    'End Function
End Class
