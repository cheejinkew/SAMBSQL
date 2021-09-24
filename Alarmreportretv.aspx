
<%@ Page Language="VB" Debug="true" %>
<!--#include file="kont_id.aspx"-->
<%@ Import Namespace="ADODB,System.Data.Odbc"%>

<%     
    Dim l1 As Integer = "0"
    Dim l2 As Integer = "0"
    Dim h1 As Integer = "0"
    Dim h2 As Integer = "0"
    Dim no As Integer = "0"
    Dim start_date = Request.QueryString("start")
    Dim end_date = Request.QueryString("end")
    Dim dist1 As String = Request.QueryString("dist")
    Dim i
    Dim dist
    Dim strconn = ConfigurationSettings.AppSettings("DSNPG")
    Dim sqlRs
    sqlRs = New ADODB.Recordset()
     
    Dim arryControlDistrict = Split(dist1, ",")
    If arryControlDistrict.length() > 1 Then
        For i = 0 To (arryControlDistrict.length() - 1)
            If i <> (arryControlDistrict.length() - 1) Then
                dist = dist & "'" & Trim(arryControlDistrict(i)) & "', "
            Else
                dist = dist & "'" & Trim(arryControlDistrict(i)) & "'"
            End If
        Next i
    Else
        dist = dist & "'" & arryControlDistrict(0) & "'"
    End If
    
    'Alor Gajah', 'Jasin'
   
  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Alarm Notification</title>
</head>
<body>

<table style="left: 25px; position: absolute; "><tr><td colspan="2" >
<table>
<tr ><td style="font-family: Verdana; font-size: 10pt; color:Blue; size:2; font-weight:bold"><b><%Response.Write(" &nbsp Date : " & start_date & " to " & end_date)%></b></td></tr></table>
</td></tr>
<tr valign=top >
<td >
<% 
    If Not dist = "" Then
        ' If Not dist = "0" Then%>   
            <%  Dim distr
              Dim strDateTime
              Dim strSite
              Dim intSiteID
              Dim strAlarm
              Dim intNum = 0
              Dim objConn = New ADODB.Connection()
              objConn.open(strconn)
                Dim t
                t = "select at1.dtimestamp, at1.siteid, at1.sitename, at1.alarmtype,st.sitedistrict  from telemetry_alert_message_table at1  left join telemetry_site_list_table st on at1.siteid=st.siteid where at1.alarmtype in (select alarmtype from telemetry_rule_list_table where alert = 1) and at1.dtimestamp >='" & start_date & "' and at1.dtimestamp <= '" & end_date & "' and st.sitedistrict in (" & dist & ") and at1.siteid NOT IN (" & strKontID & ") order by st.sitedistrict, at1.dtimestamp"
                sqlRs.Open(t, objConn)
                If sqlRs.EOF Then%>
               <table>
<tr ><td style="font-family: Verdana; font-size: 10pt; color:Blue; "><%Response.Write(" &nbsp  No Data To Be Displayed !")%>
</td></tr></table>
              <%  Else%>
                  <table border="0" style="font-family: Verdana; font-size: 8pt;">
          <tr style="background-color: #465AE8; color: #FFFFFF; top:0px"; valign=top >
           <th  >Timestamp</th>
            <th >District</th>
            <th >Site ID</th>
            <th >Site Name</th>
            <th >Alarm Type</th>
          </tr>     
                      <%Do While Not sqlRs.EOF
                          strDateTime = sqlRs("dtimestamp").value
                              distr = sqlRs("sitedistrict").value
                          intSiteID = sqlRs("siteid").value
                          strSite = sqlRs("sitename").value
                          strAlarm = sqlRs("alarmtype").value
                      
                          If strAlarm = "HH" Then
                              h2 = h2 + 1
                          ElseIf strAlarm = "H" Then
                              h1 = h1 + 1
                          ElseIf strAlarm = "LL" Then
                              l2 = l2 + 1
                          ElseIf strAlarm = "L" Then
                              l1 = l1 + 1
                          End If
                          If intNum = 0 Then
                              intNum = 1%>                  
                  <tr align="center" bgcolor="#FFFFFF">
          <%  ElseIf intNum = 1 Then
                  intNum = 0
	  %></tr>
	<tr align="center" bgcolor="#E7E8F8" valign=top >
	  <%End If%>          
          <td ><%=strDateTime%></td>
           <td ><%=distr%></td>
          <td ><%=intSiteID%></td>
          <td ><%=strSite%></td>
          <td ><%=strAlarm%></td>
         </tr>
         <%  no = no + 1
             sqlRs.movenext()
         Loop%>
          </table>   
         
</td>
<td align="right" valign=top >
            <table border="1" style=" border-color:Black;  font-family: Verdana; font-size: 10pt;">
            <tr align="center"><td style="width: 45px; background-color: #465AE8; color: #FFFFFF">HH</td><td style="width: 50px;"><%=h2%></td></tr>
            <tr align="center"><td style="width: 45px; background-color: #465AE8; color: #FFFFFF">H</td><td style="width: 50px;"><%=h1%></td></tr>
            <tr align="center"><td style="width: 45px; background-color: #465AE8; color: #FFFFFF">L</td><td style="width: 50px;"><%=l1%></td></tr>
            <tr align="center"><td style="width: 45px; background-color: #465AE8; color: #FFFFFF">LL</td><td style="width: 50px;"><%=l2%></td></tr>
            </table>            
</td>
</tr></table>
   <% 
   End If
   sqlRs.close()
   objConn.close()
             objConn = nothing%>
         <%-- <%Else
              Response.Write("Select the District")
          End If%> --%>
          <% Else
                    Response.Write("no dist is selected")
              End If
          %>
             
        </body>
</html>