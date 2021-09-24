Imports System.Data.SqlClient
Imports System.Data

Partial Class USERR
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
  loadall()
    End Sub

    Private Sub loadall()
        Dim Myconn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim Mycomm As New SqlCommand
        Dim dr As SqlDataReader

        Dim i As Integer = 0

        Dim strControlDistrict As String = ""
        Dim strFullControlDistrict As String = "ALL"   'request.cookies("Telemetry")("ControlDistrict")
        Dim arryControlDistrict() As String = Split(strFullControlDistrict, ",")

        If arryControlDistrict.Length() > 1 Then
            For i = 0 To (arryControlDistrict.Length() - 1)
                If i <> (arryControlDistrict.Length() - 1) Then
                    strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
                Else
                    strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
                End If
            Next i
        Else
            strControlDistrict = strControlDistrict & "" & arryControlDistrict(0) & ""
        End If


        'Dim intNum As Integer
        'Dim intUserID As Integer
        'Dim strUserName As String
        'Dim strPassword As String
        ' Dim strPhone As String
        'Dim strAddress As String
        'Dim strRole As String

        If arryControlDistrict(0) <> "ALL" Then
            Mycomm.CommandText = "select  userid,username, pwd, phoneno, streetname, " _
                     & " postcode , sstate as address, srole" _
                     & " from telemetry_user_table " _
              & " where control_district in ('" & strFullControlDistrict & "','" & strControlDistrict & "') order by username "
        Else
            Mycomm.CommandText = "select userid,username, pwd, phoneno, streetname ," _
                      & " postcode , sstate as address, srole" _
                      & " from telemetry_user_table order by username"
        End If

        Dim Gridcheckbox As New DataGrid
        Dim dt As New DataTable

        With dt.Columns
            .Add(New DataColumn("userid"))
            .Add(New DataColumn("chk"))
            .Add(New DataColumn("username"))
            .Add(New DataColumn("pwd"))
            .Add(New DataColumn("phoneno"))
            .Add(New DataColumn("streetname"))
            .Add(New DataColumn("srole"))
        End With

        Dim dA As New SqlDataAdapter
        Dim ds As New DataSet
        Dim r As DataRow

        Mycomm.Connection = Myconn
        dA.SelectCommand = Mycomm
        dA.Fill(ds)


        Myconn.Open()

        For q As Integer = 0 To ds.Tables(0).Rows.Count - 1
            r = dt.NewRow

            r(0) = ds.Tables(0).Rows(q)("userid")
            r(1) = "<input type=""checkbox"" name=""chk"" value=""" & ds.Tables(0).Rows(q)("userid") & """/>"
            r(2) = ds.Tables(0).Rows(q)("username")
            r(3) = ds.Tables(0).Rows(q)("pwd")
            r(4) = ds.Tables(0).Rows(q)("phoneno")
            r(5) = ds.Tables(0).Rows(q)("streetname")
            r(6) = ds.Tables(0).Rows(q)("srole")
            dt.Rows.Add(r)
        Next

        usergrid.DataSource = dt
        usergrid.DataBind()



       
        '   If Not sqlRs Then
        'strDisabled = "false"
        '  Else
        ' strDisabled = "true"
        ' End If

        ' Do While Not sqlRs.EOF
        'intUserID = sqlRs("userid").value
        '  strUserName = sqlRs("username").value
        '  strPassword = sqlRs("pwd").value
        ' strPhone = sqlRs("phoneno").value
        ' strAddress = sqlRs("address").value
        'strRole = sqlRs("srole").value

        'If intNum = 0 Then
        'ntNum = 1

    End Sub

    'public Sub 
    '  Try
    '    Dim Myconn As New SqlConnection(Data Source=ACER-PC;Initial Catalog=SAMB;User ID=sa;Password=123)

    ' Dim userids() As String = Split(Request.Form("chk"), ",")
    '        For i As Int16 = 0 To userids.Length - 1
    ' Dim Mycomm As New SqlCommand
    '       Mycomm.CommandText = "Delete from telemetry_contact_list_table where contact_id='" & userids(i) & "'"
    '         Mycomm.ExecuteNonQuery()
    '    Next
    '     cmd.Dispose()
    '     odbc_Conn.Close()
    '     LoadContact()
    '  Catch ex As Exception
    '       Response.Write("Delete User" & ex.Message)
    '   End Try
    'End Sub
    Protected Sub DeleteUser()

        Dim Myconn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim Mycomm As New SqlCommand
        '  Dim i As Integer = 0

        Dim a As String = ""

        Myconn.Open()
        Dim userid() As String = Split(Request.Form("chk"), ",")

        For i As Integer = 0 To userid.Length - 1
            Mycomm = New SqlCommand("delete from telemetry_user_table where userid = '" & userid(i) & "'", Myconn)
            Mycomm.ExecuteNonQuery()
        Next


        ' i += 1
        ' Myconn.Open()
        'For i As Integer = 0 To userids.Length - 1


        '  Dim chhk As CheckBox = usergrid.Rows(i).FindControl("chk") 
        'If usergrid.Rows.Count = i Then

        '    chhk.Checked = False

        'If chhk.Checked Then

        'Dim userid As Integer = Convert.ToInt16(usergrid.DataKeys(row.RowIndex).Value)



        '    Response.Write(chhk)
        '    Exit Sub
        'If (CType(usergrid.FindControl("chk"), CheckBox).Checked = True) Then


        '    'Dim userid As String = usergrid.Columns("username").ToString

        'Dim userid As Integer = Convert.ToInt16(usergrid.Columns("chk"))

        'Dim userid As Integer = Convert.ToInt32(usergrid.DataKeys(row.RowIndex).Value)
        '    'Dim aa(i) As Integer = Split (userid),","

        'Mycomm.Connection("delete from telemetry_user_table where userid = '" & userids(i) & "'")

        ' Myconn.Close()

        'End If
        '  End If

        Myconn.Close()

        ' Dim result As Byte = 0
        ' Response.Write(Split(Request.Form("chk"), ","))

        'Dim userids As String = ""

        '  For i As Int16 = 0 To userids.Length - 1

        'yconn.Open()
        ' Mycomm.CommandText = "select * from telemetry_user_table where userid = '" & userids(i) & "'"
        'Mycomm.Connection = Myconn
        ' Mycomm.ExecuteNonQuery()

        'Next
        'Mycomm.Dispose()
        'Myconn.Close()

        loadall()




    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        DeleteUser()
    End Sub

    Private Function GridViewRow() As Object
        Throw New NotImplementedException
    End Function

End Class
