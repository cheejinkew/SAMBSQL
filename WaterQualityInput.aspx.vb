Imports System.Data.SqlClient
Imports System.Data
Imports System.Math
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports System.Windows.Forms

Partial Class WaterQualityInput
    Inherits System.Web.UI.Page

    Dim strConn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
    Public ec As String = "false"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        If IsPostBack = False Then
            txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
            load_district()
        End If
    End Sub

    Public Sub load_district()
        strConn.Open()
        Dim strSql As New SqlCommand("select distinct(sitedistrict)  from telemetry_site_list_table", strConn)

        Dim dr As SqlDataReader = strSql.ExecuteReader

        While dr.Read()
            If dr("sitedistrict").ToString = "Testing" Then
                Exit While
            End If
            ddlSiteDistrict.Items.Add(New ListItem(dr("sitedistrict").ToString, dr("sitedistrict").ToString))

        End While
        strConn.Close()
    End Sub

    Public Sub load_sitename()

        strConn.Open()
        Dim strSql4 As String = ""
        Dim dr As SqlDataReader

        strSql4 = "select sitename,siteid from telemetry_site_list_table where sitedistrict ='" & ddlSiteDistrict.SelectedValue & "' order by sitename asc"

        Dim strSql5 As New SqlCommand(strSql4, strConn)
        dr = strSql5.ExecuteReader

        While dr.Read
            ddlSiteName.Items.Add(New ListItem(dr("sitename").ToString, dr("siteid").ToString))
        End While

        strConn.Close()

    End Sub
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Try

            Dim cmd As New SqlCommand()
            cmd = strConn.CreateCommand()
            If Not checkexist() Then
                cmd.CommandText = "Insert into telemetry_waterquality_maintainence(sitedist,siteid,timestamp,rawwater,treatedwater) Values ('" & ddlSiteDistrict.SelectedValue & "','" & ddlSiteName.SelectedValue & "','" & Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy/MM/dd") & "','" & txtrawwater.Value & "','" & txttreated.Value & "')"
            Else
                cmd.CommandText = "update telemetry_waterquality_maintainence set sitedist='" & ddlSiteDistrict.SelectedValue & "' , rawwater='" & txtrawwater.Value & "',treatedwater='" & txttreated.Value & "' where siteid='" & ddlSiteName.SelectedValue & "' and timestamp ='" & Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy/MM/dd") & "'"
            End If
            strConn.Open()
            cmd.ExecuteNonQuery()

        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            strConn.Close()
            txtrawwater.Value = ""
            txttreated.Value = ""
        End Try
    End Sub


    Public Function checkexist() As Boolean
        Dim res As Boolean = False
        Try
            strConn.Open()
            Dim strSql As New SqlCommand("select  * from telemetry_waterquality_maintainence where siteid='" & ddlSiteName.SelectedValue & "'  and timestamp ='" & Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy/MM/dd") & "'", strConn)

            Dim dr As SqlDataReader = strSql.ExecuteReader

            If dr.Read() Then
                res = True
            End If
            strConn.Close()
        Catch ex As Exception
        Finally
            strConn.Close()
        End Try
        Return res
    End Function
    Protected Sub ddlSiteDistrict_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSiteDistrict.SelectedIndexChanged
        ddlSiteName.Items.Clear()
        load_sitename()
    End Sub
End Class
