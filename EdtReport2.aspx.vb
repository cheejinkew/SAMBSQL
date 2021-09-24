Imports System.Data.SqlClient
Imports System.Data
Imports System.Math
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports System.Windows.Forms

Public Class EdtReport2
    Inherits System.Web.UI.Page
    Dim strConn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
    Public ec As String = "false"

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        If IsPostBack = False Then
            txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
            txtEnddate.Value = Now().ToString("yyyy-MM-dd")


            ' load_district()
        End If



    End Sub
    Public Sub load_gridView()
        strConn.Open()
        Dim strSql6 As String = ""
        Dim strSql7 As String = ""
        Dim dt As New DataTable
        Dim r As DataRow
        Dim r1 As DataRow
        Dim dtCount As New DataTable
        Dim rCount As DataRow

        Dim dDate As String = ""
        Dim dTime As String = ""

        Dim dEndDate As String = txtEnddate.Value & " " & ddlH2.SelectedValue & ":" & ddlM2.SelectedValue & ":00"
        Dim dBeginDate As String = txtBeginDate.Value & " " & ddlH1.SelectedValue & ":" & ddlM1.SelectedValue & ":00"

        Dim dateNow As String = Now().Date()
        strSql6 = "Select distinct CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA1M') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        ' strSql6 += "Select distinct CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA2M') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        strSql6 += "Select distinct CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA5M') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"
        ''  strSql6 += "Select distinct CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA8M') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        strSql6 += "Select distinct a.siteid, CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA4M') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        strSql6 += "Select distinct a.siteid, CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA9M') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        strSql6 += "Select distinct a.siteid, CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA10') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        strSql6 += "Select distinct a.siteid, CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA11') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"

        strSql6 += "Select distinct a.siteid, CONVERT(varchar,a.dtimestamp,111) dtimestamp , dbo.[fn_getDayCounter](a.siteid,a.dtimestamp) as daycount  from telemetry_log_table_m6 a inner join telemetry_site_list_table b on a.siteid=b.siteid where a.siteid in('DA12') and  position=2  and b.sitetype = 'FLOWRATE'  and dtimestamp between '" & dBeginDate & "' and '" & dEndDate & "' order by dtimestamp asc;"
        ' Response.Write(strSql6)

        Dim da As New SqlDataAdapter(strSql6, strConn)
        da.SelectCommand.CommandTimeout = 1000000
        Dim ds As New dataset
        Dim ds1 As New dataset

        da.Fill(ds)

        With dt.Columns

            .Add(New DataColumn("DateTime"))
            .Add(New DataColumn("DA1M"))
            .Add(New DataColumn("DA2M"))
            .Add(New DataColumn("DA5M"))
            .Add(New DataColumn("DA8M"))
            .Add(New DataColumn("DA4M"))
            .Add(New DataColumn("DA9M"))
            .Add(New DataColumn("DA10"))
            .Add(New DataColumn("DA11"))
            .Add(New DataColumn("DA12"))
            .Add(New DataColumn("TotaliserMasuk"))
            .Add(New DataColumn("TotaliserKeluar"))
            .Add(New DataColumn("Lebihan A-B"))
        End With

        Dim totalvalue As Double = 0
        Dim totalvalue1 As Double = 0
        Dim lebihan As Double = 0
        Dim pengurangan As Double = 0
	dim totallebih as double=0
        dim totalmasuk as double=0
	dim totalkeluar as double=0
        Dim i As Integer
        Dim j As Integer


        'Assigning value to  cell
        Dim rowCount As Integer = ds.Tables(0).Rows.Count
        Dim colCount As Integer = ds.Tables(0).Columns.Count
        'Assigning value to  cell
        Dim rowCount1 As Integer = ds.Tables(1).Rows.Count
        Dim colCount1 As Integer = ds.Tables(1).Columns.Count

        Dim dataArray(rowCount, colCount) As String
        Dim dataArray1(rowCount1, colCount1) As String


        ' If ds.Tables(3).Rows.Count > 0 Then

        For i = 0 To rowCount - 1
                For j = 0 To colCount - 1

            Next


                ' For a As Integer = 0 To ds.Tables(0).Rows.Count - 1 ' & ds.Tables(1).Rows.Count - 1 & ds.Tables(2).Rows.Count - 1 & ds.Tables(3).Rows.Count - 1 & ds.Tables(4).Rows.Count - 1

                r = dt.NewRow
                r(0) = Convert.ToDateTime(ds.Tables(0).Rows(i).Item("dtimestamp")).ToString("yyyy/MM/dd")
                Dim sValue As Double = (ds.Tables(0).Rows(i).Item("daycount"))
            '   Dim sValue2 As Double = (ds.Tables(1).Rows(i).Item("daycount"))
            Dim sValue3 As Double = (ds.Tables(1).Rows(i).Item("daycount"))
            '   Dim sValue4 As Double = (ds.Tables(2).Rows(i).Item("daycount"))
            Dim sValue5 As Double = (ds.Tables(2).Rows(i).Item("daycount"))
            Dim sValue6 As Double = (ds.Tables(3).Rows(i).Item("daycount"))
            Dim sValue7 As Double = (ds.Tables(4).Rows(i).Item("daycount"))
            Dim sValue8 As Double = (ds.Tables(5).Rows(i).Item("daycount"))
            Dim sValue9 As Double = (ds.Tables(6).Rows(i).Item("daycount"))
            totalvalue = totalvalue + sValue + sValue3
            totalvalue1 = totalvalue1 + sValue5 + sValue6 + sValue7 + sValue8 + sValue9
            lebihan = totalvalue - totalvalue1
	    totallebih=totallebih+lebihan
	    totalmasuk=totalmasuk+totalvalue
            totalkeluar=totalkeluar+totalvalue1
            r(1) = sValue
            r(2) = "--"
            r(3) = sValue3
            r(4) = "--"
            r(5) = sValue5
                r(6) = sValue6
                r(7) = sValue7
                r(8) = sValue8
                r(9) = sValue9
                r(10) = totalvalue
                r(11) = totalvalue1
                r(12) = lebihan
                dt.Rows.Add(r)
            Next
            r = dt.NewRow
            r(0) = ""
            r(1) = ""
            r(2) = ""
        r(3) = ""
        r(4) = ""
        r(5) = ""
            r(6) = ""
            r(7) = ""
            r(8) = ""
            r(9) = "TOTAL"
            r(10) = totalmasuk
            r(11) = totalkeluar
            r(12) = totallebih
            dt.Rows.Add(r)

        '   Else

        ' Label1.Text = "No Data"
        ' Label1.Visible = True

        'r = dt.NewRow
        ' r(0) = sValue
        'r(1) = sValue
        'r(2) = sValue2
        ' r(3) = sValue3
        'r(4) = "--"
        ' r(5) = sValue5
        'r(6) = sValue6
        'r(7) = sValue7
        'r(8) = sValue8
        'r(9) = sValue9
        ' r(10) = totalvalue
        'r(11) = totalvalue1
        'r(12) = lebihan


        ' dt.Rows.Add(r)

        ' End If

        ec = "true"
        Session("exceltable") = dt

        gvLogReport.DataSource = dt
        gvLogReport.DataBind()
        strConn.Close()

    End Sub


    Public Function checkValue(ByRef Value As Double) As Double

        Dim Temp() As Double

        ReDim Temp(0)

        If Value <> 0 Or Value <> Nothing Then
            Temp(0) = Value

        ElseIf Value = Nothing Or Value = 0 Then
            Value = Temp(0)
            'Response.Write(Temp(0) & "  ,,, " & Value)
            Return Value
        End If

        Return Value
    End Function

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click

        load_gridView()

    End Sub

    Protected Sub gvLogReport_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvLogReport.RowDataBound


        '     If e.Row.RowType = DataControlRowType.DataRow Then
        '  If Not String.IsNullOrEmpty(e.Row.Cells(1).Text) Then
        'If e.Row.Cells(1).Text = "da1m" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Yellow

        'ElseIf e.Row.Cells(1).Text = "da2m" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Yellow


        'ElseIf e.Row.Cells(1).Text = "da5m" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Yellow

        'ElseIf e.Row.Cells(1).Text = "da8m" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Yellow

        'ElseIf e.Row.Cells(1).Text = "da4m" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Red

        'ElseIf e.Row.Cells(1).Text = "da9m" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Red

        'ElseIf e.Row.Cells(1).Text = "da10" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Red

        ' ElseIf e.Row.Cells(1).Text = "da11" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Red

        'ElseIf e.Row.Cells(1).Text = "da12" Then
        'e.Row.Cells(1).ForeColor = System.Drawing.Color.Black
        'e.Row.Cells(1).BackColor = System.Drawing.Color.Red

        '  End If
        ' End If
        'End If

        If e.Row.RowType = DataControlRowType.DataRow Then
            For Each row As TableCell In e.Row.Cells
                If e.Row.Cells(9).Text = "TOTAL" Then
                    row.CssClass = "MASUK"
                End If
                'If e.Row.Cells(1).Text = "DA1M" Then
                'Row.CssClass = "MASUK"
                'End If
                'If e.Row.Cells(1).Text = "DA2M" Then
                'Row.CssClass = "MASUK"
                'End If
                'If e.Row.Cells(1).Text = "DA5M" Then
                '  Row.CssClass = "MASUK"
                '  End If
                '  If e.Row.Cells(1).Text = "DA8M" Then
                ' Row.CssClass = "MASUK"
                ' End If
                ' If e.Row.Cells(1).Text = "DA4M" Then
                '  Row.CssClass = "KELUAR"
                'End If
                'If e.Row.Cells(1).Text = "DA9M" Then
                '  Row.CssClass = "KELUAR"
                '  End If
                ' If e.Row.Cells(1).Text = "DA10" Then
                '   Row.CssClass = "KELUAR"
                'End If
                'If e.Row.Cells(1).Text = "DA11" Then
                'Row.CssClass = "KELUAR"
                'End If
                If e.Row.Cells(3).Text = "TOTAL KELUAR" Then
                    row.CssClass = "KELUAR"
                End If

            Next
        End If
    End Sub
End Class