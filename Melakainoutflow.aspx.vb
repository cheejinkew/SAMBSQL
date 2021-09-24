Imports System.Data, ADODB
Partial Class Melakainoutflow
    Inherits System.Web.UI.Page
    Dim str As String = System.Configuration.ConfigurationManager.AppSettings("DSNPG")
    Dim conn = New ADODB.Connection()
    Dim conn2 = New ADODB.Connection()
    Dim sqlRs = New ADODB.Recordset()
    Dim sqlRs2 = New ADODB.Recordset()
    Dim Query As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            DropDownList1.SelectedValue = "0"
            txtBeginDate.Value = Now.ToString("yyyy/MM/dd")
        End If
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        If DropDownList1.SelectedValue <> "0" Then
            FillGrid()
        End If
    End Sub
    Private Sub FillGrid()
        Try
            Dim t As New DataTable
            t.Columns.Add(New DataColumn("Sno"))
            't.Columns.Add(New DataColumn("Site"))
            t.Columns.Add(New DataColumn("Sequence"))
            t.Columns.Add(New DataColumn("In"))
            t.Columns.Add(New DataColumn("Out"))
            Dim r As DataRow
            'Query = "SELECT * FROM telemetry_log_table WHERE siteid ='STEF' and position ='56' and sequence BETWEEN '2010/10/05 00:00:00' AND '2010/10/05 23:59:59' ORDER BY siteid,sequence DESC"

            Query = "SELECT * FROM telemetry_log_table WHERE siteid ='" & DropDownList1.SelectedValue & "' and position ='2' and sequence >= '" & txtBeginDate.Value & "' and sequence < '" & Date.Parse(txtBeginDate.Value).AddDays(1) & "' ORDER BY sequence DESC"

            conn.open(str)
            sqlRs.Open(Query, conn)
            Dim k As Int32 = 0
            Do While Not sqlRs.EOF
                k += 1
                r = t.NewRow()
                r(0) = k
                r(1) = String.Format("{0:yyyy/MM/dd HH:mm:ss}", Date.Parse(sqlRs("sequence").value))
                r(2) = sqlRs("value").value
                r(3) = GetOutflowdetails(sqlRs("sequence").value.ToString())
                'r(4) = sqlRs("data").value
                t.Rows.Add(r)
                sqlRs.movenext()
            Loop
            sqlRs.close()
            conn.close()
            conn = Nothing
            If t.Rows.Count > 0 Then
                GridView1.DataSource = t
                GridView1.DataBind()
            End If
        Catch ex As Exception
            'Response.Write(ex.Message & "::" & txtBeginDate.Value)
        End Try
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        If DropDownList1.SelectedValue <> "0" Then
            FillGrid()
        End If
    End Sub
    Function GetOutflowdetails(ByVal dat As String)
        Dim _result As String = "0"
        Dim Query2 As String = "SELECT value FROM telemetry_log_table WHERE siteid ='" & DropDownList1.SelectedValue & "' and position = '3' and sequence='" & dat & "'"
        conn2.open(str)
        sqlRs2.Open(Query2, conn2)
        If Not sqlRs2.EOF Then
            _result = sqlRs2("value").value
        End If
        sqlRs2.close()
        conn2.close()
        Return _result
    End Function
End Class
