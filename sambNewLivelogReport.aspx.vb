Imports System.Data.SqlClient
Imports System.Data

Partial Class sambNewLivelogReport
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            btnSubmit.Attributes.Add("onclick", "return mysubmit()")
            GetDistrict()
            txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
        End If
    End Sub
    Public Sub GetDistrict()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim sqlcmd As SqlCommand
        Dim sqldr As SqlDataReader

        strsql = "Select distinct(sitedistrict) from telemetry_site_list_Table where sitedistrict <> 'Testing' order by sitedistrict"
        sqlcmd = New SqlCommand(strsql, conn)
        conn.Open()
        sqldr = sqlcmd.ExecuteReader
        cboDistrict.Items.Add(New ListItem("All", "All"))
        While sqldr.Read
            cboDistrict.Items.Add(New ListItem(sqldr("sitedistrict"), sqldr("sitedistrict")))
        End While

        conn.Close()

    End Sub
    Public Sub GetLiveData()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim adpLive As SqlDataAdapter

        Dim value() As Double
        Dim dtimestamp() As DateTime
        Dim j As Integer = 0

        Dim strBeginDateTime As String = Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy-MM-dd")

        Dim dtLive As New DataTable
        Dim r As DataRow
        With dtLive.Columns
            .Add(New DataColumn("No"))
            .Add(New DataColumn("SiteNo"))
            .Add(New DataColumn("sitename"))
            .Add(New DataColumn("Sim No"))
            .Add(New DataColumn("Read1(M)"))
            .Add(New DataColumn("Status1"))
            .Add(New DataColumn("time1"))
            .Add(New DataColumn("Read2(M)"))
            .Add(New DataColumn("Status2"))
            .Add(New DataColumn("time2"))
            .Add(New DataColumn("Read3(M)"))
            .Add(New DataColumn("Status3"))
            .Add(New DataColumn("time3"))
        End With
        Dim getTimeframe As Integer = DateDiff(DateInterval.Minute, Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd 00:00:00")), Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")))
        Dim statusMorning As Boolean = False
        Dim statusNoon As Boolean = False
        Dim statusNight As Boolean = False
        Try
            '    Response.Write(a)

            Select Case getTimeframe
                Case 0 To 479
                    If cboDistrict.SelectedValue = "All" Then
                        strsql = "Select  * from telemetry_equip_status_table l right join telemetry_site_list_Table sl on sl.siteid=l.siteid inner join unit_list ul on ul.unitid=sl.unitid where dtimestamp between '" & DateTime.Now.ToString("yyyy/MM/dd 00:00:00") & "' and '" & DateTime.Now.ToString("yyyy/MM/dd 07:59:59") & "' ORDER BY sitename, dtimestamp"
                    Else
                        strsql = "Select  * from telemetry_equip_status_table l right join telemetry_site_list_Table sl on sl.siteid=l.siteid inner join unit_list ul on ul.unitid=sl.unitid where sl.sitedistrict='" & cboDistrict.SelectedValue & "' and dtimestamp between '" & DateTime.Now.ToString("yyyy/MM/dd 00:00:00") & "' and '" & DateTime.Now.ToString("yyyy/MM/dd 07:59:59") & "' ORDER BY sitename, dtimestamp"
                    End If
                    statusNight = True

                Case 511 To 959
                    If cboDistrict.SelectedValue = "All" Then
                        strsql = "Select  * from telemetry_equip_status_table l right join telemetry_site_list_Table sl on sl.siteid=l.siteid inner join unit_list ul on ul.unitid=sl.unitid where dtimestamp between '" & DateTime.Now.ToString("yyyy/MM/dd 08:00:00") & "' and '" & DateTime.Now.ToString("yyyy/MM/dd 15:59:59") & "' ORDER BY sitename, dtimestamp"
                    Else
                        strsql = "Select  * from telemetry_equip_status_table l right join telemetry_site_list_Table sl on sl.siteid=l.siteid inner join unit_list ul on ul.unitid=sl.unitid where sl.sitedistrict='" & cboDistrict.SelectedValue & "' and dtimestamp between '" & DateTime.Now.ToString("yyyy/MM/dd 08:00:00") & "' and '" & DateTime.Now.ToString("yyyy/MM/dd 15:59:59") & "' ORDER BY sitename, dtimestamp"
                    End If
                    statusMorning = True
                Case 960 To 1439



                    If cboDistrict.SelectedValue = "All" Then
                        strsql = "Select  * from telemetry_equip_status_table l right join telemetry_site_list_Table sl on sl.siteid=l.siteid inner join unit_list ul on ul.unitid=sl.unitid where dtimestamp between '" & DateTime.Now.ToString("yyyy/MM/dd 16:00:00") & "' and '" & DateTime.Now.ToString("yyyy/MM/dd 23:59:59") & "' ORDER BY sitename, dtimestamp"
                    Else
                        strsql = "Select  * from telemetry_equip_status_table l right join telemetry_site_list_Table sl on sl.siteid=l.siteid inner join unit_list ul on ul.unitid=sl.unitid where sl.sitedistrict='" & cboDistrict.SelectedValue & "' and dtimestamp between '" & DateTime.Now.ToString("yyyy/MM/dd 16:00:00") & "' and '" & DateTime.Now.ToString("yyyy/MM/dd 23:59:59") & "' ORDER BY sitename, dtimestamp"

                    End If


                    statusNoon = True
            End Select

        
            ' Response.Write(strsql)
            '  Exit Sub
            adpLive = New SqlDataAdapter(strsql, conn)
            Dim dsLive As New DataSet
            conn.Open()
            adpLive.Fill(dsLive)
            statusMorning = True
            statusNight = False
            statusNoon = False
            If dsLive.Tables(0).Rows.Count <> 0 Then
                For i As Integer = 0 To dsLive.Tables(0).Rows.Count - 1
                    r = dtLive.NewRow
                    r(0) = i + 1
                    r(1) = dsLive.Tables(0).Rows(i)("siteid")
                    r(2) = dsLive.Tables(0).Rows(i)("sitename")
                    r(3) = dsLive.Tables(0).Rows(i)("simno")
                    If statusMorning = True Then
                        If IsDBNull(dsLive.Tables(0).Rows(i)("value")) = False And IsDBNull(dsLive.Tables(0).Rows(i)("dtimestamp")) = False Then
                            r(4) = dsLive.Tables(0).Rows(i)("value")
                            r(5) = getAlarm(dsLive.Tables(0).Rows(i)("siteid"), dsLive.Tables(0).Rows(i)("value"))
                            r(6) = Convert.ToDateTime(dsLive.Tables(0).Rows(i)("dtimestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                        Else
                            r(4) = "-"
                            r(5) = "-"
                            r(6) = "-"
                        End If
                       
                        r(7) = "-"
                        r(8) = "-"
                        r(9) = "-"
                        r(10) = "-"
                        r(11) = "-"
                        r(12) = "-"
                    ElseIf statusNight = True Then
                        r(4) = "-"
                        r(5) = "-"
                        r(6) = "-"
                        r(7) = "-"
                        r(8) = "-"
                        r(9) = "-"
                        If IsDBNull(dsLive.Tables(0).Rows(i)("value")) = False And IsDBNull(dsLive.Tables(0).Rows(i)("dtimestamp")) = False Then
                            r(10) = dsLive.Tables(0).Rows(i)("value")
                            r(11) = getAlarm(dsLive.Tables(0).Rows(i)("siteid"), dsLive.Tables(0).Rows(i)("value"))
                            r(12) = Convert.ToDateTime(dsLive.Tables(0).Rows(i)("dtimestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                        Else
                            r(10) = "-"
                            r(11) = "-"
                            r(12) = "-"
                        End If
                      


                    ElseIf statusNoon = True Then
                        r(4) = "-"
                        r(5) = "-"
                        r(6) = "-"
                        If IsDBNull(dsLive.Tables(0).Rows(i)("value")) = False And IsDBNull(dsLive.Tables(0).Rows(i)("dtimestamp")) = False Then
                            r(7) = dsLive.Tables(0).Rows(i)("value")
                            r(8) = getAlarm(dsLive.Tables(0).Rows(i)("siteid"), dsLive.Tables(0).Rows(i)("value"))
                            r(9) = Convert.ToDateTime(dsLive.Tables(0).Rows(i)("dtimestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                        Else
                            r(7) = "-"
                            r(8) = "-"
                            r(9) = "-"
                        End If
                       
                        r(10) = "-"
                        r(11) = "-"
                        r(12) = "-"




                    End If
                        dtLive.Rows.Add(r)
                Next

              
            Else
                r = dtLive.NewRow
                r(0) = "--"
                r(1) = "--"
                r(2) = "--"
                r(3) = "--"
                r(4) = "--"
                r(5) = "--"
                r(6) = "--"
                r(7) = "--"
                r(8) = "--"
                r(9) = "--"
                r(10) = "-"
                r(11) = "-"
                r(12) = "-"
                dtLive.Rows.Add(r)
            End If
            conn.Close()
            With GridView1
                ' .PageSize = noofrecords.SelectedValue
                .DataSource = dtLive
                .DataBind()
                ' CountRecord()
                'If .PageCount > 1 Then
                '    show = True
                'End If

            End With
            '  ec = "true"
            ' Session("exceltable2") = dtEvents


        Catch ex As Exception
            Response.Write("Events" & ex.Message)
        End Try
    End Sub
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
   GetLiveData()
    End Sub
    Protected Sub GridView1_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) 'Handles GridView2.RowCreated
        'If (e.Row.RowType = DataControlRowType.Header) Then
        '    Dim row As GridViewRow = New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
        '    Dim cell As New TableCell()
        '    cell.BackColor = System.Drawing.Color.DeepSkyBlue '(255, 70, 90, 232)
        '    cell.ForeColor = System.Drawing.Color.White '.FromArgb(232, 70, 89)
        '    cell.Font.Bold = True

        '    cell.ColumnSpan = 4
        '    cell.HorizontalAlign = HorizontalAlign.Center
        '    cell.Text = ""
        '    row.Cells.Add(cell)
        '    GridView1.Controls(0).Controls.AddAt(0, row)

        '    Dim cell2 As New TableCell()
        '    cell2.BackColor = System.Drawing.Color.DeepSkyBlue '(255, 70, 90, 232)
        '    cell2.ForeColor = System.Drawing.Color.White '.FromArgb(232, 70, 89)
        '    cell2.Font.Bold = True
        '    cell2.ColumnSpan = 3
        '    cell2.HorizontalAlign = HorizontalAlign.Center
        '    cell2.Text = "Time (At 08.00AM)"
        '    row.Cells.Add(cell2)
        '    GridView1.Controls(0).Controls.AddAt(0, row)

        '    Dim cell3 As New TableCell()
        '    cell3.BackColor = System.Drawing.Color.DeepSkyBlue '(255, 70, 90, 232)
        '    cell3.ForeColor = System.Drawing.Color.White '.FromArgb(232, 70, 89)
        '    cell3.Font.Bold = True
        '    cell3.ColumnSpan = 3
        '    cell3.HorizontalAlign = HorizontalAlign.Center
        '    cell3.Text = "Time (At 04.00pm)"
        '    row.Cells.Add(cell3)
        '    GridView1.Controls(0).Controls.AddAt(0, row)

        '    Dim cell4 As New TableCell()
        '    cell4.BackColor = System.Drawing.Color.DeepSkyBlue '(255, 70, 90, 232)
        '    cell4.ForeColor = System.Drawing.Color.White '.FromArgb(232, 70, 89)
        '    cell4.Font.Bold = True
        '    cell4.ColumnSpan = 3
        '    cell4.HorizontalAlign = HorizontalAlign.Center
        '    cell4.Text = "Time (At 12.00am)"
        '    row.Cells.Add(cell4)
        '    GridView1.Controls(0).Controls.AddAt(0, row)

        'End If
    End Sub

    Private Function getAlarm(ByVal paraSiteId As String, ByVal paraValue As Double) As String
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim dr As SqlDataReader
        Dim cmd As SqlCommand
        Dim getRange() As String
        Dim strsql As String
        Dim alarmType As String
        Try
            strsql = "Select alarmtype,multiplier from telemetry_rule_list_table where siteid='" & paraSiteId & "'"
            conn.Open()
            cmd = New SqlCommand(strsql, conn)
            dr = cmd.ExecuteReader
            cmd.Dispose()

            While dr.Read
                getRange = Split(dr("multiplier"), ";")
                If paraValue >= getRange(1) And paraValue <= getRange(2) Then
                    alarmType = dr("alarmType")
                    Return alarmType
                End If
            End While
        Catch ex As Exception
            Response.Write("GetAlert :" & ex.Message)
        Finally
            conn.Close()
        End Try
    End Function
End Class
