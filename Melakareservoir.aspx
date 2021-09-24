<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<!--#include file="../kont_id.aspx"-->
<%
   dim objConn
   dim sqlRs
   dim sqlRs1
   dim strConn
   dim intUserID
   dim intGetUserID
   dim strError
   dim strErrorColor
   dim strUsername
   dim strDisabled = "true"
    Dim strSelectedSiteDistrict = Request.Form("ddDistrict")
    If strSelectedSiteDistrict = "" Then
        strSelectedSiteDistrict = Request.QueryString("dist")
    End If
    
    


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
    sqlRs1 = New ADODB.Recordset()
   
    If strSelectedSiteDistrict = "" Then
        strSelectedSiteDistrict = "0"
    End If
   
    strError = Request.Form("txtError")
    strErrorColor = Request.Form("txtErrorColor")

%>

<html>
<head>
<style>

.bodytxt 
{
font-weight: normal;
          font-size: 12px;
          color: #333333;
          line-height: normal;
          font-family: Verdana, Arial, Helvetica, sans-serif;}
.FormDropdown 
{
      font-family: Verdana, Arial, Helvetica, sans-serif;
      font-size: 12px;
      color:#5F7AFC;
      width: 158px;
      border-width: 1px;
      border-style: solid;
      border-color: #CBD6E4;
}
a { text-decoration: none;}
</style>
<script language="javascript" src="JavaScriptFunctions.js"></script>

</head>
<body>
  <form name="frmSite" method="post" action="Updateresevoir.aspx">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" height="50" colspan="4">
            <p align="center"><img border="0" src="images/SiteMgmt.jpg"/></p>
            
          </td>
        </tr>
        <tr>
          <td width="9%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>District</b></font></td>
          <td width="2%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="33%" height="30">
            <font face="Verdana" size="1" color="#3952F9">
            <select name="ddDistrict" class="FormDropdown" onchange="goSubmit();" style="left: 216px; position: absolute; top: 72px" id="Select1">
            <option value="0" >- Select District -</option>
            <%
                Dim strSiteDistrict = "Melaka"
               
                'objConn.open(strConn)

                ' If arryControlDistrict(0) <> "ALL" Then
                    
                '     sqlRs.Open("SELECT distinct sitedistrict from telemetry_site_list_table " & _
                '                "where sitedistrict in (" & strControlDistrict & ")", objConn)
                    
                ' Else
                '     sqlRs.Open("SELECT distinct sitedistrict from telemetry_site_list_table", objConn)
                '     leg2.Visible = False
                ' End If
               
                'do while not sqlRs.EOF
                '     strSiteDistrict = sqlRs("sitedistrict").value
                    
            %>
            <option value="<%=strSiteDistrict%>"><%=strSiteDistrict%></option>
            <%

                '  sqlRs.movenext
                'Loop
                
                'sqlRs.close()
                'objConn.close()
                'objConn = nothing
               
            %>
            </select>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            </font>
          </td>
          <td width="50%" height="30"> <p align="right"><b><font size="1" face="Verdana" color="gray" ><a href="Melakareservoiradmin.aspx">Add New ReservoirInfo</a></font></b></p></td> 
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="70%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%">
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmSite')">
            </th>
            <th width="50%">Site</th>
            <th width="15%">Capacity</th>
            <th width="35%">Distribution Areas</th>
          </tr>
      
          <%
             dim intSiteID
        
             dim strSiteName
              Dim capacity
              Dim year
              Dim destribuation
             dim intNum = 0
             dim intAsscID
             dim strAsscSite
               
             objConn = new ADODB.Connection()  
             objConn.open(strConn)
              'sqlRs.Open("select siteid, unitid, sitename, sitetype, associate " & _
              '           " from telemetry_site_list_table " & _
              '           " where sitedistrict ='" & strSelectedSiteDistrict & "'" & _
              '           " order by sitetype, sitename", objConn)
              sqlRs.Open("select s.site_tele,s.siteid,s.sitename,r.capacity,r.year_built,r.destribution_area " & _
                       " from reservoirinfo r,telemetry_site_list_table s " & _
                       " where s.siteid IN ("& strKontID &") and s.siteid=r.siteid " & _
                       " order by  s.site_tele", objConn)
             
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
              Do While Not sqlRs.EOF
                  leg2.Visible = True
               
                  intSiteID = sqlRs("siteid").value
             
                  strSiteName = sqlRs("sitename").value
                  capacity = sqlRs("capacity").value
                  destribuation = sqlRs("destribution_area").value
                  'if intAsscID <> "None" then
                  '  sqlRs1.Open("select sitetype || ' : ' || sitename as sites " & _
                  '              "from telemetry_site_list_table where siteid ='" & _
                  '               intAsscID & "'", objConn)
                  '  if not sqlRs1.EOF then
                  '    strAsscSite = sqlRs1("sites").value
                  '  end if
                  '  sqlRs1.close() 
                  'else
                  '  strAsscSite = "None"
                  'end if
               
                  If intNum = 0 Then
                      intNum = 1

           %>

	<tr bgcolor="#FFFFFF">
          <%
	       elseif intNum = 1 then
              intNum = 0
           %>
    </tr>      
	<tr bgcolor="#E7E8F8">
	  <%
	       end if
          %>
          <td width="1%">
            <input type="checkbox" name="chkDelete" value="<%=intSiteID%>">
          </td>
          <%If sqlRs("site_tele").value = True Then%>
          <td style="margin-left: 5">
            <a href="javascript:gotoUpdate('frmSite', 'txtSiteID','<%=intSiteID%>');">
               <font face="Times New Roman" size="2" color="#oo33ff"  ><%=intSiteID%> : <%=strSiteName%>
            </a>
          </td>
          <%Else%>
          <td style="margin-left: 5" >
           <a href="javascript:gotoUpdate('frmSite', 'txtSiteID','<%=intSiteID%>');">
               <font face="Times New Roman" size="2" color="#ff0000"  > <%=intSiteID%> : <%=strSiteName%></font>
            </a>
          </td>     
          <%End If%>
          <td style="margin-left: 5" ><%=capacity%></td>
          <td style="margin-left: 5"><%=destribuation%></td>
          </tr>
    
         <%
               
               sqlRs.movenext
             Loop
                
             sqlRs.close()
             objConn.close()
             sqlRs = nothing
             objConn = nothing
          %>

       <tr>
         <td colspan="6">
           <br>
           <br>
           <%if strDisabled ="false" then%>
           <a href="javascript:gotoDelete('frmSite','HelperPages/deletereservoir.aspx');">
             <img border="0" src="Images/Delete.jpg" id="IMG1" onclick="return IMG1_onclick()">
           </a>
           <%end if%>
         </td>
       </tr>
     </table><br />
     </center>
     
     <input type="hidden" name="txtSiteID" value=""/>
     <font size="1" face="Verdana" color="#5373A2">
     <legend id="leg2" runat="server" >
       <font color="Red" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Red =Telemetry Uninstalled Site</font><br />
      <font color="blue" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      Blue =Telemetry Installed Site</font></legend><br /><br />
     <p align="center" style="margin-bottom: 15">
        Copyright © <%=now.ToString("yyyy") %> Gussmann Technologies Sdn Bhd. All rights reserved. </p>
         
     </font> 
    
</form>
</body>
</html>
<script language="javascript">
  var strDisabled ="<%=strDisabled%>";
  document.onkeypress = checkCR;
  document.frmSite.ddDistrict.value="<%=strSelectedSiteDistrict%>";
  
  if (strDisabled =="true")
  {
    document.frmSite.chkAllDelete.disabled = strDisabled;
  }
  else
  {
    document.frmSite.chkAllDelete.disabled = false;
  }

  function goSubmit()
  {
    document.frmSite.action="Melakareservoir.aspx";
    document.frmSite.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "Melakalogin.aspx";
  }

</script>