Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.UI
Partial Class EventReportsSamb
    Inherits System.Web.UI.Page
    Public show As Boolean
    Public ec As String = "false"

    Public Sub GetDistrict()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim sqlcmd As SqlCommand
        Dim sqldr As SqlDataReader

        cboDistrict.Items.Clear()
        'cboDistrict.Items.Add(New ListItem("--All Sites--", "ALL"))

        strsql = "Select distinct(sitedistrict) from telemetry_site_list_Table order by sitedistrict"
        sqlcmd = New SqlCommand(strsql, conn)
        conn.Open()
        sqldr = sqlcmd.ExecuteReader
        cboDistrict.Items.Add("Select District")
        cboDistrict.Items.Add(New ListItem("--All Sites--", "ALL"))
        While sqldr.Read
            cboDistrict.Items.Add(New ListItem(sqldr("sitedistrict"), sqldr("sitedistrict")))
        End While

        conn.Close()

    End Sub
    Public Sub GetSite()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim sqlcmd As SqlCommand
        Dim sqldr As SqlDataReader
        Try
            cboSiteName.Items.Clear()
            'cboSiteName.Items.Add(New ListItem("--All Sites--", "ALL"))

            If cboDistrict.SelectedValue.ToUpper() = "ALL" Then
                strsql = "Select siteid,sitename from telemetry_site_list_Table order by sitename"
            Else
                strsql = "Select siteid,sitename from telemetry_site_list_Table where sitedistrict='" & cboDistrict.SelectedValue & "'  order by sitename"
            End If

            'strsql = "Select siteid,sitename from telemetry_site_list_Table where sitedistrict='" & cboDistrict.SelectedValue & "'  order by sitename"
            sqlcmd = New SqlCommand(strsql, conn)
            conn.Open()
            sqldr = sqlcmd.ExecuteReader
            cboSiteName.Items.Add("Select Site")
            cboSiteName.Items.Add(New ListItem("--All Sites--", "ALL"))
            While sqldr.Read
                cboSiteName.Items.Add(New ListItem(sqldr("sitename"), sqldr("siteid")))
            End While

            conn.Close()
        Catch ex As Exception
            Response.Write("Site" & ex.Message)
        End Try
    End Sub

    Public Sub GetEvent()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim adpEvents As SqlDataAdapter
        Dim sevent(), sitename(), siteid() As String
        Dim value() As Double
        Dim dtimestamp() As DateTime
        Dim j As Integer = 0

        Dim dr As SqlDataReader
        Dim cmd As SqlCommand

        Dim strBeginDateTime As String = Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy-MM-dd") & " " & ddlbh.SelectedValue & ":" & ddlbm.SelectedValue & ":00"
        Dim strEndDateTime As String = Convert.ToDateTime(txtEndDate.Value).ToString("yyyy-MM-dd") & " " & ddleh.SelectedValue & ":" & ddlem.SelectedValue & ":59"

        Dim dtEvents As New DataTable
        Dim r As DataRow
        With dtEvents.Columns
            .Add(New DataColumn("No"))
            .Add(New DataColumn("dtimestamp"))
            .Add(New DataColumn("sitename"))
            .Add(New DataColumn("siteId"))
            .Add(New DataColumn("value"))
            .Add(New DataColumn("event"))
        End With

        Dim dtCountEvents As New DataTable
        With dtCountEvents.Columns
            .Add(New DataColumn("HH"))
            .Add(New DataColumn("H"))
            .Add(New DataColumn("NN"))
            .Add(New DataColumn("L"))
            .Add(New DataColumn("LL"))
        End With

        Try
            If cboSiteName.SelectedValue.ToUpper() = "ALL" Then

                If cboDistrict.SelectedValue.ToUpper() = "ALL" Then

                    strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename, sl.sitedistrict from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.position='2' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' order by siteid, dtimestamp desc"

                Else

                    strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename, sl.sitedistrict from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where sl.sitedistrict = '" + cboDistrict.SelectedValue + "' AND eh.position='2' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' order by siteid, dtimestamp desc"

                End If

                'If cboEvents.SelectedValue = "All Types" Then
                'strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.position='2' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' order by siteid, dtimestamp desc"
                'Else
                'strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename  from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.position='2' and eh.sevent='" & cboEvents.SelectedValue & "' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' order by siteid, dtimestamp desc"
                'End If
            Else

                'If cboEvents.SelectedValue = "All Types" Then
                strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename, sl.sitedistrict from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.siteid='" & cboSiteName.SelectedValue & "' and eh.position='2' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' order by siteid, dtimestamp desc"
                'Else
                'strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename  from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.siteid='" & cboSiteName.SelectedValue & "' and eh.position='2' and eh.sevent='" & cboEvents.SelectedValue & "' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' order by siteid, dtimestamp desc"
                'End If
            End If

            'If cboEvents.SelectedValue = "All Types" Then
            '    strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.siteid='" & cboSiteName.SelectedValue & "' and eh.position='2' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "' "
            'Else
            '    strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename  from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.siteid='" & cboSiteName.SelectedValue & "' and eh.position='2' and eh.sevent='" & cboEvents.SelectedValue & "' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "'"
            'End If
            ' Response.Write(strsql)
            'adpEvents = New SqlDataAdapter(strsql, conn)
            'Dim dsEvents As New DataSet

            conn.Open()

            cmd = New SqlCommand(strsql, conn)
            cmd.CommandTimeout = 300
            dr = cmd.ExecuteReader()

            Dim strEvent As String = ""
            Dim intHH As Int16 = 0
            Dim intH As Int16 = 0
            Dim intNN As Int16 = 0
            Dim intL As Int16 = 0
            Dim intLL As Int16 = 0
            Dim intCount As Int16 = 0

            While dr.Read()

                If cboEvents.SelectedValue <> "All Types" Then

                    If strEvent <> dr("sevent").ToString().ToUpper() Then

                        strEvent = dr("sevent").ToString().ToUpper()

                        If strEvent = cboEvents.SelectedValue.ToUpper() Then

                            intCount = intCount + 1
                            r = dtEvents.NewRow

                            r(0) = intCount 'No
                            r(1) = dr("dtimestamp").ToString() 'dtimestamp
                            r(2) = dr("sitename").ToString() 'sitename
                            r(3) = dr("siteid").ToString() 'siteid
                            r(4) = dr("value").ToString() 'value
                            r(5) = strEvent 'event

                            dtEvents.Rows.Add(r)

                            If strEvent = "HH" Then

                                intHH = intHH + 1

                            ElseIf strEvent = "H" Then

                                intH = intH + 1

                            ElseIf strEvent = "NN" Then

                                intNN = intNN + 1

                            ElseIf strEvent = "L" Then

                                intL = intL + 1

                            ElseIf strEvent = "LL" Then

                                intLL = intLL + 1

                            End If

                        End If

                    End If

                Else

                    If strEvent <> dr("sevent").ToString().ToUpper() Then

                        strEvent = dr("sevent").ToString().ToUpper()
                        intCount = intCount + 1
                        r = dtEvents.NewRow

                        r(0) = intCount 'No
                        r(1) = dr("dtimestamp").ToString() 'dtimestamp
                        r(2) = dr("sitename").ToString() 'sitename
                        r(3) = dr("siteid").ToString() 'siteid
                        r(4) = dr("value").ToString() 'value
                        r(5) = strEvent 'event

                        dtEvents.Rows.Add(r)

                        If strEvent = "HH" Then

                            intHH = intHH + 1

                        ElseIf strEvent = "H" Then

                            intH = intH + 1

                        ElseIf strEvent = "NN" Then

                            intNN = intNN + 1

                        ElseIf strEvent = "L" Then

                            intL = intL + 1

                        ElseIf strEvent = "LL" Then

                            intLL = intLL + 1

                        End If

                    End If
                End If

            End While

            conn.Close()

            If dtEvents.Rows.Count = 0 Then

                r = dtEvents.NewRow

                r(0) = ""
                r(1) = ""
                r(2) = ""
                r(3) = ""
                r(4) = ""
                r(5) = ""

                dtEvents.Rows.Add(r)

            End If

            r = dtCountEvents.NewRow
            r(0) = intHH
            r(1) = intH
            r(2) = intNN
            r(3) = intL
            r(4) = intLL
            dtCountEvents.Rows.Add(r)

            GridView1.DataSource = dtEvents
            GridView1.DataBind()

            GridView2.DataSource = dtCountEvents
            GridView2.DataBind()

            'adpEvents.Fill(dsEvents)
            'If dsEvents.Tables(0).Rows.Count <> 0 Then

            '    For i As Integer = 0 To dsEvents.Tables(0).Rows.Count - 1
            '        If i = 0 Then
            '            ReDim siteid(0)
            '            ReDim sitename(0)
            '            ReDim dtimestamp(0)
            '            ReDim value(0)
            '            ReDim sevent(0)
            '            siteid(0) = dsEvents.Tables(0).Rows(i)("siteid")
            '            sitename(0) = dsEvents.Tables(0).Rows(i)("sitename")
            '            dtimestamp(0) = dsEvents.Tables(0).Rows(i)("dtimestamp")
            '            value(0) = dsEvents.Tables(0).Rows(i)("value")
            '            sevent(0) = dsEvents.Tables(0).Rows(i)("sevent")
            '        Else
            '            If sevent(j) <> dsEvents.Tables(0).Rows(i)("sevent") Then
            '                j = j + 1
            '                ReDim Preserve siteid(j)
            '                ReDim Preserve sitename(j)
            '                ReDim Preserve dtimestamp(j)
            '                ReDim Preserve value(j)
            '                ReDim Preserve sevent(j)


            '                siteid(j) = dsEvents.Tables(0).Rows(i)("siteid")
            '                sitename(j) = dsEvents.Tables(0).Rows(i)("sitename")
            '                dtimestamp(j) = dsEvents.Tables(0).Rows(i)("dtimestamp")
            '                value(j) = dsEvents.Tables(0).Rows(i)("value")
            '                sevent(j) = dsEvents.Tables(0).Rows(i)("sevent")


            '            End If

            '        End If

            '    Next
            '    For i As Integer = 0 To sevent.Length - 1
            '        r = dtEvents.NewRow
            '        r(0) = i + 1
            '        r(1) = Convert.ToDateTime(dtimestamp(i)).ToString("yyyy/MM/dd HH:mm:ss")
            '        r(2) = sitename(i)
            '        r(3) = siteid(i)
            '        r(4) = value(i)
            '        r(5) = sevent(i)
            '        dtEvents.Rows.Add(r)
            '    Next
            'Else
            '    r = dtEvents.NewRow
            '    r(0) = "--"
            '    r(1) = "--"
            '    r(2) = "--"
            '    r(3) = "--"
            '    r(4) = "--"
            '    r(5) = "--"
            '    dtEvents.Rows.Add(r)
            'End If
            'conn.Close()
            'With GridView1
            '    ' .PageSize = noofrecords.SelectedValue
            '    .DataSource = dtEvents
            '    .DataBind()
            '    ' CountRecord()
            '    'If .PageCount > 1 Then
            '    '    show = True
            '    'End If

            'End With
            ec = "true"
            Session("exceltable2") = dtEvents
        Catch ex As Exception
            Response.Write("Events" & ex.Message)
        End Try
    End Sub
    Public Sub CountEvent()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim CountHH, CountH, CountNN, CountL, CountLL As Integer

        Dim strBeginDateTime As String = txtBeginDate.Value & " " & ddlbh.SelectedValue & ":" & ddlbm.SelectedValue & ":00"
        Dim strEndDateTime As String = txtEndDate.Value & " " & ddleh.SelectedValue & ":" & ddlem.SelectedValue & ":59"
        Dim j As Integer = 0
        Dim r As DataRow
        Dim dtCountEvents As New DataTable
        Dim adpEvents As SqlDataAdapter
        With dtCountEvents.Columns
            .Add(New DataColumn("HH"))
            .Add(New DataColumn("H"))
            .Add(New DataColumn("NN"))
            .Add(New DataColumn("L"))
            .Add(New DataColumn("LL"))
        End With
        Try
            If cboEvents.SelectedValue = "All Types" Then
                strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.siteid='" & cboSiteName.SelectedValue & "' and eh.position='2' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "'"
            Else
                strsql = "Select eh.dtimestamp,eh.siteid,eh.value,eh.sevent,sl.sitename  from telemetry_event_history_table eh inner join telemetry_site_list_table sl on eh.siteid=sl.siteid where eh.siteid='" & cboSiteName.SelectedValue & "' and eh.position='2' and eh.sevent='" & cboEvents.SelectedValue & "' and eh.dtimestamp between '" & strBeginDateTime & "' AND '" & strEndDateTime & "'"
            End If
            adpEvents = New SqlDataAdapter(strsql, conn)
            Dim dsEvents As New DataSet
            conn.Open()
            adpEvents.Fill(dsEvents)
            CountHH = 0
            CountH = 0
            CountNN = 0
            CountL = 0
            CountLL = 0
            If dsEvents.Tables(0).Rows.Count <> 0 Then
                For i As Integer = 0 To dsEvents.Tables(0).Rows.Count - 1
                    If dsEvents.Tables(0).Rows(i)("sevent") = "NN" Then
                        CountNN = CountNN + 1
                    ElseIf dsEvents.Tables(0).Rows(i)("sevent") = "L" Then
                        CountL = CountL + 1
                    ElseIf dsEvents.Tables(0).Rows(i)("sevent") = "H" Then
                        CountH = CountH + 1
                    ElseIf dsEvents.Tables(0).Rows(i)("sevent") = "HH" Then
                        CountHH = CountHH + 1
                    ElseIf dsEvents.Tables(0).Rows(i)("sevent") = "LL" Then
                        CountLL = CountLL + 1
                    End If
                Next
                r = dtCountEvents.NewRow
                r(0) = CountHH
                r(1) = CountH
                r(2) = CountNN
                r(3) = CountL
                r(4) = CountLL
                dtCountEvents.Rows.Add(r)
            Else
                r = dtCountEvents.NewRow
                r(0) = "--"
                r(1) = "--"
                r(2) = "--"
                r(3) = "--"
                r(4) = "--"
                dtCountEvents.Rows.Add(r)
            End If
            conn.Close()
            With GridView2
                ' .PageSize = noofrecords.SelectedValue
                .DataSource = dtCountEvents
                .DataBind()
                'If .PageCount > 1 Then
                '    show = True
                'End If
            End With
            ec = "true"
            Session("exceltable") = dtCountEvents
        Catch ex As Exception
            Response.Write("Events" & ex.Message)
        End Try
    End Sub
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        GetEvent()
        'CountEvent()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            btnSubmit.Attributes.Add("onclick", "return mysubmit()")
            GetDistrict()
            txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
            txtEndDate.Value = Now().ToString("yyyy-MM-dd")
        End If
    End Sub

    Protected Sub cboDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboDistrict.SelectedIndexChanged
        cboSiteName.Items.Clear()
        GetSite()
    End Sub
End Class
