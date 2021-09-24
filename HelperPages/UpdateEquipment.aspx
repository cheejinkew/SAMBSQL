<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%

  dim objConn
  dim strConn
  dim sqlSp
  dim strError
  dim strErrorColor
  dim strURL
  
  dim intSiteID = request.form("ddSite")
  dim arryTmp = split(request.form("txtUnit"), " : ")
  dim arryTmp1 = split(request.form("txtSite"), " : ")
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
  dim intOldPosition = request.form("txtOldPosition")
  dim intMax = request.form("txtMax")

  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  
  try
    objConn.open (strConn)
 
  
        sqlSp = "update telemetry_equip_list_table set equiptype = '" & strEquipType & "' " _
            & ", multiplier='" & strMultiplier & "', sdesc ='" & strEquipDesc & "' " _
            & ", max=" & intMax & ", measurement='" & strMeasure & "' " _
            & ", position=" & intPosition & ", equipname='" & strEquipName & "' " & _
            " where siteid='" & intSiteID & "' and Iindex=" & intIndex & " " _
            & " and position =" & intOldPosition & " "

    objConn.Execute (sqlSp)
    Catch ex As Exception
    
        strError = ex.Message
        strErrorColor = "Red"

  end try
  
  objConn.close
  objConn = Nothing

  if strError ="" then
%>
    <form name="frmUpdateEquip" method="post" action="../Equipment.aspx">
      <input type="hidden" name="ddSite" value="<%=intSiteID%>">
    </form>

<%else
%>
<html>
<head><title>.</title></head>
<body>
   <form name="frmUpdateEquip" method="post" action="../UpdateEquipment.aspx">
     <input type="hidden" name="ddSite" value="<%=intSiteID%>">
     <input type="hidden" name="txtEquipID" value="<%=intIndex%>,<%=intOldPosition%>">
     <input type="hidden" name="txtError" value="<%=strError%>">
     <input type="hidden" name="txtErrorColor" value="<%=strErrorColor%>">
     <input type="hidden" name="txtWrongPosition" value="<%=intPosition%>">
   </form>
</body>
</html>
<%end if%>

<script language="javascript">
  document.frmUpdateEquip.submit();
</script>