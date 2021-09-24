
Partial Class DownloadChart
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Try
            Response.Clear()
            Response.ClearHeaders()
            Dim title As String = Request.QueryString("newtitle")
            Dim sessionStatus As String = Request.QueryString("sessionstatus")
            Response.ContentType = "image/png"
            If sessionStatus = "Chart" Then
                Response.BinaryWrite(Session("Chart"))
            ElseIf sessionStatus = "Chart2" Then
                Response.BinaryWrite(Session("Chart2"))
            ElseIf sessionStatus = "Chart3" Then
                Response.BinaryWrite(Session("Chart3"))
            ElseIf sessionStatus = "Chart4" Then
                Response.BinaryWrite(Session("Chart4"))
                'Else
                '    Response.Write("<script>alert('efwerwer');</script>")
            End If

            Response.AddHeader("Content-Disposition", "attachment; filename=" & title & ".png;")
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.Flush()
            Response.End()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
