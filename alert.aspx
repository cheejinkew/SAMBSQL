<!--#include file="kont_id.aspx"-->
<%
    Dim time As String
    Dim time1 As String
   dim objConn 
   dim strConn 
   dim sqlRs 
   dim strSiteName
   dim strEvent
    Dim begindate = Request("begindate")
    Dim enddate = Request("enddate")
    Dim i
    Dim so
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
    
   objConn.open(strConn)

   if arryControlDistrict(0) <> "ALL" then     
        'sqlRs.Open("select final.siteid,final.sitename,final.sequence,final.alarmtype from (select result.siteid,t1.sitename,result.sequence,t1.alarmtype from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('LL','L','H','HH'))) final,telemetry_site_list_table as sitelist where final.siteid=sitelist.siteid and sitelist.sitedistrict in (" & strControlDistrict & ")", objConn)
        sqlRs.Open("select final.siteid,final.sitename,final.sequence,final.alarmtype from (select result.siteid,t1.sitename,result.sequence,t1.alarmtype from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('LL','L','H','HH'))) final,telemetry_site_list_table as sitelist where final.siteid=sitelist.siteid and final.sequence between '" & begindate & " ' and '" & enddate & " ' and sitelist.sitedistrict in (" & strControlDistrict & ") and sitelist.siteid NOT IN ("& strKontID &") order by sitename  ", objConn)
    Else
        'sqlRs.Open("select result.siteid,t1.sitename,result.sequence,t1.alarmtype from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('LL','L','H','HH'))", objConn)
        sqlRs.Open("select result.siteid,t1.sitename,result.sequence,t1.alarmtype from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN ("& strKontID &") and t1.sequence between '" & begindate & " ' and '" & enddate & " ' and t1.alarmtype in('LL','L','H','HH'))", objConn)
    End If
    strSiteName = ""
    While (Not sqlRs.EOF)
        strEvent = sqlRs("alarmtype").value
        time = sqlRs("sequence").value
        time1 = time.Format("{0:HH:mm:ss tt}", Date.Parse(time))
        strSiteName = strSiteName + sqlRs("sitename").value + " : " + strEvent + "<br/>" + " Time : " + time1 + "<br/>"
        sqlRs.MoveNext()
    End While
    If Session("sound") = "true" Then
        so = "ok"
    Else
        so = "no"
            
    End If
%>
<%  If so = "ok" Then%>
<embed id="1"src="images/notify.wav" autostart="true" hidden="true" loop="true" width="1" height="1" controls="console" >
</embed>
<% else %>
<embed id="Embed1"src="images/notify.wav" autostart="false" hidden="true" loop="true" width="1" height="1" controls="console" >
</embed>
<%End If%>

<div id="alert" class="divStyle">
   <u>P/S - ALERT :</u>
   <br /> 
    <%=strSiteName%> <%--; <%=strEvent%>--%>
  <br/>
  
</div>

<div id="AlertSound" >
<%  If so = "ok" Then%>
<input type=checkbox name="chk" id="chk" onclick="javascript:fun(this);" runat=server  />  <font face="Verdana" size="2" color="#3952F9"><b>Mute</b></font>

 
<% else %>
<input type=checkbox name="chk1" id="chk1" onclick="javascript:fun(this);" runat=server  checked="true"  /> <font face="Verdana" size="2" color="#3952F9"><b>Mute</b></font>


<% End If%>
 
   <!-- <a href="javascript: StopAlert();"><img src="images/StopAlert.jpg" style="border:0;"></a>-->
</div>
<%    
    sqlRs.Close()
   objConn.close()
   sqlRs = nothing
   objConn = nothing
%>