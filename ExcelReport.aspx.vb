Imports System.Text
Imports System.Data


Namespace AVLS

    Partial Class ExcelReport
        Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub


        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region
        Public sbrHTML As StringBuilder
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            'If Session("login") = Nothing Then
            '    Response.Redirect("Login.aspx")
            'End If

            Dim columncount As Byte = 8

            Dim title As String = Request.QueryString("title")
            Dim plateno As String = Request.QueryString("plateno")

            If Not Session("exceltable") Is Nothing Then

                Dim table As New DataTable
                table = Session("exceltable")

                columncount = table.Columns.Count
                If title = "Vehicle Log Report" Then
                    columncount = columncount - 1
                ElseIf title = "Vehicle Idling Report" Then
                    columncount = columncount - 1
                End If


                Response.Write("<table>")
                Response.Write("<tr><td colspan='" & columncount & "' align='left'><b style='font-family:Verdana;font-size:20px;color:#465AE8;'>" & title & "</b></td></tr>")
                Response.Write("<tr><td colspan='" & columncount & "'></td></tr>")
                If plateno <> Nothing Then
                    Response.Write("<tr><td colspan='" & columncount & "' align='left'><b>Vehicle Plate Number : </b>" & plateno & "</td></tr>")
                End If
                Response.Write("<tr><td colspan='" & columncount & "' align='left'><b>Report Date : </b>" & DateTime.Now & "</td></tr>")

                Response.Write("<tr><td colspan='" & columncount & "'></td></tr>")


                Response.Write("<tr>")
                For j As Int32 = 0 To columncount - 1
                    Response.Write("<th style='background-color: #465AE8; color: #FFFFFF';border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid>" & table.Columns(j).Caption & "</th>")
                Next
                Response.Write("</tr>")

                Dim totalRow As Boolean = False

                For j As Int32 = 0 To table.Rows.Count - 1
                    Response.Write("<tr>")

                    For i As Int32 = 0 To columncount - 1

                        If table.Rows(j).Item(i).ToString() = "TOTAL" Or table.Rows(j).Item(i).ToString() = "" Then
                            totalRow = True
                        End If
                        If totalRow = True Then
                            Response.Write("<td style='border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid'>" & table.Rows(j).Item((i)).ToString() & "</td>")
                        Else
                            Response.Write("<td style='border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid'>" & table.Rows(j).Item((i)).ToString() & "</td>") 'background-color: #FFFFE1;
                        End If
                    Next
                    totalRow = False
                    Response.Write("</tr>")
                Next

                'Response.Write("<tr><td colspan='" & columncount & "'></td></tr>")

                'Response.Write("<tr><td colspan='" & columncount & "' align='left'><b>Total Number of Records : " & table.Rows.Count & "</b></td></tr>")
                Response.Write("</table>")
            End If


            If Not Session("exceltable2") Is Nothing Then
                Dim table As New DataTable
                table = Session("exceltable2")

                columncount = table.Columns.Count

                Response.Write("<br/>")
                Response.Write("<br/>")
                Response.Write("<table border='1'>")

                Response.Write("<tr>")
                For j As Int32 = 0 To table.Columns.Count - 1
                    Response.Write("<th style='background-color: #465AE8; color: #FFFFFF'>" & table.Columns(j).Caption & "</th>")
                Next
                Response.Write("</tr>")


                For j As Int32 = 0 To table.Rows.Count - 1
                    Response.Write("<tr>")

                    For i As Int32 = 0 To table.Columns.Count - 1
                        Response.Write("<td >" & table.Rows(j).Item((i)).ToString() & "</td>") 'style='background-color: #FFFFE1;'
                    Next

                    Response.Write("</tr>")
                Next
                Response.Write("</table>")
            End If

            If Not Session("exceltable3") Is Nothing Then
                Dim table As New DataTable
                table = Session("exceltable3")

                columncount = table.Columns.Count

                Response.Write("<br/>")
                Response.Write("<br/>")
                Response.Write("<table border='1'>")

                Response.Write("<tr>")
                For j As Int32 = 0 To table.Columns.Count - 1
                    Response.Write("<th style='background-color: #465AE8; color: #FFFFFF'>" & table.Columns(j).Caption & "</th>")
                Next
                Response.Write("</tr>")


                For j As Int32 = 0 To table.Rows.Count - 1
                    Response.Write("<tr>")

                    For i As Int32 = 0 To table.Columns.Count - 1
                        Response.Write("<td >" & table.Rows(j).Item((i)).ToString() & "</td>") 'style='background-color: #FFFFE1;'
                    Next

                    Response.Write("</tr>")
                Next
                Response.Write("</table>")
            End If


            Response.ContentType = "application/vnd.ms-excel"
            Response.AddHeader("Content-Disposition", "attachment; filename=" & title & ".xls;")

        End Sub
    End Class
End Namespace
