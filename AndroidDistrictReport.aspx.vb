Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class AndroidSiteDistrict
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim SiteDist As String = Request.QueryString("sd")

            If (IsNothing(SiteDist)) Then
                SiteDist = ""
            End If

            GetJson(SiteDist)

        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

    End Sub

    Protected Function GetJson(ByVal sDist As String) As String

        Dim countLogin As Integer = 0
        Dim Json As String = ""
        Dim JsonArr As ArrayList = New ArrayList

        Try

            Dim connstr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
            Dim conn As New SqlConnection(connstr)
            Dim cmd As New SqlCommand("SELECT distinct(sl.sitename) as sitename, es.dtimestamp, es.value FROM telemetry_site_list_table sl left outer join telemetry_equip_status_table es on sl.siteid = es.siteid where sl.sitedistrict = @SiteDist and sl.sitetype = 'RESERVOIR' and es.position='2' order by sl.sitename", conn)
            With cmd.Parameters
                .Add(New SqlParameter("@SiteDist", sDist))
            End With

            conn.Open()
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                Dim temp As New ReturnData()

                If IsDBNull(dr("sitename")) Then
                    temp.SiteName = "-"
                Else
                    temp.SiteName = dr("sitename")
                End If

                If IsDBNull(dr("dtimestamp")) Then
                    temp.TimeStamp = "-"
                Else
                    Dim strTemp As Date = dr("dtimestamp")
                    temp.TimeStamp = strTemp.ToString("MM/dd/yyyy HH:mm:ss tt")
                End If

                If IsDBNull(dr("value")) Then
                    temp.Level = "-"
                Else
                    Dim tempValue As Double = dr("value")
                    temp.Level = tempValue.ToString("N2")
                End If

                JsonArr.Add(temp)
            End While
            conn.Close()

            If JsonArr.Count < 1 Then
                Dim temp As New ReturnData()

                temp.SiteName = "-"
                temp.TimeStamp = "-"
                temp.Level = "-"

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
        Public SiteName As String
        Public TimeStamp As String
        Public Level As String
    End Structure
End Class
