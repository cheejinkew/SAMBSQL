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
  
  dim intUnitID = request.form("ddUnit")
  dim strSiteDistrict = request.form("ddDistrict")
  dim intSiteID = request.form("txtSiteID")
  dim strSiteType = request.form("txtSiteType")
  dim strSiteName = request.form("txtSiteName")
  dim intAsscID = request.form("ddAssociate")
  dim intLat = request.form("txtLat")
  dim intLon = request.form("txtLon")
  dim strComment = request.form("txtComment")
  if strComment ="" then
    strComment = "None"
  end if
  
  dim strAddress = request.form("txtAddress")
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  objConn.open (strConn)
 
    sqlSp = "insert into telemetry_site_list_table (siteid, unitid, sitename, sitetype, sitedistrict, associate, lat, lon, comment, address) values('" & intSiteID & "', '" & intUnitID & "', '" & strSiteName & "', '" & strSiteType & "', '" & strSiteDistrict & "', '" & intAsscID & "','" & intLat & "',' " & intLon & "','" & strComment & "','" & strAddress & "')"

  objConn.Execute (sqlSp)
  strError = "Site :" & strSiteName & " is added successfully !"
  strErrorColor = "Green"
  
  objConn.close
  objConn = Nothing

  strURL="../Site.aspx"
%>


<form name="frmAddSite" method="post" action="<%=strURL%>">
  <input type="hidden" value="<%=strSiteDistrict%>" name="ddDistrict">
</form>
</body>
<script language="javascript">
  document.frmAddSite.submit();
</script>
</html>