Imports System.Data.SqlClient
Imports System.Data


Partial Class UPDATEUSERR
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim getUserid As String = Request.QueryString("userid")

        Try

            Dim Myconn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBConnection"))
            Myconn.Open()
            Dim Mycomm As New SqlCommand("select * from telemetry_user_table where userid ='" & getUserid & "'", Myconn)


            Dim dt As New DataTable
            Dim ds As New DataSet
            Dim da As New SqlDataAdapter

            da.SelectCommand = Mycomm
            da.Fill(ds, "telemetry_user_table")


            OutUsername.Text = ds.Tables("telemetry_user_table").Rows(0).Item("username").ToString.ToUpper
            txtOldPass.Text = ds.Tables("telemetry_user_table").Rows(0).Item("pwd")
            txtPhoneno.Text = ds.Tables("telemetry_user_table").Rows(0).Item("phoneno")
            txtFaxNo.Text = ds.Tables("telemetry_user_table").Rows(0).Item("faxno")
            txtStreet.Text = ds.Tables("telemetry_user_table").Rows(0).Item("streetname")
            txtPostCode.Text = ds.Tables("telemetry_user_table").Rows(0).Item("postcode")
            dLState.Text = ds.Tables("telemetry_user_table").Rows(0).Item("sstate")
            ddLRole.Text = ds.Tables("telemetry_user_table").Rows(0).Item("srole")
            lstAccessible.Text = ds.Tables("telemetry_user_table").Rows(0).Item("control_district")

            Mycomm.ExecuteNonQuery()



        Catch ex As Exception
            MsgBox(ex.Message)
        End Try



    End Sub

 
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim userid As String = Request.QueryString("userid")

        Dim Myconn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBConnection"))
        Dim da As New SqlDataAdapter


        Dim NewPas As String = txtNewPass.Text
        Dim ComfirmPas As String = txtConfirmPass.Text
        

        If NewPas <> ComfirmPas Then
            lblNotMatch.Text = "New Password and Confirm Password NOT Match !"
        Else
            Dim Phoneno As String = Request.Form("txtPhoneno")
            Dim FaxNo As String = Request.Form("txtFaxNo")
            Dim Street As String = Request.Form("txtStreet")
            Dim PostCode As String = Request.Form("txtPostCode")
            Dim State As String = Request.Form("dLState")
            Dim role As String = Request.Form("ddLRole")
            Dim Ass As String = Request.Form("lstAccessible")


            Dim Mycomm As New SqlCommand("update telemetry_user_table set pwd ='" & ComfirmPas & "', phoneno='" & Phoneno & "', faxno='" & FaxNo & "', streetname = '" & Street & "' , postcode ='" & PostCode & "', sstate ='" & State & "',srole = '" & role & "' ,control_district='" & Ass & "' where userid = '" & userid & "' ")
            Myconn.Open()
            Mycomm.Connection = Myconn
            Mycomm.ExecuteNonQuery()
            Me.Dispose()
            Response.Redirect("UserManagementSamb.aspx")
        End If

    End Sub
  
End Class
