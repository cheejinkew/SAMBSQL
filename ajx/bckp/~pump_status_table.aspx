<%
	dim SiteID = request.querystring("siteid")
	dim SiteName = request.QueryString("sitename")
	dim District = request.QueryString("district")
	dim SiteType = request.QueryString("sitetype")
	dim Message = request.QueryString("message")
   	dim objConn
   	dim rsRecords
   	dim strConn

   	dim strObjects
	
   	strConn = ConfigurationSettings.AppSettings("DSNPG")
   	objConn =  new ADODB.Connection()
   	rsRecords = new ADODB.Recordset()

   	objConn.open(strConn)

	dim refreshinterval as integer
	dim equiplist(0) as string
	dim equipname(0) as string
	dim equipdesc(0) as string
	dim multiplier(0) as string
	dim ulimit(0) as string
   	dim i as integer
	refreshinterval = 20
	rsRecords.Open("select " & chr(34) & "desc" & chr(34) & ", equipname, equiptype, multiplier, max from telemetry_equip_list_table where siteid='" & SiteID & "' order by position",objConn)
   	do while not rsRecords.EOF
		equiplist(i) = rsrecords.fields("equiptype").value 
		equipname(i) = rsrecords.fields("equipname").value
		equipdesc(i) = rsrecords.fields("desc").value 
		multiplier(i) = rsrecords.fields("multiplier").value
		ulimit(i) = rsrecords.fields("max").value
		i = i + 1
		redim preserve equiplist(i)
		redim preserve equipname(i)
		redim preserve equipdesc(i)
		redim preserve multiplier(i)
		redim preserve ulimit(i)
		
		rsRecords.MoveNext
	loop
	rsRecords.close
	
	
	dim events(2) as string
	dim sequence as string
	dim readings(2) as string

	rsRecords.Open("select sequence, value, event from telemetry_equip_status_table where siteid='" & SiteID & "' order by position",objConn)
   	if rsrecords.eof = false then
		i = 2
		do while not rsRecords.EOF
			events(i) = rsrecords.fields("event").value 
			sequence = rsrecords.fields("sequence").value 
			readings(i) = rsrecords.fields("value").value
			if readings(i) < 0 then readings(i) = 0
			i = i + 1
			redim preserve events(i)
			redim preserve readings(i)
			rsrecords.movenext
		loop
	else
		response.Write("Data Not Available")
		exit sub
	end if
	rsrecords.close
	
	rsrecords = nothing
	objConn.close
	objConn = Nothing
	dim XMLData as string
	dim minvalue as string
	dim maxvalue as string
	dim j as integer
	
	for i = 0 to ubound(equiplist)

'======================================================================
	dim equiplist2(ubound(equiplist)) as string
	dim equipname2(ubound(equiplist)) as string
	dim equipdesc2(ubound(equiplist)) as string	
'======================================================================

	if equiplist(i)="PUMP CONTROL" then
%>
<p>&nbsp;</p>
<table width="728" border="1">
<tr>
    <td width="224"><div align="center"><% = equipdesc(i) %></div></td>
    <td width="488"><div align="center"><a href="Trending.aspx?siteid=<%=siteid%>&sitename=<%=sitename%>&district=<%=district%>&equipname=<%=equipname(i)%>&position=<%=i%>&sitetype=<%=SiteType%>&equipdesc=<%=equipdesc(i)%>">
    <% = equipname(i)%>
    </a></div></td>
</tr>
<tr>
    <td rowspan="2" height="74"><div align="center" id="<%=equipdesc(i)%>">
<% 
				if readings(i) = 0 then
					if equipname(i) = "Pump Control Status" then
						response.Write("Auto (Remote)")
					else
						response.Write("Light On")
						strObjects = strObjects & equipdesc(i) & ","
					end if
				else 
					if equipname(i) = "Pump Control Status" then
						response.Write("Manual (Local)")
					else
						response.Write("Light Off")
						strObjects = strObjects & equipdesc(i) & ","
					end if
				end if
%>
	</div></td>
<% 
			XMLData = "<chart bgColor='000000' canvasBorderThickness='1' canvasBorderColor='008040' canvasBgColor='000000' yAxisMaxValue='" & ulimit(i) & "' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='1' decimalPrecision='2' divLineDecimalPrecision='0' limitsDecimalPrecision='0' numdivlines='9' numVDivLines='20' numDisplaySets='20' divLineColor='008040' vDivLineColor='008040' chartLeftMargin='10' chartBottomMargin='100' chartRightMargin='110' baseFontColor='00dd00' showRealTimeValue='0' dataStreamURL='RealTimeTrendDataFeed.aspx?siteid=" & siteid & "%26index=0%26position=" & i & "' refreshInterval='" & refreshinterval &"' numberSuffix='NTU' rotateNames='1' hoverCapBgColor='000000' hoverCapBorderColor='008040' baseFontSize='10'><categories><category name='Timestamp'/></categories><dataset color='00dd00' seriesName='' showValues='0' alpha='100' anchorAlpha='0' lineThickness='2'><set value='0' /></dataset></chart>"
%>
    <td><div align="center">
<% 
					if equipname(i) = "Pump Control Status" then
%> 
                              Setting of Local / Remote is performed at actual site.
				<% else %> 
                              <a href="SetPumpOn.aspx">Set Pump On</a>
				<% end if %>
	</div></td>
</tr>                        
<tr>
	<td><div align="center">
<% 
					if equipname(i) = "Pump Control Status" then
%>
                              Setting of Local / Remote is performed at actual site. 
                 <% else %> 
                                <a href="SetPumpOff.aspx">Set Pump Off</a>
                 <%	end if %>
                              
    </div></td>
</tr>
<tr><td colspan=2><div align="center" onClick="show_indicator()">KLASS</div></td></tr>
</table>
<!-- <p>&nbsp;</p> -->
<!-- PUMP CONTROL -->
<%
end if	
next i
%>