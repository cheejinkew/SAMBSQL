Imports System.Data.SqlClient
Imports System.Data
Imports Newtonsoft
Imports Newtonsoft.Json

Partial Class SajWtpBhpAlertsSetting
    Inherits System.Web.UI.Page
    Public siteids As String
    Public dispatchno As String
    Public opr As Integer
    Public sb As StringBuilder
    Public sb1 As StringBuilder
    Public sb3 As StringBuilder
    Dim values As String = "0"
    Dim values1 As String = "0"
    Dim pos As String = "0"
    Dim ids As String = "0"
    Dim siteid As String
    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        opr = Request.QueryString("opr")

        Dim dr As SqlDataReader
        Try
            Dim strQuery As String = "SELECT a.siteid,a.sitename, a.unitid, b.simno  from telemetry_site_list_table a, unit_list b  where a.unitid=b.unitid and a.sitetype<>'RESERVOIR'    order by sitename "
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            'sb = New StringBuilder()
            'sb.Append("<select class='FormDropdown' id='ddlSite' onchange='getequpments()' ><option value='0'>SELECT SITE</option>")

            While dr.Read()
                'sb.Append("<option value='" & dr("siteid") & ">" & dr("sitename") & "-" & dr("siteid") & "</option>")
                ddlSite.Items.Insert(0, New ListItem(dr("sitename") & "-" & dr("siteid"), dr("siteid")))

            End While


            'sb.Append("</select >")

            dr.Close()
            conn.Close()

        Catch ex As Exception

        End Try
        If (opr = 0) Then
            ddlSite.Enabled = True
            Fillcontactdetails()
        Else
            ddlSite.Enabled = False
            siteid = Request.QueryString("siteid")
            dispatchno = Request.QueryString("dispatchno")
            Fillcontactdetails()
            Getdetails(siteid, dispatchno)
        End If

    End Sub
    Public Sub Fillcontactdetails()
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        Try
            Dim dr As SqlDataReader
            Dim strQuery As String = "select cname ,simno  from telemetry_contact_list_table where cstatus =1 "
            'Dim strQuery As String = "select username as cname ,phoneno as simno  from telemetry_saj_user_table "
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            sb1 = New StringBuilder()


            While dr.Read()
                sb1.Append("<option value='" & dr("simno") & "'>" & dr("cname").ToString().ToUpper() & "</option>")
            End While
            dr.Close()
            conn.Close()

        Catch ex As Exception

        End Try
    End Sub
    Public Sub Fillequipments(ByVal siteid As String)
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        Dim json As String = ""
        Try
            Dim dr As SqlDataReader
            Dim strQuery As String = "select  position,equipid   from telemetry_equip_list_table where siteid ='" + siteid + "' "
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            sb3 = New StringBuilder()

            sb3.Append("<table style='width:100%;text-align:left;font-family :Verdana;font-size:11px; color:#5373A2;' align='right' >")
            sb3.Append("<thead align ='centre'><tr><th style ='width :40%;'>Event </th><th style ='width :10%;'>LL </th><th style ='width :10%;'>L </th><th style ='width :10%;'>NN </th><th style ='width :10%;'>H</th><th style ='width :20%;'>HH </th></tr></thead>")
            sb3.Append("<tbody>")
            While dr.Read()
                sb3.Append("<tr><td>" & dr(1) & "</td><td><input id='chk" & dr(0) & "LL' type='checkbox' value='" & dr(0) & "LL' onclick='check(this)' /></td>")
                sb3.Append("<td><input id='chk" & dr(0) & "L' type='checkbox' value='" & dr(0) & "L' onclick='check(this)' /></td>")
                sb3.Append("<td><input id='chk" & dr(0) & "NN' type='checkbox' value='" & dr(0) & "NN' onclick='check(this)' /></td>")
                sb3.Append("<td><input id='chk" & dr(0) & "H' type='checkbox' value='" & dr(0) & "H' onclick='check(this)' /></td>")
                sb3.Append("<td><input id='chk" & dr(0) & "HH' type='checkbox' value='" & dr(0) & "HH' onclick='check(this)' /></td></tr>")
            End While
            sb3.Append("</tbody>")
            sb3.Append("</table>")
            'hidevents.Value = ""
            'hidevents.Value = sb3.ToString()
            'Json = JsonConvert.SerializeObject(sb3, Formatting.None)
            'ClientScript.RegisterStartupScript(Me.GetType(), "Javascript", "javascript:getequpments('" + json + "'); ", True)


            dr.Close()
            conn.Close()

        Catch ex As Exception

        End Try
    End Sub





    Public Sub Getdetails(ByVal siteid As String, ByVal mobileno As String)

        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        siteid = Request.QueryString("siteid")
        Dim ds As New DataSet
        Dim dr As SqlDataReader
        sb = New StringBuilder()
        Dim sitename As String = ""

        Dim dispatchnos As String = Nothing
        Dim simno As String = Nothing
        Dim category As String = Nothing

        Dim mobilenums() As String = mobileno.Split(",")


        Try
            ' Dim strQuery As String = "select a.id, a.siteid,b.sitename  ,a.unitid ,a.simno,a.position,a.value,a.mob1,a.mob2,a.mob3,a.mob4,a.mob5,a.mob6,a.mob7,a.mob8,a.mob9,a.mob10 from telemetry_bphwtp_alertssettings_table a,telemetry_site_list_table b where a.siteid =b.siteid and b.siteid ='" & siteid & "' order by siteid "
            Dim strQuery As String
            If mobilenums.Length > 1 Then
                strQuery = "select distinct Siteid  ,position ,value, alert,alerttype,category  from telemetry_bphwtp_alertsetting_table where Siteid ='" & siteid & "'"

            Else
                strQuery = "select Siteid ,dispatchno ,position ,value, alert,alerttype,category  from telemetry_bphwtp_alertsetting_table where Siteid ='" & siteid & "' and (dispatchno ='+" & mobilenums(0).Trim() & "' or dispatchno ='" & mobilenums(0).Trim() & "')"

            End If
            cmd = New SqlCommand(strQuery, conn)
            conn.Open()
            dr = cmd.ExecuteReader()
            Dim i As Integer = 0
            While dr.Read()

                pos = pos & "," & dr("position")
                If Convert.ToInt32(dr("position")) > 35 Then
                    values = values & "," & dr("value") & ":" & dr("alerttype")
                Else
                    values = values & "," & dr("value")
                End If

                sitename = dr("Siteid")

                category = dr("category")
                'mob1.Value = dr("mob1")
                'mob2.Value = dr("mob2")
                'mob3.Value = dr("mob3")
                'mob4.Value = dr("mob4")
                'mob5.Value = dr("mob5")
                'mob6.Value = dr("mob6")
                'mob7.Value = dr("mob7")
                'mob8.Value = dr("mob8")
                'mob9.Value = dr("mob9")
                'mob10.Value = dr("mob10")
            End While

            ClientScript.RegisterStartupScript(Me.GetType(), "Javascript", "javascript:Getsettings('" & sitename & "','" & pos & "','" & values & "','" & mobileno & "','" & category & "'); ", True)


            'sb.Append("<select class='FormDropdown' id='ddlSite' ><option value='" & siteid & "'>" & sitename & "</option></select>")
            ''txtunitid.Value = unitid
            'txtsimno.Value = simno


        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        'Dim cmd As SqlCommand
        'Dim dr As SqlDataReader
        'Try
        '    Dim strQuery As String = "SELECT a.siteid,a.sitename, a.unitid, b.simno  from telemetry_site_list_table a, unit_list b  where a.unitid=b.unitid and a.sitetype<>'RESERVOIR' and a.siteid not in(select distinct siteid from telemetry_bphwtp_alertsettings_table)   order by sitename "
        '    cmd = New SqlCommand(strQuery, conn)
        '    conn.Open()
        '    dr = cmd.ExecuteReader()
        '    'sb = New StringBuilder()
        '    'sb.Append("<select class='FormDropdown' id='ddlSite' onchange='getequpments()' ><option value='0'>SELECT SITE</option>")

        '    While dr.Read()
        '        'sb.Append("<option value='" & dr("siteid") & ">" & dr("sitename") & "-" & dr("siteid") & "</option>")
        '        ddlSite.Items.Insert(0, New ListItem(dr("sitename") & "-" & dr("siteid"), dr("siteid")))

        '    End While


        '    'sb.Append("</select >")

        '    dr.Close()
        '    conn.Close()

        'Catch ex As Exception

        'End Try
    End Sub

    'Protected Sub ddlSite_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSite.SelectedIndexChanged
    '    Try
    '        Fillequipments(ddlSite.SelectedValue)
    '    Catch ex As Exception

    '    End Try


    'End Sub
End Class
