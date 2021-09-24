Imports System.Text
Imports System.Data
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class gettrendingjson
    Inherits System.Web.UI.Page
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            Dim siteid As String = Request.QueryString("sid")
            Dim fromdate As String = Request.QueryString("fd")
            Dim todate As String = Request.QueryString("td")
            FillTrending(siteid, fromdate, todate)
        Catch ex As Exception

        End Try
    End Sub

    Public Sub FillTrending(ByVal siteid As String, ByVal fromdate As String, ByVal todate As String)
        Dim tdata As trenddata = New trenddata()
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Try
            Dim strquery As String = "select siteid,dtimestamp ,value  from telemetry_log_table  where siteid='" & siteid & "' and position='2' and dtimestamp between @from and @todate"
            cmd = New SqlCommand(strquery, conn)
            cmd.Parameters.AddWithValue("@from", fromdate)
            cmd.Parameters.AddWithValue("@todate", todate)
            conn.Open()
            dr = cmd.ExecuteReader()
            Dim categories As List(Of category) = New List(Of category)()
            Dim datasets As List(Of dataset) = New List(Of dataset)()
            Dim dts As dataset = New dataset()
            Dim categ As category = New category()
            Dim dval As dataval = New dataval()
            Dim datavals As List(Of dataval) = New List(Of dataval)()
            dts.seriesname = "Level"
            While dr.Read
                categ.label = Convert.ToDateTime(dr("dtimestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                dval.value = dr("value")
                datavals.Add(dval)
                categories.Add(categ)
            End While
            dts.data = datavals
            datasets.Add(dts)
            tdata.categories = categories
            tdata.datasets = datasets

            Dim json As String = JsonConvert.SerializeObject(tdata, Formatting.None)
            Response.Write(json)
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            conn.Close()
        End Try
    End Sub

End Class
Public Structure trenddata
    Public categories As List(Of category)
    Public datasets As List(Of dataset)
End Structure
Public Structure category
    Public label As String
End Structure
Public Structure dataset
    Public seriesname As String
    Public data As List(Of dataval)
End Structure

Public Structure dataval
    Public value As String
End Structure