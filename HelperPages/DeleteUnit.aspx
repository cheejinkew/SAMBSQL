<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlSp
   dim strConn
   dim arryVehicle
   dim intUserID
   dim i
   dim intUnitID
   dim intEvenOdd
   dim intVersionID
   dim arryUnitID
   dim arryVersionID

   arryVehicle = split(Request.Form("chkDelete"), ",")
   intUserID = Request.Form("ddUser")

   for i = 0 to ubound(arryVehicle) step 2
     intUnitID = intUnitID & ", " & arryVehicle(i)
   next

   for i = 0 to ubound(arryVehicle)
     intEvenOdd = i mod 2
     if intEvenOdd <> 0 then
       intVersionID = intVersionID & ", " & arryVehicle(i)
     end if
   next

   arryUnitID = split(intUnitID, ",")
   arryVersionID = split(intVersionID, ",")

   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

   for i = 1 to ubound(arryUnitID)
     sqlSp = "Delete from unit_list where versionid='" & ltrim(arryVersionID(i)) & "' and unitid='" & ltrim(arryUnitID(i)) & "'"
     
     objConn.Execute (sqlSp)
   next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteUnit" method="post" action="../Unit.aspx">
  <input type="hidden" name="ddUser" value="<%=intUserID%>">
</form>
</body></html>
<script language="javascript">
  document.frmDeleteUnit.submit();
</script>