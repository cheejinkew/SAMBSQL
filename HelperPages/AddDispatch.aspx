<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="AspMap"%>
<%@ Import Namespace="ADODB" %>

<%

  dim objConn
  dim strConn
  dim sqlSp
  dim sqlRs
  dim strError
  dim strErrorColor
  dim strURL
  
  dim intSiteID = request.form("ddSite")
  dim intRuleID = request.form("ddRule")

    Dim strName = Request.Form("txtName")
  dim strPost = request.form("txtPost")
  dim strSIMNo = request.form("txtSIMno")
  dim intPriority = request.form("txtPriority")
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  Try
  objConn.open (strConn)
 
        sqlSp = "insert into telemetry_dispatch_list_table (ruleid, simno, priority, sname, post) values('" & intRuleID & "','" & strSIMNo & _
          "'," & intPriority & ",'" & strName & "','" & strPost & "')"

  objConn.Execute (sqlSp)
  Catch
    strError = "Primary Key Duplication !"
    strErrorColor = "Red"
  End Try
  
  objConn.close
  objConn = Nothing

  if strError = "" then
%>

<form name="frmAddDispatch" method="post" action="../Dispatch.aspx">
  <input type="hidden" name="ddSite" value="<%=intSiteID%>">
</form>

<%else%>

<form name="frmAddDispatch" method="post" action="../AddDispatch.aspx">
  <input type="hidden" name="ddSite" value="<%=intSiteID%>">
  <input type="hidden" name="ddRule" value="<%=intRuleID%>">
  <input type="hidden" name="txtName" value="<%=strName%>">
  <input type="hidden" name="txtPost" value="<%=strPost%>">
  <input type="hidden" name="txtSIMno" value="<%=strSIMNo%>">
  <input type="hidden" name="txtPriority" value="<%=intPriority%>">
  <input type="hidden" name="txtError" value="<%=strError%>">
  <input type="hidden" name="txtErrorColor" value="<%=strErrorColor%>">

</form>

<%end if%>

<script language="javascript">
  document.frmAddDispatch.submit();
</script>

