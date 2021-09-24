<script runat="server">

Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

End Sub
</script>

<%
    Dim SiteID = Request.QueryString("pilih")
    If SiteID = "mute" Then
        Session("sound") = "false"
    Else
        Session("sound") = "true"
    End If
   
%>