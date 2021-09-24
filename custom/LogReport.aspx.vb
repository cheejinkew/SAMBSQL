Imports System.Data.SqlClient
Imports System.Data

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
    'Public Sub load_sitetype()
    '    strConn.Open()
    '    Dim strSql2 As String = ""
    '    Dim dr As SqlDataReader

    '    strSql2 = "select distinct(sitetype) from telemetry_site_list_table where sitedistrict='" & ddlSiteDistrict.SelectedValue & "' "

    '    Dim strSql3 As New SqlCommand(strSql2, strConn)

    '    dr = strSql3.ExecuteReader

    '    While dr.Read
    '        ddlSiteType.Items.Add(New ListItem(dr("sitetype").ToString, dr("sitetype").ToString))
    '    End While
    '    'RemoveDuplicateItems(ddlSiteType)
    '    strConn.Close()
    'End Sub

    Public Sub load_sitename()

        strConn.Open()
        Dim strSql4 As String = ""
        Dim dr As SqlDataReader
        
        strSql4 = "select sitename,siteid from telemetry_site_list_table where sitedistrict ='" & ddlSiteDistrict.SelectedValue & "'  "

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

        Dim strSiteName As String = ddlSiteName.SelectedValue
        Dim ArraySiteName() As String = Split(strSiteName, " : ")
        Dim dDate As String = ""
        Dim dTime As String = ""

        Dim dEndDate As String = txtEndDate.Value & " " & ddlH2.SelectedValue & ":" & ddlM2.SelectedValue & ":00"
        Dim dBeginDate As String = txtBeginDate.Value & " " & ddlH1.SelectedValue & ":" & ddlM1.SelectedValue & ":00"

        strSql6 = "select sdesc,equipname,dtimestamp,value from telemetry_log_table I,telemetry_equip_list_table e" _
            & " where I.siteid ='" & ArraySiteName(1) & "' and I.siteid=e.siteid and I.position=I.position  " _
            & " and dtimestamp>='" & dBeginDate & "' and dtimestamp<='" & dEndDate & "' "

        Dim da As New SqlDataAdapter(strSql6, strConn)
        Dim ds As New DataSet
        da.Fill(ds)

        With dt.Columns
            .Add(New DataColumn("Date"))
            .Add(New DataColumn("Time"))
            .Add(New DataColumn("Equipment"))
            .Add(New DataColumn("Value"))
            .Add(New DataColumn("Rule"))
        End With

        If ds.Tables(0).Rows.Count > 0 Then
            For a As Integer = 0 To ds.Tables(0).Rows.Count - 1

                r = dt.NewRow
                r(0) = String.Format("{0:dd/MM/yyyy}", ds.Tables(0).Rows(a).Item("dtimestamp"))
                r(1) = String.Format("{0:t}", ds.Tables(0).Rows(a).Item("dtimestamp"))
                r(2) = ds.Tables(0).Rows(a).Item("equipname")
                r(3) = ds.Tables(0).Rows(a).Item("value")
                r(4) = getAlarmType(ArraySiteName(1), 2, (ds.Tables(0).Rows(a).Item("value")))
                dt.Rows.Add(r)
            Next
        Else

            r = dt.NewRow
            r(0) = "-"
            r(1) = "-"
            r(2) = "-"
            r(3) = "-"
            r(4) = "-"
            dt.Rows.Add(r)
        End If
        ec = "true"
        Session("exceltable2") = dt
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
                Exit While
            End If
        End While

        Return rules
        strConn.Close()
    End Function

    Public Function check(ByRef NullO As String) As Boolean

        Dim Boll As Boolean = False

        If NullO = "0" Then
            Boll = False
        Else
            Boll = True
        End If
        Return Boll
    End Function

    Public Sub RemoveDuplicateItems(ByVal s As DropDownList)


        For i As Integer = 0 To s.Items.Count - 1
            s.SelectedIndex = i
            Dim str As String = s.SelectedItem.ToString

            For a As Integer = 1 To s.Items.Count - 1
                s.SelectedIndex = a
                Dim str2 As String = s.SelectedItem.ToString

                If str2 = str Then
                    s.Items.Remove(a)
                End If
            Next

        Next
    End Sub

    Protected Sub ddlSiteDistrict_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSiteDistrict.SelectedIndexChanged
        ddlSiteName.Items.Clear()
        load_sitename()
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        load_gridView()
    End Sub
End Class
