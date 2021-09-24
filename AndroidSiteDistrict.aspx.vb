Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class AndroidSiteDistrict
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim strCtrlDist As String = ""

            If Not Request.QueryString("cd") Is Nothing Then
                strCtrlDist = Request.QueryString("cd").TrimStart().TrimEnd()
            End If

            GetJson(strCtrlDist)
        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

    End Sub

    Protected Function GetJson(ByVal ctrlDist As String) As String

        Dim countLogin As Integer = 0
        Dim strCtrlDist As String = ctrlDist
        Dim Json As String = ""
        Dim JsonArr As ArrayList = New ArrayList
        Dim arrCtrlDist() As String = {}

        Try
            If ctrlDist.ToUpper <> "ALL" Then
                If ctrlDist.Length() > 1 Then
                    If ctrlDist.IndexOf(",") > -1 Then
                        arrCtrlDist = ctrlDist.Split(",")
                    End If
                End If
            End If

            If arrCtrlDist.Length > 0 Then

                strCtrlDist = ""

                For index As Integer = 0 To arrCtrlDist.Length - 1
                    strCtrlDist += "'" + arrCtrlDist(index) + "',"
                Next

                strCtrlDist = strCtrlDist.Substring(0, strCtrlDist.Length - 1)

            Else
                If strCtrlDist.Length > 0 Then
                    strCtrlDist = "'" + strCtrlDist + "'"
                End If

            End If

            Dim connstr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
            Dim conn As New SqlConnection(connstr)
            Dim cmd As New SqlCommand("SELECT distinct(sitedistrict) from telemetry_site_list_table", conn)

            If strCtrlDist.ToUpper <> "'ALL'" And strCtrlDist.Length > 0 Then
                cmd = New SqlCommand("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" + strCtrlDist + ")", conn)
            End If

            'Response.Write(strCtrlDist)
            conn.Open()
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                Dim temp As New ReturnData()
                temp.SiteDistict = dr("sitedistrict")
                JsonArr.Add(temp)
            End While
            conn.Close()

            If JsonArr.Count = 0 Then
                Dim temp As New ReturnData()
                temp.SiteDistict = "-"
                JsonArr.Add(temp)
            End If

            Json = "{" & """JsonData""" & ":" & JsonConvert.SerializeObject(JsonArr) & "}"

            Context.Response.ContentType = "application/json"
            Context.Response.Write(Json)

        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

        Return Json

    End Function

    Private Structure ReturnData
        Public SiteDistict As String
    End Structure
End Class
