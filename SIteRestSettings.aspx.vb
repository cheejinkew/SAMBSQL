Imports System.Data
Imports System.Data.SqlClient

Partial Class SIteRestSettings
    Inherits System.Web.UI.Page 
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then

            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
            Dim cmd As SqlCommand

            Dim ds As New DataSet

            Try
                Dim strQuery As String = "SELECT distinct(sitedistrict) as sitedistrict from telemetry_site_list_table where  sitedistrict <>'' ORDER BY sitedistrict "
                cmd = New SqlCommand(strQuery, conn)
                conn.Open()
                Dim da As SqlDataAdapter
                da = New SqlDataAdapter(cmd)
                da.Fill(ds)
                ddlDistics.DataSource = ds.Tables(0)
                ddlDistics.DataValueField = "sitedistrict"
                ddlDistics.DataTextField = "sitedistrict"
                ddlDistics.DataBind()
                ddlDistics.Items.Insert(0, "Select District")
                ddlDistics.Items.Insert(1, "ALL")
                Getsettings()
            Catch ex As Exception

            End Try

        End If

    End Sub

    Protected Sub ddlDistics_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDistics.SelectedIndexChanged
        Getsettings()
    End Sub

    Public Sub Getsettings()
        Dim dt As New DataTable
        dt.Columns.Add("sno")
        dt.Columns.Add("District")
        dt.Columns.Add("siteid")
        dt.Columns.Add("Sitename")
        dt.Columns.Add("Timestamp")
        dt.Columns.Add("IsUpdate")
        dt.Columns.Add("Level")
        dt.Columns.Add("Status")

        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim sb As StringBuilder
        Dim sb1 As StringBuilder
        Dim prevsiteid As String = ""
        Dim presentsiteid As String = ""
        Dim prevphno As String = ""
        Dim presentphno As String = ""
        Dim ds As New DataTable
        Dim dr As SqlDataReader
        Dim cmd As SqlCommand
        Dim aaa As ArrayList
        Dim aa As ArrayList
        Dim a As ArrayList

        Try
            Dim strQuery As String
            If ddlDistics.SelectedValue = "ALL" Then
                strQuery = " select st.siteid ,t.dtimestamp,t.value,t.sevent ,st.sitename ,st.sitedistrict,et.position   from telemetry_equip_status_table t right outer join telemetry_site_list_table st on t.siteid =st.siteid left outer join telemetry_equip_list_table et on st.siteid =et.siteid and t.position =et.position  where  ((t.value is null and t.position is null) or t.position =2)   and st.sitetype ='RESERVOIR' order by st.sitedistrict"
                ' strQuery = "select st.siteid ,t.dtimestamp,t.value,t.sevent ,st.sitename ,st.sitedistrict  from telemetry_equip_status_table t right outer join telemetry_site_list_table st on t.siteid =st.siteid  where t.position =2 and st.sitetype ='RESERVOIR' order by st.sitedistrict "
            Else
                strQuery = " select st.siteid ,t.dtimestamp,t.value,t.sevent ,st.sitename ,st.sitedistrict,et.position   from telemetry_equip_status_table t right outer join telemetry_site_list_table st on t.siteid =st.siteid left outer join telemetry_equip_list_table et on st.siteid =et.siteid and t.position =et.position  where  ((t.value is null and t.position is null) or t.position =2) and st.sitedistrict ='" & ddlDistics.SelectedValue & "'  and st.sitetype ='RESERVOIR' order by st.sitedistrict"
                'strQuery = "select st.siteid ,t.dtimestamp,t.value,t.sevent ,st.sitename ,st.sitedistrict  from telemetry_equip_status_table t right outer join telemetry_site_list_table st on t.siteid =st.siteid  where t.position =2 and st.sitetype ='RESERVOIR' and st.sitedistrict ='" & ddlDistics.SelectedValue & "' order by st.sitedistrict "
            End If
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            aaa = New ArrayList()
            aa = New ArrayList()
            Dim sno As Int16 = 1
            While (dr.Read())
                Dim dtr As DataRow
                sb = New StringBuilder()
                dtr = dt.NewRow
                dtr(0) = sno
                dtr(1) = dr("sitedistrict")
                dtr(2) = dr("siteid")
                dtr(3) = dr("sitename")
                If IsDBNull(dr("dtimestamp")) Then
                    dtr(4) = "-"
                    dtr(5) = "-"
                Else
                    dtr(4) = Convert.ToDateTime(dr("dtimestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                    If DateDiff(DateInterval.Minute, DateTime.Now, Convert.ToDateTime(dr("dtimestamp"))) > 500 Then
                        dtr(5) = "No"
                    Else
                        dtr(5) = "Yes"
                    End If
                End If
                If IsDBNull(dr("value")) Then
                    dtr(6) = "-"
                Else
                    dtr(6) = dr("value")
                End If
                If IsDBNull(dr("sevent")) Then
                    dtr(7) = "-"
                Else
                    dtr(7) = dr("sevent")
                End If

                dt.Rows.Add(dtr)
                sno = sno + 1
            End While

            If (dt.Rows.Count = 0) Then
                Dim dar As DataRow
                dar = dt.NewRow()
                dar(0) = ""
                dar(1) = ""
                dar(2) = "No Data"
                dar(3) = ""
                dar(4) = ""
                dar(5) = ""
                dar(6) = ""
                dar(7) = ""
                dt.Rows.Add(dar)
            End If
            GvAlertsSettings.DataSource = dt
            GvAlertsSettings.DataBind()
            conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            conn.Close()
        End Try
    End Sub


        
    Protected Sub imgdelete_Click(sender As Object, e As System.EventArgs)
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Try
            Dim res As Integer
            Dim cmd As SqlCommand
            Dim btn As Button = DirectCast(sender, Button)
            Dim row As GridViewRow = DirectCast(btn.NamingContainer, GridViewRow)
            Dim siteid As String = row.Cells(2).Text
            Dim strQuery As String = ""
            strQuery = "delete from telemetry_equip_status_table where siteid='" & siteid & "' and position=2"
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            res = cmd.ExecuteNonQuery()
            If res > 0 Then
                Getsettings()
            End If
        Catch ex As Exception
            Response.Write("Reset: " & ex.Message)
        Finally
            conn.Close()
        End Try
    End Sub

    Protected Sub GvAlertsSettings_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GvAlertsSettings.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.Cells(5).Text = "Yes" Then
                    If e.Row.Cells(6).Text <> "-" Then
                        If Convert.ToSingle(e.Row.Cells(6).Text) > 10 Or Convert.ToSingle(e.Row.Cells(6).Text) < 0 Then
                            e.Row.ForeColor = Drawing.Color.Red
                        Else
                            e.Row.ForeColor = Drawing.Color.Green
                        End If
                    Else
                        e.Row.ForeColor = Drawing.Color.Red
                    End If 
                Else
                    e.Row.ForeColor = Drawing.Color.Red
                End If
            Catch ex As Exception

            End Try
        End If

    End Sub
End Class
