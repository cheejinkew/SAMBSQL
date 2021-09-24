Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class AndroidSiteDistrict
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim strDist As String = ""
            strDist = Request.QueryString("sd")

            If IsNothing(strDist) Then
                strDist = ""
            End If

            GetJson(strDist)
        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

    End Sub

    Protected Function GetJson(ByVal SiteDist As String) As String

        Dim countLogin As Integer = 0
        Dim Json As String = ""
        Dim JsonArr As ArrayList = New ArrayList

        Try

            Dim connstr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
            Dim conn As New SqlConnection(connstr)
            Dim cmd As New SqlCommand("SELECT distinct(sitetype) from telemetry_site_list_table where sitedistrict = @siteDist and sitetype in ('RESERVOIR','BPH') ", conn)
            With cmd.Parameters
                .Add(New SqlParameter("@siteDist", SiteDist))
            End With

            conn.Open()
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                Dim temp As New ReturnData()
                temp.SiteType = dr("sitetype")
                JsonArr.Add(temp)
            End While
            conn.Close()

            Json = "{" & """JsonData""" & ":" & JsonConvert.SerializeObject(JsonArr) & "}"

            Context.Response.ContentType = "application/json"
            Context.Response.Write(Json)

        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

        Return Json

    End Function

    Private Structure ReturnData
        Public SiteType As String
    End Structure
End Class
