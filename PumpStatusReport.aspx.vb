Imports System.Data.SqlClient
Imports System.Data

Partial Class PumpStatusReport
    Inherits System.Web.UI.Page

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
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where sitetype<>'RESERVOIR' order by sitename  "
            ElseIf ddldistrict.SelectedValue = "ALL" And ddltype.SelectedValue <> "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where   sitetype<>'RESERVOIR' and  sitetype ='" & ddltype.SelectedValue & "' "
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue = "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where  sitetype<>'RESERVOIR' and   sitedistrict='" & ddldistrict.SelectedValue & "'"
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue <> "ALL" Then
                strQuery = "SELECT siteid ,sitename   from telemetry_site_list_table where   sitetype<>'RESERVOIR' and  sitedistrict='" & ddldistrict.SelectedValue & "' and sitetype ='" & ddltype.SelectedValue & "'"
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
            'ddlsitename.Items.Insert(1, "ALL")
            'ddlsitename.SelectedValue = "ALL"
        Catch ex As Exception

        End Try
    End Sub

    'Protected Sub ddlsitename_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlsitename.SelectedIndexChanged
    '    Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAJconnection"))
    '    Dim cmd As SqlCommand

    '    Dim ds As New DataSet
    '    Dim strQuery As String = ""
    '    Try
    '        If ddlsitename.SelectedValue = "ALL" Then
    '            strQuery = "select distinct position,equiptype  from telemetry_equip_list_table  "
    '        Else
    '            strQuery = "select distinct position,equiptype  from telemetry_equip_list_table  where siteid  ='" & ddlsitename.SelectedValue & "'"
    '        End If

    '        cmd = New SqlCommand(strQuery, conn)
    '        conn.Open()
    '        Dim da As SqlDataAdapter
    '        da = New SqlDataAdapter(cmd)
    '        da.Fill(ds)
    '        ddlEquipment.DataSource = ds.Tables(0)
    '        ddlEquipment.DataValueField = "position"
    '        ddlEquipment.DataTextField = "equiptype"
    '        ddlEquipment.DataBind()
    '        ddlEquipment.Items.Insert(0, "Select Equipment")
    '        ddlEquipment.Items.Insert(1, "ALL")
    '        ddlEquipment.Items.Insert(ddlEquipment.Items.Count + 1, "Others")
    '        ddlEquipment.SelectedValue = "ALL"
    '    Catch ex As Exception

    '    End Try
    'End Sub

   

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        Dim ds As New DataSet
        Dim strQuery As String = ""
        Dim dtrange As String

        Dim dt As New DataTable
        dt.Columns.Add("sno")
        dt.Columns.Add("siteid")
        dt.Columns.Add("sitename")
        dt.Columns.Add("Fromtime")
        dt.Columns.Add("totime")
        dt.Columns.Add("duration")
        Dim begindatetime As String = Date.Parse(txtfromdate.Text).ToString("yyyy-MM-dd") & " " & ddBeginHour.SelectedValue & ":" & ddBeginMinute.SelectedValue & ":00"
        Dim enddatetime As String = Date.Parse(txtEnddate.Text).ToString("yyyy-MM-dd") & " " & ddendHour.SelectedValue & ":" & ddendMinute.SelectedValue & ":59"

        dtrange = "'" & txtfromdate.Text & " " & ddBeginHour.SelectedValue & ":" & ddBeginMinute.SelectedValue & "' and '" & txtEnddate.Text & " " & ddendHour.SelectedValue & ":" & ddendMinute.SelectedValue & "'"
        Try
           
            strQuery = "select lt.siteid ,slt .sitename ,dtimestamp ,value  from telemetry_log_table lt left outer join telemetry_site_list_table slt on lt.siteid =slt .siteid   where lt.siteid='" & ddlsitename.SelectedValue & "' and dtimestamp between " & dtrange & "  and position ='" & ddlEquipment.SelectedValue & "'"


            cmd = New SqlCommand(strQuery, conn)
            Dim prevstatus As String = "stop"
            Dim currentstatus As String = "stop"
            Dim tempprevtime As DateTime = begindatetime
            Dim prevtime As DateTime = begindatetime
            Dim currenttime As DateTime = begindatetime
            conn.Open()
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            Dim sno As Integer = 1
            Dim r As DataRow
            Dim totalSpan As TimeSpan
            Try
            While dr.Read()
                currenttime = dr("dtimestamp")
                If dr("value") = 1 Then
                    currentstatus = "Running"
                Else
                    currentstatus = "stop"
                End If
                If prevstatus <> currentstatus Then
                    tempprevtime = currenttime
                    Dim temptime As TimeSpan = tempprevtime - prevtime 'currenttime - prevtime
                    Dim minutes As Int16 = temptime.TotalMinutes()
                    If prevstatus = "Running" Then
                        If (temptime.Hours * 60) + temptime.Minutes >= 1 Then
                            r = dt.NewRow
                            r(0) = sno
                            r(1) = dr("siteid")
                            r(2) = dr("sitename")
                            r(3) = prevtime.ToString("yyyy-MM-dd HH:mm:ss")
                            r(4) = currenttime.ToString("yyyy-MM-dd HH:mm:ss")
                            r(5) = temptime
                            totalSpan = totalSpan + temptime
                            dt.Rows.Add(r)
                            sno = sno + 1
                        End If
                    End If
                    prevtime = currenttime
                    prevstatus = currentstatus
                End If
                End While
            Catch ex1 As Exception
                Response.Write(ex1.Message)
            End Try
            If prevtime <> currenttime Then
                Dim temptime As TimeSpan = currenttime - prevtime
                Dim minutes As Int16 = temptime.TotalMinutes()
                If prevstatus = "Running" Then
                    If (temptime.Hours * 60) + temptime.Minutes >= 1 Then
                        r = dt.NewRow
                        r(0) = sno
                        r(1) = ddlsitename.SelectedValue
                        r(2) = ddlsitename.Text
                        r(3) = prevtime.ToString("yyyy-MM-dd HH:mm:ss")
                        r(4) = currenttime.ToString("yyyy-MM-dd HH:mm:ss")
                        r(5) = temptime
                        totalSpan = totalSpan + temptime
                        dt.Rows.Add(r)
                    End If
                End If
            End If

            If dt.Rows.Count = 0 Then
                r = dt.NewRow
                r(0) = "--"
                r(1) = "--"
                r(2) = "--"
                r(3) = "--"
                r(4) = "--"
                r(5) = "--"
                dt.Rows.Add(r)
            End If


            gvreport.DataSource = dt
            gvreport.DataBind()
            If totalSpan.Days > 0 Then
                gvreport.FooterRow.Cells(5).Text = totalSpan.Duration.Days & "." & totalSpan.Duration.Hours.ToString.PadLeft(2, "0"c) & ":" & totalSpan.Duration.Minutes.ToString.PadLeft(2, "0"c) & ":" & totalSpan.Duration.Seconds.ToString.PadLeft(2, "0"c)
            Else
                gvreport.FooterRow.Cells(5).Text = totalSpan.Duration.Hours.ToString.PadLeft(2, "0"c) & ":" & totalSpan.Duration.Minutes.ToString.PadLeft(2, "0"c) & ":" & totalSpan.Duration.Seconds.ToString.PadLeft(2, "0"c)
            End If

            ' Response.Write(ds.Tables(0).Rows.Count)
        Catch ex As Exception
            Response.Write(ex.Message + " " + strQuery)
        Finally
            conn.Close()
        End Try
    End Sub
End Class
