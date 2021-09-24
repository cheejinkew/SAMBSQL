Imports System.Data
Imports System.Data.SqlClient
Partial Class AddDispatchSamb
    Inherits System.Web.UI.Page

    Dim str As String = System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB")
    Dim Myconn As New SqlConnection(str)
    Dim ds As New DataSet()


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim Str_Conn As String = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
        'odbc_Conn = New OdbcConnection(Str_Conn)

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

            Dim Mycomm As SqlCommand

            ddlDistrict.Items.Add(New ListItem("-Select District-", "0"))
            ddlSiteName.Items.Add(New ListItem("-Select Site-", "0"))
            str = "SELECT DISTINCT(sitedistrict) FROM telemetry_site_list_table WHERE sitetype='RESERVOIR' AND sitedistrict IN ('Alor Gajah','Jasin','Melaka Tengah') ORDER BY sitedistrict"
            Mycomm = New SqlCommand(str, Myconn)
            Myconn.Open()
            Dim dr As SqlDataReader
            dr = Mycomm.ExecuteReader

            Do While dr.Read()
                ddlDistrict.Items.Add(New ListItem(dr("sitedistrict").ToString().ToUpper, dr("sitedistrict").ToString()))
            Loop
            dr.Close()
            Myconn.Close()
        Catch ex As Exception
            Response.Write("Step 0" & ex.Message())
        End Try
    End Sub
    Protected Sub loadSite()
        Try
            Dim Mycomm2 As SqlCommand

            str = "SELECT siteid,sitename from telemetry_site_list_table WHERE sitedistrict='" & ddlDistrict.SelectedValue & "' and sitetype='RESERVOIR' order by sitename"
            ' Response.Write(str)
            Myconn.Open()
            Mycomm2 = New SqlCommand(str, Myconn)
            Dim dr As SqlDataReader
            dr = Mycomm2.ExecuteReader

            Do While dr.Read()
                'chkSite.Items.Add(New ListItem(dr("sitename").ToString(), dr("siteid").ToString()))
                ddlSiteName.Items.Add(New ListItem(dr("sitename").ToString(), dr("siteid").ToString()))
            Loop
            dr.Close()
            Myconn.Close()
        Catch ex As Exception
            Response.Write("Step 1" & ex.Message())
        End Try
    End Sub
    Protected Sub LoadRule()


        Dim Mycomm6 As SqlCommand
        Dim Mycomm3 As SqlCommand
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Dim da1 As SqlDataAdapter
        Dim ds1 As New DataSet
        Myconn.Open()

        str = "Select ruleid, alarmtype, position from telemetry_rule_list_table where siteid ='" & ddlSiteName.SelectedValue & "' and dispatch='1'"

        Mycomm6 = New SqlCommand(str, Myconn)
        Dim dr As SqlDataReader
        dr = Mycomm6.ExecuteReader

        While dr.Read

            str = "Select sdesc from telemetry_equip_list_table " & _
                                   "where siteid ='" & ddlSiteName.SelectedValue & "' and position=" & dr("position").ToString & ""

            Dim dr1 As SqlDataReader
            Mycomm3 = New SqlCommand(str, Myconn)
            dr1 = Mycomm3.ExecuteReader

            While dr1.Read
                ddlVehicle.Items.Add(New ListItem(dr1("sdesc").ToString & ":" & dr("alarmtype").ToString, dr("ruleid").ToString))
            End While

        End While

        Myconn.Close()

    End Sub
    Protected Sub LoadContact()
        Try

            Dim Mycomm4 As SqlCommand

            str = "SELECT * from telemetry_contact_list_table ORDER BY sname, simno"

            Myconn.Open()
            Mycomm4 = New SqlCommand(str, Myconn)
            Dim dr As SqlDataReader
            dr = Mycomm4.ExecuteReader()
            Do While dr.Read()

                ddlContact.Items.Add(New ListItem(dr("sname").ToString().ToUpper & " :" & " (" & dr("simno").ToString().ToUpper & ") ", dr("sname").ToString().ToUpper & ":" & dr("simno").ToString().ToUpper))
            Loop

            Myconn.Close()
        Catch ex As Exception
            Response.Write("Step 3" & ex.Message())
        End Try
    End Sub
    Protected Sub ddlSiteName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSiteName.SelectedIndexChanged
        ddlVehicle.Items.Clear()
        LoadRule()
        LoadContact()
    End Sub

    Protected Sub ibSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibSubmit.Click
        'Try
        Dim strsql As String
        Dim istep As Integer
        Dim Mycomm5 As New SqlCommand

        Myconn.Open()

        For i As Integer = 0 To ddlContact.Items.Count - 1
            If ddlContact.Items(i).Selected Then
                Dim userdata() As String = Split(ddlContact.Items(i).Value, ":")
                For j As Integer = 0 To ddlVehicle.Items.Count - 1
                    istep = 2
                    If ddlVehicle.Items(j).Selected Then
                        istep = 3
                        ' strsql = 
                        str = ("Insert into telemetry_dispatch_list_table(ruleid,simno,priority,sname,post) Values ('" & ddlVehicle.Items(j).Value & "','" & userdata(1) & "','" & Trim(txtPriority.Text) & "','" & userdata(0) & "','""')")
                        'New OdbcCommand(str, odbc_Conn)
                        Mycomm5 = New SqlCommand(str, Myconn)
                        Mycomm5.ExecuteNonQuery()
                        'Response.Write(strsql & "<br />")
                    End If
                Next
            End If
        Next

        Myconn.Close()
        'Catch ex As Exception
        '    Response.Write("Step 4" & ex.Message)
        'End Try
    End Sub
End Class
