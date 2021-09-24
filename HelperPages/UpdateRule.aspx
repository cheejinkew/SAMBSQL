<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

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
  
  dim intRuleID = request.form("txtRuleID")
  dim intSiteID = request.form("txtSiteID")
  dim strSiteName = request.form("ddSite")
  dim strRuleIDSiteName = intRuleID & "," & strSiteName
  
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
    
    If strAlert = "TRUE" Then
        strAlert = "1"
    ElseIf strAlert = "FALSE" Then
        strAlert = "0"
    End If
    If strDispatch = "TRUE" Then
        strDispatch = "1"
    ElseIf strDispatch = "FALSE" Then
        strDispatch = "0"
    End If
    Try
        objConn.open(strConn)
 
        sqlSp = "update telemetry_rule_list_table set iIndex = 0, alarmtype='" & strAlarmType & _
                "', multiplier='" & strMultiplier & "', sequence=" & intSequence & _
                ", dispatch=" & strDispatch & ", alarmmode='" & strAlarmMode & "', colorcode='" & strColor & _
                "', alert=" & strAlert & " where ruleid = '" & intRuleID & "'"
    
        objConn.Execute(sqlSp)
    Catch
        
        strError = sqlSp
        strErrorColor = "Red"
    End Try
  
    objConn.close()
    objConn = Nothing

%>
<html>
<head><title>.</title></head>
<body>
<%  if strError ="" then %>

<form name="frmUpdateRule" method="post" action="../Rule.aspx">
   <input type="hidden" name="ddSite" value="<%=intSiteID%>">
   <input type="hidden" name="txtSiteName" value="<%=strSiteName%>">
</form>

<%else%>

<form name="frmUpdateRule" method="post" action="../UpdateRule.aspx">
  <input type="hidden"  name="txtError" value="<%=strError%>">
  <input type="hidden"  name="txtErrorColor" value="<%=strErrorColor%>">

  <input type="hidden"  name="txtRuleIDSiteName" value="<%=strRuleIDSiteName%>">
</form>

<%end if%>
</body>
</html>
<script language="javascript">
  document.frmUpdateRule.submit();
</script>


  