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
  
  dim intUserID = request.form("txtUserID")
  dim strPassword = UCase(request.form("txtNewPassword"))
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

  objConn.open (strConn)
 
  sqlSp = "update telemetry_user_table set pwd='" & strPassword & _
          "', phoneno = '" & strPhone & "', faxno='" & strFax & _
          "', streetname = '" & strStreet & "', postcode='" & strPostCode & _
          "', state = '" & strState & "', role='" & strRole & _
          "', control_district ='" & strAccessDistrict & "' where userid =" & intUserID

  objConn.Execute (sqlSp)
 
  objConn.close
  objConn = Nothing

  strURL="../User.aspx"
%>

<html>
<head><title>.</title></head>
<body>
<form name="frmUpdateUser" method="post" action="<%=strURL%>">
</form>
</body></html>
<script language="javascript">
  document.frmUpdateUser.submit();
</script>