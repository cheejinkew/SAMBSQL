Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class AndroidSiteDistrict
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim SiteDist As String = Request.QueryString("sd")
            Dim SiteType As String = Request.QueryString("st")
            Dim SiteName As String = Request.QueryString("sn")

            If IsNothing(SiteDist) Then
                SiteDist = ""
            End If

            If IsNothing(SiteType) Then
                SiteType = ""
            End If

            If IsNothing(SiteName) Then
                SiteName = ""
            End If

            GetJson(SiteName, SiteType, SiteDist)
        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

    End Sub

    Protected Function GetJson(ByVal sName As String, ByVal sType As String, ByVal sDist As String) As String

        Dim Json As String = ""
        Dim JsonArr As ArrayList = New ArrayList
        Dim bphsname As String = ""
        Dim bphsdesc As String = ""
        Try
            Dim connstr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
            Dim conn As New SqlConnection(connstr)
            Dim cmd As New SqlCommand
            'Dim cmd As New SqlCommand("SELECT value, dtimestamp from telemetry_equip_status_table where siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn)

            If sType = "RESERVOIR" Then
                cmd = New SqlCommand("SELECT value, dtimestamp from telemetry_equip_status_table where siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn)
                With cmd.Parameters
                    .Add(New SqlParameter("@SiteName", sName))
                    .Add(New SqlParameter("@SiteType", sType))
                    .Add(New SqlParameter("@SiteDist", sDist))
                End With
            ElseIf sType = "BPH" Then
                If sName.Split("_").Length > 0 Then
                    bphsname = sName.Split("_")(0)
                    bphsdesc = sName.Split("_")(1)
                End If
                cmd = New SqlCommand("select t1.value,t1.dtimestamp  from telemetry_equip_status_table t1 inner join telemetry_equip_list_table t2 on t1.siteid =t2.siteid  and t1.position=t2.position  where t1.siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist) and t2.sdesc=@bphsdec", conn)
                With cmd.Parameters
                    .Add(New SqlParameter("@SiteName", bphsname))
                    .Add(New SqlParameter("@SiteType", sType))
                    .Add(New SqlParameter("@SiteDist", sDist))
                    .Add(New SqlParameter("@bphsdec", bphsdesc))
                End With
            End If

            Dim cmd1 As New SqlCommand("SELECT alarmtype, multiplier from telemetry_rule_list_table where siteid=(Select siteid from telemetry_site_list_table where sitename = @SiteName and sitetype = @SiteType and sitedistrict = @SiteDist)", conn)
            With cmd1.Parameters
                .Add(New SqlParameter("@SiteName", sName))
                .Add(New SqlParameter("@SiteType", sType))
                .Add(New SqlParameter("@SiteDist", sDist))
            End With

            conn.Open()

            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()

                Dim temp As New ReturnData()

                temp.WaterLevel = dr("value")
                temp.Status = ""
                temp.TimeStamp = dr("dtimestamp")

                JsonArr.Add(temp)

            End While

            If JsonArr.Count > 0 Then

                Dim strStatusData As String = ""
                Dim tempData As ReturnData = JsonArr(0)

                Dim dr1 As SqlDataReader = cmd1.ExecuteReader()
                While dr1.Read()

                    Dim strTemp As String = dr1("multiplier")
                    Dim strStatus As String = dr1("alarmtype")
                    Dim strRange As String() = strTemp.Split(";")

                    strStatusData = strStatusData + "-" + strStatus + ";" + strTemp

                    If Double.Parse(tempData.WaterLevel) >= Double.Parse(strRange(1)) And Double.Parse(tempData.WaterLevel) <= Double.Parse(strRange(2)) Then
                        tempData.Status = strStatus
                    End If

                End While

                If strStatusData.Length > 0 Then
                    strStatusData = strStatusData.Substring(1, strStatusData.Length - 1)
                End If

                tempData.StatusData = strStatusData
                JsonArr(0) = tempData

            End If

            conn.Close()

            If JsonArr.Count = 0 Then
                Dim temp As New ReturnData()
                temp.WaterLevel = "0 meter"
                temp.Status = "-"
                temp.TimeStamp = "-"
                temp.StatusData = "-"
                JsonArr.Add(temp)
            Else
                Dim temp As ReturnData = JsonArr(0)
                temp.WaterLevel = temp.WaterLevel & " meters"
                JsonArr(0) = temp
            End If

            Json = JsonConvert.SerializeObject(JsonArr)
            Json = Json.Substring(1, Json.Length - 2)

            Context.Response.ContentType = "application/json"
            Context.Response.Write(Json)

        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

        Return Json

    End Function

    Private Structure ReturnData
        Public WaterLevel As String
        Public Status As String
        Public TimeStamp As String
        Public StatusData As String
    End Structure

End Class
