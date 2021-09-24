<%@ Page Language="VB" %>
<%@ Import Namespace="ADODB"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Public st1, StrUserID 'As String
    Private Sub tv_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Write("AFter Click")
        Dim objConn
        Dim strConn
        Dim sqlRs
        Dim table = Request.QueryString("table")
        Dim district = Request.QueryString("dist")
        Dim start_date = Request.QueryString("start")
        Dim speriod = Request.QueryString("p")
        Dim uid = Request.QueryString("uid")
        Dim end_date
        Dim level_read, RF_read, cumRainfall, maya, tempoh
        Dim total_rainfall, counter
        Dim i
        strConn = ConfigurationSettings.AppSettings("DSNPG")
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        Dim st
        If tv.Nodes(0).Selected = True Then
            st = "select userid,state from telemetry_user_table where username='AKSBADMIN'" '" & tv.Nodes(0).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                StrUserID = 116
                Response.Redirect("Summary.aspx?&StrUserID=" & 116)
               
            End If
        End If
        If tv.Nodes(1).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(1).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                StrUserID = ""
                StrUserID = 120
                Response.Redirect("Summary.aspx?&StrUserID=" & 120)
            Else
            End If
        End If
        If tv.Nodes(2).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(2).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                Response.Redirect("Summary.aspx?&StrUserID=" & 130)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
        If tv.Nodes(3).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(3).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                Response.Redirect("Summary.aspx?&StrUserID=" & 129)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
        If tv.Nodes(4).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(4).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                Response.Redirect("Summary.aspx?&StrUserID=" & 131)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
        If tv.Nodes(5).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(5).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                Response.Redirect("Summary.aspx?&StrUserID=" & 9)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
        If tv.Nodes(6).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(6).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then  
                Response.Redirect("Summary.aspx?&StrUserID=" & 124)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
        If tv.Nodes(7).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(7).Text & "'"
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                Response.Redirect("Summary.aspx?&StrUserID=" & 125)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
        If tv.Nodes(8).Selected = True Then
            st = "select userid,state from telemetry_user_table where username ='" & tv.Nodes(8).Text & "'"
            Response.Write(st)
            objConn.open(strConn)
            sqlRs.Open(st, objConn)
            If Not sqlRs.EOF Then
                st1 = Convert.ToString(sqlRs("userid"))
                Response.Write(st1)
                Dim stONe As String = ""
                Response.Redirect("Summary.aspx?&StrUserID=" & 126) '&StrUserID=" & st1)
            Else
                Response.Redirect("nouser.aspx")
            End If
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title> 
</head>
<body>
    <form id="form1" runat="server">
<table border=1 style="height: 91px">
<tr> <td style="width: 1045px"><img align=top  src="../images/GUSSMANN.GIF" /></td>
</tr>
</table>
   <%-- <img align=top src="../images/GUSSMANN.GIF" style="width: 406px; height: 80px"> --%>
       <font><b>
      <div ></div>
     <div style="position:absolute ; left: 255px; width: 464px; top: 468px;font-size:medium;font-family:Arial;font-style:normal;font-weight:bolder; z-index: 100;"><small style="vertical-align: middle"> 
         24 Hour Help Line Center : 019 - 2117 703 / info@gussmanntech.com</small></div></b>
          <div style="position:absolute; left: 188px; top: 485px;font:status-bar; width: 592px; z-index: 101; vertical-align: bottom; direction: ltr; text-align: center;"; left: 184px; top: 487px>
              ...................................................................................................................................................<br />
              &nbsp;www.g1.com.my<br />
              Copyright © 2007 Global Telematics Sdn Bhd. All rights reserved<br />
              Powered by Integra ®</div></font>
        &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
        <asp:Label ID="Label1" runat="server" Text="User Summary" style="z-index: 103; left: 72px; position: absolute; top: 115px; vertical-align: middle; text-align: center;" Width="168px"></asp:Label>
        <asp:TreeView ID="tv" style="position:absolute; left: 70px; top: 143px;" runat="server" Height="297px" OnSelectedNodeChanged="tv_SelectedNodeChanged" Width="172px" ImageSet="News" NodeIndent="10" >
            <Nodes>
                <asp:TreeNode Text="AKSBADMIN" Value="AKSBADMIN"></asp:TreeNode> 
                <asp:TreeNode Text="JBAN9ADMIN" Value="JBAN9ADMIN"></asp:TreeNode>
                <asp:TreeNode Text="PHGADMIN" Value="PHGADMIN"></asp:TreeNode>
                <asp:TreeNode Text="PERAKADMIN" Value="PERAKADMIN"></asp:TreeNode>
                <asp:TreeNode Text="SWKADMIN" Value="SWKADMIN"></asp:TreeNode>
                <asp:TreeNode Text="LAKUADMIN" Value="LAKUADMIN"></asp:TreeNode>
                <asp:TreeNode Text="SELANGOR" Value="SELANGOR"></asp:TreeNode>
                <asp:TreeNode Text="SABAH" Value="SABAH"></asp:TreeNode>
               <asp:TreeNode Text="LABUAN" Value="LABUAN"></asp:TreeNode>             
            </Nodes>
            <ParentNodeStyle Font-Bold="False" />
            <HoverNodeStyle Font-Underline="True" />
            <SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" />
            <NodeStyle Font-Names="Arial" Font-Size="10pt" ForeColor="Black" HorizontalPadding="5px"
                NodeSpacing="0px" VerticalPadding="0px" />
        </asp:TreeView>
    </form>
 </body>
</html>