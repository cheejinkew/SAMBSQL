<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="AspMap" %>
<!-- #Include file="SubAndFunctions.inc" -->

<script runat="Server">

    Dim objConn
    'dim strConn
    Dim sqlRs
    Dim sqlRs1

    Dim sqlrsblue
    Dim sqlrsred
    Dim sqlrsyellow

    Dim map As Map
    Dim points As DynamicPoints
    Dim pointLayer
    Dim tools As Tools
    Dim legend As Legend
    Dim tempFile As String
    Dim strCommand As String
    Dim item
    Dim IdentifyRS = Nothing
    Dim cal
    Dim ArrySiteID

    Dim myDeg
    Dim strGetPointName

    Dim i
    Dim strControlDistrict
    Dim arryControlDistrict

    Dim strConn As String = ConfigurationSettings.AppSettings("DSNPG")

    Sub Page_Load(ByVal Source As Object, ByVal E As EventArgs)
  
        arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
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

        strCommand = UCase(Request.QueryString("Command"))
        Response.Expires = 0

        map = New Map
        map.Width = 600
        map.Height = 400
        map.MapUnit = 9036

    
        Call LoadMapLayers()
  
        Call LoadSiteLocationLayer()
    

        Call UpdateExtent()
    
        Call ProcessCommand()


        If Session("GetCoord") = 1 Then
            strGetPointName = True
            Session("GetCoord") = 0
        End If

    
        '** Creates a unique image name and saves the map image to a temporary folder (./TEMP). **

        tools = New Tools
        tempFile = "TEMP_" & tools.GetUniqueString() & ".gif"

        map.ImageFormat = ImageFormat.mcGIF

    

        If Not map.SaveImage(Server.MapPath("./TEMP") & "\" & tempFile) Then
            Response.Write("Can't save map image.")
            Response.End()
        End If

        Session("mScale") = map.MapScale
        '    response.write("mapscale: " & Session("mScale"))   

    End Sub
</script>

<%
  
    Dim strStatus = Request.QueryString("c")
    Dim visibiliti
  
    If strStatus = 1 Then
        visibiliti = "visible"
    Else
        visibiliti = "hidden"
    End If


%>
<html>
<head>
    <title>Displaying Telemetry Unit on Map</title>
</head>
<body>
    <form name="test" action="MelakaDisplayMap.aspx">
        <div align="center">
            <center>
                <table border="0" width="90%" cellspacing="1">
                    <tr>
                        <td width="95%" colspan="3">
                            <p align="center">
                                <b><font size="2" face="Verdana"><b>On click:</b> </font><font size="1" face="Verdana">
                                    <input type="radio" name="command" value="ZOOMIN" <%if strCommand = "ZOOMIN" then%>
                                        CHECKED<%end if%>>
                                    Zoom In
                                    <input type="radio" name="command" value="ZOOMOUT" <%if strCommand = "ZOOMOUT" then%>
                                        CHECKED<%end if%>>Zoom Out
                                    <input type="radio" name="command" value="PAN" <%if strCommand = "PAN" then%> CHECKED<%end if%>>Pan
                                    <input type="radio" name="command" value="IDENTIFY" <%if strCommand = "IDENTIFY" then%>
                                        CHECKED<%end if%>>Identify
                                    <input style="visibility: <%=visibiliti%>" type="radio" name="command" value="GETPOINT"
                                        <%if strCommand = "GETPOINT" then%> CHECKED<%end if%>><span style="visibility: <%=visibiliti%>">Set
                                            POI</span>
                                    <br>
                                    <a href="MelakaDisplayMap.aspx?Command=MAP&c=<%=strStatus%>">Return to Full Extent</b></a>
                                </font>
                                <br>
                        </td>
                        <td width="5%">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td width="10%">
                            &nbsp;</td>
                        <td width="12%">
                            <p align="center">
                                <input type="image" name="Click" src="TEMP/<%=tempFile%>" width="<%=map.Width%>"
                                    height="<%=map.Height%>" style="border-style: solid; border-color: #3366FF">
                            </p>
                        </td>
                        <td width="10%">
                            &nbsp;</td>
                    </tr>
                </table>
            </center>
        </div>
        <input type="hidden" name="Left" value="<%=CStr(Map.Extent.Left)%>">
        <input type="hidden" name="Bottom" value="<%=CStr(Map.Extent.Bottom)%>">
        <input type="hidden" name="Right" value="<%=CStr(Map.Extent.Right)%>">
        <input type="hidden" name="Top" value="<%=CStr(Map.Extent.Top)%>">
        <input type="hidden" name="imageFile" value="<%=tempFile%>">
        <input type="hidden" name="c" value="<%=strStatus%>">
        <p align="center" style="margin-bottom: 15">
            <font size="1" face="Verdana" color="#5373A2">Copyright ©
                <%=now.ToString("yyyy") %>
                Gussmann Technologies Sdn Bhd. All rights reserved. </font>
        </p>
    </form>
    <%
        If strGetPointName = True Then
            Response.Redirect("AddSite.aspx")
        End If
    %>
    <%
        If Not IdentifyRS Is Nothing Then
            Response.Write("<CENTER><font size='1' face='Verdana'><b>Identify Results:<br>")
            PrintRecordset(IdentifyRS)
            Response.Write("</font></CENTER>")
        End If
    %>
</body>
</html>

<script language="Javascript">

var strSession = '<%=session("login")%>';
if (strSession != "true")
{
  top.location.href = "Melakalogin.aspx";
}

</script>

