
'Imports System.Convert
'Imports Gussmann.CelcomShortCode
Imports System.Data.SqlClient
Imports System.Collections.Generic

Partial Class alert1
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        gettingalerts()

    End Sub

    Public Sub gettingalerts()
        Dim istep As Integer
        Dim k As Integer = 0
        Dim l As Integer = 0
        Dim i As Integer = 0
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim cmd, cmd2 As SqlCommand
        Dim dr, dr2 As SqlDataReader
        Dim dcAlerts As New Dictionary(Of String, String)
        Dim groupnode As TreeNode
        Dim vehiclenode As TreeNode
        Dim strControlDistrict5, strsql, dcRecords, strSiteName1, siteid, sitename, strEvent2, trackvalue, time2 As String
        Dim district As String
        Dim startdate1 = System.DateTime.Now
        Dim str2 = Format(startdate1, "yyyy/MM/dd")
        Dim begindate = str2 + " " + "00:00:00"
        Dim tempoh1 = 23
        Dim time4() As String
        Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(begindate).AddHours(tempoh1))
        Dim aaa = ""
        '  Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
        '  Response.Write(Request.Cookies("Telemetry")("ControlDistrict"))
        Try
            TreeView1.Nodes.Clear()
            istep = 1
            'If arryControlDistrict.length() > 1 Then
            '    For i = 0 To (arryControlDistrict.length() - 1)
            '        If i <> (arryControlDistrict.length() - 1) Then
            '            strControlDistrict5 = strControlDistrict5 & "'" & Trim(arryControlDistrict(i)) & "', "
            '        Else
            '            strControlDistrict5 = strControlDistrict5 & "'" & Trim(arryControlDistrict(i)) & "'"
            '        End If
            '    Next i
            'Else
            '    strControlDistrict5 = strControlDistrict5 & "'" & arryControlDistrict(0) & "'"
            'End If

            'If arryControlDistrict(0) <> "ALL" Then
            ' strsql = "SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict5 & ")"
            '  Else
            ' strsql = "SELECT distinct(sitedistrict) from telemetry_site_list_table"
            ' End If
            strsql = "SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in ('Alor Gajah','Melaka Tengah','Jasin')"
            cmd = New SqlCommand(strsql, conn)
            conn.Open()
            dr = cmd.ExecuteReader
            While dr.Read
                dcAlerts.Add(dr("sitedistrict"), dr("sitedistrict"))
            End While
            dr.Close()
            cmd.Dispose()
            Dim list As New List(Of String)(dcAlerts.Keys)

            istep = 2

            For Each dcRecords In list
                groupnode = New TreeNode()
                groupnode.Text = dcAlerts.Item(dcRecords)

                istep = 3
                '  strsql = "select final.siteid,final.sitename,final.dtimestamp,final.alarmtype from (select result.siteid,t1.sitename,result.dtimestamp,t1.alarmtype from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.dtimestamp=result.dtimestamp and t1.alarmtype in('LL','L','H','HH'))) final,telemetry_site_list_table as sitelist where final.siteid=sitelist.siteid and final.dtimestamp between '" & begindate & " ' and '" & enddate & " ' and  sitelist.sitedistrict = '" & dcAlerts.Item(dcRecords) & "' order by sitename  "
                strsql = "select final.siteid,final.sitename,final.dtimestamp,final.alarmtype from (select result.siteid,t1.sitename,result.dtimestamp,t1.alarmtype from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table where dtimestamp between '" & begindate & " ' and '" & enddate & " ' group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.dtimestamp=result.dtimestamp and t1.alarmtype in('LL','L','H','HH'))) final,telemetry_site_list_table as sitelist where final.siteid=sitelist.siteid and sitelist.sitedistrict = '" & dcAlerts.Item(dcRecords) & "' and sitelist.sitetype='RESERVOIR' order by sitename  "
                ' Response.Write(strsql)
                cmd = New SqlCommand(strsql, conn)
                dr2 = cmd.ExecuteReader

                istep = 4

                While dr2.Read
                    strEvent2 = dr2("alarmtype")
                    time2 = dr2("dtimestamp")
                    time4 = Split(time2, " ")
                    sitename = dr2("sitename")
                    siteid = dr2("siteid")
                    strsql = "SELECT value from telemetry_equip_status_table where siteid='" & siteid & "'"
                    cmd2 = New SqlCommand(strsql, conn)
                    trackvalue = cmd2.ExecuteScalar
                    cmd2.Dispose()
                    strSiteName1 = dr2("sitename") + "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + " Time : " + Convert.ToDateTime(time2).ToString("HH:mm:ss")  'time4(1)

                    If Not dcAlerts.Item(dcRecords) = Nothing Then
                        istep = 12
                        vehiclenode = New TreeNode()
                        vehiclenode.Text = "<img id='aaa' alt='Site Name:" & sitename & "&nbsp;&nbsp; Value:" & trackvalue & " &nbsp;&nbsp; Alert:" & strEvent2 & " &nbsp;&nbsp;time:" & Convert.ToDateTime(time2).ToString("HH:mm:ss") & " ' style='vertical-align:middle;border:solid white 0px;' onmouseout='javascript:height2(this)' onmouseover='javascript:height1(this)' border='0' src='images/" & strEvent2 & ".png 'height='20'width='20'/>&nbsp;&nbsp;" & strSiteName1.ToString()

                        vehiclenode.Target = "main"
                        vehiclenode.NavigateUrl = "Summary.aspx?sitetype=RESERVOIR&sitename=" & sitename & "&siteid=" & siteid & "&district=" & groupnode.Text
                        vehiclenode.ToolTip = "Click to go to Summary"
                        groupnode.ChildNodes.Add(vehiclenode)
                    End If

                End While

                If groupnode.ChildNodes.Count > 0 Then
                    TreeView1.Nodes.Add(groupnode)
                End If
            Next

            istep = 30

            TreeView1.ExpandAll()
            dr2.Close()
            cmd.Dispose()
            conn.Close()

            istep = 40
            'NewThread.Priority = ThreadPriority.Lowest
            'NewThread.Start()
        Catch ex As Exception
            Response.Write(ex.ToString() & "Step :" & CStr(istep))
        End Try

    End Sub
End Class
