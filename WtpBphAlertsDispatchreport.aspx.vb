Imports System.Data.SqlClient
Imports System.Data

Partial Class WtpBphAlertsDispatchreport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            txtfromdate.Text = Date.Now.ToString("yyyy/MM/dd")
            txtEnddate.Text = Date.Now.ToString("yyyy/MM/dd")

            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAJconnection"))
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
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAJconnection"))
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
            ddlsitename.Items.Insert(1, "ALL")
            ddlsitename.SelectedValue = "ALL"
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ddlsitename_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlsitename.SelectedIndexChanged
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAJconnection"))
        Dim cmd As SqlCommand

        Dim ds As New DataSet
        Dim strQuery As String = ""
        Try
            If ddlsitename.SelectedValue = "ALL" Then
                strQuery = "select distinct cname,simno from telemetry_contact_list_table where simno in (select distinct dispatchno  from telemetry_bphwtp_alertsetting_table) order by cname "
            Else
                strQuery = "select cname,simno from telemetry_contact_list_table where simno in (select dispatchno  from telemetry_bphwtp_alertsetting_table where siteid  ='" & ddlsitename.SelectedValue & "')"
            End If

            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            Dim da As SqlDataAdapter
            da = New SqlDataAdapter(cmd)
            da.Fill(ds)
            ddlEquipment.DataSource = ds.Tables(0)
            ddlEquipment.DataValueField = "simno"
            ddlEquipment.DataTextField = "cname"
            ddlEquipment.DataBind()
            ddlEquipment.Items.Insert(0, "Select Name")
            ddlEquipment.Items.Insert(1, "ALL")
            ddlEquipment.SelectedValue = "ALL"
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ddlEquipment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlEquipment.SelectedIndexChanged

    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAJconnection"))
        Dim cmd As SqlCommand
        Dim ds As New DataSet
        Dim strQuery As String = ""
        Dim dtrange As String
        Dim dr As SqlDataReader
        Dim dt As New DataTable
        dt.Columns.Add("sno")
        dt.Columns.Add("timestamp")
        dt.Columns.Add("siteid")
        dt.Columns.Add("sitename")
        dt.Columns.Add("Name")
        dt.Columns.Add("equiptype")
        dt.Columns.Add("value")
        dt.Columns.Add("alertevent")
        dtrange = "'" & txtfromdate.Text & " " & ddBeginHour.SelectedValue & ":" & ddBeginMinute.SelectedValue & "' and '" & txtEnddate.Text & " " & ddendHour.SelectedValue & ":" & ddendMinute.SelectedValue & "'"
        Try
            If ddldistrict.SelectedValue = "ALL" And ddltype.SelectedValue = "ALL" And ddlsitename.SelectedValue = "ALL" And ddlEquipment.SelectedValue = "ALL" Then
                strQuery = "select ROW_NUMBER() over (order by a.timestamp) as sno,a.timestamp, a.siteid,b.sitename ,a.position,a.[event], a.simno,c.equipname,d.cname,a.value   from telemetry_WtpBph_dispatch_history_table a left outer join telemetry_site_list_table b on a.siteid=b.siteid left outer join telemetry_equip_list_table c on a.siteid=c.siteid and a.position=c.position left outer join telemetry_contact_list_table d on a.simno=d.simno where  timestamp between " & dtrange & "  order by a.timestamp"
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue = "ALL" And ddlsitename.SelectedValue = "ALL" And ddlEquipment.SelectedValue = "ALL" Then
                strQuery = "select ROW_NUMBER() over (order by a.timestamp) as sno,a.timestamp, a.siteid,b.sitename ,a.position,a.[event], a.simno,c.equipname,d.cname,a.value   from telemetry_WtpBph_dispatch_history_table a left outer join telemetry_site_list_table b on a.siteid=b.siteid left outer join telemetry_equip_list_table c on a.siteid=c.siteid and a.position=c.position left outer join telemetry_contact_list_table d on a.simno=d.simno where  timestamp between " & dtrange & " and b.sitedistrict='" & ddldistrict.SelectedValue & "'  order by a.timestamp"
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue = "ALL" And ddlsitename.SelectedValue <> "ALL" And ddlEquipment.SelectedValue = "ALL" Then
                strQuery = "select ROW_NUMBER() over (order by a.timestamp) as sno,a.timestamp, a.siteid,b.sitename ,a.position,a.[event], a.simno,c.equipname,d.cname,a.value  from telemetry_WtpBph_dispatch_history_table a left outer join telemetry_site_list_table b on a.siteid=b.siteid left outer join telemetry_equip_list_table c on a.siteid=c.siteid and a.position=c.position left outer join telemetry_contact_list_table d on a.simno=d.simno where  a.siteid='" & ddlsitename.SelectedValue & "' and  timestamp between " & dtrange & " and b.sitedistrict='" & ddldistrict.SelectedValue & "'  order by a.timestamp"
            ElseIf ddldistrict.SelectedValue <> "ALL" And ddltype.SelectedValue = "ALL" And ddlEquipment.SelectedValue <> "ALL" Then
                strQuery = "select ROW_NUMBER() over (order by a.timestamp) as sno,a.timestamp, a.siteid,b.sitename ,a.position,a.[event], a.simno,c.equipname,d.cname,a.value  from telemetry_WtpBph_dispatch_history_table a left outer join telemetry_site_list_table b on a.siteid=b.siteid left outer join telemetry_equip_list_table c on a.siteid=c.siteid and a.position=c.position left outer join telemetry_contact_list_table d on a.simno=d.simno where  a.siteid='" & ddlsitename.SelectedValue & "' and  timestamp between " & dtrange & " and b.sitedistrict='" & ddldistrict.SelectedValue & "' and a.simno='" & ddlEquipment.SelectedValue & "'  order by a.timestamp"
            Else
                strQuery = "select ROW_NUMBER() over (order by a.timestamp) as sno,a.timestamp, a.siteid,b.sitename ,a.position,a.[event], a.simno,c.equipname,d.cname,a.value  from telemetry_WtpBph_dispatch_history_table a left outer join telemetry_site_list_table b on a.siteid=b.siteid left outer join telemetry_equip_list_table c on a.siteid=c.siteid and a.position=c.position left outer join telemetry_contact_list_table d on a.simno=d.simno where  a.siteid='" & ddlsitename.SelectedValue & "' and  timestamp between " & dtrange & "  order by a.timestamp"
            End If
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            While (dr.Read())
                Dim r As DataRow
                r = dt.NewRow
                r(0) = dr(0)
                r(1) = dr("timestamp")
                r(2) = dr("siteid")
                r(3) = dr("sitename")
                r(4) = dr("cname")
                r(5) = dr("equipname")
                r(6) = dr("value")
                r(7) = dr("event")
                dt.Rows.Add(r)
            End While

            If dt.Rows.Count > 0 Then
                For i As Integer = 0 To dt.Rows.Count - 1
                    If IsDBNull(dt.Rows(i)("equiptype")) Then
                        dt.Rows(i)("equiptype") = "Other"
                    Else
                        If dt.Rows(i)("equiptype") = "" Then
                            dt.Rows(i)("equiptype") = "Other"
                        End If
                    End If
                Next
            Else
                Dim r As DataRow
                r = dt.NewRow
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
            

            gvreport.DataSource = dt
            gvreport.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            conn.Close()
        End Try
    End Sub
End Class
