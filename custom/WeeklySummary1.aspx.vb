Imports System.Data
Imports ADODB
Imports System.Data.Oledb, System.Data.Odbc

Partial Class WeeklySummary1
    Inherits System.Web.UI.Page
    Public arrylist As New ArrayList()
    Public StrSiteId As String
    Public StrSitename As String
    Public strConn = ConfigurationSettings.AppSettings("DSNPG")
    'Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim dis = Request.QueryString("root")
        StrSitename = Request.QueryString("sitename")
        StrSiteId = Request.QueryString("siteid")

        Dim dt As New DataTable
        Dim dr As OdbcDataReader
        Dim dr3 As OdbcDataReader
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


        Dim str As String = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,position FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and to_char(sequence,'D')='7' and position='2'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position order by sequence desc "
        con.Open()
        Dim cmd As New OdbcCommand(str, con)
        dr = cmd.ExecuteReader()
        Dim i As New Integer
        For i = 1 To 10
            If dr.Read() = True Then
                arrylist.Add(dr(0))
            End If
        Next
        con.Close()
        Dim s = 0
        For i = 0 To arrylist.Count - 1
            Dim enddate = arrylist(i)
            Dim chdate As New Date
            chdate = enddate
            Dim bdate = chdate.AddDays(-6)
            Dim edate = chdate.AddDays(6)
            Dim begindate ' = chdate.Year & "/" & chdate.Month & "/" & bdate
            Dim enddate2 '= chdate.Year & "/" & chdate.Month & "/" & edate
            begindate = String.Format("{0:yyyy/MM/dd 00:00:00}", Date.Parse(enddate))
            enddate = String.Format("{0:yyyy/MM/dd}", Date.Parse(bdate))
            enddate2 = String.Format("{0:yyyy/MM/dd 23:59:59}", Date.Parse(edate))
            Dim con13 As New OdbcConnection(strConn)
            Dim st1 As String = "select min(minval),max(maxval),sum(TotVal) from (SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate2 & "' and position='2'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position)t1 "
            'Dim st1 As String = "select sequence,min(minval),max(maxval),sum(TotVal) from (SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MIN(value) AS maxpressure,position FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & begindate & "' and '" & enddate2 & "' and position='2'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position)t1 group by t1.sequence order by t1.sequence desc "
            con13.Open()
            Dim cmd13 As New OdbcCommand(st1, con13)
            dr3 = cmd13.ExecuteReader()
            RW = dt.NewRow()
            'For s = 0 To arrylist.Count - 1
            If dr3.Read() = True Then
                RW(0) = arrylist(i)
                RW(1) = dr3(0)
                RW(2) = dr3(1)
                RW(3) = dr3(2)
                ' RW(4) = "0"
                ' RW(5) = "0"
                RW(4) = "<a href='DailyTrendDetails.aspx?date=" & arrylist(i) & "&Ndays=" & 6 & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'/>Graphical</a>" & "  " & "<a href='WeekDaily.aspx?date=" & arrylist(i) & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'/>Tabular</a>"
                dt.Rows.Add(RW)
            End If
            'Next
            con13.Close()
            s += 1
        Next

        'Dim count As Int16 = 0
        'For i = 0 To arrylist.Count - 1
        '    Dim enddate1 = arrylist(i)
        '    Dim chdate1 As New Date
        '    chdate1 = enddate1
        '    Dim bdate1 = chdate1.AddDays(-6)
        '    Dim edate1 = chdate1.AddDays(6)
        '    Dim begindate1 ' = chdate.Year & "/" & chdate.Month & "/" & bdate
        '    Dim enddate12 '= chdate.Year & "/" & chdate.Month & "/" & edate
        '    begindate1 = String.Format("{0:yyyy/MM/dd}", Date.Parse(bdate1))
        '    enddate1 = String.Format("{0:yyyy/MM/dd 00:00:00}", Date.Parse(enddate1))
        '    enddate12 = String.Format("{0:yyyy/MM/dd 23:59:59}", Date.Parse(edate1))
        '    Dim con3 As New OdbcConnection(strConn)
        '    Dim st As String = "select min(minval),max(maxval),sum(TotVal),min(minpressure),max(maxpressure) from (SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and sequence between '" & enddate1 & "' and '" & enddate12 & "' and position='1'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position)t1"
        '    con3.Open()
        '    Dim cmd3 As New OdbcCommand(st, con3)
        '    dr3 = cmd3.ExecuteReader()
        'If dr3.Read() = True Then
        '    dt.Rows(count)(4) = dr3(3)
        '    dt.Rows(count)(5) = dr3(4)
        'End If
        '    con3.Close()
        '    count += 1
        'Next

        Me.GridView1.DataSource = dt
        GridView1.DataBind()
        If Me.GridView1.Rows.Count = 0 Then
            imgdata.Visible = True
            Label2.Visible = False
        ElseIf GridView1.Rows.Count > 0 Then
            imgdata.Visible = False
            Label2.Visible = True
        End If

        ''Dim str As String = "SELECT MIN(value) as minval, MAX(value) as maxval, (round(cast(SUM(value) as numeric),3)) as TotVal, to_char(sequence, 'yyyy/mm/dd') as sequence FROM telemetry_log_table WHERE siteid = '" & StrSiteId & "' and to_char(sequence,'D')='7' group by to_char(sequence,'yyyy/mm/dd') order by to_char(sequence,'yyyy/mm/dd')"
        ''SqlDataSource1.SelectCommand = str
        ''Me.GridView1.DataSourceID = "SqlDataSource1"
        ''If GridView1.Rows.Count = 0 Then
        ''    imgdata.Visible = True
        ''Else
        ''    imgdata.Visible = False
        ''End If
        ''Response.Write(StrSitename)

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
