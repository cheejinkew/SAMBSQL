
Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class DataClean
    Inherits System.Web.UI.Page
    Dim connectionString As String = "SAMBconnection"
    Protected Sub btnClean_Click(sender As Object, e As EventArgs) Handles btnClean.Click
        Dim res As reponce = New reponce
        Try

            Try
                Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings(connectionString))
                Dim cmd As SqlCommand = New SqlCommand()
                cmd.CommandText = "sp_ClearunwantedRawdata"
                cmd.Connection = conn
                conn.Open()
                If (cmd.ExecuteNonQuery() > 0) Then
                    res.errmsg = ""
                    res.result = "success"
                Else
                    res.errmsg = ""
                    res.result = "fail"
                End If
                cmd.Dispose()
                conn.Close()
            Catch ex As Exception
                res.errmsg = ex.Message
                res.result = "fail"
            End Try
        Catch ex As Exception

        End Try
        Response.Write(JsonConvert.SerializeObject(res))
    End Sub
    Public Structure reponce
        Public result As String
        Public errmsg As String
    End Structure
End Class
