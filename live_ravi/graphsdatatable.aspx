<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<%@ Import Namespace="ChartDirector" %>
<%@ Import Namespace="System.IO" %>  
<meta http-equiv="refresh" content="900"/>
<!--#include file="table_head.aspx"-->
<script language="VB" runat="server">
   Public SiteID,EquipName,chart1URL,LatestStatus,LatestValue,statusColor As String
    Public LatestDateTime,fontweight,tsimno as string
    '=========================Function Creating Chart================================================================
    Private Function trending(ByVal stid As String, ByVal speriod As Integer, ByVal stname As String)
         SiteId=stid 
         Dim District1 = Request.QueryString("district")
         Dim Position1 = speriod
         Dim SiteName = stname
         EquipName = "Water Level Trending"
         Dim startdate As String
         Dim enddate2 As String
         Dim enddate As String
         enddate2 = Date.Parse(Now).AddHours(-24)
         enddate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(enddate2))
         startdate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(enddate).AddHours(-2))
	     Dim strConn1
         Dim objConn1
         Dim rsRecords
         Dim values() As Double
         Dim sequence()
         Dim sequence1() As String
         Dim i As Integer = 0
         Dim strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(startdate))
         Dim strLastDate1
         strLastDate1 = strLastDate
         strConn1 = ConfigurationManager.AppSettings("DSNPG")
         objConn1 = New ADODB.Connection()
         rsRecords = New ADODB.Recordset()
         objConn1.open(strConn1)
         strLastDate = strLastDate1
         Dim xscale = 1
              Do While strLastDate <= enddate
                       Dim r = Request.QueryString("siteid")
                          If SiteID = Nothing Then
                             Response.Write("THERE IS NO DATA TO BE DISPLAYED")
                             Exit Function
                          End If
                     'rsRecords.open("select value,sequence from telemetry_log_table where siteid='" & SiteID & _
                      '            "' and position=" & Position1 & " and sequence between '" & strLastDate & _
                       '          ":00' and '" & strLastDate & ":59' order by sequence desc limit 5 ", objConn1)
                      rsRecords.open("select value,sequence from telemetry_log_table where siteid='" & SiteID & _
                                   "' and sequence between '" & strLastDate & ":00' and '" & strLastDate & ":59' order by sequence desc limit 5 ", objConn1)
                       
                      
                          If Not rsRecords.EOF Then
                            ReDim Preserve values(i)
                            ReDim Preserve sequence(i)
                            ReDim Preserve sequence1(i)
                            values(i) = rsRecords("value").value
                            sequence(i) = rsRecords("sequence").value
                            sequence1(i) = String.Format("{0:HH:mm}", Date.Parse(sequence(i).AddHours(24)))
                            i = i + 1
                          End If
                       strLastDate = String.Format("{0:yyyy/MM/dd HH:mm}", Date.Parse(strLastDate).AddMinutes(xscale))
                       rsRecords.close()
              Loop
              if  i=0 then
                                 rsRecords.Open("select simno from unit_list where unitid='" & stid & "'",objConn1)
	                             tsimno = rsrecords("simno").value
		                         rsrecords.close
               return 0
              else
              
                   Dim rmultiplier(0) As String
        Dim rposition(0) As Integer
        Dim ralarmtype(0) As String
        Dim rcolorcode(0) As String
        Dim ralert(0) As Boolean
        i = 0
        rsRecords.Open("select multiplier, position, alarmtype, colorcode, alert" & _
                       " from telemetry_rule_list_table where siteid='" & SiteID & _
                       "' And alarmmode = 'EVENT' order by position, sequence asc", objConn1)
            Do While Not rsRecords.EOF
                         rmultiplier(i) = rsRecords("multiplier").value
                         rposition(i) = rsRecords("position").value
                         ralarmtype(i) = rsRecords("alarmtype").value
                         rcolorcode(i) = rsRecords("colorcode").value
                         ralert(i) = rsRecords("alert").value
                         i = i + 1
                         ReDim Preserve rmultiplier(i)
                         ReDim Preserve rposition(i)
                         ReDim Preserve ralarmtype(i)
                         ReDim Preserve rcolorcode(i)
                         ReDim Preserve ralert(i)
                         rsRecords.MoveNext()
            Loop
        rsRecords.close()
       
	    Dim minValue As Integer
        Dim Suffix As String
	
	        If InStr(1, EquipName, "Flowmeter") > 0 Then
	                Suffix = "m3/h"
                    minValue = 0
            End If
       
        On Error Resume Next
        '=================Creating XYChart======================================================
        dim c As XYChart = New XYChart(220,150,&HFFFFFF, &H0,0)

        c.setPlotArea(50, 8, 150,100).setGridColor(&HFBCCF9, &HFBCCF9)
       
       'Add a line chart layer using the given data
        c.addLineLayer(values, &HC000&)
      
        c.setBorder(&HFFFFFF)
       'Set the labels on the x axis.''''''''''30 angle
        c.xAxis().setLabels(sequence1).setFontAngle(30)
        c.yAxis().setColors(&H0&, &H0&, &H0&)
       
  
       'Display 1 out of 3 labels on the x-axis.
        Dim Div As Integer
            If UBound(values) <= 31 Then
                Div = 0
            Else
                Div = (UBound(values) / 31)
            End If
        Dim k As Integer = 0
        Dim d = Div * 1
          
        c.xAxis().setLabels(sequence1).setFontAngle(45)
        c.xAxis().setLabels(sequence1).setFontSize(8)
        c.xAxis().setLabelStep(0.5)
  
        Dim maxrulevalue As Double
        Dim minrulevalue As Double
        Dim reverse As Boolean

        reverse = True
                 
        For i = 0 To UBound(rmultiplier)
           minrulevalue = szParseString(rmultiplier(i), ";", 2)
           maxrulevalue = szParseString(rmultiplier(i), ";", 3)
           If ralert(i) = True Then
           
             If reverse = True Then
             
              c.yAxis().addMark(maxrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & maxrulevalue).setLineWidth(2)
              
             Else
                    
              c.yAxis().addMark(minrulevalue, "&H" & rcolorcode(i), ralarmtype(i) & " : " & minrulevalue).setLineWidth(2)
             End If
           Else
              reverse = ralert(i)
           End If
        Next i
        
'===================Creating Chart and saving to TempFolder created on Local System=======================================   
               
                chart1URL = c.makeSession(Session, SiteId)
                SiteID=c.getHTMLImageMap("#", "", _
                                "title='Time {xLabel}: " & EquipName & " {value} " & Suffix & "'")
                rsRecords.Open("select sequence,value,event" & _
                                 " from telemetry_equip_status_table where siteid='" & stid & _
                                 "' order by sequence desc limit 1", objConn1)
                Do While Not rsRecords.EOF
                                      
                                 LatestStatus=rsRecords("event").value
                                 LatestValue=Math.Round(rsRecords("value").value, 2)
                                 LatestDateTime=String.Format("{0:dd MMMM yyyy h:mm tt}",rsRecords("sequence").value)
                                 select case LatestStatus
                                 
                                 Case "NN"
                                           fontweight="normal" 
                                 Case "N"
                                           fontweight="normal"    
                                 Case "HH"
                                           fontweight="bold" 
                                 case "H"  
                                           fontweight="bold" 
                                 Case "LL"
                                           fontweight="bold" 
                                 Case "L"  
                                          
                                           fontweight="bold" 
                                 Case Else
             
                                           LatestStatus=" "
                                           fontweight="bold" 
                                 end select
                                 
                                 rsRecords.MoveNext()
               loop
                                 rsRecords.close()
                                 rsRecords.Open("select colorcode from telemetry_rule_list_table where siteid='" & stid & "' and alarmtype='" & LatestStatus & "'",objConn1)
                                 statusColor=rsRecords("colorcode").value
                                 rsRecords.close()
                                 rsRecords.Open("select simno from unit_list where unitid='" & stid & "'",objConn1)
	                             tsimno = rsrecords("simno").value
		                         rsrecords.close
		                         rsrecords = nothing
		                         return 1
          
       
     
        
       end if
    End Function

    
</script>

<%

dim objConn
dim strConn 
dim sqlRs
dim table = Request.QueryString("table")
dim district = Request.QueryString("dist")
dim start_date = Request.QueryString("start")
dim speriod as integer = Request.QueryString("p")
dim uid = Request.QueryString("uid")
dim end_date, stid as string 
dim level_read, RF_read, cumRainfall, maya, tempoh
dim total_rainfall,counter
strConn = ConfigurationSettings.AppSettings("DSNPG")
objConn = new ADODB.Connection()
sqlRs = new ADODB.Recordset()

makeHTMLHeader_Open()
     
%>
<!--#include file="table_style.inc"-->
<% 

               '===========THIS CODE IS FOR CREATING TABLES AND DISPLAYING DYNAMICALLY==========='
                makeHTMLHeader_Close()
                Response.Write("<body onload=" & Chr(34) & "parent.startTimer();" & Chr(34) & ">")
                Dim metar
                If district = "All" Then
                    metar = GetDistrict(strConn, uid, 2).Replace("|", "'")
                Else
                    metar = "'" & district & "'"
                End If

                Select Case table
                    Case 1 'DAILY	
                            Dim cmdQuery, x, class_pg, class_ptg, class_mlm
                            tempoh = 23
                            Response.Write("<br><center><h1>")
                            Response.Write("INCOMING DATA TABLE (" & UCase(metar.replace("'", "")) & ")")
                            Response.Write("</h1></center>" & vbCrLf)
                            objConn.open(strConn)
		                    Dim todayDate = String.Format("{0:dd MMMM yyyy h:mm tt}", Date.Parse(Now))
                            cmdQuery = "select siteid,sitename from telemetry_site_list_table where sitedistrict in" & _
                                    " (" & metar & ") and exists (select unitid from unit_list where versionid like" & _
                                    " 'M%' and unitid=telemetry_site_list_table.unitid) order by siteid"
                            sqlRs.Open(cmdQuery, objConn)
                            'THIS IS FOR TABLE CREATION
                            Response.write("<center>")
                            Response.write("<table cellpadding='5px' cellspacing='5px'>")
                            'Response.write("<tr align=center><td align=center>")
                            dim t as integer=0
                            Response.write("<tr>")
		                     Do Until sqlRs.EOF
                                counter = counter + 1
                                
                                
                                Dim stname = GetSiteName(strConn, sqlRs("siteid").value)
                                stid = sqlRs("siteid").value
                                '============== Modified on 28-06-2007=========================================
                                if (trending(stid, speriod, stname))= 1 then
                                
                               
                                if (t mod 3) = 0 then
                                Response.write("</tr>")
                                Response.write("<tr>")
                                end if 
                                 t=t+1
                                   'Response.write("<div  style='float:left;width:100px;padding:2px;'>")
                                   Response.write("<td align=center>")
                                   Response.write("<table class=tbl_1  width='260'>")
                                   Response.write("<tr style='font-weight:" & fontweight & "'><td align=center colspan=2 id=" & chr(34) & "siteid" & counter & chr(34) & _
                                                  " class=" & chr(34) & "tdc" & chr(34) & ">" & stid & _
                                                  "</td></tr><tr><td align=center colspan=2 id=" & chr(34) & "sitename" & counter & chr(34) & _
                                                  " class=" & chr(34) & "tdc" & chr(34) & " title='" & tsimno & "'>" & stname & "</td></tr>")
			                       Response.write("<tr><td colspan=2 align=center class=tdc height='170'><IMG class=tdimage SRC=getchart.aspx?" & chart1URL & " usemap='#" & SiteId & "'></td></tr>")
			                       Response.write("<map  name='"& SiteID &"'>" & SiteID & "</map>")
		                           Response.write("<tr><td class=tdc align=right>Last Value:</td><td id=" & chr(34) & "pg_value" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "' style='font-weight:" & fontweight & "'>" & LatestValue & " m</td></tr>")
		                           Response.write("<tr><td class=tdc align=right>Status:</td><td id=" & chr(34) & "pg_status" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "' style='font-weight:" & fontweight & "'><font color='#" & statusColor  & "'>" & LatestStatus & "</font></td>")
			                       Response.write("<tr ><td class=tdc align=right>Timestamp:</td><td id=" & chr(34) & "pg_DateTime" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "'>" & LatestDateTime & "</td></tr>")
			                       Response.Write("</table>")
			                       Response.write("</td>")
                                   'Response.write("</div>")
                                   LatestStatus=" "
                                   LatestValue=" "
                                   statusColor=" "
                                   LatestDateTime=" "
                                   fontweight=" "
                                   tsimno=" "
                                   sqlRs.MoveNext()
                                else
                                
                               
                               
                                if t mod 3 = 0 then
                                Response.write("</tr>")
                                Response.write("<tr>")
                                end if 
                                 t=t+1
                                   'Response.write("<div  style='float:left;width:100px;padding:2px;'>")
                                   Response.write("<td align=center>")
                                   Response.write("<table class=tbl_1 align=center width='260'>")
                                   Response.write("<tr style='font-weight:" & fontweight & "'><td align=center colspan=2 id=" & chr(34) & "siteid" & counter & chr(34) & _
                                                  " class=" & chr(34) & "tdc" & chr(34) & ">" & stid & _
                                                  "</td></tr><tr><td align=center colspan=2 id=" & chr(34) & "sitename" & counter & chr(34) & _
                                                  " class=" & chr(34) & "tdc" & chr(34) & " title='" & tsimno & "'>" & stname & "</td></tr>")
			                       Response.write("<tr><td colspan=2 align=center class=tdc height='170'>No Data To Be Displayed !</td></tr>")
			                       if LatestValue = " " then
			                       
			                              Response.write("<tr><td class=tdc align=right>Last Value:</td><td id=" & chr(34) & "pg_value" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "' style='font-weight:" & fontweight & "'>" & LatestValue & "-</td></tr>")
			                        else
			                              Response.write("<tr><td class=tdc align=right>Last Value:</td><td id=" & chr(34) & "pg_value" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "' style='font-weight:" & fontweight & "'>" & LatestValue & " m</td></tr>")
			                              
			                       end if

		                           Response.write("<tr><td class=tdc align=right>Status:</td><td id=" & chr(34) & "pg_status" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "' style='font-weight:" & fontweight & "'><font color='#" & statusColor  & "'>" & LatestStatus & "</font></td>")
			                       Response.write("<tr ><td class=tdc align=right>Timestamp:</td><td id=" & chr(34) & "pg_DateTime" & counter & chr(34) & " class=" & chr(34) & "tdc" & chr(34) & " align=" & chr(34) & "center" & chr(34) & " title='" & LatestDateTime & "'>" & LatestDateTime & "</td></tr>")
			                       Response.Write("</table>")
			                       Response.write("</td>")
                                   'Response.write("</div>")
                                   LatestStatus=" "
                                   LatestValue=" "
                                   statusColor=" "
                                   LatestDateTime=" "
                                   fontweight=" "
                                   tsimno=" "
                                   sqlRs.MoveNext()
                                 end if
			                  Loop
			                
                             Response.write("</tr></table>")
                             Response.write("</center>")
                             sqlRs.Close()
                             objConn.close()
                             sqlRs = Nothing
                             objConn = Nothing
                           
		            Case 2 'WEEKLY
                        Response.Write("Do Nothing!")
                    Case 3 'MONTHLY
                        Response.Write("Do Nothing!")
                End Select
                          
                                           
%>    
                                                       
         
<!--#include file="table_foot.aspx"-->



