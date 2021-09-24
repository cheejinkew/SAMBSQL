<%@ Page Language="VB" Debug="true" %>
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


</head>
<body>
<script language="JavaScript" src="JavaScriptFunctions.js"></script>
  <form name="frmAlarm" method="post" action="UpdateUnit.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" height="50" colspan="4">            
            
          </td>
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="80%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
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
               sqlRs.Open("select sequence, siteid, sitename, alarmtype " & _
                          " from telemetry_alert_message_table " & _
   	                  " where siteid in (select siteid from telemetry_site_list_table " & _ 
	                  "                   where sitedistrict in (" & strControlDistrict & ")) " & _
                          " and alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                          "  order by sequence desc limit 20", objConn)
             else
               sqlRs.Open("select sequence, siteid, sitename, alarmtype " & _
                          " from telemetry_alert_message_table " & _
                          " where alarmtype in (select alarmtype from telemetry_rule_list_table where alert = true) " & _       
                          "  order by sequence desc limit 20", objConn)
             end if
             
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
             do while not sqlRs.EOF
               
               strDateTime = sqlRs("sequence").value
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
           <%if strDisabled ="false" then%>

           <%end if%>
         </td>
       </tr>
     </table>
     <input type="hidden" name="txtDateTime" value="">
  </form>
</body>
</html>