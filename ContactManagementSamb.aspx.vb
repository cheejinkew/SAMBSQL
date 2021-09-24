Imports System.Data
Imports System.Data.Odbc
Partial Class ContactManagementSamb
    Inherits System.Web.UI.Page
    Dim Str_Conn As String = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
    Dim odbc_Conn As OdbcConnection
    Dim str As String = ""
    Dim ds As New DataSet()
    Dim dr As OdbcDataReader
    Dim cmd As OdbcCommand
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadContact()
    End Sub


    Protected Sub LoadContact()
        Dim istep As Integer
        Try
            Dim contactTable As New DataTable
            With contactTable.Columns
                .Add(New DataColumn("chk"))
                .Add(New DataColumn("sno"))
                .Add(New DataColumn("contactname"))
                .Add(New DataColumn("simno"))
                .Add(New DataColumn("post"))
                .Add(New DataColumn("district"))
            End With

            Dim r As DataRow
            Dim strsql As String
            Dim da As New System.Data.OleDb.OleDbDataAdapter()
            Dim ds As New Data.DataSet()
            Dim adocon As New ADODB.Connection()
            Dim sqlRs As New ADODB.Recordset()
            adocon.ConnectionString = Str_Conn
            adocon.Open()
            sqlRs.CursorLocation = ADODB.CursorLocationEnum.adUseClient
            sqlRs.CursorType = ADODB.CursorTypeEnum.adOpenStatic
            sqlRs.LockType = ADODB.LockTypeEnum.adLockBatchOptimistic
            strsql = "SELECT * from telemetry_contact_list_table ORDER BY cname, simno"
            istep = 1
            sqlRs.Open(strsql, adocon)
            sqlRs.ActiveConnection = Nothing
            adocon.Close()
            istep = 2
            da.Fill(ds, sqlRs, "contact")
            istep = 3
            For i As Integer = 0 To ds.Tables("contact").Rows.Count - 1
                r = contactTable.NewRow
                r(0) = "<input type=""checkbox"" name=""chk"" value=""" & ds.Tables("contact").Rows(i)("c_id") & """/>"
                r(1) = (i + 1).ToString
                r(2) = ds.Tables("contact").Rows(i)("cname")
                r(3) = ds.Tables("contact").Rows(i)("simno")
                r(4) = ds.Tables("contact").Rows(i)("cpost")
                r(5) = ""
                contactTable.Rows.Add(r)
            Next
            usersgrid.DataSource = contactTable
            usersgrid.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message() & "Step :" & CStr(istep))
        End Try
    End Sub
    Protected Sub DeleteUser()
        Try
            odbc_Conn = New OdbcConnection(Str_Conn)
            odbc_Conn.Open()
            ' Dim result As Byte = 0
            Dim userids() As String = Split(Request.Form("chk"), ",")
            For i As Int16 = 0 To userids.Length - 1
                cmd = odbc_Conn.CreateCommand()
                cmd.CommandText = "Delete from telemetry_contact_list_table where c_id='" & userids(i) & "'"
                cmd.ExecuteNonQuery()
            Next
            cmd.Dispose()
            odbc_Conn.Close()
            LoadContact()
        Catch ex As Exception
            Response.Write("Delete User" & ex.Message)
        End Try
    End Sub
   
    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        DeleteUser()
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        DeleteUser()
    End Sub
End Class
