Imports System.Data.SqlClient
Imports System.Data

Partial Class localdatabase
    Inherits System.Web.UI.Page
    ' cmd = New SqlCommand("SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA ='dbo'", connTable)


    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim strBeginDateTime As String = txtBeginDate.Value & " " & ddlbh.SelectedValue & ":" & ddlbm.SelectedValue & ":00"
        Dim strEndDateTime As String = txtEndDate.Value & " " & ddleh.SelectedValue & ":" & ddlem.SelectedValue & ":59"
        Dim strsql As String
        Dim adplocal As SqlDataAdapter
        Dim dslocal As New DataSet
        Dim drRow As DataRow
        Dim dtlocal As New DataTable
        Try

      
            With dtlocal.Columns
                .Add(New DataColumn("No"))
                .Add(New DataColumn("timestamp"))
                .Add(New DataColumn("userid"))
                .Add(New DataColumn("siteid"))
                .Add(New DataColumn("rfidTag"))
                .Add(New DataColumn("rfidTag1"))
                .Add(New DataColumn("weight"))
                .Add(New DataColumn("weight1"))
                .Add(New DataColumn("orderNumber"))
                .Add(New DataColumn("productType"))
                .Add(New DataColumn("InOutStatus"))
                .Add(New DataColumn("DI1"))
                .Add(New DataColumn("DI2"))
                .Add(New DataColumn("DO1"))
                .Add(New DataColumn("DO2"))
                .Add(New DataColumn("LastEditDate"))
                .Add(New DataColumn("CreationDate"))
                .Add(New DataColumn("image_name"))
            End With
            ' Dim connStr As String = "Server=175.139.140.209;Database=avlsdev;User ID=zbguss00;Password=1234$$qweroff;MultipleActiveResultSets=True;Connection Timeout=2000;"
            ' Dim connStr As String = "Data Source=175.139.140.209,1433;Network Library=DBMSSOCN;Initial Catalog=avlsdev;User ID=sa;Password=baad0987654321;"

            ' Dim connStr As String = "Server=175.139.140.209;Database=avlsdev;User ID=sa;Password=baad0987654321;MultipleActiveResultSets=True;Connection Timeout=2000;"
            Dim conn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("localServer"))
            If cboRecords.SelectedValue <> "All" Then
                strsql = "Select top '" & cboRecords.SelectedValue & "' * from rfid_history where siteid='" & txtSiteId.Text & "' and timestamp between '" & strBeginDateTime & "' and '" & strEndDateTime & "' order by timestamp"
            Else
                strsql = "Select  * from rfid_history where siteid='" & txtSiteId.Text & "' and timestamp between '" & strBeginDateTime & "' and '" & strEndDateTime & "' order by timestamp"
            End If
            conn.Open()
            adplocal = New SqlDataAdapter(strsql, conn)

            adplocal.Fill(dslocal)
            For i As Integer = 0 To dslocal.Tables(0).Rows.Count - 1
                drRow = dtlocal.NewRow
                drRow(0) = i + 1
                drRow(1) = Convert.ToDateTime(dslocal.Tables(0).Rows(i)("timestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                drRow(2) = dslocal.Tables(0).Rows(i)("userid")
                drRow(3) = dslocal.Tables(0).Rows(i)("siteid")
                drRow(4) = dslocal.Tables(0).Rows(i)("rfidTag")
                drRow(5) = dslocal.Tables(0).Rows(i)("rfidTag1")
                drRow(6) = dslocal.Tables(0).Rows(i)("weight")
                drRow(7) = dslocal.Tables(0).Rows(i)("weight1")
                drRow(8) = dslocal.Tables(0).Rows(i)("orderNumber")
                drRow(9) = dslocal.Tables(0).Rows(i)("productType")
                drRow(10) = dslocal.Tables(0).Rows(i)("InOutStatus")
                drRow(11) = dslocal.Tables(0).Rows(i)("DI1")
                drRow(12) = dslocal.Tables(0).Rows(i)("DI2")
                drRow(13) = dslocal.Tables(0).Rows(i)("DO1")
                drRow(14) = dslocal.Tables(0).Rows(i)("DO2")
                drRow(15) = Convert.ToDateTime(dslocal.Tables(0).Rows(i)("LastEditDate")).ToString("yyyy/MM/dd HH:mm:ss")
                drRow(16) = Convert.ToDateTime(dslocal.Tables(0).Rows(i)("CreationDate")).ToString("yyyy/MM/dd HH:mm:ss")
                drRow(17) = dslocal.Tables(0).Rows(i)("image_name")
                dtlocal.Rows.Add(drRow)
            Next
            With GridView1
                .DataSource = dtlocal
                .DataBind()
            End With
            conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            '   btnSubmit.Attributes.Add("onclick", "return mysubmit()")
            'txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
            'txtEndDate.Value = Now().ToString("yyyy-MM-dd")
        End If
    End Sub
End Class
