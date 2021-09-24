Imports System.Data
Imports System.Data.SqlClient
Partial Class HelperPages_AddUpdateSettingsHelper
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim siteid As String = Request.Form("siteid")
        'Dim unitid As String = Request.QueryString("unitid")
        'Dim simno As String = Request.QueryString("simno")
        Dim values As String = Request.Form("values")
        Dim pos As String = Request.Form("pos")
        Dim opr As Integer = Convert.ToInt16(Request.Form("opr"))
        Dim mobilenos As String = Request.Form("mobilenos")
        Dim categories As String = Request.Form("categs")
        Dim id() As String
        Dim value() As String
        Dim position() As String
        Dim mobnums() As String
        Dim categs() As String
        value = values.Split(",")
        position = pos.Split(",")
        mobnums = mobilenos.Split(",")
        categs = categories.Split(",")
        Dim alert As Integer
        Dim alerttype As String = ""
        Dim posi As String = ""
        Try
            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
            Dim cmd As SqlCommand
            Dim frto() As String = Nothing


            conn.Open()
            If opr = 0 Then
                For mobno As Integer = 0 To mobnums.Length - 1
                    For i As Integer = 0 To position.Length - 1
                        If position(i).Length > 1 Then
                            If Convert.ToInt32(position(i).Substring(0, 2)) < 48 Then
                                    alert = 1
                                    alerttype = "Narmal"
                                    posi = position(i)
                            ElseIf Convert.ToInt32(position(i).Substring(0, 2)) >= 48 Then
                                alert = 1
                                alerttype = position(i).Substring(2)
                                posi = position(i).Substring(0, 2)
                            End If
                        Else
                            alert = 1
                            alerttype = "Narmal"
                            posi = position(i)
                        End If
                       
                        ' cmd = New SqlCommand("insert into telemetry_bphwtp_alertsetting_table(siteid,unitid,simno,position,value,insertdate,mob1,mob2,mob3,mob4,mob5,mob6,mob7,mob8,mob9,mob10) values('" & siteid & "','" & unitid & "','+" & simno.Trim() & "','" & position(i) & "','" & value(i) & "','" & Date.Now & "','+" & mobnums(0).Trim() & "','+" & mobnums(1).Trim() & "','+" & mobnums(2).Trim() & "','+" & mobnums(3).Trim() & "','+" & mobnums(4).Trim() & "','+" & mobnums(5).Trim() & "','+" & mobnums(6).Trim() & "','+" & mobnums(7).Trim() & "','+" & mobnums(8).Trim() & "','+" & mobnums(9).Trim() & "')", conn)
                        Try

                            cmd = New SqlCommand("insert into telemetry_bphwtp_alertsetting_table(siteid,dispatchno,position,value,alert,alerttype,distict,category) values('" & siteid & "','" & mobnums(mobno).Trim() & "','" & posi & "','" & alert & "','" & alert & "','" & alerttype & "','','" & categs(mobno).Trim() & "')", conn)
                            cmd.ExecuteNonQuery()
                        Catch ex As Exception

                        End Try
                      
                    Next
                Next
              
            ElseIf opr = 1 Then
               
                Deletesettings(siteid, mobilenos)
                For mobno As Integer = 0 To mobnums.Length - 1
                    For i As Integer = 0 To position.Length - 1
                         If position(i).Length > 1 Then
                            If Convert.ToInt32(position(i).Substring(0, 2)) < 48 Then
                                alert = 1
                                alerttype = "Narmal"
                                posi = position(i)
                            ElseIf Convert.ToInt32(position(i).Substring(0, 2)) >= 48 Then
                                alert = 1
                                alerttype = position(i).Substring(2)
                                posi = position(i).Substring(0, 2)
                            End If
                        Else
                            alert = 1
                            alerttype = "Narmal"
                            posi = position(i)
                        End If

                        ' cmd = New SqlCommand("insert into telemetry_bphwtp_alertsetting_table(siteid,unitid,simno,position,value,insertdate,mob1,mob2,mob3,mob4,mob5,mob6,mob7,mob8,mob9,mob10) values('" & siteid & "','" & unitid & "','+" & simno.Trim() & "','" & position(i) & "','" & value(i) & "','" & Date.Now & "','+" & mobnums(0).Trim() & "','+" & mobnums(1).Trim() & "','+" & mobnums(2).Trim() & "','+" & mobnums(3).Trim() & "','+" & mobnums(4).Trim() & "','+" & mobnums(5).Trim() & "','+" & mobnums(6).Trim() & "','+" & mobnums(7).Trim() & "','+" & mobnums(8).Trim() & "','+" & mobnums(9).Trim() & "')", conn)
                        Try
                            cmd = New SqlCommand("insert into telemetry_bphwtp_alertsetting_table(siteid,dispatchno,position,value,alert,alerttype,distict,category) values('" & siteid & "','" & mobnums(mobno).Trim() & "','" & posi & "','" & alert & "','" & alert & "','" & alerttype & "','','" & categs(mobno).Trim() & "')", conn)
                            cmd.ExecuteNonQuery()
                        Catch ex As Exception

                        End Try

                    Next
                Next
            End If
            Try

            Catch ex As Exception

            Finally
                conn.Close()
            End Try
        Catch ex As Exception

        End Try
        Response.Redirect("../DispatchAlertsSettings.aspx")
    End Sub

    'Public Function getExistsornot(ByVal siteid As String, ByVal mobileno As Integer) As Boolean
    '    Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
    '    Dim cmd As SqlCommand
    '    Dim dr As SqlDataReader
    '    Dim res As Boolean
    '    Try
    '        conn.Open()
    '        cmd = New SqlCommand("select * from telemetry_bphwtp_alertsetting_table where siteid='" & siteid & "' and position ='" & pos & "' and id='" & ID & "'", conn)
    '        dr = cmd.ExecuteReader()
    '        If (dr.Read()) Then
    '            res = True
    '        Else
    '            res = False
    '        End If
    '        conn.Close()


    '    Catch ex As Exception


    '    End Try
    '    Return res

    'End Function
    Public Function Deletesettings(ByVal siteid As String, ByVal mobileno As String) As Integer
        Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("SAMBconnection"))
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim mobnums() As String
     
        mobnums = mobileno.Split(",")
        Dim res As Integer
        Try
            conn.Open()
            For mobno As Integer = 0 To mobnums.Length - 1
                cmd = New SqlCommand("delete from telemetry_bphwtp_alertsetting_table where siteid='" & siteid & "' and dispatchno='" & mobnums(mobno) & "' ", conn)
                res = cmd.ExecuteNonQuery()
            Next
            conn.Close()
        Catch ex As Exception

        End Try
        Return res

    End Function
End Class
