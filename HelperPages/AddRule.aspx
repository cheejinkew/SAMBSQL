<%@ Page Language="VB" Debug="true" %>
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
  dim strMultiplier

  dim strOperator = request.form("ddThreshold")
  dim intThreshold = request.form("txtThreshold")
  dim intMax = request.form("txtMax")
  dim intMin = request.form("txtMin")
  
  dim intSiteID = request.form("ddSite")
  dim strEquip = request.form("ddEquip")
  dim ArryEquip = split(strEquip, ",")
  dim strAlarmType = request.form("txtAType")
  dim strAlarmMode = request.form("ddAMode")
  dim strFormula =  request.form("optFormula")
  dim intSequence = request.form("txtSequence")
  dim strDispatch = request.form("ddDispatch")
  dim strAlert = request.form("ddAlert")
  dim strColor =  request.form("ddColor")
  
  if strFormula ="Threshold" then
    strMultiplier = "THRESHOLD;" & intThreshold & ";" & strOperator
  else if strFormula ="Range"
    strMultiplier = "RANGE;" & intMin & ";" & intMax
  end if


  dim strName = request.form("txtName")
  dim strPost = request.form("txtPost")
  dim strSIMNo = request.form("txtSIMno")
  dim intPriority = request.form("txtPriority")
  
  strConn = ConfigurationSettings.AppSettings("DSNPG")
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()
  
  Try
    objConn.open (strConn)
        If strAlert = "TRUE" Then
            strAlert = 1
        Else
            strAlert = 0
        End If
        
        If strDispatch = "TRUE" Then
            strDispatch = 1
        Else
            strDispatch = 0
        End If
       
        sqlSp = "insert into telemetry_rule_list_table(siteid,unitid,versionid,iIndex,position,alarmtype,multiplier,sequence,dispatch,alarmmode,colorcode,alert,ALERT_INTERVAL) values('" & intSiteID & "','" & ArryEquip(0) & _
            "', '" & ArryEquip(1) & "', 0 , " & ArryEquip(2) & ",'" & strAlarmType & _
            "', '" & strMultiplier & "'," & intSequence & _
            ", '" & strDispatch & "', '" & strAlarmMode & "','" & strColor & "', '" & strAlert & "','45')"
        
        
        
        'Response.Write(sqlSp)
        'Exit Sub
        objConn.Execute(sqlSp)
    Catch
        strError = "Insert Failed. Duplication posibility !"
        strErrorColor = "Red"
    End Try
  
  objConn.close
  objConn = Nothing

  if strError ="" then
%>


<form name="frmAddRule" method="post" action="../Rule.aspx">
   <input type="hidden" name="ddSite" value="<%=intSiteID%>">
</form>

<%else%>

<form name="frmAddRule" method="post" action="../AddRule.aspx">
  <input type="hidden"  name="txtError" value="<%=strError%>">
  <input type="hidden"  name="txtErrorColor" value="<%=strErrorColor%>">

  <input type="hidden"  name="ddSite" value="<%=intSiteID%>">
  <input type="hidden"  name="ddEquip" value="<%=strEquip%>">
  <input type="hidden"  name="ddColor" value="<%=strColor%>">
  <input type="hidden"  name="ddDispatch" value="<%=strDispatch%>">
  <input type="hidden"  name="ddAlert" value="<%=strAlert%>">
  <input type="hidden"  name="txtSequence" value="<%=intSequence%>">
  <input type="hidden"  name="optFormula" value="<%=strFormula%>">
  <input type="hidden"  name="ddThreshold" value="<%=strOperator%>">
  <input type="hidden"  name="txtThreshold" value="<%=intThreshold%>">
  <input type="hidden"  name="txtMax" value="<%=intMax%>">
  <input type="hidden"  name="txtMin" value="<%=intMin%>">
  <input type="hidden"  name="ddAMode" value="<%=strAlarmMode%>">
  <input type="hidden"  name="txtAType" value="<%=strAlarmType%>">
</form>

<%end if%>
</body></html>
<script language="javascript">
  document.frmAddRule.submit();
</script>


  