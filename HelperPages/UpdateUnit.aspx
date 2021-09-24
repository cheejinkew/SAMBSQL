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
  
  dim intUID = request.form("txtUserID")
  dim strUser = request.form("ddUser")

  dim strPassword = request.form("txtPassword")
  dim strSIMNo = request.form("txtSIMNo")
  dim strVersionID = request.form("txtVersionID")
  dim strUnitID = request.form("txtUnitID")
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  objConn.open (strConn)
 
  sqlSp = "Update unit_list set pwd='" & strPassword & "', simno='" & strSIMNo  & "'" & _
           "where unitid='" & strUnitID  & "' and versionid='" & strVersionID & "'"
 
  objConn.Execute (sqlSp)
  objConn.close
  objConn = Nothing

  strURL="../Unit.aspx"
%>

<html>
<head><title>.</title></head>
<body>
<form name="frmUpdateUnit" method="post" action="<%=strURL%>">
  <input type="hidden" value="<%=strUser%>" name="ddUser">
</form>
</body></html>
<script language="javascript">
  document.frmUpdateUnit.submit();
</script>