﻿Imports System.Data.SqlClient
Imports System.Data

Partial Class AddUserR
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim sUserName As String = ""
        Dim sPassword As String = ""
        Dim sPhoneno As String = ""
        Dim sFaxno As String = ""
        Dim sStreet As String = ""
        Dim sPostCode As String = ""
        Dim sState As String = ""
        Dim sRole As String = ""
        Dim sAccessble As String = ""


        Try
            sUserName = Convert.ToString(Request.Form("txtUsername"))
            sPassword = Convert.ToString(Request.Form("txtPassword"))
            sPhoneno = Convert.ToString(Request.Form("txtPhoneno"))
            sFaxno = Convert.ToString(Request.Form("txtFaxNo"))
            sStreet = Convert.ToString(Request.Form("txtStreet"))
            sPostCode = Convert.ToString(Request.Form("txtPostcode"))
            sState = Convert.ToString(Request.Form("dLState"))
            sRole = Convert.ToString(Request.Form("ddLRole"))
            sAccessble = Convert.ToString(Request.Form("lstAccessible"))

            Dim Myconn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
            Myconn.Open()
            Dim MycommSMAXUserid As New SqlCommand("select MAX(userid) from telemetry_user_table ", Myconn)
            MycommSMAXUserid.ExecuteNonQuery()

            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            Dim dt As New DataTable
            Dim MaxUserid As Integer

            da.SelectCommand = MycommSMAXUserid
            da.Fill(ds, "telemetry_user_table")
            MaxUserid = Convert.ToInt16(ds.Tables("telemetry_user_table").Rows(0).Item(0))
            MaxUserid = MaxUserid + 1


            Dim Mycomm As New SqlCommand("insert into telemetry_user_table (userid,username,pwd,phoneno,faxno,streetname,postcode,sstate,srole) values ('" & MaxUserid & "','" & sUserName & "' ,'" & sPassword & "','" & sPhoneno & "','" & sFaxno & "','" & sStreet & "','" & sPostCode & "','" & sState & "','" & sRole & "' ")
            Mycomm.CommandText = "insert into telemetry_user_table (userid,username,pwd,phoneno,faxno,streetname,postcode,sstate,srole,control_district ) values ('" & MaxUserid & "','" & sUserName & "','" & sPassword.ToUpper & "','" & sPhoneno & "','" & sFaxno & "','" & sStreet & "','" & sPostCode & "','" & sState & "','" & sRole & "','" & sAccessble & "' )"

            Mycomm.Connection = Myconn
            Mycomm.ExecuteNonQuery()
            Me.Dispose()
            Response.Redirect("UserManagementSamb.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Me.Dispose()

    End Sub
End Class
