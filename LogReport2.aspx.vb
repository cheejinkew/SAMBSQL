Imports System.Data.SqlClient
Imports System.Data
Imports System.Math
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports System.Windows.Forms



Partial Class samb_SambSql_LogReport
    Inherits System.Web.UI.Page

    Public ec As String = "false"


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            txtBeginDate.Value = Now().ToString("yyyy-MM-dd")
            txtEndDate.Value = Now().ToString("yyyy-MM-dd")
     
        End If
      

    End Sub

  
End Class
