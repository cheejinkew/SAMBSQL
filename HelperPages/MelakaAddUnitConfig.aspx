<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<script runat="server">
  
  Function getValue (strThreshold as String) as string
    dim intPos, intNum
    
    intPos=InStr(strThreshold,".")

    if intPos = 0 then
      if len(strThreshold) = 1 then
        intNum = "0" & strThreshold & "0"
      elseif len(strThreshold) = 2 then
        intNum = strThreshold & "0"
      elseif len(strThreshold) = 3 then
        intNum = 100
      end if
    elseif intPos = 2 then
      intNum = "0" & replace(Mid(strThreshold, 1, 3), ".", "")
    elseif intPos = 3 then
      intNum = replace(Mid(strThreshold, 1, 4), ".", "")
    end if
    
    return intNum
  End function
</script>

<%
  dim objConn
  dim strConn
  dim sqlSp
  dim sqlRs
  dim strError
  dim strErrorColor
  
'  dim intUID = request.cookies("VehicleTracking")("UserID")
  dim strPassword = request.form("txtPassword")
  dim strURL
  dim strTemp = request.form("ddSite")
  dim arryTemp = split(strTemp, ",")
  
  dim intSiteID = arryTemp(0)
  dim intVersionID = arryTemp(1)
  dim strSimNo = arryTemp(2)
  dim strDBPwd = arryTemp(3)
  dim intUnitID = arryTemp(4)
  
  dim arryCheck(10) as string
  dim i
  dim j
  dim strSMS =""
  dim strSMS1 =""
  dim strSMS2 =""
  dim strSMS3 =""

  dim strMode = request.form("ddMode")
  dim strCenterNo = request.form("txtCenterNo")
  dim strNewPass = request.form("txtNewPass")
  dim strDate = request.form("txtDateTime")
  dim strHr = request.form("txtHr")
  dim strMin = request.form("txtMin")
  dim strSec = request.form("txtSec")
  dim strTime = strHr & ":" & strMin & ":" & strSec
  dim strHH = request.form("txtHH")
  dim strH = request.form("txtH")
  dim strL = request.form("txtL")
  dim strLL = request.form("txtLL")

  dim strLog = request.form("ddLog")
  dim intMax
  dim intThreshold
  dim intFinalNum
  dim strDTNow as DateTime
  
  strDTNow = DateTime.Now

  if strDate <> "" then
    strDate = String.Format("{0:yy/MM/dd}", Date.Parse(strDate))
  end if
  
  if strHr <> "" then
    strTime = String.Format("{0:HH:mm:ss}", Date.Parse(strTime))
  end if
  
  arryCheck(0) = request.form("chkCenterNo")
  arryCheck(1) = request.form("chkNewPass")
  arryCheck(2) = request.form("chkDateTime")
  arryCheck(3) = request.form("chkHH")
  arryCheck(4) = request.form("chkH")
  arryCheck(5) = request.form("chkL")
  arryCheck(6) = request.form("chkLL")
  arryCheck(7) = request.form("chkLog12am")
  arryCheck(8) = request.form("chkLog8am")
  arryCheck(9) = request.form("chkLog345pm")

  strConn = ConfigurationSettings.AppSettings("DSNPG")  
  objConn = new ADODB.Connection()
  sqlRs = new ADODB.Recordset()

  objConn.open (strConn)
 
  sqlRs.open ("select max from telemetry_equip_list_table where siteid='" & intSiteID & _
              "' and unitid='" & intUnitID & "' and position=2", strConn)
  if not sqlRs.EOF then
     intMax = sqlRs("max").value
  end if

  
    for i = 0 to 9
      if arryCheck(i) = "ON"
        select case i
          case 0 'Center No
            strSMS = "(P" & strDBPwd & ";01" & strCenterNo & ")"

          case 1 'New Password
            strSMS = "(P" & strDBPwd & ";02" & strNewPass & ")"

          case 2 'Date Time
            strSMS = "(S" & strDBPwd & ";20" & strDate & strTime & ")"

          case 3 'Threshold HH
            if intMax <> 0 then
              intThreshold = (strHH * 8) + 20
              intFinalNum = getValue(CStr(intThreshold))
            else
              intFinalNum = "000"
            end if
            strSMS = "(S" & strDBPwd & ";21" & intFinalNum & ")"

          case 4 'Threshold H
            if intMax <> 0 then
              intThreshold = (strH * 8) + 20
              intFinalNum = getValue(CStr(intThreshold))
            else
              intFinalNum = "000"
            end if
            strSMS = "(S" & strDBPwd & ";22" & intFinalNum & ")"
  
          case 5 'Threshold L
            if intMax <> 0 then
              intThreshold = (strL * 8) + 20
              intFinalNum = getValue(CStr(intThreshold))
            else
              intFinalNum = "000"
            end if
            strSMS = "(S" & strDBPwd & ";23" & intFinalNum & ")"

          case 6 'Threshold LL
            if intMax <> 0 then
              intThreshold = (strLL * 8) + 20
              intFinalNum = getValue(CStr(intThreshold))
            else
              intFinalNum = "000"
            end if
            strSMS = "(S" & strDBPwd & ";24" & intFinalNum & ")"

          case 7 
            if strLog = "Today" then
              strSMS = "(C" & strDBPwd & ";22)"
            else if strLog = "Yesterday" then
              strSMS = "(C" & strDBPwd & ";25)"
            else if strLog = "Both" then
              strSMS = "(C" & strDBPwd & ";22)"
              strSMS1 = "(C" & strDBPwd & ";25)"
            end if
            
          case 8 
            if strLog = "Today"  then
              strSMS = "(C" & strDBPwd & ";23)"
            else if strLog = "Yesterday" then
              strSMS = "(C" & strDBPwd & ";26)"
            else if strLog = "Both" then
              strSMS = "(C" & strDBPwd & ";23)"
              strSMS2 = "(C" & strDBPwd & ";26)"
            end if
         
          case 9 
            if strLog = "Today" then
              strSMS = "(C" & strDBPwd & ";24)"
            else if strLog = "Yesterday" then
              strSMS = "(C" & strDBPwd & ";27)"
            else if strLog = "Both" then
              strSMS = "(C" & strDBPwd & ";24)"
              strSMS3 = "(C" & strDBPwd & ";27)"
            end if
            
        end select

        'response.write(strSMS & "<br>")
        
        sqlSp = "insert into sms_outbox_table values('" & strSimNo & "','" & strDTNow & "','" & _
                 strDTNow.AddDays(1) & "',2,'" & strSMS & "', 'None', 'False', '" & strDTNow & "')"
        'response.write(sqlSp & "<br>")
        objConn.Execute (sqlSp)

      end if
    next i  
    
'**************************************************************************************************
'Insert yesterday data if the log data are for both days.
'**************************************************************************************************

    if arryCheck(7) = "ON" and strLog = "Both" and strSMS1 <> "" then
       sqlSp = "insert into sms_outbox_table values('" & strSimNo & "','" & strDTNow & "','" & _
                strDTNow.AddDays(1) & "',2,'" & strSMS1 & "', 'None', 'False', '" & strDTNow & "')"
                
       'response.write("2: " & sqlSp & "<br>")
       objConn.Execute (sqlSp)
    end if
    
    if arryCheck(8) = "ON" and strLog = "Both" and strSMS2 <> "" then
       sqlSp = "insert into sms_outbox_table values('" & strSimNo & "','" & strDTNow & "','" & _
                strDTNow.AddDays(1) & "',2,'" & strSMS2 & "', 'None', 'False', '" & strDTNow & "')"
       'response.write("3: " & sqlSp & "<br>")
       objConn.Execute (sqlSp)
    end if   
    
    if arryCheck(9) = "ON" and strLog = "Both" and strSMS3 <> "" then
       sqlSp = "insert into sms_outbox_table values('" & strSimNo & "','" & strDTNow & "','" & _
                strDTNow.AddDays(1) & "',2,'" & strSMS3 & "', 'None', 'False', '" & strDTNow & "')"
                
       'response.write("4: " & sqlSp & "<br>")
       objConn.Execute (sqlSp)
    end if
    
  strError = "Unit has been successfully configurated !"
  strErrorColor = "Green"
  objConn.close
  objConn = Nothing

  strURL="../UnitConfig.aspx"
  
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmUnitConfigure" method="post" action="<%=strURL%>">
  <input type="hidden" value="<%=strError%>" name="txtError">
  <input type="hidden" value="<%=strErrorColor%>" name="txtErrorColor">
  <input type="hidden" value="<%=strTemp%>" name="ddSite">
</form>
</body>
</html>
<script language="javascript">
  document.frmUnitConfigure.submit();
</script>
