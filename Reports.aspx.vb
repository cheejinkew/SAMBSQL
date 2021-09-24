Imports System.Xml

Partial Class Reports
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim userid As String = "0000"
            ddlreport.Attributes.Add("onchange", "mysubmit(this)")

            Dim xmldoc As XmlDocument = New XmlDocument()
            'If userid = "323" Or userid = "1028" Or userid = "1029" Or userid = "1048" Or userid = "985" Or userid = "1001" Or userid = "1012" Or userid = "1031" Or Session("role") = "Admin" Then
            '    xmldoc.Load(Server.MapPath("xmlfiles/ReportsPre.xml"))
            'Else
            '    xmldoc.Load(Server.MapPath("xmlfiles/Reports.xml"))
            'End If
         
                xmldoc.Load(Server.MapPath("xmlfiles/Reports.xml"))
            Dim reports As XmlNode = xmldoc.SelectSingleNode("/Root/Reports[@UserID and (@UserID=""" & userid & """)]")

            Dim reportlist As XmlNodeList = reports.ChildNodes()
            ddlreport.Items.Add(New ListItem("--Select Report Type--", "Reports.aspx"))

            Try
                For i As Int16 = 0 To reportlist.Count - 1
                    ddlreport.Items.Add(New ListItem((i + 1).ToString("00") & " - " & reportlist(i).Attributes("Name").Value, reportlist(i).Attributes("Value").Value))
                Next
            Catch ex As Exception

            End Try


        Catch ex As Exception

        End Try
    End Sub
End Class
