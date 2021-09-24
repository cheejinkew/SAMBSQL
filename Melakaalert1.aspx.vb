Imports System.IO, System.Convert, System.Data.OleDb, ADODB, System.Array, System.Threading, Gussmann.CelcomShortCode, System.Data.Odbc
Partial Class Melakaalert1
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        gettingalerts()

    End Sub

    Public Sub gettingalerts()
        Try
            Dim k = 0
            Dim l = 0
            Dim startdate1 = System.DateTime.Now
            Dim str2 = Format(startdate1, "yyyy/MM/dd")
            Dim begindate = str2 + " " + "00:00:00"

            Dim text, x
            Dim tempoh1 = 23
            Dim enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(begindate).AddHours(tempoh1))

            Dim strControlDistrict5
            Dim strConn5 = System.Configuration.ConfigurationManager.AppSettings("DSNPG")

            Dim sqlRs5 = New ADODB.Recordset()
            Dim objConn5 = New ADODB.Connection()
            objConn5.open(strConn5)
            Dim i = 0
            Dim sqlRs6 = New ADODB.Recordset()
            Dim sqlRs7 = New ADODB.Recordset()

            Dim aaa = ""

            TreeView1.Nodes.Clear()

            Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
            If arryControlDistrict.length() > 1 Then
                For i = 0 To (arryControlDistrict.length() - 1)
                    If i <> (arryControlDistrict.length() - 1) Then
                        strControlDistrict5 = strControlDistrict5 & "'" & Trim(arryControlDistrict(i)) & "', "
                    Else
                        strControlDistrict5 = strControlDistrict5 & "'" & Trim(arryControlDistrict(i)) & "'"
                    End If
                Next i
            Else
                strControlDistrict5 = strControlDistrict5 & "'" & arryControlDistrict(0) & "'"
            End If


            Dim district = "Melaka"

            sqlRs6.Open("select final.siteid,final.sitename,final.sequence,final.alarmtype from (select result.siteid,t1.sitename,result.sequence,t1.alarmtype from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('LL','L','H','HH'))) final,telemetry_site_list_table as sitelist where final.siteid=sitelist.siteid and final.sequence between '" & begindate & " ' and '" & enddate & " ' and  sitelist.siteid in ('8511','8512','8619','8620','8621','8643','8546') order by sitename  ", objConn5)

            If sqlRs6.EOF = False Then

                Dim groupnode As TreeNode
                Dim vehiclenode As TreeNode
                groupnode = New TreeNode()
                groupnode.Text = district.ToString

                Do While Not sqlRs6.EOF

                    Dim strEvent2 = sqlRs6("alarmtype").value
                    Dim time2 = sqlRs6("sequence").value
                    Dim time4 = Split(time2, " ")
                    Dim sitename = sqlRs6("sitename").value
                    Dim siteid = sqlRs6("siteid").value
                    Dim value = "0"
                    sqlRs7.Open("SELECT value from telemetry_equip_status_table where siteid='" & siteid & "'", objConn5)

                    If Not sqlRs7.EOF Then

                        value = sqlRs7("value").value

                    End If

                    Dim strSiteName1 = sqlRs6("sitename").value + "<br/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + " Time : " + time4(1)

                    If Not district = Nothing Then

                        vehiclenode = New TreeNode()
                        vehiclenode.Text = "<img id='aaa' alt='Site Name:" & sitename & "&nbsp;&nbsp; Value:" & value & " &nbsp;&nbsp; Alert:" & strEvent2 & " &nbsp;&nbsp;time:" & time4(1) & " ' style='vertical-align:middle;border:solid white 0px;' onmouseout='javascript:height2(this)' onmouseover='javascript:height1(this)' border='0' src='images/" & strEvent2 & ".png 'height='20'width='20'/>&nbsp;&nbsp;" & strSiteName1.ToString

                        vehiclenode.Target = "main"
                        vehiclenode.NavigateUrl = "Summary.aspx?sitetype=RESERVOIR&sitename=" & sitename & "&siteid=" & siteid & "&district=" & groupnode.Text
                        vehiclenode.ToolTip = "Click to go to Summary"
                        groupnode.ChildNodes.Add(vehiclenode)

                    End If
                    sqlRs6.Movenext()
                    sqlRs7.close()
                Loop
                If groupnode.ChildNodes.Count > 0 Then
                    TreeView1.Nodes.Add(groupnode)
                End If
                k += 1
            End If
            sqlRs6.close()
            objConn5.close()

            TreeView1.ExpandAll()

            'NewThread.Priority = ThreadPriority.Lowest

            'NewThread.Start()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

    End Sub
End Class
