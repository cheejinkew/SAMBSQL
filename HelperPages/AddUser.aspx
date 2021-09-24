<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="AspMap"%>
<%@ Import Namespace="ADODB" %>
<html>
<head><title>.</title></head>
<body>
<%

  dim objConn
  dim strConn
  dim sqlSp
  dim sqlRs
  dim strError
  dim strErrorColor
  dim strURL
  
  dim strUsername = UCase(request.form("txtUsername"))
  dim strPassword = UCase(request.form("txtPassword"))
  dim strPhone = request.form("txtPhone")
  dim strFax = request.form("txtFax")
  dim strStreet = request.form("txtStreet")
  dim strPostCode = request.form("txtPostCode")
  dim strState = request.form("ddState")
  dim strRole = request.form("ddRole")
  dim strAccessDistrict = request.form("ddAccessDistrict")
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  Try
    objConn.open (strConn)
 
    sqlSp = "insert into telemetry_user_table values(nextval('telemetry_user_table_userid_seq'), '" & _
             strUsername & "','" & strPassword & "', '" & strPhone  & "', '" & strFax & "', '" & strStreet & _
            "', '" & strPostCode & "', '" & strState & "', '" & strRole & "', '" & strAccessDistrict & "')"

    objConn.Execute (sqlSp)
  Catch
    strError = "Database Error !"
    strErrorColor = "Red"
  End Try
  objConn.close
  objConn = Nothing
  
  if strError ="" then
%>

<form name="frmAddSite" method="post" action="../User.aspx">
</form>

<%else%>

<form name="frmAddSite" method="post" action="../AddUser.aspx">
  <input type="hidden" name="txtError" value="<%=strError%>">
  <input type="hidden" name="txtErrorColor" value="<%=strErrorColor%>">
  <input type="hidden" name="txtUsername" value="<%=strUsername%>">
  <input type="hidden" name="txtPassword" value="<%=strPassword%>">
  <input type="hidden" name="txtPhone" value="<%=strPhone%>">
  <input type="hidden" name="txtFax" value="<%=strFax%>">
  <input type="hidden" name="txtStreet" value="<%=strStreet%>">
  <input type="hidden" name="txtPostCode" value="<%=strPostCode%>">
  <input type="hidden" name="ddState" value="<%=strState%>">
  <input type="hidden" name="ddRole" value="<%=strRole%>">
</form>

<%end if%>
</body></html>
<script language="javascript">
  document.frmAddSite.submit();
</script>