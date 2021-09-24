<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
   dim sqlRs
   dim strConn
   dim strDistrict
   dim strSelectedDistrict
   dim strType
   dim strSelectedType
   dim strSiteName
   dim intSiteID
   dim intUnitID
   dim intNum

   strSelectedDistrict = request.form("ddDistrict")
   strSelectedType = request.form("ddType")
   
   if strSelectedDistrict ="" then
     strSelectedDistrict= "0"
   end if
   
   if strSelectedType ="" then
     strSelectedType= "0"
   end if
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
   
%>


<html>
<head>
<style>
.bodytxt 
  {
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  }
  
  
.FormDropdown 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 158px;
  border: 1 solid #CBD6E4;
  }
  
a { text-decoration: none;}
</style>
</head>
<body topmargin=5 leftmargin=5>
  <form name="frmSite" method="post" action="UpdateVehicle.aspx">
    <input type="hidden" name="txtUserID" value="">
    <div align="center">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td width="100%" height="60" colspan="3">
            <p align="center"><img border="0" src="images/SiteSelection.jpg" align="left">
            
          </td>
        </tr>
        <tr>
          <td width="15%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>District</b></font></td>
          <td width="10%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="75%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddDistrict" class="FormDropdown" onchange="goSubmit(1);">
            <option value="0" > - Select Site District -</option>
            
            <%
               objConn = new ADODB.Connection()
               objConn.open(strConn)

               sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table",objConn)
               do while not sqlRs.EOF
                 strDistrict = sqlRs("sitedistrict").value
            %>
            <option value="<%=strDistrict%>"><%=strDistrict%></option>
            <%

                 sqlRs.movenext
               Loop
                
               sqlRs.close()
               objConn.close()
               objConn = nothing
               
            %>
               
            </select>
            
            
           </font></td>

        </tr>
        <tr>
          <td width="15%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>Type</b></font></td>
          <td width="10%" height="30">
            <font face="Verdana" size="2" color="#3952F9"><b>:</b></font></td>
          <td width="75%" height="30">
            <font face="Verdana" size="2" color="#3952F9">
            <select name="ddType" class="FormDropdown" onchange="goSubmit(2);">
            <option value="0" > - Select Site Type -</option>
            
            <%
            
               objConn = new ADODB.Connection()
               objConn.open(strConn)

               sqlRs.Open("SELECT distinct(sitetype) from telemetry_site_list_table where sitedistrict='" & _
                          strSelectedDistrict & "'",objConn)
               do while not sqlRs.EOF
                 strType = sqlRs("sitetype").value
            %>
            <option value="<%=strType%>"><%=strType%></option>
            <%

                 sqlRs.movenext
               Loop
                
               sqlRs.close()
               objConn.close()
               objConn = nothing
               
            %>
            
            </select>
            
            
           </font></td>

        </tr>
        <tr>
          <td width="15%" height="30">
          </td>
          <td width="10%" height="30">
          </td>
          <td width="75%" height="30">
          </td>

        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="100%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="56%">Site Name</th>
            <th width="22%">Site ID</th>
            <th width="22%">Unit ID</th>
            
          </tr>
      
            <%
               objConn = new ADODB.Connection()
               objConn.open(strConn)

               sqlRs.Open("SELECT sitename, siteid, unitid from telemetry_site_list_table where sitedistrict='" & _
                          strSelectedDistrict & "' and sitetype='" & strSelectedType & "' order by sitename",objConn)
               
               do while not sqlRs.EOF
                 strSiteName = sqlRs("sitename").value
                 intSiteID = sqlRs("siteid").value
                 intUnitID = sqlRs("unitid").value
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
            <td style="margin-left: 5"><b><a href="Summary.aspx?siteid=<%=intSiteID%>&sitename=<%=strSiteName%>&district=<%=strSelectedDistrict%>" target="main"><%=strSiteName%></a></b></td>
            <td style="margin-left: 5"><%=intSiteID%></td>
            <td style="margin-left: 5"><%=intUnitID%></td>
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
         <td colspan="3">
           <br>
           <br>
           
         </td>
       </tr>
     </table>
  </form>
</body>
<div align="left" left=0>
        <iframe ID="alert" SRC="alert.aspx"  style="width: 220; height: 100" allowautotransparency="true" frameborder=0 scrolling="no">
        </iframe>
</div>



</html>
<script language="javascript">
  document.frmSite.ddDistrict.value='<%=strSelectedDistrict%>';
  document.frmSite.ddType.value='<%=strSelectedType%>';
  
  function goSubmit(fldValue)
  {
    if (fldValue ==  1)
    {
    document.frmSite.ddType.value="0";
    }
    document.frmSite.action="left.aspx";
    document.frmSite.submit();
  }

  var strSession = '<%=session("login")%>';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }

</script>