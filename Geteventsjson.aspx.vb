Imports System.Data.SqlClient
Imports System.Data
Imports Newtonsoft
Imports Newtonsoft.Json
Partial Class Geteventsjson
    Inherits System.Web.UI.Page
    Public sb3 As StringBuilder
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
        Dim cmd As SqlCommand
        Dim json As String = ""
        Dim aa As ArrayList = New ArrayList()
        Dim a As ArrayList
        Dim siteid As String = Request.QueryString("siteid")
        Dim opr As String = Request.QueryString("opr")
        Dim position As String
        Dim dispatchno As String
        Dim disnums() As String
        Try
            Dim dr As SqlDataReader
            Dim strQuery As String
            If (opr = "0") Then
                strQuery = "select  position,equipid   from telemetry_equip_list_table where siteid ='" & siteid & "' "
                cmd = New SqlCommand(strQuery, conn)
                conn.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    a = New ArrayList()
                    a.Add(dr(0))
                    a.Add(dr(1))
                    aa.Add(a)

                End While
            ElseIf (opr = "1") Then
                dispatchno = Request.QueryString("dis")
                disnums = dispatchno.Split(",")
                If disnums.Length > 1 Then
                    strQuery = "select distinct a.position,a.equipid,isnull(alert,0) alert,isnull(b.alerttype,'') alerttype   from telemetry_equip_list_table a left outer join telemetry_bphwtp_alertsetting_table b on a.siteid =b.Siteid and a.position =b.position   where a.siteid ='" & siteid & "' and a.position >=48"
                Else
                    strQuery = "select  a.position,a.equipid,isnull(alert,0) alert,isnull(b.alerttype,'') alerttype   from telemetry_equip_list_table a left outer join telemetry_bphwtp_alertsetting_table b on a.siteid =b.Siteid and a.position =b.position   where a.siteid ='" & siteid & "' and( b.dispatchno='+" & dispatchno.Trim() & "' or b.dispatchno='" & dispatchno.Trim() & "' or b.dispatchno is null) and a.position >=48 order by a.position,value "
                End If

                Dim da As SqlDataAdapter = New SqlDataAdapter(strQuery, conn)
                Dim dt As New DataTable
                da.Fill(dt)
                Dim value As String = ""
                For i As Integer = 0 To dt.Rows.Count
                    If i = 0 Then
                        value = dt.Rows(i)(1).ToString() & "," & dt.Rows(i)(0).ToString() & "," & dt.Rows(i)(0).ToString() & dt.Rows(i)(3).ToString()
                    ElseIf i = dt.Rows.Count Then
                        aa.Add(value)
                    ElseIf dt.Rows(i)(0).ToString() = dt.Rows(i - 1)(0).ToString() Then
                        value = value & "," & dt.Rows(i)(0).ToString() & dt.Rows(i)(3).ToString()
                    Else
                        aa.Add(value)
                        value = dt.Rows(i)(1).ToString() & "," & dt.Rows(i)(0).ToString() & "," & dt.Rows(i)(0).ToString() & dt.Rows(i)(3).ToString()
                    End If
                Next

            ElseIf (opr = "2") Then
                position = Request.QueryString("p")
                strQuery = "select  *  from telemetry_s1_event_values_table where siteid ='" & siteid & "' and position='" & position & "' "
                cmd = New SqlCommand(strQuery, conn)
                conn.Open()
                dr = cmd.ExecuteReader()
                a = New ArrayList()
                If (dr.Read()) Then
                    a.Add(1)
                Else
                    a.Add(0)
                End If
                aa.Add(a)

            ElseIf (opr = "3") Then
                position = Request.QueryString("p")
                Dim subopr As String = Request.QueryString("subopr")
                Dim llmin As String = Request.QueryString("llmin")
                Dim llmax As String = Request.QueryString("llmax")
                Dim lmin As String = Request.QueryString("lmin")
                Dim lmax As String = Request.QueryString("lmax")
                Dim nnmin As String = Request.QueryString("nnmin")
                Dim nnmax As String = Request.QueryString("nnmax")
                Dim hmin As String = Request.QueryString("hmin")
                Dim hmax As String = Request.QueryString("hmax")
                Dim hhmin As String = Request.QueryString("hhmin")
                Dim hhmax As String = Request.QueryString("hhmax")
                Dim tlimit1 As String = Request.QueryString("tlimit1")
                Dim tlimit2 As String = Request.QueryString("tlimit2")
                Dim pname As String = Request.QueryString("pname")
                Dim res As Byte
                Dim strchk As String
                Dim dr1 As SqlDataReader
                strchk = "select * from  telemetry_s1_event_values_table where  siteid='" & siteid & "' and position='" & position & "'"

                cmd = New SqlCommand(strchk, conn)
                conn.Open()
                dr1 = cmd.ExecuteReader()
                If dr1.Read() Then
                    strQuery = "update telemetry_s1_event_values_table set posname='" & pname & "', LLmin='" & llmin & "',LLmax='" & llmax & "',Lmin='" & lmin & "',Lmax='" & lmax & "',NNmin='" & nnmin & "',NNmax='" & nnmax & "',Hmin='" & hmin & "',Hmax='" & hmax & "',HHmin='" & hhmin & "',HHmax='" & hhmax & "',timelimit1='" & tlimit1 & "',timelimit2='" & tlimit2 & "' where siteid='" & siteid & "' and position='" & position & "'"
                Else
                    strQuery = "insert into telemetry_s1_event_values_table(siteid,position,posname,LLmin,LLmax,Lmin,Lmax,NNmin,NNmax,Hmin,Hmax,HHmin,HHmax,timelimit1,timelimit2) values('" & siteid & "','" & position & "','" & pname & "','" & llmin & "','" & llmax & "','" & lmin & "','" & lmax & "','" & nnmin & "','" & nnmax & "','" & hmin & "','" & hmax & "','" & hhmin & "','" & hhmax & "','" & tlimit1 & "','" & tlimit2 & "' )"

                End If
                dr1.Close()
                cmd = New SqlCommand(strQuery, conn)

                res = cmd.ExecuteNonQuery()
                a = New ArrayList()
                If (res > 0) Then
                    a.Add(1)
                Else
                    a.Add(0)
                End If
                aa.Add(a)

            ElseIf (opr = "4") Then
                position = Request.QueryString("p")
                strQuery = "select  *  from telemetry_s1_event_values_table where siteid ='" & siteid & "' and position='" & position & "' "
                cmd = New SqlCommand(strQuery, conn)
                conn.Open()
                dr = cmd.ExecuteReader()
                a = New ArrayList()
                If (dr.Read()) Then
                    a.Add(dr(2))
                    a.Add(dr(3))
                    a.Add(dr(4))
                    a.Add(dr(5))
                    a.Add(dr(6))
                    a.Add(dr(7))
                    a.Add(dr(8))
                    a.Add(dr(9))
                    a.Add(dr(10))
                    a.Add(dr(11))
                    a.Add(dr(12))
                    a.Add(dr(13))
                    a.Add(dr(14))
                    a.Add(1)
                Else
                    a.Add("")
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                    a.Add(0)
                End If
                aa.Add(a)
            ElseIf (opr = "5") Then
                Dim res As Byte
                dispatchno = Request.QueryString("dis")
                strQuery = "delete from telemetry_bphwtp_alertsetting_table where siteid='" & siteid & "' and dispatchno='+" & dispatchno.Trim() & "'"
                cmd = New SqlCommand(strQuery, conn)
                conn.Open()
                res = cmd.ExecuteNonQuery()
                a = New ArrayList()
                If (res > 0) Then
                    a.Add(1)
                Else
                    a.Add(0)
                End If
                aa.Add(a)
            End If

            Dim jss As New Newtonsoft.Json.JsonSerializer()

            json = JsonConvert.SerializeObject(aa, Formatting.None)

            Response.ContentType = "text/plain"
            Response.Write(json)



            conn.Close()

        Catch ex As Exception

        End Try
    End Sub
End Class
