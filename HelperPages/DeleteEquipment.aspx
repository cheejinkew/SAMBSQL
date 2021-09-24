<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlSp
   dim strConn
   dim arryTmp
   dim arryEquip
   dim i
   dim intSiteID

   arryTmp = split(Request.Form("chkDelete"), ",")
   intSiteID = Request.Form("ddSite")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

   for i = 0 to ubound(arryTmp)
     arryEquip = split(arryTmp(i), "|")
        sqlSp = "Delete from telemetry_equip_list_table where Iindex='" & LTrim(arryEquip(0)) & _
             "' and position='" & LTrim(arryEquip(1)) & "' and siteid='" & intSiteID & "'"
     objConn.Execute (sqlSp)
   next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteEquip" method="post" action="../Equipment.aspx">
  <input type="hidden" name="ddSite" value="<%=intSiteID%>">
</form>
</body></html>
<script language="javascript">
  document.frmDeleteEquip.submit();
</script>
