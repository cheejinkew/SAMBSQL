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
  
  dim intSiteID = request.form("ddSite")
  dim strVersionUnit = request.form("ddUnit")
  dim arryTmp = split(strVersionUnit, " : ")
  dim arryTmp1 = split(request.form("txtSiteType"), " : ")
  dim strVersion = arryTmp(0)
  dim strUnit =  arryTmp(1)
  dim strSiteType = arryTmp1(1)
  dim strEquipType = request.form("ddType")


  dim strEquipDesc = request.form("ddDesc")
  dim strEquipName = request.form("txtName")
  dim strMultiplier = request.form("txtMult")
  dim strMeasure = request.form("txtMeasure")
  dim intIndex = request.form("txtIndex")
  dim intPosition = request.form("txtPosition")
  dim intMax = request.form("txtMax")

  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  Try
    objConn.open (strConn)
 

    sqlSp = "insert into telemetry_equip_list_table values( " & _
            "'" & intSiteID & "'," & intIndex & ", " & intPosition & ", 'None', '" & strSiteType & "', " & _
            "'None', '" & strVersion & "', '" & strUnit & "', '" & strEquipType & "', '" & strMultiplier & "', " & _
            "'" & strEquipName & "', '" & strEquipDesc & "', " & intMax & ", '" & strMeasure & "')"

    objConn.Execute (sqlSp)
  Catch
    strError = "Primary Key Duplication !"
    strErrorColor = "Red"
    
  End Try
  
  objConn.close
  objConn = Nothing

  if strError ="" then
%>
    <form name="frmAddEquip" method="post" action="../Equipment.aspx">
      <input type="hidden" name="ddSite" value="<%=intSiteID%>">
    </form>

<%else
%>
   <form name="frmAddEquip" method="post" action="../AddEquipment.aspx">
     <input type="hidden" name="ddSite" value="<%=intSiteID%>">
     <input type="hidden" name="ddUnit" value="<%=strVersionUnit%>">
     <input type="hidden" name="ddType" value="<%=strEquipType%>">
     <input type="hidden" name="ddDesc" value="<%=strEquipDesc%>">
     <input type="hidden" name="txtName" value="<%=strEquipName%>">
     <input type="hidden" name="txtMult" value="<%=strMultiplier%>">
     <input type="hidden" name="txtMeasure" value="<%=strMeasure%>">
     <input type="hidden" name="txtIndex" value="<%=intIndex%>">
     <input type="hidden" name="txtPosition" value="<%=intPosition%>">
     <input type="hidden" name="txtMax" value="<%=intMax%>">

     <input type="hidden" name="txtError" value="<%=strError%>">
     <input type="hidden" name="txtErrorColor" value="<%=strErrorColor%>">
   </form>
<%end if%>
</body></html>
<script language="javascript">
  document.frmAddEquip.submit();
</script>

