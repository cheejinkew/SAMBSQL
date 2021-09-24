Imports System.Data
Imports System.Data.Odbc
Partial Class AddContactSamb
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
    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Try
            odbc_Conn = New OdbcConnection(Str_Conn)
            odbc_Conn.Open()
            cmd = odbc_Conn.CreateCommand()
            cmd.CommandText = "Insert into telemetry_contact_list_table(simno,cname,cpost,cstatus) Values ('" & Trim(txtSimno.Text) & "','" & Trim(txtContact.Text) & "','" & Trim(txtPost.Text) & "','1')"
            cmd.ExecuteNonQuery()
            cmd.Dispose()
            odbc_Conn.Close()
            Response.Redirect("ContactManagementSamb.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
   
  
    Protected Sub LoadContact()
        Try
            Dim contactid As Integer
            odbc_Conn = New OdbcConnection(Str_Conn)
            odbc_Conn.Open()
            str = "SELECT c_id from telemetry_contact_list_table ORDER BY c_id desc"
            cmd = New OdbcCommand(str, odbc_Conn)
            contactid = cmd.ExecuteScalar()
            txtID.Text = contactid + 1
            cmd.Dispose()
            odbc_Conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message())
        End Try
    End Sub
End Class
