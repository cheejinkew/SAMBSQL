<%@ Import Namespace="ADODB" %>
<script runat="Server">


  '*************************************************************************************
  ' Load Map Layers
  '*************************************************************************************
  Sub LoadMapLayers()

    ' Declare global variable for the path to sample data
    dim MapDir 
    dim mlayer
    'dim wlayer
     
    map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/ALOR_GAJAH/ALOR_GAJAH.shp"))
        mlayer = map.Layer("ALOR_GAJAH")
        mlayer.ShowLabels = True
        mlayer.LabelField = "name"
        ' mlayer.Symbol.PointStyle = PointStyle.mcSquarePoint
        mlayer.Symbol.FillColor = RGB(255, 228, 181)
        'mlayer.Symbol.Size = 6
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(0, 0, 160)
        mlayer.visible = True

        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/ALOR_GAJAH/JASIN.shp"))
        mlayer = map.Layer("JASIN")
        mlayer.ShowLabels = True
        mlayer.LabelField = "name"
        mlayer.Symbol.PointStyle = PointStyle.mcSquarePoint
        mlayer.Symbol.FillColor = RGB(255, 182, 193)
        'mlayer.Symbol.Size = 6
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(0, 0, 160)
        mlayer.visible = True

        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/ALOR_GAJAH/MELAKA_TENGAH.shp"))
        mlayer = map.Layer("MELAKA_TENGAH")
        mlayer.ShowLabels = True
        mlayer.LabelField = "name"
        'mlayer.Symbol.PointStyle = PointStyle.mcCrossPoint
        mlayer.Symbol.FillColor = RGB(176, 226, 255)
        'mlayer.Symbol.Size = 6
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(0, 0, 160)
        mlayer.visible = True

        'map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/melaka.ecw"))ALOR_GAJAH

        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/Melaka_Town.shp"))
        mlayer = map.Layer("Melaka_Town")
        mlayer.ShowLabels = True
        mlayer.LabelField = "Label"
        mlayer.Symbol.PointStyle = PointStyle.mcSquarePoint
        mlayer.Symbol.FillColor = RGB(0, 0, 160)
        mlayer.Symbol.Size = 6
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(0, 0, 160)
        mlayer.visible = True

        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/Melaka_Road.shp"))
        mlayer = map.Layer("Melaka_Road")
        mlayer.ShowLabels = True
        mlayer.LabelField = "label"
        mlayer.Symbol.LineStyle = LineStyle.mcRoadLine
        mlayer.Symbol.Size = 1
        mlayer.Symbol.LineColor = RGB(183, 147, 0)
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(183, 147, 0)
        mlayer.visible = True

        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/Melaka_Polygon.shp"))
        mlayer = map.Layer("Melaka_Polygon")
        mlayer.ShowLabels = True
        mlayer.LabelField = "label"
        mlayer.Symbol.LineStyle = LineStyle.mcDotLine
        mlayer.Symbol.FillStyle = FillStyle.mcDiagonalCrossFill
        mlayer.Symbol.Size = 1
        mlayer.Symbol.LineColor = RGB(255, 91, 13) '(255, 91, 13)
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(255, 91, 13)
        mlayer.visible = False

        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/Melaka_Building.shp"))
        mlayer = map.Layer("Melaka_Building")
        mlayer.ShowLabels = True
        mlayer.LabelField = "label"
        mlayer.Symbol.Size = 12
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(87, 0, 174)
        mlayer.Symbol.PointStyle = PointStyle.mcBitmapPoint
        mlayer.Symbol.Bitmap = Server.MapPath("images/blueHouse.bmp")
        mlayer.visible = False


        map.AddLayer(Server.MapPath("maps/Malaysia/Melaka/Melaka_Road.shp"))
        mlayer = map.Layer("Melaka_Road")
        mlayer.ShowLabels = True
        mlayer.LabelField = "label"
        mlayer.Symbol.LineStyle = LineStyle.mcRoadLine
        mlayer.Symbol.Size = 4
        mlayer.Symbol.LineColor = RGB(139, 69, 19)
        mlayer.Symbol.InnerColor = RGB(255, 250, 205)        
        mlayer.LabelFont.Name = "Arial"
        mlayer.LabelFont.Size = 12
        mlayer.LabelFont.Color = RGB(183, 147, 0)
        mlayer.visible = True


    if strCommand ="zoomout" then
      myDeg = session("mScale") * 2
    
    else if strCommand ="zoomin"
      myDeg = session("mScale") / 2
    else
      myDeg = session("mScale")
    end if
    
    if (myDeg) < = 450 then   
      map.Layer("Melaka_Polygon").visible = true
    end if
    
    if (myDeg) < = 210 then   
      map.Layer("Melaka_Building").visible = true
    end if

  End Sub
  

  '*************************************************************************************
  ' Add Site Layers
  '*************************************************************************************
  
  Sub LoadSiteLocationLayer()
  
    objConn = new ADODB.Connection()
  
    sqlrsblue=new ADODB.Recordset()
    sqlrsred=new ADODB.Recordset()
    sqlrsyellow=new ADODB.Recordset()
    
    objConn.open (strConn)
    
    sqlrsblue.CursorLocation = CursorLocationEnum.adUseClient
    sqlrsred.CursorLocation = CursorLocationEnum.adUseClient
    sqlrsyellow.CursorLocation = CursorLocationEnum.adUseClient
     
    dim strSelectedDistrict
	dim strSelectedType



strSelectedDistrict=Session("SelectedDistrict")
strSelectedType="Reservoir"

if not (strSelectedDistrict="" and  strSelectedType="") then

      sqlrsblue.Open("select siteid,sitetype || ' : ' || sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype not in('LL','L','H','HH')) and result.siteid in ('8511','8512','8619','8620','8621','8643','8546') and sitetype='" & strSelectedType & "')",objConn)
 
      sqlrsred.Open("select siteid,sitetype || ' : ' || sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('LL','HH')) and result.siteid in ('8511','8512','8619','8620','8621','8643','8546') and sitetype='" & strSelectedType & "')",objConn)
      
      sqlrsyellow.Open("select siteid,sitetype || ' : ' || sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('L','H'))and result.siteid in ('8511','8512','8619','8620','8621','8643','8546') and sitetype='" & strSelectedType & "')",objConn)
     
else
'starting
 sqlrsblue.Open("select siteid,sitetype || ' : ' || sitename as Location,sitedistrict, lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype not in('LL','L','H','HH')))",objConn)
 
 sqlrsred.Open("select siteid,sitetype || ' : ' || sitename as Location,sitedistrict,lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('LL','HH')))",objConn)
 
 sqlrsyellow.Open("select siteid,sitetype || ' : ' || sitename as Location,sitedistrict,lat AS Y, lon AS X  from telemetry_site_list_table where siteid in(select result.siteid from (select siteid,max(sequence)as sequence from telemetry_alert_message_table group by siteid) as result,telemetry_alert_message_table as t1 where(t1.siteid=result.siteid and t1.sequence=result.sequence and t1.alarmtype in('L','H')))",objConn)
 
 end if


    Map.AddLayer(sqlrsblue) 
    Map(0).Name = "CustomLoc"
    'Map("CustomLoc").Symbol.PointStyle = PointStyle.mcBitmapPoint
    'Map("CustomLoc").Symbol.Bitmap = Server.MapPath("images/BlueTank.bmp")
    'Map("CustomLoc").Symbol.TransparentColor = RGB(255,255,255)
    'Map("CustomLoc").Symbol.Size = 18
    Map("CustomLoc").LabelField = "Location"
    'Map("CustomLoc").ShowLabels = true
    Map("CustomLoc").LabelFont.Name = "Arial"
    Map("CustomLoc").LabelFont.Size = 12
    Map("CustomLoc").visible = true
    'Map("CustomLoc").LabelFont.Color = RGB(131,159,250)
    Map("CustomLoc").LabelFont.Color = RGB(0,0,0)
    
    Map.AddLayer(sqlrsred) 
    Map(0).Name = "CustomLoc1"
    'Map("CustomLoc1").Symbol.PointStyle = PointStyle.mcBitmapPoint
    'Map("CustomLoc1").Symbol.Bitmap = Server.MapPath("images/RedTank.bmp")
    'Map("CustomLoc1").Symbol.TransparentColor = RGB(255,255,255)
    'Map("CustomLoc1").Symbol.Size = 18
    Map("CustomLoc1").LabelField = "Location"
   ' Map("CustomLoc1").ShowLabels = true
    Map("CustomLoc1").LabelFont.Name = "Arial"
    Map("CustomLoc1").LabelFont.Size = 12
    Map("CustomLoc1").visible = true
    'Map("CustomLoc1").LabelFont.Color = RGB(255,0,0)
    Map("CustomLoc").LabelFont.Color = RGB(0,0,0)

    Map.AddLayer(sqlrsyellow) 
    Map(0).Name = "CustomLoc2"
    'Map("CustomLoc2").Symbol.PointStyle = PointStyle.mcBitmapPoint
	'Map("CustomLoc2").Symbol.Bitmap = Server.MapPath("images/YellowTank.bmp")
    'Map("CustomLoc2").Symbol.TransparentColor = RGB(255,255,255)
    'Map("CustomLoc2").Symbol.Size = 18
    Map("CustomLoc2").LabelField = "Location"
    'Map("CustomLoc2").ShowLabels = true
    Map("CustomLoc2").LabelFont.Name = "Arial"
    Map("CustomLoc2").LabelFont.Size = 12
    Map("CustomLoc2").visible = true
    'Map("CustomLoc2").LabelFont.Color = RGB(255,230,0)
    Map("CustomLoc").LabelFont.Color = RGB(0,0,0)
   
   end sub  
  
  
  
  '*************************************************************************************
  ' Extract the current map extent from the request.
  '*************************************************************************************
  
  Sub UpdateExtent() 
    Dim extent as Rectangle
    dim strTmp as String
    
    extent = new Rectangle

    strTmp = Request("Left")
      If Len(strTmp) > 0 Then
      extent.Left = CDbl(strTmp)
      extent.Bottom = CDbl(Request("Bottom"))
      extent.Right = CDbl(Request("Right"))
      extent.Top = CDbl(Request("Top"))
    
      map.Extent = extent
    End If
  End Sub


  '*************************************************************************************
  ' to perform pan and zoom operations
  '*************************************************************************************
  
  Sub ProcessCommand()
  dim point
  dim layerIndex
  
  ' find Command value
  ' based on command value, take proper action
  
  Select Case strCommand
      
      Case "map":
          map.ZoomFull
          strCommand = "zoomin"
          point = map.ToMapPoint(310,230)
          map.ZoomIn (point)
          map.Layer("Melaka_Building").visible = false
          map.Layer("Melaka_Polygon").visible = false
          
      Case "zoomin":    
          point = map.ToMapPoint(CLng(Request("Click.X")), CLng(Request("Click.Y")))
          map.ZoomIn (point)
  
      Case "pan":
          point = map.ToMapPoint(CLng(Request("Click.X")), CLng(Request("Click.Y")))
          map.CenterAt (point)
  
      Case "zoomout":
          point = map.ToMapPoint(CLng(Request("Click.X")), CLng(Request("Click.Y")))
          map.ZoomOut (point)

          session("mScale") = myDeg * 4
          'response.write(" ZoomOut: " & session("mScale"))


      Case "identify":
          point = map.ToMapPoint(CLng(Request("Click.X")), CLng(Request("Click.Y")))
          layerIndex = IdentifyFeature(Map, point, IdentifyRS)
          If layerIndex >= 0 Then

            Dim callout
            callout = map.Callouts.Add 
            callout.x = point.x
            callout.y = point.y
        
            If Len(Map(layerIndex).LabelField) > 0 Then
                callout.Text = IdentifyRS(Map(layerIndex).LabelField)
            Else
                callout.Text = IdentifyRS(0)
            End If

            callout.Font.Size = 14
        End If

      Case "getpoint":
          point = map.ToMapPoint(CLng(Request("Click.X")), CLng(Request("Click.Y")))
          
          session("Lon")= point.X
          session("Lat")= point.Y 
          session("GetCoord") = 1
     
     Case Else
          strCommand = "zoomin"
  End Select
  End Sub


  
  '*************************************************************************************
  ' returns the number of the layer that contains the feature and a recordset that contains 
  ' information about the feature
  '*************************************************************************************
  
  Function IdentifyFeature(Map, point, ByRef recordset)
  Dim i 
  dim distance
  dim rect
  dim identRS
  dim layer = new Layer
  
  IdentifyFeature = -1
  recordset = Nothing
  identRS = Nothing
        
  for i = 0 to Map.LayerCount - 1
      
      layer = Map.Layer(i)
  
      Select Case Layer.LayerType 
          Case LayerType.mcPointLayer:
              identRS = layer.SearchByDistance(point, Map.ToMapDistance(Layer.Symbol.Size/2))
          Case LayerType.mcLineLayer:                
              distance = Map.ToMapDistance(Layer.Symbol.Size+2)
              rect = Server.CreateObject("AspMap.Rectangle")
              rect.top = point.y + distance/2
              rect.left = point.x - distance/2
              rect.right = point.x + distance/2
              rect.bottom = point.y - distance/2    
              identRS = Layer.SearchShape(rect, searchMethod.mcIntersect)
          Case LayerType.mcPolygonLayer:
              identRS = Layer.SearchShape(point, searchMethod.mcPointInPolygon)
      End Select
  
      If (Not identRS Is Nothing) And (Not identRS.EOF) Then
          recordset = identRS
          IdentifyFeature = i
          Exit Function
      End If
      
          
  Next         
  End Function


  '*************************************************************************************
  ' print out the identified information
  '*************************************************************************************

  Sub PrintRecordset(Recset)
    Dim nIndex
  
    Response.Write ("<TABLE cellspacing=1 cellpadding=2 style='font-family: Verdana; font-size: 8pt'>")
  
  
    for nIndex = 0 to Recset.FieldCount - 1
      Response.Write ("<TH bgcolor='#AAC6FF'>" & "<b>" & Recset.FieldName(nIndex) & "</b>")
    next
  
    Recset.MoveFirst
    
    

    do while (not Recset.EOF)
      Response.Write ("<TR>")
		if Recset.FieldCount=5 then
		dim str as string
		str=Recset(1)
		 Dim sarray() As String
		 sarray=str.Split(":"c)
		
		Response.Write ("<TD style='border: 1 solid #AAC6FF'><a href='Summary.aspx?siteid=" & Recset(0) & "&district=" & Recset(2) & "&sitename=" & sarray(1) & "&sitetype=" & sarray(0) & "'>" & Recset(0) & "</a></TD>")
		
      for nIndex = 1 to Recset.FieldCount - 1
        Response.Write ("<TD style='border: 1 solid #AAC6FF'>" & Recset(nIndex) & "</TD>")
      next
      else
       for nIndex = 0 to Recset.FieldCount - 1
        Response.Write ("<TD style='border: 1 solid #AAC6FF'>" & Recset(nIndex) & "</TD>")
      next
      end if

      Response.Write ("</TR>")
      Recset.MoveNext
    loop
    Response.Write ("</TABLE>")
  End Sub

  '*************************************************************************************
  
  Const MU_DECIMALDEGREES = 0 
  Const MU_MILES = 1
  Const MU_KILOMETERS = 2
  
  
  Function GetMapScale(Map, mapUnits)
  Select Case mapUnits
  	Case MU_DECIMALDEGREES
  		GetMapScale = CLng(Map.Extent.Width / (Map.Width / (72 * 4374754)))
  	Case MU_MILES
  		GetMapScale = CLng(Map.Extent.Width / (Map.Width / (72 * 63360)))
  	Case MU_KILOMETERS
  		GetMapScale = CLng(Map.Extent.Width / (Map.Width / (72 * 39370.1)))
  End Select
  End Function

  '*************************************************************************************
  ' to remove temporary map image files.
  '*************************************************************************************
  
  
  Sub Page_Unload(source As Object, e As EventArgs)   

    'tools.RemoveTempFiles (Server.MapPath("./TEMP"), 1)
    
   ' map = nothing
    'points = nothing
    'tools = nothing
    'legend = nothing

    'sqlRs.Close()
    'sqlRs1.Close()
    'objConn.close()
    'objConn = nothing

  End Sub
  
</script>

