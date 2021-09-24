<%@ Page Language="VB" Debug="true" %>
<!--#include file="../kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>
<%
    Dim objConn
    Dim sqlRs
    Dim strConn
    Dim intUserID
    Dim intGetUserID
    Dim strError
    Dim strErrorColor
    Dim strUsername
    Dim strDisabled = "true"
   
    Dim i
    Dim strControlDistrict

    Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1) Then
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
            Else
                strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
    End If
   

    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
   
    intGetUserID = Request.Form("ddUser")
    If intGetUserID = "" Then
        intGetUserID = "0"
    End If
   
    strError = Request.Form("txtError")
    strErrorColor = Request.Form("txtErrorColor")

%>
<html>
<head>
    <style>
.bodytxt {font-weight: normal;
          font-size: 11px;
          color: #333333;
          line-height: normal;
          font-family: Verdana, Arial, Helvetica, sans-serif;}
.FormDropdown 
{
      font-family: Verdana, Arial, Helvetica, sans-serif;
      font-size: 12px;
      color:#5F7AFC;
      width: 158px;
      border: 1 solid #CBD6E4;
}
</style>
</head>
<body>

    <script language="JavaScript" src="JavaScriptFunctions.js"></script>

    <form name="frmAlarm" method="post" action="MelakaUpdateUnit.aspx">
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="70%">
                <tr>
                    <td width="100%" height="50" colspan="4">
                        <p align="center">
                            <img border="0" src="images/AlarmNotification.jpg">
                    </td>
                </tr>
            </table>
        </div>
        <center>
            <table border="0" width="80%" style="font-family: Verdana; font-size: 8pt">
                <tr style="background-color: #465AE8; color: #FFFFFF">
                    <th width="1%">
                        <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmAlarm')">
                    </th>
                    <th width="40%">
                        DateTime</th>
                    <th width="30%">
                        Site</th>
                    <th width="30%">
                        Alarm Type</th>
                </tr>
                <%
                    Dim strDateTime
                    Dim strSite
                    Dim intSiteID
                    Dim strAlarm
                    Dim intNum = 0
               
                    objConn.open(strConn)
             
                    'if arryControlDistrict(0) <> "ALL" then             
                    sqlRs.Open("select sequence, siteid, sitename, alarmtype " & _
                               " from telemetry_alert_message_table " & _
                           " where IN ("& strKontID &") " & _
                               " and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _
                               "  order by sequence desc", objConn)
                    'else
                    ' sqlRs.Open("select sequence, siteid, sitename, alarmtype " & _
                    '            " from telemetry_alert_message_table " & _
                    '            " where alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _
                    '            "  order by sequence desc", objConn)
                    'end if
             
             
                    If Not sqlRs.EOF Then
                        strDisabled = "false"
                    Else
                        strDisabled = "true"
                    End If
             
                    Do While Not sqlRs.EOF
               
                        strDateTime = sqlRs("sequence").value
                        intSiteID = strDateTime & "|" & sqlRs("siteid").value
                        strSite = sqlRs("sitename").value
                        strAlarm = sqlRs("alarmtype").value
                        If intNum = 0 Then
                            intNum = 1

                %>
                <tr bgcolor="#FFFFFF">
                    <%
                    ElseIf intNum = 1 Then
                        intNum = 0
                    %>
                    <tr bgcolor="#E7E8F8">
                        <%
                        End If
                        %>
                        <td width="1%">
                            <input type="checkbox" name="chkDelete" value="<%=intSiteID%>">
                        </td>
                        <td style="margin-left: 5">
                            <%=strDateTime%>
                        </td>
                        <td style="margin-left: 5">
                            <%=strSite%>
                        </td>
                        <td style="margin-left: 5">
                            <%=strAlarm%>
                        </td>
                    </tr>
                    <%
                        sqlRs.movenext()
                    Loop
                
                    sqlRs.close()
                    objConn.close()
                    objConn = Nothing
                    %>
                    <tr>
                        <td colspan="6">
                            <br>
                            <br>
                            <%If strDisabled = "false" Then%>
                            <a href="javascript:gotoDelete('frmAlarm','HelperPages/DeleteAlarmEvent.aspx');">
                                <img border="0" src="Images/Delete.jpg">
                            </a>
                            <%End If%>
                        </td>
                    </tr>
            </table>
            <input type="hidden" name="txtDateTime" value="">
    </form>
    <p align="center" style="margin-bottom: 15">
        <font size="1" face="Verdana" color="#5373A2">Copyright © <%=Now.ToString("yyyy")%> Gussmann Technologies
            Sdn Bhd. All rights reserved. </font>
    </p>
</body>
</html>

<script language="javascript">
  
  var strDisabled ="<%=strDisabled%>";
  document.onkeypress = checkCR;
  
  if (strDisabled =="true")
  {
    document.forms(0).chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.forms(0).chkAllDelete.disabled = false;
  }


  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }


function checkCR(evt)
{

  var evt  = (evt) ? evt : ((event) ? event : null);
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
  //keyCode 13 is return key, keyCode 39 is single quote key
  if ((evt.keyCode == 13) && (node.type=="text")) {return false;}
  if ((evt.keyCode == 39) && (node.type=="text")) {alert("Single Quote is not allowed."); return false;}
 
 }


function getDelLenght(strForm)
{
  var strTolDel = 0;

  if (eval("document." + strForm + ".chkDelete && document." + strForm + ".chkDelete[0]"))
  {
    strTolDel = eval("document." + strForm + ".chkDelete.length");
  }
  else if (eval("document." + strForm + ".chkDelete"))
  {
    strTolDel = 1;
  }
  else
  {
    eval("document." + strForm + ".chkAllDelete.disabled=true");
  }
  return strTolDel;
}


function gotoCheckAll(strForm)
{
  var strTolDel = getDelLenght(strForm);
 
  if (strTolDel > 1)
  {
    if (eval("document." + strForm + ".chkAllDelete.checked"))
    {
      for(var intI = 0; intI < strTolDel; intI++)
      {
       eval("document." + strForm + ".chkDelete[intI].checked=true");
      }
    }
    else
    {
      for(var intI = 0; intI < strTolDel; intI++)
      {
       eval("document." + strForm + ".chkDelete[intI].checked=false");
      }
    }
  }
  else
  {
    if (eval("document." + strForm + ".chkAllDelete.checked"))
    {
    eval("document." + strForm + ".chkDelete.checked=true");
    }
    else
    {
    eval("document." + strForm + ".chkDelete.checked=false");
    }
  }
}

function gotoDelete(strForm, strURL)
{
  var blnSubmit = true;
  var strCheckDel=0;
  var strTolDel = getDelLenght(strForm);
  
  if(strTolDel > 1)
  {

    for(var intI = 0; intI < strTolDel; intI++)
    {
      if (eval("document." + strForm + ".chkDelete[intI].checked"))
      {
        strCheckDel=strCheckDel+ 1
      }
    }

    if (strCheckDel == 0)
    {
      alert ("No item to be deleted !");
      blnSubmit = false;
    }
  }
  else if (strTolDel == 1)
  {
     if(eval("!document." + strForm + ".chkDelete.checked"))
     {
      alert ("No item to be deleted !");
      blnSubmit = false;
     }
  }
  else
  {
    alert ("No item to be deleted !");
    blnSubmit = false;

  }
  if (blnSubmit)
  {
    eval("document." + strForm + ".action=strURL");
    eval("document." + strForm + ".submit()");
  }
}



</script>

