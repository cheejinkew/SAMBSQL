Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Data
Partial Class WebQuery
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            Label1.Text = ""
            Label1.Visible = False
            Label1.ForeColor = Color.Green

            Dim query As String = QueryTextBox.Text.Trim()
            Dim password As String = Request.QueryString("p")

            If password = "GZiC9Y5Rmj71aSQq" Then
                If query.StartsWith("select") Then
                    Try
                        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
                        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
                        Dim ds As New DataSet
                        da.Fill(ds)

                        If ds.Tables(0).Rows.Count = 0 Then
                            Label1.Text = "0 records"
                            Label1.Visible = True
                        Else
                            GridView1.DataSource = ds.Tables(0)
                            GridView1.DataBind()
                        End If
                    Catch ex As Exception
                        Label1.ForeColor = Color.Red
                        Label1.Text = ex.Message
                        Label1.Visible = True
                    End Try
                ElseIf query.StartsWith("update") Then
                    Try
                        Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
                        Dim cmd As SqlCommand = New SqlCommand(query, conn)
                        Try
                            conn.Open()
                            Dim records As Int32 = cmd.ExecuteNonQuery()
                            Label1.Text = records.ToString() & " records affected"
                            Label1.Visible = True
                        Catch ex As Exception
                            Label1.ForeColor = Color.Red
                            Label1.Text = ex.Message
                            Label1.Visible = True
                        End Try
                    Catch ex As Exception
                        Label1.ForeColor = Color.Red
                        Label1.Text = ex.Message
                        Label1.Visible = True
                    End Try
                End If
            Else

            End If
        Catch ex As Exception
            Label1.ForeColor = Color.Red
            Label1.Text = ex.Message
            Label1.Visible = True
        End Try
    End Sub
End Class
