<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="ADODB" %>
<%
    Dim strDistrict = Request("strSelectedDistrict")
    Dim Type = Request("strSelectedType")
    Dim url1 = ""
    Dim high = 100
    
    If Type = "RESERVOIR" Then
        url1 = "SiteSummary.aspx"
        high = 800
    End If
    
    If Type = "DAM" Then
        url1 = "SiteSummary.aspx"
        high = 150
    End If
    
    If Type = "WTP" Then
        url1 = "SiteSummarywtp.aspx"
        high = 250
    End If
%>
<html>
<head>
</head>
<body>
    <form name="frmSite" method="post">
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <div style="margin-right: 0px; overflow: auto; overflow-x: hidden;">
                            <iframe id="map" src="displayMap.aspx?strSelectedDistrict=<%=strDistrict%>&strSelectedType=<%=type%>"  width="700" height="520" marginheight="0" marginwidth="0"
                                scrolling="auto" style="left: 0;" frameborder="0"></iframe>
                        </div>
                    </td>
                </tr>
                <tr><td></td></tr>
                <tr>
                    <td>
                        <div style="margin-right: 0px; overflow: auto; overflow-x: hidden;">
                            <iframe id="site" src="<%=url1%>?District=<%=strDistrict%>&Type=<%=type%>" width="700" height="<%=high%>" marginheight="0" marginwidth="0" scrolling="auto"
                                style="left: 0;" frameborder="0"></iframe>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

<script>
var width1 = document.body.clientWidth; 

document.getElementById('map').style.width= + width1-20;
document.getElementById('site').style.width= + width1-20;

</script>