<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<%
   dim objConn
    Dim sqlSp
    Dim sqlSp1
    Dim sqlSp2
   dim strConn
   dim arrySite
   dim i
   dim strSiteDistrict

   arrySite = split(Request.Form("chkDelete"), ",")
   strSiteDistrict = Request.Form("ddDistrict")
   
   strConn = ConfigurationSettings.AppSettings("DSNPG")
   objConn = new ADODB.Connection()
   objConn.open(strConn)

    For i = 0 To UBound(arrySite)
        sqlSp2 = "delete from res_outletpipe_table where siteid='" & LTrim(arrySite(i)) & "'"
        objConn.Execute(sqlSp2)
       
        sqlSp1 = "delete from res_dimension_table where siteid='" & LTrim(arrySite(i)) & "'"
        objConn.Execute(sqlSp1)
       
        sqlSp = "delete from reservoirinfo where siteid='" & LTrim(arrySite(i)) & "'"
        'and siteid not in (" & ddselect.selectedValue & ")"
        
       
        objConn.Execute(sqlSp)
        'If childdata.Value = Nothing Then
            
        '    sqlSp = "Delete from reservoirinfo where siteid='" & LTrim(arrySite(i)) & "'and siteid not in (" & ddselect.selectedValue & ")"
        '    objConn.Execute(sqlSp)
        'Else
        '    sqlSp = "Delete from res_dimension_table where siteid='" & LTrim(arrySite(i)) & "'"
        '    objConn.Execute(sqlSp)
        'End If
    Next

  objConn.close
  objConn = nothing
%>
<html>
<head><title>.</title></head>
<body>
<form name="frmDeleteSite" method="post" action="../reservoir.aspx">
  <input type="hidden" name="ddDistrict" value="<%=strSiteDistrict%>">
  <input type="hidden" runat="server" id="childdata" value="no" style="color: black"  />
</form>
</body></html>
<script language="javascript">
  document.frmDeleteSite.submit();
</script>