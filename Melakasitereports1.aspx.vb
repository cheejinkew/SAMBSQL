Imports System.Data
Imports System.Collections
Imports ADODB
Partial Class Melakasite_reports1
    Inherits System.Web.UI.Page
    Public str1
    Public str2
    Public str3
    Public str4
    Public str5
    Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
    Dim strControlDistrict

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim i
        Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
        If arryControlDistrict.length() > 1 Then
            For i = 0 To (arryControlDistrict.length() - 1)
                If i <> (arryControlDistrict.length() - 1) Then
                    strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
                Else
                    strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
                End If
            Next i
        Else
            strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
        End If

        If Page.IsPostBack = False Then
            Dim objConn
            Dim str
            objConn = New ADODB.Connection()
            str = New ADODB.Recordset()
            objConn.open(strConn)
            'If arryControlDistrict(0) <> "ALL" Then
            '    str.open("select distinct(sitedistrict) from telemetry_site_list_table where sitetype='RADCOM' and sitedistrict in(" & strControlDistrict & ") order by sitedistrict", objConn)
            'Else
            '    str.open("select distinct(sitedistrict) from telemetry_site_list_table where sitetype='RADCOM'  order by sitedistrict", objConn)
            'End If
            Dim cont1 As Integer = 0
            Dim cont2 As Integer = 0

            'Do While Not str.EOF
            str4 = "Melaka" 'str("sitedistrict").value
            TreeView1.Nodes.Add(New TreeNode(str4, str4))
            Dim lable1 = Request.QueryString("lab")
            Dim dis = Request.QueryString("root")
            Dim dist = "Besut" 'str("sitedistrict").value
            str5 = New ADODB.Recordset()
            str5.open("select distinct sitename,siteid from telemetry_site_list_table where siteid in ('8511','8512','8619','8620','8621','8643','8546')  order by sitename ", objConn)
            cont1 += cont2
            TreeView1.Nodes(TreeView1.Nodes.Count - 1).NavigateUrl = "javascript:TreeView_ToggleNode(TreeView1_Data," & cont1 & ",TreeView1n" & cont1 & ",' ',TreeView1n" & cont1 & "Nodes)"
            Do While Not str5.Eof
                str3 = str5("sitename").value
                str1 = str5("siteid").value & " - " & str5("sitename").value
                Dim tn As TreeNode = New TreeNode(str3, str1)
                tn.NavigateUrl = dis & "sitename=" & str5("sitename").value & "&siteid=" & str5("siteid").value & "&lab=" & lable1
                tn.Target = "main"
                TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn)
                cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
                str5.movenext()
            Loop
            str5.close()
            'str3 = "P Perhentian Besar " 'str5("sitename").value
            'str1 = "F330 - P Perhentian Besar" 'str5("siteid").value & " - " & str5("sitename").value
            'Dim tn2 As TreeNode = New TreeNode(str3, str1)
            'tn2.NavigateUrl = dis & "sitename=" & str3 & "&siteid=F330&lab=" & lable1
            'tn2.Target = "main"
            'TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Add(tn2)
            'cont2 = (TreeView1.Nodes(TreeView1.Nodes.Count - 1).ChildNodes.Count) + 1
            'str.movenext()
            '    Loop
            'Str.close()
            objConn.close()
        End If
    End Sub
End Class
