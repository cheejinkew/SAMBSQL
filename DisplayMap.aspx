<%@ Page Language="VB" Debug="true" %>

<%@ Import Namespace="AspMap" %>
<%@ Import Namespace="System.Data.sqlclient" %>
<!-- #Include file="SubAndFunctions.inc" -->
<!--#include file="kont_id.aspx"-->
<script runat="Server">

    
    Dim objConn
    'dim strConn
    
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
    Dim District
    Dim SiteType
 

    Dim myDeg
    Dim strGetPointName

    Dim i
    Dim strControlDistrict
    Dim arryControlDistrict

    Dim strSelectedDistrict


    Dim strConn As String = ConfigurationSettings.AppSettings("DSNPG")


    Sub Page_Load(ByVal Source As Object, ByVal E As EventArgs)
  
        Try
            If (Not Page.IsPostBack) Then

                Response.Cookies("Telemetry")("UserID") = Request.Cookies("Telemetry")("UserID")
                Response.Cookies("Telemetry")("UserName") = Request.Cookies("Telemetry")("UserName")
                Response.Cookies("Telemetry")("ControlDistrict") = Request.Cookies("Telemetry")("ControlDistrict")
        
        
                Dim SelectedDistrict = Request.QueryString("strSelectedDistrict")
                Dim SelectedType = Request.QueryString("strSelectedType")
                If (SelectedDistrict <> "") Then
    
                    Session("SelectedDistrict") = SelectedDistrict
                    Session("SelectedType") = SelectedType
                End If
    
            End If
            Dim District = Request.QueryString("district")
            Dim SiteType = Request.QueryString("sitetype")
   

            strSelectedDistrict = System.Web.HttpContext.Current.Response.Cookies("Telemetry")("ddDistrictt")
   
	
            'arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
            'If arryControlDistrict.length() > 1 Then
            '    For i = 0 To (arryControlDistrict.length() - 1)
            '        If i <> (arryControlDistrict.length() - 1) Then
            '            strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "', "
            '        Else
            '            strControlDistrict = strControlDistrict & "'" & Trim(arryControlDistrict(i)) & "'"
            '        End If
            '    Next i
            'Else
            '    strControlDistrict = strControlDistrict & "'" & arryControlDistrict(0) & "'"
            'End If
	

            strCommand = Request.QueryString("Command")


            Response.Expires = 0

            map = New Map
            map.Width = 600
            map.Height = 400
            map.MapUnit = 9036

    
        
            Call LoadMapLayers()
            '  Call LoadSiteLocationLayer()
            Call UpdateExtent()
            Call ProcessCommand()


            Dim p As New Point
            p.X = 102.3086386930208
            p.Y = 2.3331957680302313
    
            Dim x As Object
            Dim y As Object
            x = Nothing
            y = Nothing
    
            map.FromMapPoint(p, x, y)
    
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
            'response.write("mapscale: " & Session("mScale"))
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
       

    End Sub

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:t="urn:schemas-microsoft-com:time">
<head>
    <title>Displaying Telemetry Unit on Map</title><?IMPORT namespace="t" implementation="#default#time2">
</head>

<script language="JavaScript" src="ajx/get_left.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
var command="<%=strCommand %>";
var xmlhttpobj;
function fun(obj,url)
{
    if(command=="identify")
    {
    var formobj=document.getElementById("gismap");
        
    var inputobj1 = document.createElement('input');
    inputobj1.setAttribute('type','hidden');
    inputobj1.setAttribute('name','Click.x');
    inputobj1.setAttribute('value', parseInt(obj.style.left)+8);
    
    var inputobj2 = document.createElement('input');
    inputobj2.setAttribute('type','hidden');
    inputobj2.setAttribute('name','Click.y');
    inputobj2.setAttribute('value', parseInt(obj.style.top)+8);
    
    formobj.appendChild(inputobj1);
    formobj.appendChild(inputobj2);
      
    formobj.submit();
    }
    else
    {
        var obj=top.frames[2];
   
        top.frames[2].location=url;
        obj.submit();
      
    }
    
}
function change(commandval)
{
command=commandval;
}
var gname;
function tankover(obj,siteid,name)
{
    gname=name;
    
    var x=event.clientX-84;
    var y=event.clientY-54;
    
    var tankinfodivobj=document.getElementById("tankinfodiv");
    tankinfodivobj.style.visibility="visible";
       
   
    
    if(x<450)
    {
        tankinfodivobj.style.left=event.clientX;
        tankinfodivobj.style.top=event.clientY-105;
    }
    else if(y<300)
    {   
        tankinfodivobj.style.left=event.clientX-160;
        tankinfodivobj.style.top=event.clientY;
    }
    else if(x<450 && y<300)
    {
        tankinfodivobj.style.left=event.clientX+5;
        tankinfodivobj.style.top=event.clientY+5;
       
    }
    else if(x>450 && y>300)
    {   
        tankinfodivobj.style.left=event.clientX-155;
        tankinfodivobj.style.top=event.clientY-105;
    }
    
    var datadivobj=document.getElementById("datadiv");
    datadivobj.innerHTML="<img border=\"0\" src=\"images/loading.gif\"><b>Loading...</b>";
    //window.drawtank(0); 
    
    var url="Tankinfo.aspx?siteid="+siteid;
    xmlhttpobj=GetXmlHttpObject(displaytankinfo);
    xmlhttpobj.open("GET", url , true);
    xmlhttpobj.send(null);
       
}
function displaytankinfo()
{
    if (xmlhttpobj.readyState==4 || xmlhttpobj.readyState=="complete")
    { 
       
       document.getElementById("datadiv").innerHTML="Name : "+gname.toLowerCase( )+"<br/>"+xmlhttpobj.responseText;
       //window.drawtank(document.getElementById("level").innerText); 
      
    } 
}
function tankout()
{
    var tankinfodivobj=document.getElementById("tankinfodiv");
    tankinfodivobj.style.visibility="hidden";
    
    var datadivobj=document.getElementById("datadiv");
    datadivobj.innerHTML="";
}
function adjustdiv()
    {
            var maindivobj=document.getElementById("maindiv");
            var agent = navigator.userAgent.toLowerCase();
            var appversion=navigator.appVersion;
            if(agent.indexOf("msie")>=0)
            {
            
            }
            else if(agent.indexOf("firefox")>=0)
            {
                 maindivobj.style.top="51px";
            }
            else if(agent.indexOf("opera")>=0)
            {
                maindivobj.style.top="51px";
            }
            else if(agent.indexOf("netscape")>=0)
            {
                 maindivobj.style.top="51px";
            }
            //maindivobj.style.visibility="visible";
   }
</script>

<script language="Javascript" type="text/javascript">

//var strSession = '<%=session("login")%>';
//if (strSession != "true")
//{
//    Session("SelectedDistrict")=""
//    Session("SelectedType")=""
//    top.location.href = "login.aspx";
//}

</script>

<body onload="top.frames[0].location.reload();" style="margin-left: 80px; margin-top: 5px;
    font-family: Verdana; font-size: 11px;">
    <div id="tankinfodiv" style="position: absolute; border: #b0bec7 1px solid; height: 100px;
        width: 150px; font-family: Verdana; font-size: 11px; left: 0px; top: 0px; z-index: 100;
        visibility: hidden; overflow: hidden;">
        <div style="padding: 3px; background-image: url(images/head.gif); background-repeat: repeat-x;
            border-right: #b0bec7 0px solid; background-position: left bottom; border-top: #b0bec7 0px solid;
            border-left: #b0bec7 0px solid; color: #18397c; border-bottom: #93a6b4 1px solid;
            background-color: #fff;">
            <b style="color: #16387c;">&nbsp; Tank Information</b>
        </div>
       <!-- <embed src="chart.svg" width="20px" height="72px" style="position: absolute; left: 128px;
            top: 22px;" pluginspage="http://www.adobe.com/svg/viewer/install/"></embed>-->
        <div id="datadiv" style="height: 72px; border-right: #fff 1px solid; border-top: #fff 1px solid;
            border-left: #fff 1px solid; border-bottom: #fff 1px solid; background-image: url(images/body.gif);
            padding: 3px; color: #16387c;">
        </div>
    </div>
    <form id="gismap" action="">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr align="center">
                <td style="font-family: Verdana; font-size: 11px;">
                    <b>On click:</b>
                    <input type="radio" name="command" value="zoomin" onclick="change('zoomin')" <%if strcommand = "zoomin" then%>
                        checked="checked" <%end if%> />
                    Zoom In
                    <input type="radio" name="command" value="zoomout" onclick="change('zoomout')" <%if strcommand = "zoomout" then%>
                        checked<%end if%> />Zoom Out
                    <input type="radio" name="command" value="pan" onclick="change('pan')" <%if strcommand = "pan" then%>
                        checked<%end if%> />Pan
                    <input type="radio" name="command" value="identify" onclick="change('identify')"
                        <%if strcommand = "identify" then%> checked<%end if%> />Identify
                    <input type="radio" name="command" value="getpoint" onclick="change('getpoint')"
                        <%if strcommand = "getpoint" then%> checked<%end if%> />Set POI
                    <br />
                    <a href="DisplayMap.aspx?Command=map"><b>Return to Full Extent</b></a>
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="image" name="Click" src="TEMP/<%=tempFile%>" style="border: solid 4px #3366FF;
                        position: relative; left: 0px; top: 0px; width: 600px; height: 400px;" />
                    <div id="maindiv" style="position: absolute; width: 600px; height: 400px; background-color: transparent;
                        cursor: hand; left: 84px; top: 54px;">
                        <%
                            
                            
                            Dim conn As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("sqlserverconnectionSAMB"))
                            Dim cmdblue, cmdred, cmdyellow As SqlCommand
                            Dim sqlBlue, sqlRed, sqlyellow As String
                            Dim drBlue, drRed, drYellow As SqlDataReader
                            Dim html As String = ""
                            Dim lat As Decimal
                            Dim log As Decimal
                            Dim point As Point
                            Dim x As Object = Nothing
                            Dim y As Object = Nothing
                            Dim px As Int32
                            Dim py As Int32
                            Dim strSelectedDistrict
                            Dim strSelectedType

                            strSelectedDistrict = Session("SelectedDistrict")
                            strSelectedType = Session("SelectedType")

                            If Not (strSelectedDistrict = "" And strSelectedType = "") Then
                                sqlBlue = "select siteid,sitetype + ' : ' + sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN (" & strKontID & ") and t1.dtimestamp=result.dtimestamp and t1.alarmtype not in('LL','L','H','HH')) and sitedistrict in ('" & strSelectedDistrict & "') and sitetype='" & strSelectedType & "')"
                                sqlRed = "select siteid,sitetype + ' : ' + sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN (" & strKontID & ") and t1.dtimestamp=result.dtimestamp and t1.alarmtype in('LL','HH')) and sitedistrict in ('" & strSelectedDistrict & "') and sitetype='" & strSelectedType & "')"
                                sqlyellow = "select siteid,sitetype + ' : ' + sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN (" & strKontID & ") and t1.dtimestamp=result.dtimestamp and t1.alarmtype in('L','H'))and sitedistrict in ('" & strSelectedDistrict & "') and sitetype='" & strSelectedType & "')"
                            Else
                                'starting
                                sqlBlue = "select siteid,sitetype + ' : ' + sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN (" & strKontID & ") and t1.dtimestamp=result.dtimestamp and t1.alarmtype not in('LL','L','H','HH')))"
                                sqlRed = "select siteid,sitetype + ' : ' + sitename as Location,sitedistrict,lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN (" & strKontID & ") and t1.dtimestamp=result.dtimestamp and t1.alarmtype in('LL','HH')))"
                                sqlyellow = "select siteid,sitetype + ' : ' + sitename as Location,sitedistrict,lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(dtimestamp)as dtimestamp from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and result.siteid NOT IN (" & strKontID & ") and t1.dtimestamp=result.dtimestamp and t1.alarmtype in('L','H')))"
                            End If
                            
                            cmdblue = New SqlCommand(sqlBlue, conn)
                            cmdred = New SqlCommand(sqlRed, conn)
                            cmdyellow = New SqlCommand(sqlyellow, conn)
                            
                            conn.Open()
                            drBlue = cmdblue.ExecuteReader()
                            While drBlue.Read
                                If IsDBNull(drBlue("Y")) Then
                                    lat = 0
                                Else
                                    lat = drBlue("Y")
                                End If
                                
                                If IsDBNull(drBlue("X")) Then
                                    log = 0
                                Else
                                    log = drBlue("X")
                                End If
                                
                                point = New Point
                                point.X = log
                                point.Y = lat
                                map.FromMapPoint(point, x, y)
                                px = System.Convert.ToInt32(x)
                                py = System.Convert.ToInt32(y)
                                If px > 5 And px < 595 And py > 5 And py < 395 Then
                                    html = html & "<div  onmouseover=""tankover(this,'" & drBlue("siteid") & "','" & drBlue("Location").Split(":"c)(1) & "');"" onmouseout=""tankout();"" onclick=""fun(this,'Summary.aspx?siteid=" & drBlue("siteid") & "&sitename=" & drBlue("Location").Split(":"c)(1) & "&district=" & drBlue("sitedistrict") & "&sitetype=" & drBlue("Location").Split(":"c)(0) & "');"" style='width: 16px; height: 16px; left: " & px - 8 & "px; position: absolute; top: " & py - 8 & "px; background-image: url(images/BlueTank.gif); font-size: 11px; font-family: Verdana;'></div>"
                                End If
                            End While
                            drBlue.Close()
                            cmdblue.Dispose()
                            
                            drYellow = cmdyellow.ExecuteReader()
                            While drYellow.Read
                                If IsDBNull(drYellow("Y")) Then
                                    lat = 0
                                Else
                                    lat = drYellow("Y")
                                End If
                                
                                If IsDBNull(drYellow("X")) Then
                                    log = 0
                                Else
                                    log = drYellow("X")
                                End If
                                
                                point = New Point
                                point.X = log
                                point.Y = lat
                                map.FromMapPoint(point, x, y)
                                px = System.Convert.ToInt32(x)
                                py = System.Convert.ToInt32(y)
                                If px > 5 And px < 595 And py > 5 And py < 395 Then
                                    html = html & "<div  onmouseover=""tankover(this,'" & drYellow("siteid") & "','" & drYellow("Location").Split(":"c)(1) & "');"" onmouseout=""tankout();"" onclick=""fun(this,'Summary.aspx?siteid=" & drYellow("siteid") & "&sitename=" & drYellow("Location").Split(":"c)(1) & "&district=" & drYellow("sitedistrict") & "&sitetype=" & drYellow("Location").Split(":"c)(0) & "');"" style='width: 16px; height: 16px; left: " & px - 8 & "px; position: absolute; top: " & py - 8 & "px; background-image: url(images/YellowTank.gif); font-size: 11px; font-family: Verdana;'></div>"
                                End If
                            End While
                            drYellow.Close()
                            cmdyellow.Dispose()
                                   
                            drRed = cmdred.ExecuteReader()
                            While drRed.Read
                                If IsDBNull(drRed("Y")) Then
                                    lat = 0
                                Else
                                    lat = drRed("Y")
                                End If
                                
                                If IsDBNull(drRed("X")) Then
                                    log = 0
                                Else
                                    log = drRed("X")
                                End If
                                
                                point = New Point
                                point.X = log
                                point.Y = lat
                                map.FromMapPoint(point, x, y)
                                px = System.Convert.ToInt32(x)
                                py = System.Convert.ToInt32(y)
                                If px > 5 And px < 595 And py > 5 And py < 395 Then
                                    html = html & "<div  onmouseover=""tankover(this,'" & drRed("siteid") & "','" & drRed("Location").Split(":"c)(1) & "');"" onmouseout=""tankout();"" onclick=""fun(this,'Summary.aspx?siteid=" & drRed("siteid") & "&sitename=" & drRed("Location").Split(":"c)(1) & "&district=" & drRed("sitedistrict") & "&sitetype=" & drRed("Location").Split(":"c)(0) & "');"" style='width: 16px; height: 16px; left: " & px - 8 & "px; position: absolute; top: " & py - 8 & "px; background-image: url(images/RedTank.gif); font-size: 11px; font-family: Verdana;'></div>"
                                End If
                            End While
                            drRed.Close()
                            cmdred.Dispose()
                            conn.Close()
                        %>
                        <%=html %>
                    </div>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <br />
                    <p style="margin-bottom: 15px; font-family: Verdana; color: #5373A2; font-size: 11px;">
                        Copyright ?2005 Gussmann Technologies Sdn Bhd. All rights reserved.
                    </p>
                </td>
            </tr>
        </table>
        <input type="hidden" name="Left" value="<%=CStr(Map.Extent.Left)%>" />
        <input type="hidden" name="Bottom" value="<%=CStr(Map.Extent.Bottom)%>" />
        <input type="hidden" name="Right" value="<%=CStr(Map.Extent.Right)%>" />
        <input type="hidden" name="Top" value="<%=CStr(Map.Extent.Top)%>" />
        <input type="hidden" name="imageFile" value="<%=tempFile%>" />
    </form>
    <%
        If strGetPointName = True Then
            Response.Cookies("Telemetry")("UserID") = Request.Cookies("Telemetry")("UserID")
            Response.Cookies("Telemetry")("UserName") = Request.Cookies("Telemetry")("UserName")
            Response.Cookies("Telemetry")("ControlDistrict") = Request.Cookies("Telemetry")("ControlDistrict")
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

    <script language="javascript" type="text/javascript">
    adjustdiv();
	//window.open("http://download.adobe.com/pub/adobe/magic/svgviewer/win/3.x/3.03/en/SVGView.exe");
    </script>

</body>
</html>
