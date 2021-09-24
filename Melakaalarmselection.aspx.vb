
Partial Class alarmselection
    Inherits System.Web.UI.Page

    Protected Sub alarmselection_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles alarmselection.SelectedIndexChanged
        If alarmselection.SelectedItem.Text = "Alarm History" Then
            Response.Redirect("MelakaAlarm.aspx")
        ElseIf alarmselection.SelectedItem.Text = "Alarm Selection" Then
            Response.Redirect("MelakaNewAlarm.aspx")
        End If
    End Sub
End Class
