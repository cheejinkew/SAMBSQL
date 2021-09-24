<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<script language="VB" runat="server">

  Sub Page_Load(sender as Object, e as EventArgs)
    If Not Page.IsPostBack then
      Dim dirInfo as New DirectoryInfo(Server.MapPath(""))  
      
      if File.Exists(Server.MapPath("") + "\login.aspx") then
         Server.Transfer("login.aspx")
	     'response.write (File.Exists(Server.MapPath("") + "\hello.js"))
	  else
         articleList.DataSource = dirInfo.GetFiles("*.*")      
         articleList.DataBind()      
	  end if
    End If
  End Sub 
   
</script>
<html>
<head><title><%=Request.Url.Host%></title>
<style>
 a {text-decoration: none;}; a:hover {text-decoration: underline;}
</style>
</head>
<body>
<form runat="server">
  <asp:label runat="server" id="lblMessage" Font-Italic="True" ForeColor="Red" />
  <asp:DataGrid runat="server" id="articleList" Font-Name="Verdana"
      AutoGenerateColumns="False" AlternatingItemStyle-BackColor="#eeeeee"
      HeaderStyle-BackColor="Navy" HeaderStyle-ForeColor="White"
      HeaderStyle-Font-Size="10pt" HeaderStyle-Font-Bold="True"
      DataKeyField="FullName">
    <Columns>      
      
   <asp:HyperLinkColumn DataNavigateUrlField="Name" 
						DataNavigateUrlFormatString="{0}"
						DataTextField="Name" HeaderText="File Name" />

    </Columns>
  </asp:DataGrid>
</form>
</body>
</html>