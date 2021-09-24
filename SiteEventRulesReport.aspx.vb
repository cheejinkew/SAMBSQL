Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.UI
Partial Class SiteEventRulesReport
    Inherits System.Web.UI.Page
    Public show As Boolean
    Public ec As String = "false"
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        GetEvent()
    End Sub
    Public Sub GetEvent()
        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim strsql As String
        Dim j As Integer = 0

        Dim dr As SqlDataReader
        Dim cmd As SqlCommand

        Dim dtEvents As New DataTable
        Dim r As DataRow
        With dtEvents.Columns
            .Add(New DataColumn("No"))
            .Add(New DataColumn("sitename"))
            .Add(New DataColumn("siteId"))
            .Add(New DataColumn("sitedistrict"))
            .Add(New DataColumn("Equipment"))
            .Add(New DataColumn("event"))
            .Add(New DataColumn("multiplier"))
        End With

        Try

            If cboEvents.SelectedValue.ToUpper() = "ALL" Then

                strsql = "select a.siteid,b.sitename ,b.sitedistrict ,c.sdesc,a.alarmtype ,a.multiplier  from telemetry_rule_list_table a inner join telemetry_site_list_table b on a.siteid =b.siteid inner join telemetry_equip_list_table c on a.position =c.position and a.siteid=c.siteid  order by b.sitedistrict ,a.siteid"

            Else

                strsql = "select a.siteid,b.sitename ,b.sitedistrict ,c.sdesc,a.alarmtype ,a.multiplier  from telemetry_rule_list_table a inner join telemetry_site_list_table b on a.siteid =b.siteid inner join telemetry_equip_list_table c on a.position =c.position and a.siteid=c.siteid where a.alarmtype='" & cboEvents.SelectedValue & "'  order by b.sitedistrict ,a.siteid"

            End If
            conn.Open()

            cmd = New SqlCommand(strsql, conn)
            cmd.CommandTimeout = 300
            dr = cmd.ExecuteReader()
            Dim intCount As Int16 = 0

            While dr.Read()

                intCount = intCount + 1
                r = dtEvents.NewRow

                    r(0) = intCount 'No
                    r(1) = dr("sitename").ToString()
                    r(2) = dr("siteid").ToString()
                    r(3) = dr("sitedistrict").ToString() 'siteid
                    r(4) = dr("sdesc").ToString() 'value
                    r(5) = dr("alarmtype").ToString() 'value
                    r(6) = dr("multiplier").ToString() 'value

                dtEvents.Rows.Add(r)
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


            GridView1.DataSource = dtEvents
            GridView1.DataBind()

            ec = "true"
            Session("exceltable") = dtEvents
        Catch ex As Exception
            Response.Write("Events" & ex.Message)
        End Try
    End Sub
End Class
