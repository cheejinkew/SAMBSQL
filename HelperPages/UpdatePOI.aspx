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
  
  dim intSiteID = request.form("txtSiteID")
  dim intUnitID = request.form("ddUnit")
  dim strSiteName = request.form("txtSiteName")
  dim strSiteDistrict = request.form("txtDistrict")
  dim strAsscID = request.form("ddAssociate")
  dim intLat = request.form("txtLat")
  dim intLon = request.form("txtLon")
  dim strComment = request.form("txtComment")
  dim strAddress = request.form("txtAddress")
  if strComment ="" then
    strComment = "None"
  end if

 
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  objConn.open (strConn)
 
    sqlSp = "update telemetry_site_list_table set lat = " & intLat & ", lon=" & intLon & _
          " where siteid ='" & intSiteID & "'"

  objConn.Execute (sqlSp)

  objConn.close
  objConn = Nothing

    strURL = "../poi.aspx"
%>

<html>
<head><title>.</title></head>
<body>
<form name="frmUpdateSite" method="post" action="<%=strURL%>">
  <input type="hidden" name="ddDistrict" value="<%=strSiteDistrict%>">
</form>
</body></html>
<script language="javascript">
  document.frmUpdateSite.submit();
</script>