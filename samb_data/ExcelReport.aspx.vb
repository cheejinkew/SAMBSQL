Imports Npgsql


Partial Class ExcelReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim startingdate As String = Request.QueryString("start")
        Dim endingdate
        Dim time As String = Request.QueryString("time") & ":00:00"
        Dim level_read, gprsdatetime, gprsmessage As String


        Dim startdate As String = startingdate & " " & time
        startdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate))
        Dim enddate As String = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-55))


        Dim district() As String = {"Batu Pahat", "Johor Bahru", "Kluang", "Kota Tinggi", "Mersing", "Muar", "Pontian", "Segamat"}
        Dim tmconn As NpgsqlConnection = New NpgsqlConnection(ConfigurationManager.AppSettings("TMServer"))
        Dim g1conn As NpgsqlConnection = New NpgsqlConnection(ConfigurationManager.AppSettings("G1Server"))


        Dim cmd As NpgsqlCommand
        Dim dr As NpgsqlDataReader
        tmconn.Open()
        g1conn.Open()

        For i As Byte = 0 To district.Length - 1
            cmd = New NpgsqlCommand("select * from telemetry_site_list_table where sitedistrict='" & district(i) & "' and sitetype in ('BPH','WTP') order by siteid,sitetype", tmconn)
            dr = cmd.ExecuteReader()

            Response.Write("<b>District :" & district(i) & "</b><br/>")

            Response.Write("<table border='1'>")
            Response.Write("<tr><td><b>Site No</b></td><td><b>Site Name</b></td>")
            Response.Write("<td><b> Site Type </b></td>")
            Response.Write("<td><b>" & String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate)) & "</b></td>")
            Response.Write("<td><b> Latest Data </b></td>")
            Response.Write("<td><b> GPRS Data </b></td></tr>")

            While (dr.Read())

                level_read = "NO"
                enddate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(-30))
                cmd = New NpgsqlCommand("select tl.value  from telemetry_log_table tl, telemetry_site_list_table ts where tl.siteid='" & dr("siteid") & "' and  tl.siteid=ts.siteid and ts.sitetype='" & dr("sitetype") & "' and position='2'  and sequence between '" & enddate & "' and '" & startdate & "' order by sequence desc limit 1", g1conn)
                If cmd.ExecuteReader().Read() Then
                    level_read = "Yes"
                End If

                cmd = New NpgsqlCommand("select * from gprs_inbox_table where unitid='" & dr("unitid") & "' order by sequence desc limit 1", tmconn)
                Dim datadr As NpgsqlDataReader = cmd.ExecuteReader()

                If datadr.Read() Then
                    Response.Write("<tr><td>" & dr("siteid") & "</td><td>" & dr("sitename") & "</td>")
                    Response.Write("<td>" & dr("sitetype") & "</td>")
                    Response.Write("<td>" & level_read & "</td>")
                    Response.Write("<td>" & datadr("sequence") & "</td>")
                    Response.Write("<td>" & datadr("data") & "</td></tr>")
                End If
            End While

            Response.Write("</table><br/><br/>")


        Next
       
        'Dim cmd As NpgsqlCommand = New NpgsqlCommand("select * from telemetry_site_list_table where sitedistrict in ('Batu Pahat','Johor Bahru','Kluang,Kota Tinggi','Mersing','Muar','Pontian','Segamat') and sitetype in ('BPH','WTP')  order by siteid", tmconn)
        'tmconn.Open()
        'g1conn.Open()
        'Dim dr As NpgsqlDataReader = cmd.ExecuteReader()



        'Dim startdate As String = startingdate & " " & time
        'startdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate))
        'Dim enddate As String = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate).AddMinutes(-55))
        'Response.Write("<table border='1'>")

        'Response.Write("<tr><td><b>Site No</b></td><td><b>Site Name</b></td>")
        'Response.Write("<td><b>" & String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate)) & "</b></td>")
        'Response.Write("<td><b> Latest Data </b></td>")
        'Response.Write("<td><b> GPRS Data </b></td></tr>")

        'While (dr.Read())

        '    level_read = "NO"
        '    enddate = String.Format("{0:yyyy-MM-dd HH:mm}", Date.Parse(startdate).AddMinutes(-30))
        '    cmd = New NpgsqlCommand("select tl.value  from telemetry_log_table tl, telemetry_site_list_table ts where tl.siteid='" & dr("siteid") & "' and  tl.siteid=ts.siteid and ts.sitetype='" & dr("sitetype") & "' and position='2'  and sequence between '" & enddate & "' and '" & startdate & "' order by sequence desc limit 1", g1conn)
        '    If cmd.ExecuteReader().Read() Then
        '        level_read = "Yes"
        '    End If

        '    cmd = New NpgsqlCommand("select * from gprs_inbox_table where unitid='" & dr("unitid") & "' order by sequence desc limit 1", tmconn)
        '    Dim datadr As NpgsqlDataReader = cmd.ExecuteReader()

        '    If datadr.Read() Then
        '        Response.Write("<tr><td>" & dr("siteid") & "</td><td>" & dr("sitename") & "</td>")
        '        Response.Write("<td>" & level_read & "</td>")
        '        Response.Write("<td>" & datadr("sequence") & "</td>")
        '        Response.Write("<td>" & datadr("data") & "</td></tr>")
        '    End If

        'End While

        'Response.Write("</table>")

        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=Report.xls;")

    End Sub
End Class
