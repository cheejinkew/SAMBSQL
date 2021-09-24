Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class AndroidSiteDistrict
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim SiteDist As String = Request.QueryString("sd")
            Dim SiteType As String = Request.QueryString("st")

            If IsNothing(SiteDist) Then
                SiteDist = ""
            End If

            If IsNothing(SiteType) Then
                SiteType = ""
            End If

            GetJson(SiteType, SiteDist)
        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

    End Sub

    Protected Function GetJson(ByVal sType As String, ByVal sDist As String) As String

        Dim countLogin As Integer = 0
        Dim Json As String = ""
        Dim JsonArr As ArrayList = New ArrayList

        Try

            Dim connstr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
            Dim conn As New SqlConnection(connstr)
            Dim cmd As New SqlCommand
            If sType = "RESERVOIR" Then
                cmd = New SqlCommand("SELECT distinct(sitename) from telemetry_site_list_table where sitetype = @SiteType and sitedistrict = @SiteDist order by sitename", conn)
            ElseIf sType = "BPH" Then
                cmd = New SqlCommand("select t1.sitename+'_'+t2.sdesc  as sitename  from telemetry_site_list_table  t1 inner join telemetry_equip_list_table t2 on t1.siteid =t2.siteid where t1.sitetype  =@SiteType  and t1.sitedistrict = @SiteDist and SUBSTRING(t2.sdesc ,1,5)='LEVEL'", conn)
            End If
            'Dim cmd As New SqlCommand("SELECT distinct(sitename) from telemetry_site_list_table where sitetype = @SiteType and sitedistrict = @SiteDist order by sitename", conn)
            With cmd.Parameters
                .Add(New SqlParameter("@SiteType", sType))
                .Add(New SqlParameter("@SiteDist", sDist))
            End With

            conn.Open()
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                Dim temp As New ReturnData()
                temp.SiteName = dr("sitename")
                JsonArr.Add(temp)
            End While
            conn.Close()

            If JsonArr.Count = 0 Then
                Dim temp As New ReturnData()
                temp.SiteName = "-"
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
    End Structure
End Class
