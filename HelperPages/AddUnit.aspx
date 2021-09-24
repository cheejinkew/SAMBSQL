<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<html>
<head><title>.</title></head>
<body>
<%
  dim objConn
  dim strConn
  dim sqlSp
  dim strError
  dim strErrorColor
  dim strURL
  
  dim intUID = request.form("ddUser")
  dim strVersionID = request.form("txtVersionID")
  dim strUnitID = request.form("txtUnitID")
  dim strPassword = request.form("txtPassword")
    Dim strSimNo = Request.Form("txtSIMNo")
    Dim strIMEI = Request.Form("txtIMEINo")
  dim strUnitddUser = request.form("txtUnitddUser")
  
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()

  Try
    objConn.open (strConn)
 
        sqlSp = "insert into unit_list values('" & strVersionID & "','" & strUnitID & _
                "','" & intUID & "','" & strPassword & "','" & strSimNo & "','" & strIMEI & "')"
        
        
        
    objConn.Execute (sqlSp)
  
  Catch
    strError = sqlSp
    strErrorColor = "Red"
    
  End Try
  
  objConn.close
  objConn = Nothing

  if strError ="" then
%>
  <form name="frmAddUnit" method="post" action="../Unit.aspx">
    <input type="hidden" value="<%=strUnitddUser%>" name="ddUser">
  </form>
<%else%>
  <form name="frmAddUnit" method="post" action="../AddUnit.aspx?user=<%=strUnitddUser%>">
    <input type="hidden" name="ddUser" value="<%=intUID%>">
    <input type="hidden" name="txtUnitID" value="<%=strUnitID%>">
    <input type="hidden" name="txtVersionID" value="<%=strVersionID%>">
    <input type="hidden" name="txtPassword" value="<%=strPassword%>" >
    <input type="hidden" name="txtSIMNo" value="<%=strSimNo%>">
     <input type="hidden" name="txtIMEINo" value="<%=strIMEI%>">
    <input type="hidden" name="txtError" value="<%=strError%>">
    <input type="hidden" name="txtErrorColor" value="<%=strErrorColor%>">
  </form>

<%end if%>
</body>
<script language="javascript">
  document.frmAddUnit.submit();
</script>
</html>