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
    'Dim Installedsite = Request.Form("rd1")
    'Dim Uninstalledsite = Request.Form("rd2")
  dim intUnitID = request.form("ddUnit")
  dim strSiteDistrict = request.form("ddDistrict")
  dim intSiteID = request.form("txtSiteID")
  dim strSiteType = request.form("txtSiteType")
  dim strSiteName = request.form("txtSiteName")
  dim intAsscID = request.form("ddAssociate")
  dim intLat = request.form("txtLat")
  dim intLon = request.form("txtLon")
    Dim strComment = Request.Form("txtComment")
    Dim type = Request.Form("txttype")
    Dim type1
    If type = "true" Then
        type1 = True
    Else
        type1 = False
    End If
  if strComment ="" then
    strComment = "None"
  end if
  
  dim strAddress = request.form("txtAddress")
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

    objConn.open(strConn)
    'If rd2.checked Then
        
    'End If
 
    sqlSp = "insert into telemetry_site_list_table (siteid, unitid, sitename, sitetype, sitedistrict, " & _
            " associate, lat, lon, comment, address,site_tele) values ('" & intSiteID & "','" & intUnitID & "'" & _
            ", '" & strSiteName & "','" & strSiteType & "','" & strSiteDistrict & "','" & intAsscID & "'" & _
            ", " & intLat & ", " & intLon & ",'" & strComment & "','" & strAddress & "'," & type1 & ")"

    objConn.Execute(sqlSp)
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