Imports System.Data.SqlClient
Imports System.Data
Imports System.Math
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports System.Windows.Forms
Partial Class samb_SambSql_LogReport
    Inherits System.Web.UI.Page

    Dim strConn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
    Public ec As String = "false"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        If IsPostBack = False Then
            txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
            txtEndDate.Value = Now().ToString("yyyy-MM-dd")
            load_district()
        End If


    End Sub

    Public Sub load_district()
        strConn.Open()
        Dim strSql As New SqlCommand("select distinct(sitedistrict)  from telemetry_site_list_table", strConn)

        Dim dr As SqlDataReader = strSql.ExecuteReader

        While dr.Read()
            If dr("sitedistrict").ToString = "Testing" Then
                Exit While
            End If
            ddlSiteDistrict.Items.Add(New ListItem(dr("sitedistrict").ToString, dr("sitedistrict").ToString))

        End While
        strConn.Close()
    End Sub

    Public Sub load_sitename()

        strConn.Open()
        Dim strSql4 As String = ""
        Dim dr As SqlDataReader

        strSql4 = "select sitename,siteid from telemetry_site_list_table where sitedistrict ='" & ddlSiteDistrict.SelectedValue & "' order by sitename asc"

        Dim strSql5 As New SqlCommand(strSql4, strConn)
        dr = strSql5.ExecuteReader

        While dr.Read
            ddlSiteName.Items.Add(New ListItem(dr("sitename").ToString, dr("sitename").ToString & " : " & dr("siteid").ToString))
        End While

        strConn.Close()

    End Sub

    Public Sub load_gridView()

        strConn.Close()
        strConn.Open()
        Dim strSql6 As String = ""
        Dim dt As New DataTable
        Dim r As DataRow
        Dim dtCount As New DataTable
        Dim rCount As DataRow

        Dim strSiteName As String = ddlSiteName.SelectedValue
        Dim ArraySiteName() As String = Split(strSiteName, " : ")
        Dim dDate As String = ""
        Dim dTime As String = ""

        Dim dEndDate As String = txtEndDate.Value & " " & ddlH2.SelectedValue & ":" & ddlM2.SelectedValue & ":00"
        Dim dBeginDate As String = txtBeginDate.Value & " " & ddlH1.SelectedValue & ":" & ddlM1.SelectedValue & ":00"

        Dim dateNow As String = Now().Date()

        strSql6 = "select dtimestamp,value,sitename from telemetry_log_table I,telemetry_site_list_table u" _
            & " where I.siteid ='" & ArraySiteName(1) & "' and I.siteid=u.siteid" _
            & " and dtimestamp>='" & dBeginDate & "' and dtimestamp<='" & dEndDate & "' order by dtimestamp desc"

        strSql6 = "Select * from [telemetry_dispatch_history_table] where sitename = '" & ArraySiteName(0) & "'" _
            & " and dtimestamp>='" & dBeginDate & "' and dtimestamp<='" & dEndDate & "' order by dtimestamp desc"

        Dim da As New SqlDataAdapter(strSql6, strConn)
        Dim ds As New DataSet
        da.Fill(ds)


        With dt.Columns
            .Add(New DataColumn("No"))
            .Add(New DataColumn("DateTime"))
            .Add(New DataColumn("sname"))
            .Add(New DataColumn("Sitename"))
            .Add(New DataColumn("Value"))
            .Add(New DataColumn("Rule"))
        End With

        Dim CountLavel As String = ""
        Dim gCountLvlH As Integer = 0
        Dim gCountLvlHH As Integer = 0
        Dim gCountLvlNN As Integer = 0
        Dim gCountLvlL As Integer = 0
        Dim gCountLvlLL As Integer = 0



        If ds.Tables(0).Rows.Count > 0 Then

            For a As Integer = 0 To ds.Tables(0).Rows.Count - 1

                r = dt.NewRow

                r(0) = a
                r(1) = Convert.ToDateTime(ds.Tables(0).Rows(a).Item("dtimestamp")).ToString("yyyy/MM/dd HH:mm:ss")
                r(2) = ds.Tables(0).Rows(a).Item("sname")
                r(3) = ds.Tables(0).Rows(a).Item("sitename")
                Dim sValue As Double = (ds.Tables(0).Rows(a).Item("value"))

                Dim Temp() As Double
                ReDim Temp(0)

                If sValue <> 0 Or sValue <> Nothing Then
                    Temp(0) = sValue
                ElseIf sValue = Nothing Or sValue = 0 Then
                    sValue = Temp(0)
                End If

                r(4) = sValue.ToString("0.00")
                r(5) = getAlarmType(ArraySiteName(1), 2, (ds.Tables(0).Rows(a).Item("value")))

                dt.Rows.Add(r)
            Next

        Else

            Label1.Text = "No Data"
            Label1.Visible = True

            r = dt.NewRow
            r(0) = "--"
            r(1) = "--"
            r(2) = "--"
            r(3) = "--"
            r(4) = "--"
            r(5) = "--"
            dt.Rows.Add(r)

        End If
        ec = "true"
        Session("exceltable") = dt

        gvLogReport.DataSource = dt
        gvLogReport.DataBind()
        strConn.Close()

    End Sub

    Public Function getAlarmType(ByRef siteID As String, ByRef pos As Integer, ByRef intValue As String) As String

        Dim dr As SqlDataReader


        Dim strSqlAlarm As String = "select * from telemetry_rule_list_table where siteid ='" & siteID & "' and position ='" & pos & "' order by sequence asc"

        Dim strsql8 As New SqlCommand(strSqlAlarm, strConn)
        dr = strsql8.ExecuteReader
        Dim rules As String = ""

        While dr.Read
            Dim multip() As String = Split(UCase(dr("multiplier").ToString), ";")

            If (intValue >= Convert.ChangeType(multip(1), GetType(Double))) And (intValue <= Convert.ChangeType(multip(2), GetType(Double))) Then
                rules = dr("alarmtype").ToString

                If dr("alarmtype") = Nothing And dr("alarmtype") = "" Then
                    rules = "- -"
                End If
                Exit While
            End If
        End While

        Return rules
        strConn.Close()
    End Function
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

    Protected Sub ddlSiteDistrict_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSiteDistrict.SelectedIndexChanged
        ddlSiteName.Items.Clear()
        load_sitename()
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        Dim i As String = "False"
        If check(i) <> "True" Then
            Label1.Visible = True
            Label1.Text = i
        ElseIf check(i) = "True" Then
            Label1.Text = ""
            Label1.Visible = False
            load_gridView()
        End If
    End Sub

    Public Function check(ByRef NullO As String) As String

        NullO = "False"

        If ddlSiteDistrict.SelectedValue = "0" Then
            NullO = "Please Select District"
            Return NullO
        ElseIf ddlSiteName.SelectedValue = "0" Then
            NullO = "Please Select Sitename"
            Return NullO
        Else
            NullO = "True"
            Return NullO

        End If
        Return NullO

    End Function
End Class
