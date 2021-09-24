Imports System.Data
Imports System.Data.SqlClient

Partial Class operatorPolling
    Inherits System.Web.UI.Page
    Dim Str_Conn As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
    Dim odbc_Conn As SqlConnection
    Dim str As String = ""
    Dim ds As New DataSet()
    Dim dr As SqlDataReader
    Dim cmd As SqlCommand
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        odbc_Conn = New SqlConnection(Str_Conn)
        If Page.IsPostBack = False Then
            ddDistrict.Items.Clear()
            loadDistrict()
        End If
        chkSite.Attributes.Add("onclick", "CheckBoxListSelect('" & chkSite.ClientID & "')")
        ddDistrict.Attributes.Add("onchange", "clearList()")
    End Sub

    Protected Sub ddDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddDistrict.SelectedIndexChanged
        lblMessage.Text = "Idle"
        Try
            chkSite.Items.Clear()
            str = "SELECT s.unitid,s.sitename, u.unitid,u.versionid,u.simno FROM unit_list u INNER JOIN telemetry_site_list_table s " & "on u.unitid=s.unitid WHERE  s.sitedistrict='" & ddDistrict.SelectedValue & "' and versionid not in('F1','S1','R1','F2') order by s.unitid"
            '  Response.Write(str)
            'str = "SELECT siteid,sitename FROM telemetry_site_list_table WHERE sitedistrict='" & ddDistrict.SelectedValue & "' AND sitetype='RESERVOIR' ORDER BY sitename"
            odbc_Conn.Open()
            cmd = New SqlCommand(str, odbc_Conn)
            dr = cmd.ExecuteReader()
            Do While dr.Read()
                'chkSite.Items.Add(New ListItem(dr("sitename").ToString(), dr("siteid").ToString()))
                chkSite.Items.Add(New ListItem(dr("simno").ToString() & ":  " & dr("unitid").ToString() & ":  " & dr("sitename").ToString() & ":  " & dr("versionid").ToString(), dr("simno").ToString() & ":  " & dr("unitid").ToString() & ":  " & dr("sitename").ToString() & ":  " & dr("versionid").ToString()))
            Loop
            dr.Close()
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            'Response.Write(ex.Message())
        End Try
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Try
            Dim strSub As String()
            Dim strDate As String = Now.ToString("yyyy/MM/dd HH:mm:ss")
            Dim commStr As String = ""
            Select Case rdOption.SelectedValue
                Case 0
                    commStr = "(C0123456789;27)" ' Yesterday 4 - 12
                Case 1
                    commStr = "(C0123456789;26)" ' Yesterday 8 - 4
                Case 2
                    commStr = "(C0123456789;25)" ' Yesterday 12 - 8
                Case 3
                    commStr = "(C0123456789;24)" ' Today 4 - 12
                Case 4
                    commStr = "(C0123456789;23)" ' Today 8 - 4
                Case 5
                    commStr = "(C0123456789;22)" ' Today 12 - 8
                Case 6
                    commStr = "(C0123456789;20)" ' Get Current Status
                Case 7
                    commStr = "(PGUS;01" & ddCenter.SelectedValue & ")" ' Set Center Number
                    'smscTXT.SetFocus
                Case 8
                    commStr = "(SGUS;" & Now.ToString("yyyy/MM/dd") & Now.ToString("HH:mm") & ")"
            End Select
            odbc_Conn.Open()

            For i As Int32 = 0 To chkSite.Items.Count - 1
                If chkSite.Items(i).Selected = True Then
                    strSub = Split(chkSite.Items(i).Text, ":")

                    str = "INSERT INTO sms_outbox_table VALUES('" & strSub(0) & "','" & strDate & "','" & Now.AddDays(1).ToString("yyyy/MM/dd HH:mm:ss") & "',0,'" & commStr & "','None','0','" & strDate & "',0)"
                    ' Response.Write(str & "<br />")

                    cmd = New SqlCommand(str, odbc_Conn)
                    cmd.ExecuteNonQuery()
                    cmd.Dispose()


                    chkSite.Items(i).Selected = False
                End If
            Next
            lblMessage.Text = "Done"
            odbc_Conn.Close()
            chkh.Checked = False
        Catch ex As Exception
            Response.Write(ex.Message())
        End Try
    End Sub

    Protected Sub btnReset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReset.Click
        try
            odbc_Conn.Open()
            Response.Write("INSERT INTO site_reset VALUES('" & Now.ToString("yyyy/MM/dd HH:mm:ss") & "','iisreset')")
            cmd = New SqlCommand(str, odbc_Conn)
            cmd.ExecuteNonQuery()
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message())
        End Try
    End Sub
    Protected Sub loadDistrict()
            Try
            odbc_Conn = New SqlConnection(Str_Conn)
                ddDistrict.Items.Add(New ListItem("-Select District-", "0"))
            If ddlState.SelectedValue = "Melaka" Then
                str = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table WHERE sitetype='RESERVOIR' AND sitedistrict IN ('Alor Gajah','Jasin','Melaka Tengah') ORDER BY sitedistrict"
            ElseIf ddlState.SelectedValue = "Sabah" Then
                str = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table WHERE sitetype='RESERVOIR' AND sitedistrict in ('Sipitang','Beaufort','Tambunan','Tenom','Keningau','Papar','penampang','Tuaran','Gaya Park','Telupid','Ranau') ORDER BY sitedistrict"
            Else
                str = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table WHERE sitetype='RESERVOIR' AND sitedistrict in ('Besut','Dungun','Hulu Terengganu','Kemaman','Kuala Terengganu','Setiu') ORDER BY sitedistrict"
            End If

                odbc_Conn.Open()
            cmd = New SqlCommand(str, odbc_Conn)
                dr = cmd.ExecuteReader()
                Do While dr.Read()
                    ddDistrict.Items.Add(New ListItem(dr("sitedistrict").ToString(), dr("sitedistrict").ToString()))
                Loop
                dr.Close()
                cmd.Dispose()
                odbc_Conn.Close()
            Catch ex As Exception
            Response.Write(ex.Message())
            End Try
    End Sub
    Protected Sub ddlState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlState.SelectedIndexChanged
        lblMessage.Text = "Idle"
        ddDistrict.Items.Clear()
        chkSite.Items.Clear()
        loadDistrict()
    End Sub
End Class
