Imports System.Data
Imports System.Data.Odbc
Partial Class AddDispatchSamb
    Inherits System.Web.UI.Page
    Dim Str_Conn As String = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
    Dim odbc_Conn As OdbcConnection
    Dim str As String = ""
    Dim ds As New DataSet()
    Dim dr As OdbcDataReader
    Dim cmd As OdbcCommand
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        odbc_Conn = New OdbcConnection(Str_Conn)
        If Page.IsPostBack = False Then
            ddlDistrict.Items.Clear()
            loadDistrict()
        End If
    End Sub
    Protected Sub ddlDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDistrict.SelectedIndexChanged
        ddlSiteName.Items.Clear()
        loadSite()
    End Sub
    Protected Sub loadDistrict()
        Try
            odbc_Conn = New OdbcConnection(Str_Conn)
            ddlDistrict.Items.Add(New ListItem("-Select District-", "0"))
            ddlSiteName.Items.Add(New ListItem("-Select Site-", "0"))
            str = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table WHERE sitetype='RESERVOIR' AND sitedistrict IN ('Alor Gajah','Jasin','Melaka Tengah') ORDER BY sitedistrict"
            odbc_Conn.Open()
            cmd = New OdbcCommand(str, odbc_Conn)
            dr = cmd.ExecuteReader()
            Do While dr.Read()
                ddlDistrict.Items.Add(New ListItem(dr("sitedistrict").ToString(), dr("sitedistrict").ToString()))
            Loop
            dr.Close()
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message())
        End Try
    End Sub
    Protected Sub loadSite()
        Try

            str = "SELECT siteid,sitename from telemetry_site_list_table WHERE sitedistrict='" & ddlDistrict.SelectedValue & "' and sitetype='RESERVOIR' order by sitename"
            ' Response.Write(str)
            odbc_Conn.Open()
            cmd = New OdbcCommand(str, odbc_Conn)
            dr = cmd.ExecuteReader()
            Do While dr.Read()
                'chkSite.Items.Add(New ListItem(dr("sitename").ToString(), dr("siteid").ToString()))
                ddlSiteName.Items.Add(New ListItem(dr("sitename").ToString(), dr("siteid").ToString()))
            Loop
            dr.Close()
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message())
        End Try
    End Sub
    Protected Sub LoadRule()
        Dim da As New System.Data.OleDb.OleDbDataAdapter()
        Dim ds As New Data.DataSet()
        Dim sqlRs As New ADODB.Recordset()
        Dim sqlRs2 As New ADODB.Recordset()
        Dim adocon As New ADODB.Connection()
        Dim cmd As New ADODB.Command
        Dim istep As Integer
        Try
            adocon.ConnectionString = "DSN=sambsql;UID=gussbee28;PWD=$mango#17;"
            adocon.Open()
            istep = 1
            'sqlRs.CursorLocation = ADODB.CursorLocationEnum.adUseClient
            'sqlRs.CursorType = ADODB.CursorTypeEnum.adOpenStatic
            'sqlRs.LockType = ADODB.LockTypeEnum.adLockBatchOptimistic
            str = "Select ruleid, alarmtype, position from telemetry_rule_list_table " & _
                                         "where siteid ='" & ddlSiteName.SelectedValue & "' and dispatch='1'"

            ' Response.Write(str)
            sqlRs = adocon.Execute(str)
            istep = 2
            Do While Not sqlRs.EOF
                str = "Select sdesc from telemetry_equip_list_table " & _
                                       "where siteid ='" & ddlSiteName.SelectedValue & "' and position=" & sqlRs.Fields("position").Value & ""
                sqlRs2 = adocon.Execute(str)
                Do While Not sqlRs2.EOF
                    ddlVehicle.Items.Add(New ListItem(sqlRs2.Fields("sdesc").Value & ":" & sqlRs.Fields("alarmtype").Value, sqlRs.Fields("ruleid").Value))
                    sqlRs2.MoveNext()
                Loop
                sqlRs.MoveNext()
            Loop
            istep = 3
            'sqlRs2.Close()
            'sqlRs.Close()
            adocon.Close()
        Catch ex As Exception
            Response.Write("LoadRule" & ex.Message() & CStr(istep))
        End Try
    End Sub
    Protected Sub LoadContact()
        Try
            str = "SELECT * from telemetry_contact_list_table ORDER BY sname, simno"
            ' Response.Write(str)
            odbc_Conn.Open()
            cmd = New OdbcCommand(str, odbc_Conn)
            dr = cmd.ExecuteReader()
            Do While dr.Read()
                'chkSite.Items.Add(New ListItem(dr("sitename").ToString(), dr("siteid").ToString()))
                ddlContact.Items.Add(New ListItem(dr("sname").ToString() & ":" & dr("simno").ToString(), dr("sname").ToString() & ":" & dr("simno").ToString()))
            Loop
            dr.Close()
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            Response.Write("Load Contact :" & ex.Message())
        End Try
    End Sub
    Protected Sub ddlSiteName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSiteName.SelectedIndexChanged
        ddlVehicle.Items.Clear()
        LoadRule()
        LoadContact()
    End Sub

    Protected Sub ibSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibSubmit.Click
        Try
            Dim strsql As String
            Dim istep As Integer
            odbc_Conn.Open()
            For i As Integer = 0 To ddlContact.Items.Count - 1
                If ddlContact.Items(i).Selected Then
                    Dim userdata() As String = Split(ddlContact.Items(i).Value, ":")
                    For j As Integer = 0 To ddlVehicle.Items.Count - 1
                        istep = 2
                        If ddlVehicle.Items(j).Selected Then
                            istep = 3
                            ' strsql = 
                            cmd = odbc_Conn.CreateCommand()
                            cmd.CommandText = "Insert into telemetry_dispatch_list_table(ruleid,simno,priority,sname,post) Values ('" & ddlVehicle.Items(j).Value & "','" & userdata(1) & "','" & Trim(txtPriority.Text) & "','" & userdata(0) & "','""')"
                            'New OdbcCommand(str, odbc_Conn)
                            cmd.ExecuteNonQuery()
                            'Response.Write(strsql & "<br />")
                        End If
                    Next
                End If
            Next
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
