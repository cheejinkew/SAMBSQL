Imports System.Data.SqlClient
Imports System.Data
Imports System.Collections.Generic

Partial Class overLowerreport
    Inherits System.Web.UI.Page

    Public Query As String = ""

    Public strControlDistrict As String = ""

    Public arryControlDistrict As String()

    Public Shared dbMax As Double = 10

    Public Shared dbRestore As Double = 0

    Public elekw As Double = 0

    Public elekwtariff As Double = 0

    Public flowrate As Double = 0

    Public flowratetariff As Double = 0

    Public Shared dbValue As Double()

    Public Shared dtDate As String()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            txtfromdate.Text = Date.Now.ToString("yyyy/MM/dd")
            txtEnddate.Text = Date.Now.ToString("yyyy/MM/dd")

            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
            Dim cmd As SqlCommand
            Dim ds As New DataSet

            Try
                Dim strQuery As String = "SELECT distinct(sitedistrict) as sitedistrict from telemetry_site_list_table ORDER BY sitedistrict "
                cmd = New SqlCommand(strQuery, conn)
                conn.Open()
                Dim da As SqlDataAdapter
                da = New SqlDataAdapter(cmd)
                da.Fill(ds)
                ddldistrict.DataSource = ds.Tables(0)
                ddldistrict.DataValueField = "sitedistrict"
                ddldistrict.DataTextField = "sitedistrict"
                ddldistrict.DataBind()
                ddldistrict.Items.Insert(0, "Select Site District")
                ddldistrict.Items.Insert(1, "ALL")
                ddldistrict.SelectedValue = "ALL"
            Catch ex As Exception

            End Try
        End If
    End Sub

    Protected Sub ddltype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddltype.SelectedIndexChanged
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand

        Dim ds As New DataSet
        Dim strQuery As String = ""
        Try
            If ddldistrict.SelectedValue = "ALL" And ddltype.SelectedValue = "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where sitetype='RESERVOIR' and sitename is not  NULL order by sitename  "
            ElseIf ddldistrict.SelectedValue = "ALL" And ddltype.SelectedValue <> "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where   sitetype='RESERVOIR' and sitename is not  NULL and  sitetype ='" & ddltype.SelectedValue & "' "
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue = "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where  sitetype='RESERVOIR' and sitename is not  NULL and   sitedistrict='" & ddldistrict.SelectedValue & "'"
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue <> "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where   sitetype='RESERVOIR' and sitename is not  NULL and  sitedistrict='" & ddldistrict.SelectedValue & "' and sitetype ='" & ddltype.SelectedValue & "'"
            End If

            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            Dim da As SqlDataAdapter
            da = New SqlDataAdapter(cmd)
            da.Fill(ds)
            ddlsitename.DataSource = ds.Tables(0)
            ddlsitename.DataValueField = "siteid"
            ddlsitename.DataTextField = "sitename"
            ddlsitename.DataBind()
            ddlsitename.Items.Insert(0, "Select Site Name")
            ddlsitename.Items.Insert(1, "ALL")
            ddlsitename.SelectedValue = "ALL"
        Catch ex As Exception

        End Try
    End Sub

    Public Sub Fill_gvReports()
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim steps As String = "0"
        Dim Con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Try
            Dim strBeginDate As String = Date.Parse(txtfromdate.Text).ToString("yyyy-MM-dd") & " " & ddBeginHour.SelectedValue & ":" & ddBeginMinute.SelectedValue & ":00"
            Dim strEndDate As String = Date.Parse(txtEnddate.Text).ToString("yyyy-MM-dd") & " " & ddendHour.SelectedValue & ":" & ddendMinute.SelectedValue & ":59"

            Dim dt As DataTable = New DataTable()
            dt.Columns.Add("sno")
            dt.Columns.Add("sitename")
            dt.Columns.Add("Fromtime")
            dt.Columns.Add("totime")
            dt.Columns.Add("duration")
            dt.Columns.Add("flowarte")
            dt.Columns.Add("flowtarif")
            dt.Columns.Add("waterloss")
            Dim dtRow As DataRow
            Dim r As DataRow
            Dim totalSpan As TimeSpan = New TimeSpan()
            Dim total1 As Double = 0
            Dim total2 As Double = 0
            Dim total3 As Double = 0
            Dim sno As Integer = 1
            If ddlsitename.SelectedValue = "ALL" Then
                Dim aa As ArrayList = New ArrayList()
                Dim a As ArrayList = New ArrayList()
                steps = aa.Count & ":00"
                ' Response.Write(steps)
                aa = GetSitesList(ddldistrict.SelectedValue)
                Con.Open()
                steps = aa.Count & ":0"
                '  Response.Write(steps)
                For s As Integer = 0 To aa.Count - 1
                    a = aa(s)
                    Dim lstDbValue As List(Of Double) = New List(Of Double)()
                    Dim lstDateTime As List(Of DateTime) = New List(Of DateTime)()
                    Dim llRange As String() = New String(1) {"0", "0"}
                    Dim lRange As String() = New String(1) {"0", "0"}
                    Dim nnRange As String() = New String(1) {"0", "0"}
                    Dim hRange As String() = New String(1) {"0", "0"}
                    Dim hhRange As String() = New String(1) {"0", "0"}
                    Dim dtEvents As DataTable = New DataTable()
                    dtEvents.Columns.Add(New DataColumn("No"))
                    dtEvents.Columns.Add(New DataColumn("DateTime"))
                    dtEvents.Columns.Add(New DataColumn("SiteName"))
                    dtEvents.Columns.Add(New DataColumn("Value"))
                    dtEvents.Columns.Add(New DataColumn("Event"))
                    steps = a(1) & "1"
                    'a  Response.Write(steps)
                    Query = "SELECT max FROM telemetry_equip_list_table WHERE siteid = '" & a(0) & "' AND position = '2'"
                    cmd = New SqlCommand(Query, Con)
                    dr = cmd.ExecuteReader()
                    If dr.Read() Then
                        dbMax = Convert.ToDouble(dr("max").ToString())
                        dr.Close()
                    End If

                    Query = "SELECT ISNULL( outletflowrate,0) outletflowrate, ISNULL(outletflowtariff,0)  outletflowtariff FROM telemetry_tariffdetails_table where siteid='" & a(0) & "'"
                    cmd = New SqlCommand(Query, Con)
                    dr = cmd.ExecuteReader()
                    If dr.Read() Then
                        flowrate = Convert.ToDouble(dr("outletflowrate").ToString())
                        flowratetariff = Convert.ToDouble(dr("outletflowtariff").ToString())
                    End If
                    steps = a(1) & "2"
                    ' Response.Write(steps)
                    Query = "SELECT * FROM telemetry_rule_list_table WHERE siteid = '" & a(0) & "' AND alarmmode = 'EVENT'"
                    cmd = New SqlCommand(Query, Con)
                    dr = cmd.ExecuteReader()
                    While dr.Read()
                        Dim tmpRange As String() = dr("multiplier").ToString().Split(";"c)
                        Select Case dr("alarmtype").ToString()
                            Case "LL"
                                If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                    llRange(0) = tmpRange(1)
                                    llRange(1) = tmpRange(2)
                                Else
                                    llRange(0) = "0"
                                    llRange(1) = "0"
                                End If

                                Exit Select
                            Case "L"
                                If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                    lRange(0) = tmpRange(1)
                                    lRange(1) = tmpRange(2)
                                Else
                                    lRange(0) = "0"
                                    lRange(1) = "0"
                                End If

                                Exit Select
                            Case "NN"
                                If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                    nnRange(0) = tmpRange(1)
                                    nnRange(1) = tmpRange(2)
                                Else
                                    nnRange(0) = "0"
                                    nnRange(1) = "0"
                                End If

                                Exit Select
                            Case "H"
                                If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                    hRange(0) = tmpRange(1)
                                    hRange(1) = tmpRange(2)
                                Else
                                    hRange(0) = "0"
                                    hRange(1) = "0"
                                End If

                                Exit Select
                            Case "HH"
                                If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                    hhRange(0) = tmpRange(1)
                                    hhRange(1) = tmpRange(2)
                                Else
                                    hhRange(0) = "0"
                                    hhRange(1) = "0"
                                End If

                                Exit Select
                            Case Else
                        End Select
                    End While
                    steps = a(1) & "3"
                    ' Response.Write(steps)
                    Query = "SELECT * FROM telemetry_log_table WHERE siteid = '" & a(0) & "' AND position = '2' AND dtimestamp " & "BETWEEN '" + strBeginDate & "' AND '" + strEndDate & "' ORDER BY dtimestamp"
                    cmd = New SqlCommand(Query, Con)
                    dr = cmd.ExecuteReader()
                    While dr.Read()
                        lstDbValue.Add(Convert.ToDouble(dr("value").ToString()))
                        lstDateTime.Add(Convert.ToDateTime(dr("dtimestamp").ToString()))
                    End While

                    dbValue = New Double(lstDbValue.Count - 1) {}
                    dtDate = New String(lstDateTime.Count - 1) {}
                    If lstDbValue.Count > 0 Then
                        dbRestore = lstDbValue(0)
                    Else
                        dbRestore = 0
                    End If

                    For i As Integer = 0 To lstDbValue.Count - 1
                        If Convert.ToDouble(lstDbValue(i)) < dbMax Then
                            dbRestore = lstDbValue(i)
                            i = lstDbValue.Count
                        End If
                    Next

                    For i As Integer = 0 To lstDbValue.Count - 1
                        Dim dbTmp As Double = 0
                        Dim dtTmp As DateTime
                        dbTmp = lstDbValue(i)
                        dtTmp = lstDateTime(i)
                        If i > 0 Then
                            If dtTmp.Subtract(lstDateTime(i - 1)).TotalMinutes <= 20 Then
                                If dbTmp - lstDbValue(i - 1) > 1 OrElse dbTmp - lstDbValue(i - 1) < -1 Then
                                    lstDbValue(i) = lstDbValue(i - 1)
                                End If
                            End If
                        Else
                            If dbTmp > dbMax Then
                                lstDbValue(i) = dbRestore
                            End If

                            If dbTmp > dbMax Then
                                dbMax = dbTmp
                            End If
                        End If

                        dbValue(i) = lstDbValue(i)
                        dtDate(i) = lstDateTime(i).ToString("dd/MM/yyyy hh:mm:ss tt")
                    Next
                    steps = a(1) & "4"
                    '  Response.Write(steps)
                    For i As Integer = 0 To lstDbValue.Count - 1
                        dtRow = dtEvents.NewRow()
                        dtRow("No") = i + 1
                        dtRow("DateTime") = lstDateTime(i).ToString("yyyy/MM/dd HH:mm:ss")
                        dtRow("SiteName") = a(1)
                        dtRow("Value") = lstDbValue(i).ToString("0.00")
                        If lstDbValue(i) >= Convert.ToDouble(llRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(llRange(1)) Then
                            dtRow("Event") = "LL"
                        ElseIf lstDbValue(i) >= Convert.ToDouble(lRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(lRange(1)) Then
                            dtRow("Event") = "L"
                        ElseIf lstDbValue(i) >= Convert.ToDouble(nnRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(nnRange(1)) Then
                            dtRow("Event") = "NN"
                        ElseIf lstDbValue(i) >= Convert.ToDouble(hRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(hRange(1)) Then
                            dtRow("Event") = "H"
                        ElseIf lstDbValue(i) >= Convert.ToDouble(hhRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(hhRange(1)) Then
                            dtRow("Event") = "HH"
                        Else
                            dtRow("Event") = "-"
                        End If

                        dtEvents.Rows.Add(dtRow)
                    Next
                    steps = a(1) & "5"
                    '  Response.Write(steps)
                    Dim prevstatus As String = "Normal"
                    Dim currentstatus As String = "Normal"
                    Dim tempprevtime As DateTime = Convert.ToDateTime(strBeginDate)
                    Dim prevtime As DateTime = Convert.ToDateTime(strBeginDate)
                    Dim currenttime As DateTime = Convert.ToDateTime(strBeginDate)
                    ' Dim sno1 As Integer = 1

                    Try
                        For i As Integer = 0 To dtEvents.Rows.Count - 1
                            currenttime = Convert.ToDateTime(dtEvents.Rows(i)("DateTime"))
                            If dtEvents.Rows(i)("Event") <> "LL" Then
                                currentstatus = "Normal"
                            Else
                                currentstatus = "Lower"
                            End If

                            If prevstatus <> currentstatus Then
                                tempprevtime = currenttime
                                Dim temptime As TimeSpan = tempprevtime - prevtime
                                Dim minutes As Int32 = Convert.ToInt32(temptime.TotalMinutes)
                                If prevstatus = "Lower" Then
                                    If (temptime.Hours * 60) + temptime.Minutes >= 1 Then
                                        r = dt.NewRow()
                                        r(0) = sno
                                        r(1) = dtEvents.Rows(i)("SiteName")
                                        r(2) = prevtime.ToString("yyyy-MM-dd HH:mm:ss")
                                        r(3) = currenttime.ToString("yyyy-MM-dd HH:mm:ss")
                                        r(4) = temptime.TotalHours.ToString("00") & ":" & temptime.Minutes.ToString("00") & ":" & temptime.Seconds.ToString("00")
                                        r(5) = flowrate
                                        r(6) = flowratetariff
                                        r(7) = (temptime.TotalHours * flowrate * flowratetariff).ToString("0.00")
                                        total1 = total1 + (temptime.TotalHours * flowrate * flowratetariff)
                                        totalSpan = totalSpan + temptime
                                        dt.Rows.Add(r)
                                        sno = sno + 1

                                    End If
                                End If

                                prevtime = currenttime
                                prevstatus = currentstatus
                            End If
                        Next
                    Catch ex1 As Exception
                        Response.Write("Err:" & ex1.Message)
                    End Try
                    steps = a(1) & "6"
                    '  Response.Write(steps)
                    If prevtime <> currenttime Then
                        Dim temptime As TimeSpan = tempprevtime - prevtime
                        Dim minutes As Int32 = Convert.ToInt32(temptime.TotalMinutes)
                        If prevstatus = "Lower" Then
                            If (temptime.Hours * 60) + temptime.Minutes >= 1 Then
                                r = dt.NewRow()
                                r(0) = sno
                                r(1) = a(1)
                                r(2) = prevtime.ToString("yyyy-MM-dd HH:mm:ss")
                                r(3) = currenttime.ToString("yyyy-MM-dd HH:mm:ss")
                                r(4) = temptime.TotalHours.ToString("00") & ":" & temptime.Minutes.ToString("00") & ":" & temptime.Seconds.ToString("00")
                                r(5) = flowrate
                                r(6) = flowratetariff
                                r(7) = (temptime.TotalHours * flowrate * flowratetariff).ToString("0.00")
                                total1 = total1 + (temptime.TotalHours * flowrate * flowratetariff)
                                totalSpan = totalSpan + temptime
                                dt.Rows.Add(r)
                                sno = sno + 1
                            End If
                        End If
                    End If
                Next
                Con.Close()
            Else
                Dim lstDbValue As List(Of Double) = New List(Of Double)()
                Dim lstDateTime As List(Of DateTime) = New List(Of DateTime)()
                Dim llRange As String() = New String(1) {"0", "0"}
                Dim lRange As String() = New String(1) {"0", "0"}
                Dim nnRange As String() = New String(1) {"0", "0"}
                Dim hRange As String() = New String(1) {"0", "0"}
                Dim hhRange As String() = New String(1) {"0", "0"}
                Dim dtEvents As DataTable = New DataTable()
                dtEvents.Columns.Add(New DataColumn("No"))
                dtEvents.Columns.Add(New DataColumn("DateTime"))
                dtEvents.Columns.Add(New DataColumn("SiteName"))
                dtEvents.Columns.Add(New DataColumn("Value"))
                dtEvents.Columns.Add(New DataColumn("Event"))
                Query = "SELECT max FROM telemetry_equip_list_table WHERE siteid = '" & ddlsitename.SelectedValue & "' AND position = '2'"
                cmd = New SqlCommand(Query, Con)
                Con.Open()
                dr = cmd.ExecuteReader()
                If dr.Read() Then
                    dbMax = Convert.ToDouble(dr("max").ToString())
                    dr.Close()
                End If

                Query = "SELECT ISNULL( outletflowrate,0) outletflowrate, ISNULL(outletflowtariff,0)  outletflowtariff FROM telemetry_tariffdetails_table where siteid='" & ddlsitename.SelectedValue & "'"
                cmd = New SqlCommand(Query, Con)
                dr = cmd.ExecuteReader()
                If dr.Read() Then
                    flowrate = Convert.ToDouble(dr("outletflowrate").ToString())
                    flowratetariff = Convert.ToDouble(dr("outletflowtariff").ToString())
                End If

                Query = "SELECT * FROM telemetry_rule_list_table WHERE siteid = '" & ddlsitename.SelectedValue & "' AND alarmmode = 'EVENT'"
                cmd = New SqlCommand(Query, Con)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Dim tmpRange As String() = dr("multiplier").ToString().Split(";"c)
                    Select Case dr("alarmtype").ToString()
                        Case "LL"
                            If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                llRange(0) = tmpRange(1)
                                llRange(1) = tmpRange(2)
                            Else
                                llRange(0) = "0"
                                llRange(1) = "0"
                            End If

                            Exit Select
                        Case "L"
                            If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                lRange(0) = tmpRange(1)
                                lRange(1) = tmpRange(2)
                            Else
                                lRange(0) = "0"
                                lRange(1) = "0"
                            End If

                            Exit Select
                        Case "NN"
                            If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                nnRange(0) = tmpRange(1)
                                nnRange(1) = tmpRange(2)
                            Else
                                nnRange(0) = "0"
                                nnRange(1) = "0"
                            End If

                            Exit Select
                        Case "H"
                            If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                hRange(0) = tmpRange(1)
                                hRange(1) = tmpRange(2)
                            Else
                                hRange(0) = "0"
                                hRange(1) = "0"
                            End If

                            Exit Select
                        Case "HH"
                            If tmpRange(0).ToString().ToUpper() = "RANGE" Then
                                hhRange(0) = tmpRange(1)
                                hhRange(1) = tmpRange(2)
                            Else
                                hhRange(0) = "0"
                                hhRange(1) = "0"
                            End If

                            Exit Select
                        Case Else
                    End Select
                End While

                Query = "SELECT * FROM telemetry_log_table WHERE siteid = '" & ddlsitename.SelectedValue & "' AND position = '2' AND dtimestamp " & "BETWEEN '" + strBeginDate & "' AND '" + strEndDate & "' ORDER BY dtimestamp"
                cmd = New SqlCommand(Query, Con)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lstDbValue.Add(Convert.ToDouble(dr("value").ToString()))
                    lstDateTime.Add(Convert.ToDateTime(dr("dtimestamp").ToString()))
                End While

                dbValue = New Double(lstDbValue.Count - 1) {}
                dtDate = New String(lstDateTime.Count - 1) {}
                If lstDbValue.Count > 0 Then
                    dbRestore = lstDbValue(0)
                Else
                    dbRestore = 0
                End If

                For i As Integer = 0 To lstDbValue.Count - 1
                    If Convert.ToDouble(lstDbValue(i)) < dbMax Then
                        dbRestore = lstDbValue(i)
                        i = lstDbValue.Count
                    End If
                Next

                For i As Integer = 0 To lstDbValue.Count - 1
                    Dim dbTmp As Double = 0
                    Dim dtTmp As DateTime
                    dbTmp = lstDbValue(i)
                    dtTmp = lstDateTime(i)
                    If i > 0 Then
                        If dtTmp.Subtract(lstDateTime(i - 1)).TotalMinutes <= 20 Then
                            If dbTmp - lstDbValue(i - 1) > 1 OrElse dbTmp - lstDbValue(i - 1) < -1 Then
                                lstDbValue(i) = lstDbValue(i - 1)
                            End If
                        End If
                    Else
                        If dbTmp > dbMax Then
                            lstDbValue(i) = dbRestore
                        End If

                        If dbTmp > dbMax Then
                            dbMax = dbTmp
                        End If
                    End If

                    dbValue(i) = lstDbValue(i)
                    dtDate(i) = lstDateTime(i).ToString("dd/MM/yyyy hh:mm:ss tt")
                Next

                For i As Integer = 0 To lstDbValue.Count - 1
                    dtRow = dtEvents.NewRow()
                    dtRow("No") = i + 1
                    dtRow("DateTime") = lstDateTime(i).ToString("yyyy/MM/dd HH:mm:ss")
                    dtRow("SiteName") = ddlsitename.SelectedItem
                    dtRow("Value") = lstDbValue(i).ToString("0.00")
                    If lstDbValue(i) >= Convert.ToDouble(llRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(llRange(1)) Then
                        dtRow("Event") = "LL"
                    ElseIf lstDbValue(i) >= Convert.ToDouble(lRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(lRange(1)) Then
                        dtRow("Event") = "L"
                    ElseIf lstDbValue(i) >= Convert.ToDouble(nnRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(nnRange(1)) Then
                        dtRow("Event") = "NN"
                    ElseIf lstDbValue(i) >= Convert.ToDouble(hRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(hRange(1)) Then
                        dtRow("Event") = "H"
                    ElseIf lstDbValue(i) >= Convert.ToDouble(hhRange(0)) AndAlso lstDbValue(i) <= Convert.ToDouble(hhRange(1)) Then
                        dtRow("Event") = "HH"
                    Else
                        dtRow("Event") = "-"
                    End If

                    dtEvents.Rows.Add(dtRow)
                Next

                Dim prevstatus As String = "Normal"
                Dim currentstatus As String = "Normal"
                Dim tempprevtime As DateTime = Convert.ToDateTime(strBeginDate)
                Dim prevtime As DateTime = Convert.ToDateTime(strBeginDate)
                Dim currenttime As DateTime = Convert.ToDateTime(strBeginDate)
                Dim sno1 As Integer = 1

                Try
                    For i As Integer = 0 To dtEvents.Rows.Count - 1
                        currenttime = Convert.ToDateTime(dtEvents.Rows(i)("DateTime"))
                        If dtEvents.Rows(i)("Event") <> "LL" Then
                            currentstatus = "Normal"
                        Else
                            currentstatus = "Lower"
                        End If

                        If prevstatus <> currentstatus Then
                            tempprevtime = currenttime
                            Dim temptime As TimeSpan = tempprevtime - prevtime
                            Dim minutes As Int32 = Convert.ToInt32(temptime.TotalMinutes)
                            If prevstatus = "Lower" Then
                                If (temptime.Hours * 60) + temptime.Minutes >= 1 Then
                                    r = dt.NewRow()
                                    r(0) = sno1
                                    r(1) = dtEvents.Rows(i)("SiteName")
                                    r(2) = prevtime.ToString("yyyy-MM-dd HH:mm:ss")
                                    r(3) = currenttime.ToString("yyyy-MM-dd HH:mm:ss")
                                    r(4) = temptime.TotalHours.ToString("00") & ":" & temptime.Minutes.ToString("00") & ":" & temptime.Seconds.ToString("00")
                                    r(5) = flowrate
                                    r(6) = flowratetariff
                                    r(7) = (temptime.TotalHours * flowrate * flowratetariff).ToString("0.00")
                                    total1 = total1 + (temptime.TotalHours * flowrate * flowratetariff)
                                    totalSpan = totalSpan + temptime
                                    dt.Rows.Add(r)
                                    sno1 = sno1 + 1

                                End If
                            End If

                            prevtime = currenttime
                            prevstatus = currentstatus
                        End If
                    Next
                Catch ex1 As Exception
                    Response.Write("Err:" & ex1.Message)
                End Try

                If prevtime <> currenttime Then
                    Dim temptime As TimeSpan = tempprevtime - prevtime
                    Dim minutes As Int32 = Convert.ToInt32(temptime.TotalMinutes)
                    If prevstatus = "Lower" Then
                        If (temptime.Hours * 60) + temptime.Minutes >= 1 Then
                            r = dt.NewRow()
                            r(0) = sno
                            r(1) = ddlsitename.SelectedItem.Text

                            r(2) = prevtime.ToString("yyyy-MM-dd HH:mm:ss")
                            r(3) = currenttime.ToString("yyyy-MM-dd HH:mm:ss")
                            r(4) = temptime.TotalHours.ToString("00") & ":" & temptime.Minutes.ToString("00") & ":" & temptime.Seconds.ToString("00")
                            r(5) = flowrate
                            r(6) = flowratetariff
                            r(7) = (temptime.TotalHours * flowrate * flowratetariff).ToString("0.00")
                            total1 = total1 + (temptime.TotalHours * flowrate * flowratetariff)
                            totalSpan = totalSpan + temptime
                            dt.Rows.Add(r)
                            sno = sno + 1
                        End If
                    End If
                End If
            End If


            If dt.Rows.Count = 0 Then
                r = dt.NewRow()
                r(0) = "--"
                r(1) = "--"
                r(2) = "--"
                r(3) = "--"
                r(4) = "--"
                r(5) = "--"
                r(6) = "--"
                r(7) = "--"

                dt.Rows.Add(r)
            End If

            Session.Remove("exceltable")
            Session("exceltable") = dt
            gvReport.DataSource = dt
            gvReport.DataBind()
            gvReport.FooterRow.Cells(4).Text = totalSpan.Duration().TotalHours.ToString("00") & ":" + totalSpan.Duration().Minutes.ToString("00") & ":" + totalSpan.Duration().Seconds.ToString("00")
            gvReport.FooterRow.Cells(7).Text = total1.ToString("0.00")


        Catch ex As Exception
            Response.Write("Fill_gvReports Error - " & ex.Message)
        Finally
            cmd.Dispose()
            Con.Close()
        End Try

    End Sub
    Function GetSitesList(ByVal dist As String) As ArrayList
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim aa As ArrayList = New ArrayList()
        Dim a As ArrayList = New ArrayList()
        Dim strQuery As String = ""
        Try
            strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where  sitetype='RESERVOIR' and   sitedistrict='" & dist & "'"
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            While dr.Read()
                a = New ArrayList()
                a.Add(dr("siteid"))
                a.Add(dr("sitename"))
                aa.Add(a)
            End While

        Catch ex As Exception
            Response.Write("GetSitesList - " & ex.Message)
        Finally
            conn.Close()
        End Try
        Return aa
    End Function
    Protected Sub btnSubmit_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        Try
            Fill_gvReports()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ddldistrict_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddldistrict.SelectedIndexChanged
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand

        Dim ds As New DataSet
        Dim strQuery As String = ""
        Try
            If ddldistrict.SelectedValue = "ALL" And ddltype.SelectedValue = "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where sitetype='RESERVOIR' order by sitename  "
            ElseIf ddldistrict.SelectedValue = "ALL" And ddltype.SelectedValue <> "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where   sitetype='RESERVOIR' and  sitetype ='" & ddltype.SelectedValue & "' "
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue = "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where  sitetype='RESERVOIR' and   sitedistrict='" & ddldistrict.SelectedValue & "'"
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue <> "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where   sitetype='RESERVOIR' and  sitedistrict='" & ddldistrict.SelectedValue & "' and sitetype ='" & ddltype.SelectedValue & "'"
            End If

            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            Dim da As SqlDataAdapter
            da = New SqlDataAdapter(cmd)
            da.Fill(ds)
            ddlsitename.DataSource = ds.Tables(0)
            ddlsitename.DataValueField = "siteid"
            ddlsitename.DataTextField = "sitename"
            ddlsitename.DataBind()
            ddlsitename.Items.Insert(0, "Select Site Name")
            ddlsitename.Items.Insert(1, "ALL")
            ddlsitename.SelectedValue = "ALL"
        Catch ex As Exception

        End Try
    End Sub
End Class
