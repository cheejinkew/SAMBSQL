
Partial Class alarmselection
    Inherits System.Web.UI.Page

    Protected Sub alarmselection_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles alarmselection.SelectedIndexChanged
        If alarmselection.SelectedItem.Text = "Alarm History" Then
            Response.Redirect("Alarm.aspx")
        ElseIf alarmselection.SelectedItem.Text = "Alarm Selection" Then
            Response.Redirect("NewAlarm.aspx")
        End If
    End Sub
End Class
