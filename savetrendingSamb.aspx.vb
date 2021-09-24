﻿Imports System.Data.Odbc
Imports ChartDirector
Imports System.IO
Partial Class savetrendingSamb
    Inherits System.Web.UI.Page
    Public ec As String = "false"
    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim countDay As Integer
        Dim dtBeginDate, dtEndDate As DateTime
        Dim strBeginDate As String
        dtBeginDate = Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy-MM-dd")
        dtEndDate = Convert.ToDateTime(txtEndDate.Value).ToString("yyyy-MM-dd")
        countDay = DateDiff(DateInterval.Day, dtBeginDate, dtEndDate)
        For i As Integer = 0 To countDay
            strBeginDate = dtBeginDate.AddDays(i).ToString("yyyy-MM-dd")
            ' If radFirstTime.Checked = True Then
            '    CaptureTrendingbyTime(strBeginDate & " 00:00:00", strBeginDate & " 08:00:00", "0008")
            'End If

            'If radSecondTime.Checked = True Then
            '    CaptureTrendingbyTime(strBeginDate & " 08:00:00", strBeginDate & " 16:00:00", "0816")
            'End If

            'If radThirdTime.Checked = True Then
            '    CaptureTrendingbyTime(strBeginDate & " 16:00:00", strBeginDate & " 23:59:59", "1600")
            'End If

            'If radAll.Checked = True Then
            '    CaptureTrendingbyTime(strBeginDate & " 00:00:00", strBeginDate & " 23:59:59", "0023")
            'End If

            If chkFirstTime.Checked = True Then
                CaptureTrendingbyTime(strBeginDate & " 00:00:00", strBeginDate & " 08:00:00", "12AM-8AM")
            End If

            If chkSecondTime.Checked = True Then
                CaptureTrendingbyTime2(strBeginDate & " 08:00:00", strBeginDate & " 16:00:00", "8AM-4PM")
            End If

            If chkThirdTime.Checked = True Then
                CaptureTrendingbyTime3(strBeginDate & " 16:00:00", strBeginDate & " 23:59:59", "4PM-12AM")
            End If

            If chkAll.Checked = True Then
                CaptureTrendingbyTime4(strBeginDate & " 00:00:00", strBeginDate & " 23:59:59", "12AM-12AM")
            End If

        Next

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Page.IsPostBack = False Then
                ImageButton1.Attributes.Add("onclick", "return mysubmit()")
                txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
                txtEndDate.Value = Now().ToString("yyyy-MM-dd")
                GetDistrict()
            End If
        Catch ex As Exception
            Response.Write("Page Load" & ex.Message)
        End Try

    End Sub
    Private Sub GetDistrict()
        ddlDistrict.Items.Clear()
        Try
            Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
            Dim Odbcdr As OdbcDataReader
            Dim OdbcCmd As OdbcCommand
            Dim strsql As String
            odbc_Conn.Open()
            strsql = "SELECT distinct sitedistrict from telemetry_site_list_table Where sitedistrict in ('Alor Gajah','Jasin','Melaka Tengah') order by sitedistrict "
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            ddlDistrict.Items.Add(New ListItem("--Select District--"))
            While Odbcdr.Read
                ddlDistrict.Items.Add(New ListItem(Odbcdr("sitedistrict"), Odbcdr("sitedistrict")))
            End While
            OdbcCmd.Dispose()
            odbc_Conn.Close()

        Catch ex As Exception
            Response.Write("GetDistrict: " & ex.Message)
        End Try
    End Sub
    Private Sub GetSiteType()
        ddlSiteType.Items.Clear()
        Try
            Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
            Dim Odbcdr As OdbcDataReader
            Dim OdbcCmd As OdbcCommand
            Dim strsql As String
            strsql = "Select distinct siteType FROM telemetry_site_list_table where sitedistrict='" & ddlDistrict.SelectedValue & "' order by sitetype"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            odbc_Conn.Open()
            Odbcdr = OdbcCmd.ExecuteReader
            ddlSiteType.Items.Add(New ListItem("--Select Site Type--"))
            While Odbcdr.Read
                ddlSiteType.Items.Add(New ListItem(Odbcdr("siteType"), Odbcdr("siteType")))
            End While
            OdbcCmd.Dispose()
            odbc_Conn.Close()

        Catch ex As Exception
            Response.Write("GetSiteDetails: " & ex.Message)
        End Try
    End Sub
    Private Sub GetSiteDetails()
        ddlSite.Items.Clear()
        Try
            Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
            Dim Odbcdr As OdbcDataReader
            Dim OdbcCmd As OdbcCommand
            Dim strsql As String
            strsql = "Select siteid,sitename FROM telemetry_site_list_table where sitetype='" & ddlSiteType.SelectedValue & "' and sitedistrict='" & ddlDistrict.SelectedValue & "' order by sitename"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            odbc_Conn.Open()
            Odbcdr = OdbcCmd.ExecuteReader
            ddlSite.Items.Add(New ListItem("--Select Sites Name--"))
            While Odbcdr.Read
                ddlSite.Items.Add(New ListItem(Odbcdr("sitename"), Odbcdr("siteid")))
            End While
            OdbcCmd.Dispose()
            odbc_Conn.Close()

        Catch ex As Exception
            Response.Write("GetSiteDetails: " & ex.Message)
        End Try
    End Sub
    Private Sub GetEquipmentDetails()
        ddlEquipment.Items.Clear()
        Try
            Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
            Dim Odbcdr As OdbcDataReader
            Dim OdbcCmd As OdbcCommand
            Dim strsql As String
            strsql = "Select equipname FROM telemetry_equip_list_table where siteid='" & ddlSite.SelectedValue & "'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            odbc_Conn.Open()
            Odbcdr = OdbcCmd.ExecuteReader
            ddlEquipment.Items.Add(New ListItem("--Select Equipment--"))
            While Odbcdr.Read
                ddlEquipment.Items.Add(New ListItem(Odbcdr("equipname"), Odbcdr("equipname")))
            End While
            OdbcCmd.Dispose()
            odbc_Conn.Close()

        Catch ex As Exception
            Response.Write("GetEquipmentDetails: " & ex.Message)
        End Try
    End Sub
    Private Sub GetEquipmentPosition()
        txtPosition.Text = ""
        txtEDesc.Text = ""
        Try
            Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
            Dim Odbcdr As OdbcDataReader
            Dim OdbcCmd As OdbcCommand
            Dim strsql As String
            strsql = "Select position,""sdesc"" FROM telemetry_equip_list_table where equipname='" & ddlEquipment.SelectedValue & "' and position  = '2'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            odbc_Conn.Open()
            Odbcdr = OdbcCmd.ExecuteReader
            While Odbcdr.Read
                txtPosition.Text = Odbcdr("position")
                txtEDesc.Text = Odbcdr("sdesc")
            End While

            OdbcCmd.Dispose()
            odbc_Conn.Close()

        Catch ex As Exception
            Response.Write("GetEquipmentDetails: " & ex.Message)
        End Try
    End Sub
    Protected Sub ddlDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDistrict.SelectedIndexChanged
        'GetDistrict()
        If ddlDistrict.Text = "--Select District--" Then
            ddlSiteType.Items.Clear()
            ddlSite.Items.Clear()
            ddlEquipment.Items.Clear()
            txtPosition.Text = ""
            txtEDesc.Text = ""
            ddlSiteType.Items.Add("--Select Site Type--")
            ddlSite.Items.Add("--Select Site Name--")
            ddlEquipment.Items.Add("--Select Equipment--")
        Else
            ddlSiteType.Items.Clear()
            ddlSite.Items.Clear()
            ddlEquipment.Items.Clear()
            txtPosition.Text = ""
            txtEDesc.Text = ""
            ddlSiteType.Items.Add("--Select Site Type--")
            ddlSite.Items.Add("--Select Site Name--")
            ddlEquipment.Items.Add("--Select Equipment--")
            GetSiteType()
        End If

    End Sub
    Protected Sub ddlSite_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSite.SelectedIndexChanged
        If ddlSite.Text = "--Select Sites Name--" Then
            ddlEquipment.Items.Clear()
            txtPosition.Text = ""
            txtEDesc.Text = ""
            ddlEquipment.Items.Add("--Select Equipment--")
        Else
            txtPosition.Text = ""
            txtEDesc.Text = ""
            GetEquipmentDetails()
        End If
    End Sub
    Protected Sub ddlEquipment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlEquipment.SelectedIndexChanged
        If ddlEquipment.Text = "--Select Equipment--" Then
            txtPosition.Text = ""
            txtEDesc.Text = ""
        Else
            GetEquipmentPosition()
        End If
    End Sub
    Protected Sub ddlSiteType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSiteType.SelectedIndexChanged
        If ddlSiteType.Text = "--Select Site Type--" Then
            ddlSite.Items.Clear()
            ddlEquipment.Items.Clear()
            txtPosition.Text = ""
            txtEDesc.Text = ""
            ddlSite.Items.Add("--Select Site Name--")
            ddlEquipment.Items.Add("--Select Equipment--")
        Else
            ddlSite.Items.Clear()
            ddlEquipment.Items.Clear()
            txtPosition.Text = ""
            txtEDesc.Text = ""
            ddlSite.Items.Add("--Select Site Name--")
            ddlEquipment.Items.Add("--Select Equipment--")
            GetSiteDetails()
        End If
    End Sub
    Private Sub CaptureTrending()
        Dim printsubmit As String = "no"
        Dim ShowChart As Boolean = False
        Dim SiteID As String = ddlSite.SelectedValue
        Dim siteName As String = ddlSite.SelectedItem.Text
        Dim EquipName As String = ddlEquipment.SelectedValue
        Dim Position As String = txtPosition.Text
        Dim EquipDesc As String = txtEDesc.Text
        Dim blnTmp As Boolean = False
        Dim startdate, enddate, strsql As String

        startdate = txtBeginDate.Value & " " & ddlbh.SelectedValue & ":" & ddlbm.SelectedValue & ":00"
        enddate = txtEndDate.Value & " " & ddleh.SelectedValue & ":" & ddlem.SelectedValue & ":59"
        Response.Write(enddate)
        Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
        Dim Odbcdr As OdbcDataReader
        Dim OdbcCmd As OdbcCommand

        Dim i As Integer
        Dim dubValue As Double
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean
        Dim thresholdValueMax As Double
        Dim values(0) As Double
        Dim sequence(0) As String
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        i = 0
        odbc_Conn.Open()


        If (Position = "2") Then 'M4/M5
            strsql = "select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            While Odbcdr.Read
                rmultiplier(i) = Odbcdr("multiplier")
                rposition(i) = Odbcdr("position")
                ralarmtype(i) = Odbcdr("alarmtype")
                rcolorcode(i) = Odbcdr("colorcode")
                ralert(i) = Odbcdr("alert")
                i = i + 1
                ReDim Preserve rmultiplier(i)
                ReDim Preserve rposition(i)
                ReDim Preserve ralarmtype(i)
                ReDim Preserve rcolorcode(i)
                ReDim Preserve ralert(i)
            End While

            OdbcCmd.Dispose()
            thresholdValueMax = 8.0
            For i = 0 To (UBound(rmultiplier))
                maxrulevalue = szParseString(rmultiplier(i), ";", 3)
                If thresholdValueMax < maxrulevalue Then
                    thresholdValueMax = maxrulevalue
                End If
            Next
        Else 'S1
            Dim nMaxStart = String.Format("{0:yyyy-MM-dd}", Date.Parse(startdate))
            Dim nMaxEnd = String.Format("{0:yyyy-MM-dd}", Date.Parse(enddate))

            'Response.Write(strsql)

            strsql = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
                      SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
                      nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            thresholdValueMax = 100.0
            While Odbcdr.Read
                If (IsNumeric(Odbcdr("nMax"))) Then
                    thresholdValueMax = Odbcdr("nMax")
                Else
                    thresholdValueMax = 10
                End If
            End While
            If thresholdValueMax = 0 Then
                thresholdValueMax = 8.0
            End If

        End If

        i = 0
        Response.Write(startdate & "<" & Convert.ToDateTime(enddate).ToString("yyyy-MM-dd HH:mm:ss") & "<br/>")
        Do While startdate <= String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(enddate))
            Response.Write(strsql)
            strsql = "select TOP 1 value from telemetry_log_table where siteid='" & _
                    SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                     startdate & "' and '" & startdate & "' order by dtimestamp desc "


            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            If Odbcdr.Read() Then
                dubValue = CDbl(Odbcdr("value"))
                If (thresholdValueMax >= dubValue And dubValue > 0.0) Then
                    values(i) = dubValue
                    sequence(i) = Convert.ToString(startdate)
                    i = i + 1
                    ReDim Preserve values(i)
                    ReDim Preserve sequence(i)
                End If
            Else
                values(i) = Chart.NoValue
                sequence(i) = Convert.ToString(startdate)
                i = i + 1
                ReDim Preserve values(i)
                ReDim Preserve sequence(i)
            End If
            OdbcCmd.Dispose()
            startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(15))
        Loop
        ShowChart = True
        blnTmp = True

        Dim minValue As Integer
        Dim Suffix As String
        Dim yAxisTitle
        yAxisTitle = " "
        If InStr(1, UCase(EquipDesc), "FLOW METER") > 0 Then
            Suffix = "m3/h"
            minValue = 0
            yAxisTitle = "Meter Cube Per Hour (m3/h)"
        End If

        If InStr(1, UCase(EquipDesc), "PRESSURE") > 0 Then
            Suffix = "bar"
            minValue = 0
            yAxisTitle = "Pressure (Bar)"
        End If

        If InStr(1, UCase(EquipDesc), "LEVEL") > 0 Then
            Suffix = "m"
            minValue = 0
            yAxisTitle = "Water Level (Meter)"
        End If

        If InStr(1, UCase(EquipDesc), "TURBIDITY") > 0 Then
            Suffix = "NTU"
            minValue = 0
            yAxisTitle = "Turbidity (NTU)"
        End If

        If InStr(1, UCase(EquipDesc), "PH") > 0 Then
            Suffix = "pH"
            minValue = 1
            yAxisTitle = "pH Level"
        End If

        If InStr(1, UCase(EquipDesc), "CHLORINE") > 0 Then
            Suffix = "ch"
            minValue = 0
            yAxisTitle = "Chlorine Level"
        End If

        '***********************************************************************************************
        'The data for the line chart
        On Error Resume Next



        Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

        'Set the plotarea at (30, 20) and of size 200 x 200 pixels
        c.setPlotArea(90, 20, 550, 300).setGridColor(&HFBCCF9, &HFBCCF9)


        c.addLineLayer(values, &HC000&)


        c.yAxis().setColors(&H0&, &H0&, &H0&)

        Dim Div As Integer


        If UBound(values) <= 31 Then
            Div = 1
        Else
            Div = (UBound(values) / 31)
        End If

        c.addTitle("Site : " & SiteID & "  " & siteName, "Times New Roman Bold", 12, &HFFFFFF).setBackground(c.patternColor(New Integer() {&H4000, &H8000}, 2))

        c.yAxis().setTitle(yAxisTitle, "Arial Bold Italic", 12)
        c.xAxis().setTitle("Timestamp", "Arial Bold Italic", 12)
        c.xAxis().setLabels(sequence).setFontAngle(45)


        c.xAxis().setLabelStep(Div)
        c.yAxis.setLinearScale(0.0, (thresholdValueMax + 1))
        reverse = True
        Dim strColor = "FFB000"

        c.xAxis().setWidth(2)
        c.yAxis().setWidth(2)


        For i = 0 To UBound(rmultiplier)

            minrulevalue = szParseString(rmultiplier(i), ";", 2)
            maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            If (ralarmtype(i) = "L" Or ralarmtype(i) = "H") Then
                strColor = "FFB000"
            Else
                strColor = rcolorcode(i)
            End If
            'If ralert(i) = True Then
            If ralarmtype(i) <> "NN" Then
                If ralarmtype(i) = "L" Or ralarmtype(i) = "LL" Then
                    'response.write(maxrulevalue & "; ")
                    c.yAxis().addMark(maxrulevalue, "&H" & strColor, ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
                Else
                    'response.write(minrulevalue & "; ")
                    c.yAxis().addMark(minrulevalue, "&H" & strColor, ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
                End If
            End If
            'Else
            'reverse = ralert(i)
            'End Ifm
        Next i

        '================================================================================================
        c.layout()

        WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
        Dim sname, Chartname As String

        ' Response.AddHeader("Content-Disposition", "attachment; filename=" & Title & ".xls;")

        If Not Directory.Exists("C:\" & siteName & "") Then
            Directory.CreateDirectory("C:\" & siteName & "")
        End If

        Chartname = Convert.ToDateTime(txtBeginDate.Value).ToString("yyyy-MM-dd") & "To" & Convert.ToDateTime(txtEndDate.Value).ToString("yyyy-MM-dd")
        sname = "C:\" & siteName & "\" & Chartname & ".png"
        c.makeChart(sname)
        'Response.ContentType = "image/JPEG"
        'Response.Write()
        WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
         "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

        odbc_Conn.Close()
        If ShowChart = True Then
            WebChartViewer1.Visible = True
        End If
    End Sub
    Private Sub CaptureTrendingbyTime(ByVal strstartdate As String, ByVal strEndDate As String, ByVal filename As String)
        Dim printsubmit As String = "no"
        Dim ShowChart As Boolean = False
        Dim SiteID As String = ddlSite.SelectedValue
        Dim siteName As String = ddlSite.SelectedItem.Text
        Dim EquipName As String = ddlEquipment.SelectedValue
        Dim Position As String = txtPosition.Text
        Dim EquipDesc As String = txtEDesc.Text
        Dim blnTmp As Boolean = False
        Dim startdate, enddate, strsql As String
        Dim get_MAX As Integer = 0
        '  Response.Write("insert")
        startdate = strstartdate
        enddate = strEndDate
        'Response.Write(startdate & " To " & enddate & "   ")

        Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
        Dim Odbcdr As OdbcDataReader
        Dim OdbcCmd As OdbcCommand

        Dim i As Integer = 0
        Dim dubValue As Double
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean
        Dim thresholdValueMax As Double
        Dim values(0) As Double
        Dim sequence(0) As String
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        odbc_Conn.Open()

        Try

            strsql = "select max from telemetry_equip_list_table where siteid='" & SiteID & "' and position =" & Position
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            If Odbcdr.Read Then
                get_MAX = Odbcdr("Max")
            End If
            OdbcCmd.Dispose()

            startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate))
            Do While startdate <= String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(enddate))
                strsql = "select TOP 1 value,dtimestamp from telemetry_log_table where siteid='" & _
                        SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                         startdate & ":00' and '" & startdate & ":59' order by dtimestamp desc"

                OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
                Odbcdr = OdbcCmd.ExecuteReader

                If Odbcdr.Read Then
                    ReDim Preserve values(i)
                    ReDim Preserve sequence(i)
                    values(i) = Odbcdr("value")
                    sequence(i) = Odbcdr("dtimestamp")
                    i = i + 1
                End If
                OdbcCmd.Dispose()
                startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(15))
            Loop

            i = 0
            If (Position = "2") Then 'M4/M5
                strsql = "select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc"
                OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
                Odbcdr = OdbcCmd.ExecuteReader
                While Odbcdr.Read
                    rmultiplier(i) = Odbcdr("multiplier")
                    rposition(i) = Odbcdr("position")
                    ralarmtype(i) = Odbcdr("alarmtype")
                    rcolorcode(i) = Odbcdr("colorcode")
                    ralert(i) = Odbcdr("alert")
                    i = i + 1
                    ReDim Preserve rmultiplier(i)
                    ReDim Preserve rposition(i)
                    ReDim Preserve ralarmtype(i)
                    ReDim Preserve rcolorcode(i)
                    ReDim Preserve ralert(i)
                End While

                OdbcCmd.Dispose()
                'thresholdValueMax = 8.0
                'For i = 0 To (UBound(rmultiplier))
                '    maxrulevalue = szParseString(rmultiplier(i), ";", 3)
                '    If thresholdValueMax < maxrulevalue Then
                '        thresholdValueMax = maxrulevalue
                '    End If
                'Next
            Else 'S1
                Dim nMaxStart = String.Format("{0:yyyy-MM-dd}", Date.Parse(startdate))
                Dim nMaxEnd = String.Format("{0:yyyy-MM-dd}", Date.Parse(enddate))

                'Response.Write(strsql)

                strsql = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
                          SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
                          nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
                OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
                Odbcdr = OdbcCmd.ExecuteReader

                thresholdValueMax = 100.0
                While Odbcdr.Read
                    If (IsNumeric(Odbcdr("nMax"))) Then
                        thresholdValueMax = Odbcdr("nMax")
                    Else
                        thresholdValueMax = 10
                    End If
                End While
                If thresholdValueMax = 0 Then
                    thresholdValueMax = 8.0
                End If

            End If
            Dim LowerVal = LBound(values)
            Dim UpperVal = UBound(values)
            For i = LowerVal To UpperVal
                If Not i = LowerVal Then
                    If Not i = UpperVal - 1 Then
                        If values(i) = 0 Then ' FILTER 1: Case when the value is 0
                            'values(i)  = (values(i-1)  + values(i+1) )/2
                            If Not values(i + 1) = 0 Then
                                values(i) = values(i - 1)
                            End If
                        End If
                        If values(i) > get_MAX Then ' FILTER 2: Case when the value is more than maximum
                            'values(i)  = (values(i-1)  + values(i+1) )/2
                            If Not values(i + 1) > get_MAX Then
                                values(i) = values(i - 1)
                            End If
                        End If
                    End If
                End If
                'response.write("<p>" & sequence(i) & " : " & values(i) & "</p>")
            Next
            ' ==================================== Checks should anywhere here =============================================
            ' Consequences: no charts created when there's no data exists
            Dim minValue As Integer
            Dim Suffix As String

            If InStr(1, EquipName, "Flowmeter") > 0 Then
                Suffix = "m3/h"
                minValue = 0
            End If

            If InStr(1, EquipName, "Pressure") > 0 Then
                Suffix = "bar"
                minValue = 0
            End If

            If InStr(1, EquipName, "Tank") > 0 Then
                Suffix = "m"
                minValue = 0
            End If

            If InStr(1, EquipName, "Turbidity") > 0 Then
                Suffix = "NTU"
                minValue = 0
            End If

            If InStr(1, EquipName, "pH") > 0 Then
                Suffix = "pH"
                minValue = 1
            End If

            If InStr(1, EquipName, "Chlorine") > 0 Then
                Suffix = "ch"
                minValue = 0
            End If

            If InStr(1, EquipName, "Water Level Trending") > 0 Then
                Suffix = "meter"
                minValue = 0
            End If

            'The data for the line chart
            'On Error Resume Next
            'The labels for the line chart

            'Create a XYChart object of size 250 x 250 pixels
            Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

            'Set the plotarea at (30, 20) and of size 200 x 200 pixels
            c.setPlotArea(90, 30, 550, 310).setGridColor(&HFBCCF9, &HFBCCF9)

            'Add a line chart layer using the given data
            c.addLineLayer(values, &HC000&)

            'Set the labels on the x axis.
            'c.xAxis().setLabels(sequence).setFontAngle(45)
            'c.xAxis().setLabels(sequence).setFontSize(10)
            c.yAxis().setColors(&H0&, &H0&, &H0&)

            'Display 1 out of 3 labels on the x-axis.
            Dim Div As Integer
            If UBound(values) <= 31 Then
                Div = 1
            Else
                Div = (UBound(values) / 35)
            End If

            Dim k As Integer = 0
            Dim d = Div * 2
            While k < sequence.Length
                If k Mod d = 2 Then
                    sequence(k) = " "
                End If
                k = k + 1

            End While

            'c.addLineLayer(val, &HC000&)

            c.yAxis().setTitle(Suffix).setAlignment(Chart.TopLeft2)
            c.xAxis().setLabels(sequence).setFontAngle(45)
            c.xAxis().setLabels(sequence).setFontSize(9)
            c.xAxis().setLabelStep(Div)

            '	c.yAxis().addZone(0, 2, &HFF0000)

            reverse = True
            For i = 0 To UBound(rmultiplier)
                'response.write(minrulevalue & "; ")
                minrulevalue = szParseString(rmultiplier(i), ";", 2)
                maxrulevalue = szParseString(rmultiplier(i), ";", 3)
                If ralert(i) = True Then
                    If reverse = True Then
                        'response.write(maxrulevalue & "; ")
                        c.yAxis().addMark(maxrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
                    Else
                        'response.write(minrulevalue & "; ")
                        c.yAxis().addMark(minrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
                    End If
                Else
                    reverse = ralert(i)
                End If
            Next i
            '================================================================================================
            c.layout()

            ' WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
            Dim sname, Chartname As String

            ' Response.AddHeader("Content-Disposition", "attachment; filename=" & Title & ".xls;")

            'If Not Directory.Exists("C:\" & siteName & "") Then
            '    Directory.CreateDirectory("C:\" & siteName & "")
            'End If

            Chartname = Convert.ToDateTime(strstartdate).ToString("dd-MM-yyyy")
            Dim xml As String
            'Response.ContentType = "image/JPEG"
            'Response.Write()
            'WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
            ' "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

            'sname = "C:\" & siteName & "\" & Chartname & filename & ".png"
            sname = Chartname & "(" & filename & ")" & siteName ' & ".png"
            Session.Remove("Chart")
            Session("Chart") = c.makeChart(0)
            'xml = "http://www.g1.com.my/TelemetryMgmt_Melaka/DownloadChart.aspx?newtitle=" & sname & "&sessionstatus=Chart"
            'Response.Write("<script>var object1=window.open('" & xml & "','','left=-900');setTimeout(""object1.close()"",1500);</script>")
            xml = "http://samb.g1.com.my/DownloadChart.aspx?newtitle=" & sname & "&sessionstatus=Chart"
            Response.Write("<script>var object1=window.open('" & xml & "','','left=-900');setTimeout(""object1.close()"",1500);</script>")
            'Response.Redirect(xml, False)

            'Response.Buffer = True
            'Response.ContentType = "image/png"
            'Response.BinaryWrite(Session("Chart"))
            'Response.AddHeader("Content-Disposition", "attachment; filename=" & sname & ".png;")
            '  Response.Flush()

            odbc_Conn.Close()

            'If ShowChart = True Then
            '    WebChartViewer1.Visible = True
            'End If

        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try

    End Sub
    Private Sub CaptureTrendingbyTime2(ByVal strstartdate As String, ByVal strEndDate As String, ByVal filename As String)
        Dim printsubmit As String = "no"
        Dim ShowChart As Boolean = False
        Dim SiteID As String = ddlSite.SelectedValue
        Dim siteName As String = ddlSite.SelectedItem.Text
        Dim EquipName As String = ddlEquipment.SelectedValue
        Dim Position As String = txtPosition.Text
        Dim EquipDesc As String = txtEDesc.Text
        Dim blnTmp As Boolean = False
        Dim startdate, enddate, strsql As String
        Dim get_MAX As Integer = 0
        '  Response.Write("insert")
        startdate = strstartdate
        enddate = strEndDate
        'Response.Write(startdate & " To " & enddate & "   ")

        Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
        Dim Odbcdr As OdbcDataReader
        Dim OdbcCmd As OdbcCommand

        Dim i As Integer = 0
        Dim dubValue As Double
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean
        Dim thresholdValueMax As Double
        Dim values(0) As Double
        Dim sequence(0) As String
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        odbc_Conn.Open()
        strsql = "select max from telemetry_equip_list_table where siteid='" & SiteID & "' and position ='" & Position & "'"
        OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
        Odbcdr = OdbcCmd.ExecuteReader
        If Odbcdr.Read Then
            get_MAX = Odbcdr("Max")
        End If
        OdbcCmd.Dispose()

        startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate))
        Do While startdate <= String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(enddate))
            strsql = "select TOP 1 value,dtimestamp from telemetry_log_table where siteid='" & _
                    SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                     startdate & ":00' and '" & startdate & ":59' order by dtimestamp desc"

            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            If Odbcdr.Read Then
                ReDim Preserve values(i)
                ReDim Preserve sequence(i)
                values(i) = Odbcdr("value")
                sequence(i) = Odbcdr("dtimestamp")
                i = i + 1
            End If
            OdbcCmd.Dispose()
            startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(15))
        Loop

        i = 0
        If (Position = "2") Then 'M4/M5
            strsql = "select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            While Odbcdr.Read
                rmultiplier(i) = Odbcdr("multiplier")
                rposition(i) = Odbcdr("position")
                ralarmtype(i) = Odbcdr("alarmtype")
                rcolorcode(i) = Odbcdr("colorcode")
                ralert(i) = Odbcdr("alert")
                i = i + 1
                ReDim Preserve rmultiplier(i)
                ReDim Preserve rposition(i)
                ReDim Preserve ralarmtype(i)
                ReDim Preserve rcolorcode(i)
                ReDim Preserve ralert(i)
            End While

            OdbcCmd.Dispose()
            'thresholdValueMax = 8.0
            'For i = 0 To (UBound(rmultiplier))
            '    maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            '    If thresholdValueMax < maxrulevalue Then
            '        thresholdValueMax = maxrulevalue
            '    End If
            'Next
        Else 'S1
            Dim nMaxStart = String.Format("{0:yyyy-MM-dd}", Date.Parse(startdate))
            Dim nMaxEnd = String.Format("{0:yyyy-MM-dd}", Date.Parse(enddate))

            'Response.Write(strsql)

            strsql = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
                      SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
                      nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            thresholdValueMax = 100.0
            While Odbcdr.Read
                If (IsNumeric(Odbcdr("nMax"))) Then
                    thresholdValueMax = Odbcdr("nMax")
                Else
                    thresholdValueMax = 10
                End If
            End While
            If thresholdValueMax = 0 Then
                thresholdValueMax = 8.0
            End If

        End If
        Dim LowerVal = LBound(values)
        Dim UpperVal = UBound(values)
        For i = LowerVal To UpperVal
            If Not i = LowerVal Then
                If Not i = UpperVal - 1 Then
                    If values(i) = 0 Then ' FILTER 1: Case when the value is 0
                        'values(i)  = (values(i-1)  + values(i+1) )/2
                        If Not values(i + 1) = 0 Then
                            values(i) = values(i - 1)
                        End If
                    End If
                    If values(i) > get_MAX Then ' FILTER 2: Case when the value is more than maximum
                        'values(i)  = (values(i-1)  + values(i+1) )/2
                        If Not values(i + 1) > get_MAX Then
                            values(i) = values(i - 1)
                        End If
                    End If
                End If
            End If
            'response.write("<p>" & sequence(i) & " : " & values(i) & "</p>")
        Next
        ' ==================================== Checks should anywhere here =============================================
        ' Consequences: no charts created when there's no data exists
        Dim minValue As Integer
        Dim Suffix As String

        If InStr(1, EquipName, "Flowmeter") > 0 Then
            Suffix = "m3/h"
            minValue = 0
        End If

        If InStr(1, EquipName, "Pressure") > 0 Then
            Suffix = "bar"
            minValue = 0
        End If

        If InStr(1, EquipName, "Tank") > 0 Then
            Suffix = "m"
            minValue = 0
        End If

        If InStr(1, EquipName, "Turbidity") > 0 Then
            Suffix = "NTU"
            minValue = 0
        End If

        If InStr(1, EquipName, "pH") > 0 Then
            Suffix = "pH"
            minValue = 1
        End If

        If InStr(1, EquipName, "Chlorine") > 0 Then
            Suffix = "ch"
            minValue = 0
        End If

        If InStr(1, EquipName, "Water Level Trending") > 0 Then
            Suffix = "meter"
            minValue = 0
        End If

        'The data for the line chart
        On Error Resume Next
        'The labels for the line chart

        'Create a XYChart object of size 250 x 250 pixels
        Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

        'Set the plotarea at (30, 20) and of size 200 x 200 pixels
        c.setPlotArea(90, 30, 550, 310).setGridColor(&HFBCCF9, &HFBCCF9)

        'Add a line chart layer using the given data
        c.addLineLayer(values, &HC000&)

        'Set the labels on the x axis.
        'c.xAxis().setLabels(sequence).setFontAngle(45)
        'c.xAxis().setLabels(sequence).setFontSize(10)
        c.yAxis().setColors(&H0&, &H0&, &H0&)

        'Display 1 out of 3 labels on the x-axis.
        Dim Div As Integer
        If UBound(values) <= 31 Then
            Div = 1
        Else
            Div = (UBound(values) / 35)
        End If

        Dim k As Integer = 0
        Dim d = Div * 2
        While k < sequence.Length
            If k Mod d = 2 Then
                sequence(k) = " "
            End If
            k = k + 1

        End While

        'c.addLineLayer(val, &HC000&)

        c.yAxis().setTitle(Suffix).setAlignment(Chart.TopLeft2)
        c.xAxis().setLabels(sequence).setFontAngle(45)
        c.xAxis().setLabels(sequence).setFontSize(9)
        c.xAxis().setLabelStep(Div)

        '	c.yAxis().addZone(0, 2, &HFF0000)

        reverse = True
        For i = 0 To UBound(rmultiplier)
            'response.write(minrulevalue & "; ")
            minrulevalue = szParseString(rmultiplier(i), ";", 2)
            maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            If ralert(i) = True Then
                If reverse = True Then
                    'response.write(maxrulevalue & "; ")
                    c.yAxis().addMark(maxrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
                Else
                    'response.write(minrulevalue & "; ")
                    c.yAxis().addMark(minrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
                End If
            Else
                reverse = ralert(i)
            End If
        Next i
        '================================================================================================
        c.layout()

        ' WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
        Dim sname, Chartname As String

        ' Response.AddHeader("Content-Disposition", "attachment; filename=" & Title & ".xls;")

        'If Not Directory.Exists("C:\" & siteName & "") Then
        '    Directory.CreateDirectory("C:\" & siteName & "")
        'End If

        Chartname = Convert.ToDateTime(strstartdate).ToString("dd-MM-yyyy")
        Dim xml As String
        'Response.ContentType = "image/JPEG"
        'Response.Write()
        'WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
        ' "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

        'sname = "C:\" & siteName & "\" & Chartname & filename & ".png"
        sname = Chartname & "(" & filename & ")" & siteName ' & ".png"
        Session.Remove("Chart2")
        Session("Chart2") = c.makeChart(0)
        xml = "http://www.g1.com.my/TelemetryMgmt_Melaka/DownloadChart.aspx?newtitle=" & sname & "&sessionstatus=Chart2"
        Response.Write("<script>var object2=window.open('" & xml & "','','left=-900');setTimeout(""object2.close()"",1500);</script>")
        'Response.ClearHeaders()
        'Response.Buffer = True
        'Response.ContentType = "image/png"
        'Response.BinaryWrite(Session("Chart2"))
        'Response.AddHeader("Content-Disposition", "attachment; filename=" & sname & ".png;")
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Response.Flush()

        odbc_Conn.Close()

        'If ShowChart = True Then
        '    WebChartViewer1.Visible = True
        'End If

    End Sub
    Private Sub CaptureTrendingbyTime3(ByVal strstartdate As String, ByVal strEndDate As String, ByVal filename As String)
        Dim printsubmit As String = "no"
        Dim ShowChart As Boolean = False
        Dim SiteID As String = ddlSite.SelectedValue
        Dim siteName As String = ddlSite.SelectedItem.Text
        Dim EquipName As String = ddlEquipment.SelectedValue
        Dim Position As String = txtPosition.Text
        Dim EquipDesc As String = txtEDesc.Text
        Dim blnTmp As Boolean = False
        Dim startdate, enddate, strsql As String
        Dim get_MAX As Integer = 0
        '  Response.Write("insert")
        startdate = strstartdate
        enddate = strEndDate
        'Response.Write(startdate & " To " & enddate & "   ")

        Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
        Dim Odbcdr As OdbcDataReader
        Dim OdbcCmd As OdbcCommand

        Dim i As Integer = 0
        Dim dubValue As Double
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean
        Dim thresholdValueMax As Double
        Dim values(0) As Double
        Dim sequence(0) As String
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        odbc_Conn.Open()

        strsql = "select max from telemetry_equip_list_table where siteid='" & SiteID & "' and position =" & Position
        OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
        Odbcdr = OdbcCmd.ExecuteReader
        If Odbcdr.Read Then
            get_MAX = Odbcdr("Max")
        End If
        OdbcCmd.Dispose()

        startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate))
        Do While startdate <= String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(enddate))
            strsql = "select Top 1 value,dtimestamp from telemetry_log_table where siteid='" & _
                    SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                     startdate & ":00' and '" & startdate & ":59' order by dtimestamp desc"

            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            If Odbcdr.Read Then
                ReDim Preserve values(i)
                ReDim Preserve sequence(i)
                values(i) = Odbcdr("value")
                sequence(i) = Odbcdr("dtimestamp")
                i = i + 1
            End If
            OdbcCmd.Dispose()
            startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(15))
        Loop

        i = 0
        If (Position = "2") Then 'M4/M5
            strsql = "select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            While Odbcdr.Read
                rmultiplier(i) = Odbcdr("multiplier")
                rposition(i) = Odbcdr("position")
                ralarmtype(i) = Odbcdr("alarmtype")
                rcolorcode(i) = Odbcdr("colorcode")
                ralert(i) = Odbcdr("alert")
                i = i + 1
                ReDim Preserve rmultiplier(i)
                ReDim Preserve rposition(i)
                ReDim Preserve ralarmtype(i)
                ReDim Preserve rcolorcode(i)
                ReDim Preserve ralert(i)
            End While

            OdbcCmd.Dispose()
            'thresholdValueMax = 8.0
            'For i = 0 To (UBound(rmultiplier))
            '    maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            '    If thresholdValueMax < maxrulevalue Then
            '        thresholdValueMax = maxrulevalue
            '    End If
            'Next
        Else 'S1
            Dim nMaxStart = String.Format("{0:yyyy-MM-dd}", Date.Parse(startdate))
            Dim nMaxEnd = String.Format("{0:yyyy-MM-dd}", Date.Parse(enddate))

            'Response.Write(strsql)

            strsql = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
                      SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
                      nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            thresholdValueMax = 100.0
            While Odbcdr.Read
                If (IsNumeric(Odbcdr("nMax"))) Then
                    thresholdValueMax = Odbcdr("nMax")
                Else
                    thresholdValueMax = 10
                End If
            End While
            If thresholdValueMax = 0 Then
                thresholdValueMax = 8.0
            End If

        End If
        Dim LowerVal = LBound(values)
        Dim UpperVal = UBound(values)
        For i = LowerVal To UpperVal
            If Not i = LowerVal Then
                If Not i = UpperVal - 1 Then
                    If values(i) = 0 Then ' FILTER 1: Case when the value is 0
                        'values(i)  = (values(i-1)  + values(i+1) )/2
                        If Not values(i + 1) = 0 Then
                            values(i) = values(i - 1)
                        End If
                    End If
                    If values(i) > get_MAX Then ' FILTER 2: Case when the value is more than maximum
                        'values(i)  = (values(i-1)  + values(i+1) )/2
                        If Not values(i + 1) > get_MAX Then
                            values(i) = values(i - 1)
                        End If
                    End If
                End If
            End If
            'response.write("<p>" & sequence(i) & " : " & values(i) & "</p>")
        Next
        ' ==================================== Checks should anywhere here =============================================
        ' Consequences: no charts created when there's no data exists
        Dim minValue As Integer
        Dim Suffix As String

        If InStr(1, EquipName, "Flowmeter") > 0 Then
            Suffix = "m3/h"
            minValue = 0
        End If

        If InStr(1, EquipName, "Pressure") > 0 Then
            Suffix = "bar"
            minValue = 0
        End If

        If InStr(1, EquipName, "Tank") > 0 Then
            Suffix = "m"
            minValue = 0
        End If

        If InStr(1, EquipName, "Turbidity") > 0 Then
            Suffix = "NTU"
            minValue = 0
        End If

        If InStr(1, EquipName, "pH") > 0 Then
            Suffix = "pH"
            minValue = 1
        End If

        If InStr(1, EquipName, "Chlorine") > 0 Then
            Suffix = "ch"
            minValue = 0
        End If

        If InStr(1, EquipName, "Water Level Trending") > 0 Then
            Suffix = "meter"
            minValue = 0
        End If

        'The data for the line chart
        On Error Resume Next
        'The labels for the line chart

        'Create a XYChart object of size 250 x 250 pixels
        Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

        'Set the plotarea at (30, 20) and of size 200 x 200 pixels
        c.setPlotArea(90, 30, 550, 310).setGridColor(&HFBCCF9, &HFBCCF9)

        'Add a line chart layer using the given data
        c.addLineLayer(values, &HC000&)

        'Set the labels on the x axis.
        'c.xAxis().setLabels(sequence).setFontAngle(45)
        'c.xAxis().setLabels(sequence).setFontSize(10)
        c.yAxis().setColors(&H0&, &H0&, &H0&)

        'Display 1 out of 3 labels on the x-axis.
        Dim Div As Integer
        If UBound(values) <= 31 Then
            Div = 1
        Else
            Div = (UBound(values) / 35)
        End If

        Dim k As Integer = 0
        Dim d = Div * 2
        While k < sequence.Length
            If k Mod d = 2 Then
                sequence(k) = " "
            End If
            k = k + 1

        End While

        'c.addLineLayer(val, &HC000&)

        c.yAxis().setTitle(Suffix).setAlignment(Chart.TopLeft2)
        c.xAxis().setLabels(sequence).setFontAngle(45)
        c.xAxis().setLabels(sequence).setFontSize(9)
        c.xAxis().setLabelStep(Div)

        '	c.yAxis().addZone(0, 2, &HFF0000)

        reverse = True
        For i = 0 To UBound(rmultiplier)
            'response.write(minrulevalue & "; ")
            minrulevalue = szParseString(rmultiplier(i), ";", 2)
            maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            If ralert(i) = True Then
                If reverse = True Then
                    'response.write(maxrulevalue & "; ")
                    c.yAxis().addMark(maxrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
                Else
                    'response.write(minrulevalue & "; ")
                    c.yAxis().addMark(minrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
                End If
            Else
                reverse = ralert(i)
            End If
        Next i
        '================================================================================================
        c.layout()

        ' WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
        Dim sname, Chartname As String

        ' Response.AddHeader("Content-Disposition", "attachment; filename=" & Title & ".xls;")

        'If Not Directory.Exists("C:\" & siteName & "") Then
        '    Directory.CreateDirectory("C:\" & siteName & "")
        'End If

        Chartname = Convert.ToDateTime(strstartdate).ToString("dd-MM-yyyy")
        Dim xml As String
        'Response.ContentType = "image/JPEG"
        'Response.Write()
        'WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
        ' "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

        'sname = "C:\" & siteName & "\" & Chartname & filename & ".png"
        sname = Chartname & "(" & filename & ")" & siteName ' & ".png"
        Session.Remove("Chart3")
        Session("Chart3") = c.makeChart(0)
        xml = "http://www.g1.com.my/TelemetryMgmt_Melaka/DownloadChart.aspx?newtitle=" & sname & "&sessionstatus=Chart3"
        Response.Write("<script>var object3=window.open('" & xml & "','','left=-900');setTimeout(""object3.close()"",1500);</script>")
        'Response.ClearHeaders()
        'Response.Buffer = True
        'Response.ContentType = "image/png"
        'Response.BinaryWrite(Session("Chart2"))
        'Response.AddHeader("Content-Disposition", "attachment; filename=" & sname & ".png;")
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Response.Flush()

        odbc_Conn.Close()

        'If ShowChart = True Then
        '    WebChartViewer1.Visible = True
        'End If

    End Sub
    Private Sub CaptureTrendingbyTime4(ByVal strstartdate As String, ByVal strEndDate As String, ByVal filename As String)
        Dim printsubmit As String = "no"
        Dim ShowChart As Boolean = False
        Dim SiteID As String = ddlSite.SelectedValue
        Dim siteName As String = ddlSite.SelectedItem.Text
        Dim EquipName As String = ddlEquipment.SelectedValue
        Dim Position As String = txtPosition.Text
        Dim EquipDesc As String = txtEDesc.Text
        Dim blnTmp As Boolean = False
        Dim startdate, enddate, strsql As String
        Dim get_MAX As Integer = 0
        '  Response.Write("insert")
        startdate = strstartdate
        enddate = strEndDate
        'Response.Write(startdate & " To " & enddate & "   ")

        Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
        Dim Odbcdr As OdbcDataReader
        Dim OdbcCmd As OdbcCommand

        Dim i As Integer = 0
        Dim dubValue As Double
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean
        Dim thresholdValueMax As Double
        Dim values(0) As Double
        Dim sequence(0) As String
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        odbc_Conn.Open()

        strsql = "select max from telemetry_equip_list_table where siteid='" & SiteID & "' and position =" & Position
        OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
        Odbcdr = OdbcCmd.ExecuteReader
        If Odbcdr.Read Then
            get_MAX = Odbcdr("Max")
        End If
        OdbcCmd.Dispose()

        startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate))
        Do While startdate <= String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(enddate))
            strsql = "select TOP 1 value,dtimestamp from telemetry_log_table where siteid='" & _
                    SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                     startdate & ":00' and '" & startdate & ":59' order by dtimestamp desc"

            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            If Odbcdr.Read Then
                ReDim Preserve values(i)
                ReDim Preserve sequence(i)
                values(i) = Odbcdr("value")
                sequence(i) = Odbcdr("dtimestamp")
                i = i + 1
            End If
            OdbcCmd.Dispose()
            startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(15))
        Loop

        i = 0
        If (Position = "2") Then 'M4/M5
            strsql = "select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            While Odbcdr.Read
                rmultiplier(i) = Odbcdr("multiplier")
                rposition(i) = Odbcdr("position")
                ralarmtype(i) = Odbcdr("alarmtype")
                rcolorcode(i) = Odbcdr("colorcode")
                ralert(i) = Odbcdr("alert")
                i = i + 1
                ReDim Preserve rmultiplier(i)
                ReDim Preserve rposition(i)
                ReDim Preserve ralarmtype(i)
                ReDim Preserve rcolorcode(i)
                ReDim Preserve ralert(i)
            End While

            OdbcCmd.Dispose()
            'thresholdValueMax = 8.0
            'For i = 0 To (UBound(rmultiplier))
            '    maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            '    If thresholdValueMax < maxrulevalue Then
            '        thresholdValueMax = maxrulevalue
            '    End If
            'Next
        Else 'S1
            Dim nMaxStart = String.Format("{0:yyyy-MM-dd}", Date.Parse(startdate))
            Dim nMaxEnd = String.Format("{0:yyyy-MM-dd}", Date.Parse(enddate))

            'Response.Write(strsql)

            strsql = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
                      SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
                      nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            thresholdValueMax = 100.0
            While Odbcdr.Read
                If (IsNumeric(Odbcdr("nMax"))) Then
                    thresholdValueMax = Odbcdr("nMax")
                Else
                    thresholdValueMax = 10
                End If
            End While
            If thresholdValueMax = 0 Then
                thresholdValueMax = 8.0
            End If

        End If
        Dim LowerVal = LBound(values)
        Dim UpperVal = UBound(values)
        For i = LowerVal To UpperVal
            If Not i = LowerVal Then
                If Not i = UpperVal - 1 Then
                    If values(i) = 0 Then ' FILTER 1: Case when the value is 0
                        'values(i)  = (values(i-1)  + values(i+1) )/2
                        If Not values(i + 1) = 0 Then
                            values(i) = values(i - 1)
                        End If
                    End If
                    If values(i) > get_MAX Then ' FILTER 2: Case when the value is more than maximum
                        'values(i)  = (values(i-1)  + values(i+1) )/2
                        If Not values(i + 1) > get_MAX Then
                            values(i) = values(i - 1)
                        End If
                    End If
                End If
            End If
            'response.write("<p>" & sequence(i) & " : " & values(i) & "</p>")
        Next
        ' ==================================== Checks should anywhere here =============================================
        ' Consequences: no charts created when there's no data exists
        Dim minValue As Integer
        Dim Suffix As String

        If InStr(1, EquipName, "Flowmeter") > 0 Then
            Suffix = "m3/h"
            minValue = 0
        End If

        If InStr(1, EquipName, "Pressure") > 0 Then
            Suffix = "bar"
            minValue = 0
        End If

        If InStr(1, EquipName, "Tank") > 0 Then
            Suffix = "m"
            minValue = 0
        End If

        If InStr(1, EquipName, "Turbidity") > 0 Then
            Suffix = "NTU"
            minValue = 0
        End If

        If InStr(1, EquipName, "pH") > 0 Then
            Suffix = "pH"
            minValue = 1
        End If

        If InStr(1, EquipName, "Chlorine") > 0 Then
            Suffix = "ch"
            minValue = 0
        End If

        If InStr(1, EquipName, "Water Level Trending") > 0 Then
            Suffix = "meter"
            minValue = 0
        End If

        'The data for the line chart
        On Error Resume Next
        'The labels for the line chart

        'Create a XYChart object of size 250 x 250 pixels
        Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)

        'Set the plotarea at (30, 20) and of size 200 x 200 pixels
        c.setPlotArea(90, 30, 550, 310).setGridColor(&HFBCCF9, &HFBCCF9)

        'Add a line chart layer using the given data
        c.addLineLayer(values, &HC000&)

        'Set the labels on the x axis.
        'c.xAxis().setLabels(sequence).setFontAngle(45)
        'c.xAxis().setLabels(sequence).setFontSize(10)
        c.yAxis().setColors(&H0&, &H0&, &H0&)

        'Display 1 out of 3 labels on the x-axis.
        Dim Div As Integer
        If UBound(values) <= 31 Then
            Div = 1
        Else
            Div = (UBound(values) / 35)
        End If

        Dim k As Integer = 0
        Dim d = Div * 2
        While k < sequence.Length
            If k Mod d = 2 Then
                sequence(k) = " "
            End If
            k = k + 1

        End While

        'c.addLineLayer(val, &HC000&)

        c.yAxis().setTitle(Suffix).setAlignment(Chart.TopLeft2)
        c.xAxis().setLabels(sequence).setFontAngle(45)
        c.xAxis().setLabels(sequence).setFontSize(9)
        c.xAxis().setLabelStep(Div)

        '	c.yAxis().addZone(0, 2, &HFF0000)

        reverse = True
        For i = 0 To UBound(rmultiplier)
            'response.write(minrulevalue & "; ")
            minrulevalue = szParseString(rmultiplier(i), ";", 2)
            maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            If ralert(i) = True Then
                If reverse = True Then
                    'response.write(maxrulevalue & "; ")
                    c.yAxis().addMark(maxrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
                Else
                    'response.write(minrulevalue & "; ")
                    c.yAxis().addMark(minrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
                End If
            Else
                reverse = ralert(i)
            End If
        Next i
        '================================================================================================
        c.layout()

        ' WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
        Dim sname, Chartname As String

        ' Response.AddHeader("Content-Disposition", "attachment; filename=" & Title & ".xls;")

        'If Not Directory.Exists("C:\" & siteName & "") Then
        '    Directory.CreateDirectory("C:\" & siteName & "")
        'End If

        Chartname = Convert.ToDateTime(strstartdate).ToString("dd-MM-yyyy")
        Dim xml As String
        'Response.ContentType = "image/JPEG"
        'Response.Write()
        'WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
        ' "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

        'sname = "C:\" & siteName & "\" & Chartname & filename & ".png"
        sname = Chartname & "(" & filename & ")" & siteName ' & ".png"
        Session.Remove("Chart4")
        Session("Chart4") = c.makeChart(0)
        xml = "http://www.g1.com.my/TelemetryMgmt_Melaka/DownloadChart.aspx?newtitle=" & sname & "&sessionstatus=Chart4"
        Response.Write("<script>var object4=window.open('" & xml & "','','left=-900');setTimeout(""object4.close()"",1500);</script>")
        'Response.ClearHeaders()
        'Response.Buffer = True
        'Response.ContentType = "image/png"
        'Response.BinaryWrite(Session("Chart2"))
        'Response.AddHeader("Content-Disposition", "attachment; filename=" & sname & ".png;")
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Response.Flush()

        odbc_Conn.Close()

        'If ShowChart = True Then
        '    WebChartViewer1.Visible = True
        'End If

    End Sub
    Private Sub CaptureTrendingbyTimeBackUpPreviousVersion(ByVal strstartdate As String, ByVal strEndDate As String, ByVal filename As String)
        Dim printsubmit As String = "no"
        Dim ShowChart As Boolean = False
        Dim SiteID As String = ddlSite.SelectedValue
        Dim siteName As String = ddlSite.SelectedItem.Text
        Dim EquipName As String = ddlEquipment.SelectedValue
        Dim Position As String = txtPosition.Text
        Dim EquipDesc As String = txtEDesc.Text
        Dim blnTmp As Boolean = False
        Dim startdate, enddate, strsql As String
        '  Response.Write("insert")
        startdate = strstartdate
        enddate = strEndDate
        'Response.Write(startdate & " To " & enddate & "   ")

        Dim odbc_Conn As New OdbcConnection(System.Configuration.ConfigurationManager.AppSettings("DSNPG"))
        Dim Odbcdr As OdbcDataReader
        Dim OdbcCmd As OdbcCommand

        Dim i As Integer
        Dim dubValue As Double
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean
        Dim thresholdValueMax As Double
        Dim values(0) As Double
        Dim sequence(0) As String
        Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        i = 0
        odbc_Conn.Open()


        If (Position = "2") Then 'M4/M5
            strsql = "select multiplier, position, alarmtype, colorcode, alert from telemetry_rule_list_table where siteid='" & SiteID & "' And alarmmode = 'EVENT' order by position, sequence asc"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader
            While Odbcdr.Read
                rmultiplier(i) = Odbcdr("multiplier")
                rposition(i) = Odbcdr("position")
                ralarmtype(i) = Odbcdr("alarmtype")
                rcolorcode(i) = Odbcdr("colorcode")
                ralert(i) = Odbcdr("alert")
                i = i + 1
                ReDim Preserve rmultiplier(i)
                ReDim Preserve rposition(i)
                ReDim Preserve ralarmtype(i)
                ReDim Preserve rcolorcode(i)
                ReDim Preserve ralert(i)
            End While

            OdbcCmd.Dispose()
            thresholdValueMax = 8.0
            For i = 0 To (UBound(rmultiplier))
                maxrulevalue = szParseString(rmultiplier(i), ";", 3)
                If thresholdValueMax < maxrulevalue Then
                    thresholdValueMax = maxrulevalue
                End If
            Next
        Else 'S1
            Dim nMaxStart = String.Format("{0:yyyy-MM-dd}", Date.Parse(startdate))
            Dim nMaxEnd = String.Format("{0:yyyy-MM-dd}", Date.Parse(enddate))

            'Response.Write(strsql)

            strsql = "SELECT max(value) AS nMax FROM telemetry_log_table where siteid='" & _
                      SiteID & "' AND position ='" & Position & "' AND dtimestamp BETWEEN '" & _
                      nMaxStart & " 00:00:00' AND '" & nMaxEnd & " 23:59:59'"
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            thresholdValueMax = 100.0
            While Odbcdr.Read
                If (IsNumeric(Odbcdr("nMax"))) Then
                    thresholdValueMax = Odbcdr("nMax")
                Else
                    thresholdValueMax = 10
                End If
            End While
            If thresholdValueMax = 0 Then
                thresholdValueMax = 8.0
            End If

        End If

        i = 0
        'Response.Write("aaa")
        ' Do While startdate <= Convert.ToDateTime(enddate).ToString("yyyy/MM/dd HH:mm:ss")
        startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate))
        Do While startdate <= String.Format("{0:yyyy-MM-dd HH:mm:ss}", Date.Parse(enddate))
            strsql = "select TOP 1 value from telemetry_log_table where siteid='" & _
                    SiteID & "' and position ='" & Position & "' and dtimestamp between '" & _
                     startdate & ":00' and '" & startdate & ":59' order by dtimestamp desc"
            'Response.Write(strsql)
            OdbcCmd = New OdbcCommand(strsql, odbc_Conn)
            Odbcdr = OdbcCmd.ExecuteReader

            If Odbcdr.Read Then
                dubValue = CDbl(Odbcdr("value"))
                If (thresholdValueMax >= dubValue And dubValue > 0.0) Then
                    values(i) = dubValue
                    sequence(i) = Convert.ToString(startdate)

                    i = i + 1
                    ReDim Preserve values(i)
                    ReDim Preserve sequence(i)
                End If
            Else
                values(i) = Chart.NoValue
                sequence(i) = Convert.ToString(startdate)
                i = i + 1
                ReDim Preserve values(i)
                ReDim Preserve sequence(i)
            End If
            OdbcCmd.Dispose()
            startdate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(15))
        Loop
        ShowChart = True
        blnTmp = True

        Dim minValue As Integer
        Dim Suffix As String
        Dim yAxisTitle
        yAxisTitle = " "
        If InStr(1, UCase(EquipDesc), "FLOW METER") > 0 Then
            Suffix = "m3/h"
            minValue = 0
            yAxisTitle = "Meter Cube Per Hour (m3/h)"
        End If

        If InStr(1, UCase(EquipDesc), "PRESSURE") > 0 Then
            Suffix = "bar"
            minValue = 0
            yAxisTitle = "Pressure (Bar)"
        End If

        If InStr(1, UCase(EquipDesc), "LEVEL") > 0 Then
            Suffix = "m"
            minValue = 0
            yAxisTitle = "Water Level (Meter)"
        End If

        If InStr(1, UCase(EquipDesc), "TURBIDITY") > 0 Then
            Suffix = "NTU"
            minValue = 0
            yAxisTitle = "Turbidity (NTU)"
        End If

        If InStr(1, UCase(EquipDesc), "PH") > 0 Then
            Suffix = "pH"
            minValue = 1
            yAxisTitle = "pH Level"
        End If

        If InStr(1, UCase(EquipDesc), "CHLORINE") > 0 Then
            Suffix = "ch"
            minValue = 0
            yAxisTitle = "Chlorine Level"
        End If

        '***********************************************************************************************
        'The data for the line chart
        On Error Resume Next



        Dim c As XYChart = New XYChart(650, 450, &HFFFFFF, &H0, 1)
        'Set the plotarea at (30, 20) and of size 200 x 200 pixels
        c.setPlotArea(90, 20, 550, 300).setGridColor(&HFBCCF9, &HFBCCF9)
        c.addLineLayer(values, &HC000&)
        c.yAxis().setColors(&H0&, &H0&, &H0&)

        Dim Div As Integer = 1
        If UBound(values) <= 31 Then
            Div = 1
        Else
            Div = (UBound(values) / 31)
        End If

        c.addTitle("Site ID : " & SiteID, "Times New Roman Bold", 12)
        c.yAxis().setTitle(yAxisTitle, "Arial Bold Italic", 12)
        c.xAxis().setTitle("Timestamp", "Arial Bold Italic", 12)
        c.xAxis().setLabels(sequence).setFontAngle(45)
        c.xAxis().setLabelStep(Div)
        c.yAxis.setLinearScale(0.0, (thresholdValueMax + 1), 0.5)
        ' c.yAxis.setLogScale()
        reverse = True
        Dim strColor = "FFB000"
        For i = 0 To UBound(rmultiplier)
            'response.write(minrulevalue & "; ")
            minrulevalue = szParseString(rmultiplier(i), ";", 2)
            maxrulevalue = szParseString(rmultiplier(i), ";", 3)
            If (ralarmtype(i) = "L" Or ralarmtype(i) = "H") Then
                strColor = "0000ff"
            Else
                strColor = rcolorcode(i)
            End If
            'If ralert(i) = True Then
            If ralarmtype(i) <> "NN" Then
                If (ralarmtype(i) = "L" Or ralarmtype(i) = "LL" Or ralarmtype(i) = "NN") Then
                    'response.write(maxrulevalue & "; ")
                    c.yAxis().addMark(maxrulevalue, "&H" & strColor, ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
                Else
                    'response.write(minrulevalue & "; ")
                    c.yAxis().addMark(minrulevalue, "&H" & strColor, ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
                End If

            End If

            'Else
            'reverse = ralert(i)
            'End If
        Next i
        '================================================================================================
        c.layout()

        ' WebChartViewer1.Image = c.makeWebImage(Chart.PNG)
        Dim sname, Chartname As String


        'If Not Directory.Exists("C:\" & siteName & "") Then
        '    Directory.CreateDirectory("C:\" & siteName & "")
        'End If

        Chartname = Convert.ToDateTime(strstartdate).ToString("dd-MM-yyyy")
        Dim xml As String
        'Response.ContentType = "image/JPEG"
        'Response.Write()
        'WebChartViewer1.ImageMap = c.getHTMLImageMap("", "", _
        ' "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")

        'sname = "C:\" & siteName & "\" & Chartname & filename & ".png"
        sname = Chartname & "(" & filename & ")" & siteName ' & ".png"
        Session.Remove("Chart4")
        Session("Chart4") = c.makeChart(0)
        xml = "http://www.g1.com.my/TelemetryMgmt_Melaka/DownloadChart.aspx?newtitle=" & sname & "&sessionstatus=Chart4"
        Response.Write("<script>var object4=window.open('" & xml & "','','left=-900');setTimeout(""object4.close()"",1500);</script>")
        'Response.ClearHeaders()
        'Response.Buffer = True
        'Response.ContentType = "image/png"
        'Response.BinaryWrite(Session("Chart2"))
        'Response.AddHeader("Content-Disposition", "attachment; filename=" & sname & ".png;")
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Response.Flush()

        odbc_Conn.Close()

        'If ShowChart = True Then
        '    WebChartViewer1.Visible = True
        'End If

    End Sub
    Function szParseString(ByVal szString As String, ByVal szDelimiter As String, ByVal nSegmentNumber As Integer)
        On Error Resume Next
        Dim nIndex As Integer
        Dim szTemp As String
        Dim nPos As Integer

        szTemp = szString

        For nIndex = 1 To nSegmentNumber - 1
            nPos = InStr(szTemp, szDelimiter)
            If nPos Then
                szTemp = Mid$(szTemp, nPos + 1)
            Else
                Exit Function
            End If
        Next
        nPos = InStr(szTemp, szDelimiter)

        If nPos Then
            szParseString = Left$(szTemp, nPos - 1)
        Else
            szParseString = szTemp
        End If

    End Function


End Class

