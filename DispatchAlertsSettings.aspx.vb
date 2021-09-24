Imports System.Data
Imports System.Data.SqlClient

Partial Class DispatchAlertsSettings
    Inherits System.Web.UI.Page
    Dim status1() As String = {"AC Status", "DC Status"}
    Dim status2() As String = {"Pump Status", "Pump Trip Status", "Pump Remote Status"}
    Dim Status3() As String = {"L Status", "H Status", "LL Status", "HH Status"}
    Dim Status4() As String = {"Event 1", "Event 2", "Event 3", "Event 4"}

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then

            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
            Dim cmd As SqlCommand

            Dim ds As New DataSet

            Try
                Dim strQuery As String = "SELECT distinct(sitedistrict) as sitedistrict from telemetry_site_list_table  ORDER BY sitedistrict "
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
        dt.Columns.Add("Sitename")
        dt.Columns.Add("siteid")
        dt.Columns.Add("Dispatchno")
        dt.Columns.Add("alerts")

        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
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
                strQuery = "select distinct b.sitename, a.siteid from telemetry_bphwtp_alertsetting_table a,telemetry_site_list_table b where a.siteid=b.siteid   order by b.sitename"
            Else
                strQuery = "select distinct b.sitename, a.siteid from telemetry_bphwtp_alertsetting_table a,telemetry_site_list_table b where a.siteid=b.siteid  and b.sitedistrict='" & ddlDistics.SelectedValue & "' order by b.sitename"
            End If

            cmd = New SqlCommand(strQuery, conn)
            'cmd.CommandType = CommandType.StoredProcedure
            'cmd.CommandText = "sp_telemetry_alerts_setting"
            'cmd.Connection = conn
            'cmd.Parameters.AddWithValue("@distict", ddlDistics.SelectedValue)
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
                dtr(1) = dr("sitename")
                dtr(2) = dr("siteid")
                dtr(3) = ""
                dtr(4) = GetAlertsist(dr("siteid").ToString())
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
                dt.Rows.Add(dar)
            End If
            GvAlertsSettings.DataSource = dt
            GvAlertsSettings.DataBind()
            conn.Close()


        Catch ex As Exception
        Finally
            conn.Close()
        End Try
    End Sub
    Public Function Getmobileslist(ByVal siteid As String) As String
        Dim sb1 As New StringBuilder()
        Dim cmd As SqlCommand
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))

        Dim dr As SqlDataReader
        Try
            Dim strQuery As String = "select distinct dispatchno from telemetry_bphwtp_alertsetting_table where siteid='" & siteid & "'"
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            sb1.Append("<select style='width:180px;' id='ddlmobile' onchange='javascript:changemobileno();' >")
            While (dr.Read())
                sb1.Append("<option value='" & dr("dispatchno") & "'>" & dr("dispatchno") & "</option>")
            End While
            sb1.Append("</select>")
        Catch ex As Exception
        Finally
            conn.Close()
        End Try
        Return sb1.ToString()
    End Function
    Public Function GetAlertsist(ByVal siteid As String) As String
        Dim sb As New StringBuilder()
        Dim cmd As SqlCommand
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim key() As String = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35"}
        Dim value() As String = {"AC Status", "DC Status", "Pump1 Status", "Pump1 trip Status", "Pump1 Remote Status", "Pump2 Status", "Pump2 trip Status", "Pump2 Remote Status", "Pump3 Status", "Pump3 trip Status", "Pump3 Remote Status", "Pump4 Status", "Pump4 trip Status", "Pump4 Remote Status", "Pump5 Status", "Pump5 trip Status", "Pump5 Remote Status", "Pump6 Status", "Pump6 trip Status", "Pump6 Remote Status", "Pump7 Status", "Pump7 trip Status", "Pump7 Remote Status", "Pump8 Status", "Pump8 trip Status", "Pump8 Remote Status", "L1 Status", "H1 Status", "L2 Status", "H2 Status", "LL1 Status", "HH1 Status", "LL2 Status", "HH2 Status"}

        Dim dr As SqlDataReader
        Try
            Dim strQuery As String = "select distinct position from telemetry_bphwtp_alertsetting_table where siteid='" & siteid & "'"
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            sb.Append("<select style='width:180px;' ><optgroup label ='Active'>")
            While (dr.Read())
                If dr("position") < 38 Then
                    sb.Append("<option>" & value(Array.IndexOf(key, "" & dr("position") & "")) & "</option>")
                Else
                    sb.Append("<option>" & getequipmentname(siteid, dr("position")) & "</option>")
                End If
            End While
            sb.Append("</select>")
        Catch ex As Exception
        Finally
            conn.Close()
        End Try
        Return sb.ToString()
    End Function


    Public Function getequipmentname(ByVal siteid As String, ByVal position As String) As String
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand = New SqlCommand()
        Dim dr As SqlDataReader
        Dim result As String = "Nothing"
        Try
            cmd.CommandText = "select equipid from telemetry_equip_list_table where siteid='" & siteid & "' and position='" & position & "'"
            cmd.Connection = conn
            conn.Open()
            dr = cmd.ExecuteReader()
            If (dr.Read()) Then
                result = dr(0)
            End If
        Catch ex As Exception
        Finally
            conn.Close()
        End Try

        Return result
    End Function

    Protected Sub GvAlertsSettings_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GvAlertsSettings.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try

                Dim siteidlink As Label = e.Row.FindControl("LinkButton1")
                Dim siteid As String = siteidlink.Text
                If siteid = "No Data" Then
                    Dim ddlmobile As DropDownList = e.Row.FindControl("ddlmobile")
                    Dim btndelete As ImageButton = e.Row.FindControl("imgdelete")
                    Dim btnactive As Button = e.Row.FindControl("imgactive")
                    ddlmobile.Visible = False
                    btndelete.Visible = False
                    btnactive.Visible = False
                Else
                    Dim cmd As SqlCommand
                    Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
                    Dim ddlmobile As DropDownList = e.Row.FindControl("ddlmobile")
                    Dim btnactive As Button = e.Row.FindControl("imgactive")
                    Dim dr As SqlDataReader
                    Try
                        Dim strQuery As String = "select distinct dispatchno,status from telemetry_bphwtp_alertsetting_table where siteid='" & siteid & "'"
                        cmd = New SqlCommand(strQuery, conn)
                        conn.Open()
                        dr = cmd.ExecuteReader()

                        While (dr.Read())
                            Dim list As ListItem = New ListItem(dr("dispatchno"), dr("dispatchno"))
                            ddlmobile.Items.Add(list)
                            If dr("status") = True Then
                                btnactive.Text = "InActive"
                                btnactive.ToolTip = "Click To InActive"
                            Else
                                btnactive.CssClass = "action red"
                                btnactive.Text = "Active"
                                btnactive.ToolTip = "Click To Active"
                            End If
                        End While
                        If ddlmobile.Items.Count > 0 Then
                            ddlmobile.Items.Insert(0, "ALL")
                        End If

                    Catch ex As Exception
                    Finally
                        conn.Close()
                    End Try
                End If

            Catch ex As Exception

            End Try

        End If
    End Sub

    Protected Sub ddlmobile_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))

        Try
            Dim dr As SqlDataReader
            Dim cmd As SqlCommand
            Dim ddl As DropDownList = DirectCast(sender, DropDownList)
            Dim row As GridViewRow = DirectCast(ddl.NamingContainer, GridViewRow)
            Dim btn As Button = GvAlertsSettings.Rows(row.RowIndex).FindControl("imgactive")
            Dim siteid As Label = GvAlertsSettings.Rows(row.RowIndex).FindControl("LinkButton1")
            Dim strQuery As String
            If ddl.SelectedValue = "ALL" Then
                strQuery = "select distinct siteid from telemetry_bphwtp_alertsetting_table  where siteid='" & siteid.Text & "' and status=1"

            Else
                strQuery = "select distinct siteid from telemetry_bphwtp_alertsetting_table  where  siteid='" & siteid.Text & "' and dispatchno='" & ddl.SelectedValue & "' and status=1"

            End If

            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            If (dr.Read()) Then
                btn.CssClass = "action blue"
                btn.Text = "InActive"
                btn.ToolTip = "Click To InActive"
            Else
                btn.CssClass = "action red"
                btn.Text = "Active"
                btn.ToolTip = "Click To Active"
            End If

        Catch ex As Exception

        Finally
            conn.Close()
        End Try
    End Sub


    Protected Sub lnksitename_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim btn As LinkButton = DirectCast(sender, LinkButton)
            Dim row As GridViewRow = DirectCast(btn.NamingContainer, GridViewRow)
            Dim ddl As DropDownList = GvAlertsSettings.Rows(row.RowIndex).FindControl("ddlmobile")
            Dim siteid As Label = GvAlertsSettings.Rows(row.RowIndex).FindControl("LinkButton1")
            Dim dispatchstr As String = ""
            If ddl.SelectedValue = "ALL" Then
                For i As Integer = 1 To ddl.Items.Count - 1
                    If dispatchstr = "" Then
                        dispatchstr = ddl.Items(i).Value
                    Else
                        dispatchstr = dispatchstr & "," & ddl.Items(i).Value
                    End If
                Next
                Response.Redirect("SajWtpBhpAlertsSetting.aspx?siteid=" + siteid.Text + "&dispatchno=" + dispatchstr + "&opr=1")
            Else
                Response.Redirect("SajWtpBhpAlertsSetting.aspx?siteid=" + siteid.Text + "&dispatchno=" + ddl.SelectedValue + "&opr=1")
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub imgdelete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)

        Try
            Dim res As Integer
            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
            Dim cmd As SqlCommand
            Dim btn As ImageButton = DirectCast(sender, ImageButton)
            Dim row As GridViewRow = DirectCast(btn.NamingContainer, GridViewRow)
            Dim ddl As DropDownList = GvAlertsSettings.Rows(row.RowIndex).FindControl("ddlmobile")
            Dim siteid As Label = GvAlertsSettings.Rows(row.RowIndex).FindControl("LinkButton1")
            Dim strQuery As String
            If ddl.SelectedValue = "ALL" Then
                strQuery = "delete from telemetry_bphwtp_alertsetting_table where siteid='" & siteid.Text & "'"
            Else
                strQuery = "delete from telemetry_bphwtp_alertsetting_table where siteid='" & siteid.Text & "' and dispatchno='" & ddl.SelectedValue & "'"
            End If

            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            res = cmd.ExecuteNonQuery()
            If res > 0 Then
                Getsettings()
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub imgactive_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))

        Try
            Dim res As Integer
            Dim cmd As SqlCommand
            Dim btn As Button = DirectCast(sender, Button)
            Dim row As GridViewRow = DirectCast(btn.NamingContainer, GridViewRow)
            Dim ddl As DropDownList = GvAlertsSettings.Rows(row.RowIndex).FindControl("ddlmobile")
            Dim siteid As Label = GvAlertsSettings.Rows(row.RowIndex).FindControl("LinkButton1")
            Dim strQuery As String
            If ddl.SelectedValue = "ALL" Then
                If btn.Text = "Active" Then
                    strQuery = "update telemetry_bphwtp_alertsetting_table set status=1  where siteid='" & siteid.Text & "'"
                ElseIf btn.Text = "InActive" Then
                    strQuery = "update telemetry_bphwtp_alertsetting_table set status=0  where siteid='" & siteid.Text & "'"
                End If
            Else
                If btn.Text = "Active" Then
                    strQuery = "update telemetry_bphwtp_alertsetting_table set status=1  where siteid='" & siteid.Text & "' and dispatchno='" & ddl.SelectedValue & "'"
                ElseIf btn.Text = "InActive" Then
                    strQuery = "update telemetry_bphwtp_alertsetting_table set status=0  where siteid='" & siteid.Text & "' and dispatchno='" & ddl.SelectedValue & "'"
                End If
            End If


            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            res = cmd.ExecuteNonQuery()
            If res > 0 Then
                Getsettings()
            End If
        Catch ex As Exception
        Finally

            conn.Close()
        End Try

    End Sub
End Class
