Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Xml
Imports System.Runtime.Serialization
Imports Newtonsoft.Json
Imports System.Net

Partial Class AndroidLogin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim userName As String = ""
            Dim password As String = ""

            userName = Request.QueryString("u")
            password = Request.QueryString("p")

            If IsNothing(userName) Then
                userName = ""
            End If

            If IsNothing(password) Then
                password = ""
            End If

            GetJson(userName, password)

        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

    End Sub

    Protected Function GetJson(ByVal username As String, ByVal password As String) As String

        Dim countLogin As Integer = 0
        Dim ctrlDistrict As String = ""
        Dim Json As String = ""

        Try

            Dim connstr As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
            Dim conn As New SqlConnection(connstr)
            Dim cmd As New SqlCommand("select control_district from telemetry_user_table where username = @username and pwd = @password", conn)
            With cmd.Parameters
                .Add(New SqlParameter("@username", username))
                .Add(New SqlParameter("@password", password))
            End With

            conn.Open()

            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                countLogin += 1
                ctrlDistrict = dr("control_district")
            End While

            conn.Close()

            Json = "{" & """LoginCount""" & ":""" & countLogin & """," & """ControlDistrict""" & ":""" & ctrlDistrict & """}"

            Context.Response.ContentType = "application/json"
            Context.Response.Write(Json)

        Catch ex As Exception
            Throw New HttpException(ex.ToString())
        End Try

        Return Json

    End Function

End Class
