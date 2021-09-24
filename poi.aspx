<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<!--#include file="kont_id.aspx"-->

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

   strConn = ConfigurationSettings.AppSettings("DSNPG") 
   objConn = new ADODB.Connection()
   sqlRs = new ADODB.Recordset()
    Dim intUID = Request.Cookies("Telemetry")("UserID")
   
  
   
  

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
<script language="javascript" src="JavaScriptFunctions.js"></script>


<body>
  <form name="frmpoi" method="post" action="delpoi.aspx">
    <div align="center"><table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
          <td width="100%" colspan="4">
            <p align="center"><br><img border="0" src="images/POIMgmt.jpg">
            <div align="center" id="Error">
              <font color="red" size="2" face="Verdana">
                <b>&nbsp;<%=strError%></b>
              </font>
            </div>
            
          </td>
        </tr>
        <tr>
          <td width="9%" height="30">
           </td>

          <td width="50%" height="30">
            <p align="right"><b><font size="1" face="Verdana"></font></b></td>
        </tr>
      </table>
    </div>
    <center>
        <table border="0" width="70%" style="font-family: Verdana; font-size: 8pt">
          <tr style="background-color: #465AE8; color: #FFFFFF">
            <th width="1%" >
              <input type="checkbox" name="chkAllDelete" onclick="javascript:gotoCheckAll('frmpoi')">
            </th>
            
            <th width="40%" >Site Name</th>
            <th width="30%" >LAT</th>
            <th width="30%" >LON</th>
          </tr>
      
          <%
             dim lat
             dim lon
             dim name
             dim intUnitID
              Dim intSID
             dim intNum = 0
               
             objConn = new ADODB.Connection()
             objConn.open(strConn)
              sqlRs.Open("select lat,lon,sitename,siteid from telemetry_site_list_table where siteid NOT IN ("& strKontID &") ", objConn)
                        
                        
             
             if not sqlRs.EOF then
               strDisabled ="false"
             else
               strDisabled ="true"
             end if
             
             do while not sqlRs.EOF
               
               lat = sqlRs("lat").value
              lon = sqlRs("lon").value
                  name = sqlRs("sitename").value
                  intSID = sqlRs("siteid").value
              
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
            <input type="checkbox" name="chkDelete" value="<%=intSID%>">
          </td>
<td style="margin-left: 5"><a href="javascript:gotoUpdate('<%=intSID%>');"><%=name%> </a></td>

          <td style="margin-left: 5"><%=lat%></td>
          <td style="margin-left: 5"><%=lon%></td>
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
           <a href="javascript:gotoDelete('frmpoi','HelperPages/DeleteSite.aspx');">
             <img border="0" src="Images/Delete.jpg">
           </a>
           <%end if%>
         </td>
       </tr>
      
     </table>
     <input type="hidden" name="txtVehicleID" value="">
         <input type="hidden" name="txtUserID" value="">

  </form>
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


  function goSubmit()
  {
    document.forms(0).action="poi.aspx";
    document.forms(0).submit();
  }
  function gotoUpdate(strID)
{
  document.frmpoi.action="UpdatePOI.aspx?SiteID="+strID;
   //eval("document." + strForm + "." + strField + ".value=strID");
  eval("document.frmpoi.submit()");
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

</script>
