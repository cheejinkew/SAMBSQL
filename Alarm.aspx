<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlRs
   dim strConn
   dim intUserID
   dim intGetUserID
   dim strError
   dim strErrorColor
   dim strUsername
   dim strDisabled = "true"
   
   dim i
   dim strControlDistrict

   dim arryControlDistrict = split(request.cookies("Telemetry")("ControlDistrict"), ",")
   if arryControlDistrict.length() > 1 then
     for i = 0 to (arryControlDistrict.length() - 1)
       if i <> (arryControlDistrict.length() - 1)
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "', "
       else
         strControlDistrict = strControlDistrict & "'" & trim(arryControlDistrict(i)) & "'"
       end if
     next i
   else
     strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
   end if
   

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   
   intGetUserID = request.form("ddUser")
   if intGetUserID = "" then
    intGetUserID ="0"
   end if
   
   strError = request.form("txtError")
   strErrorColor = request.form("txtErrorColor")

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

<script language =javascript>
function loadleft()
{
 var obj=document.frmAlarm;
 obj.action="left.aspx";
 obj.target="contents";
 obj.submit();
}
</script>
</head>
<body >
<script language="JavaScript" src="JavaScriptFunctions.js"></script>
  <form name="frmAlarm" method="post" action="UpdateUnit.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/AlarmNotification.jpg">
            
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
            <th width="40%">DateTime</th>
            <th width="30%">Site</th>
            <th width="30%">Alarm Type</th>

            
          </tr>
      
          <%
             dim strDateTime
             dim strSite
             dim intSiteID
             dim strAlarm
             dim intNum = 0
               
             objConn.open(strConn)
             
             if arryControlDistrict(0) <> "ALL" then             
                  sqlRs.Open("select Top 1500 dtimestamp, siteid, sitename, alarmtype " & _
                          " from telemetry_alert_message_table " & _
                      " where siteid in (select siteid from telemetry_site_list_table " & _
                   "                   where sitedistrict in (" & strControlDistrict & ") and siteid NOT IN (" & strKontID & ")) " & _
                          " and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = 1) " & _
                          "  order by dtimestamp desc", objConn)
             else
                  sqlRs.Open("select Top 1500 dtimestamp, siteid, sitename, alarmtype " & _
                          " from telemetry_alert_message_table " & _
                          " where siteid NOT IN (" & strKontID & ") and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = 1) " & _
                          "  order by dtimestamp desc", objConn)
             end if
             
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
             do while not sqlRs.EOF
               
               strDateTime = sqlRs("dtimestamp").value
               intSiteID = strDateTime & "|" & sqlRs("siteid").value
               strSite = sqlRs("sitename").value
               strAlarm = sqlRs("alarmtype").value
               if intNum = 0 then
	         intNum = 1

           %>

	<tr bgcolor="#FFFFFF">
          <%
	       elseif intNum = 1 then
	         intNum = 0
	  %>
	<tr bgcolor="#E7E8F8">
	  <%
	       end if
          %>
          <td width="1%">
            <input type="checkbox" name="chkDelete" value="<%=intSiteID%>">
          </td>
          <td style="margin-left: 5"><%=strDateTime%></td>
          <td style="margin-left: 5"><%=strSite%></td>
          <td style="margin-left: 5"><%=strAlarm%></td>
         </tr>
         <%

               sqlRs.movenext
             Loop
                
             sqlRs.close()
             objConn.close()
             objConn = nothing
          %>

       <tr>
         <td colspan="6">
           <br>
           <br>
           <%if strDisabled ="false" then%>
           <a href="javascript:gotoDelete('frmAlarm','HelperPages/DeleteAlarmEvent.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtDateTime" value="">
  </form>
  <p align="center" style="margin-bottom: 15">
    <font size="1" face="Verdana" color="#5373A2">
       Copyright © 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
    </font>
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
    top.location.href = "login.aspx";
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