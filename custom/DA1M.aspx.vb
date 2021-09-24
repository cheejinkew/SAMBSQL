
Imports System.Data.SqlClient

Partial Class custom_DA1M
    Inherits System.Web.UI.Page
    Public strsiteid As String = "S1H3"
    Public damsitename As String = "Test"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Try
            strsiteid = Request.QueryString("ID")
            If strsiteid = "" Then
                strsiteid = "DA1M"
            End If
            ' Response.Write("Test" & strsiteid)
            damsitename = Getsitename(strsiteid)
            '    damsitename = "Tetst"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Public Function Getsitename(ByVal siteid As String) As String
        Dim Cmd As SqlCommand
        Dim Con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB").ToString())
        Dim dr As SqlDataReader
        Dim Query As String = ""
        Dim sitename As String = ""
        Try
            Query = "select sitename from telemetry_site_list_table where siteid ='" & siteid & "'"
            Cmd = New SqlCommand(Query, Con)
            Con.Open()
            dr = Cmd.ExecuteReader()
            If dr.HasRows Then
                If dr.Read() Then
                    'Response.Write("Test" & dr("sitename").ToString())
                    sitename = dr("sitename").ToString()
                End If
            Else
                sitename = "test"
            End If

            dr.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return sitename
    End Function

End Class
