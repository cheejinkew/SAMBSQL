<%@ Page Language="VB" Debug="true" %>
<script runat="server">
    Dim strControlDistrict As String
    Dim ds As System.Data.DataSet
    
    Dim strBeginDate
Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim arryControlDistrict
        Dim j As Integer
        
        Try
            If Page.IsPostBack = False Then
                
                strBeginDate = Now().ToString("yyyy-MM-dd")
            
                For j = 0 To 23
                    If j <= 9 Then
                        time.Items.Add("0" & j)
                    Else
                        time.Items.Add(j)
                    End If
                    
                Next
                For j = 0 To 59
                    If j <= 9 Then
                        Min.Items.Add("0" & j)
                    Else
                        Min.Items.Add(j)
                    End If
                    
                Next
                arryControlDistrict = "Batu Pahat,Johor Bahru,Kluang,Kota Tinggi,Mersing,Muar,Pontian,Segamat"
                arryControlDistrict = Split(arryControlDistrict, ",")
                Dim i As Integer
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
				
				dim strConn = ConfigurationSettings.AppSettings("DSNPG")
				dim objConn = New ADODB.Connection()
				dim sqlRs = New ADODB.Recordset()
				
				objConn.open(strConn)
				
				'response.write("opened ")
				
				'dim i=1
                'ds = New System.Data.DataSet
                If arryControlDistrict(0) <> "ALL" Then
                    'ds = obj.CALL_PROC_SP("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") ORDER BY sitedistrict")
					sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") ORDER BY sitedistrict",objConn)
                Else
                    'ds = obj.CALL_PROC_SP("SELECT distinct(sitedistrict) from telemetry_site_list_table ORDER BY sitedistrict")
					sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table ORDER BY sitedistrict",objConn)
                End If
				'response.write("connected ")
              
                DropDownList1.Items.Add("BPH")
                DropDownList1.Items.Add("RESERVOIR")
                DropDownList1.Items.Add("WTP")
				Do While Not sqlRs.EOF
					DropDownList1.Items.Add(sqlRs("sitedistrict").value)
					sqlRs.movenext()
				Loop
				sqlRs.close()
				objConn.close()
		
                ' If ds.Tables(0).Rows.Count > 0 Then
                    ' For i = 0 To ds.Tables(0).Rows.Count - 1
                        ' DropDownList1.Items.Add(ds.Tables(0).Rows(i).Item(0))
                    ' Next
                   
                    ' DropDownList1.SelectedValue = "BPH"
                    ' ds.Dispose()
                ' End If
            End If
        Catch ex As Exception
			Response.Write("ERROR: "& ex.Message)
        End Try
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> SAJ Incoming data Report</title>
<!--#include file="report_style.inc"-->
<style type="text/css">
div#divWait
  {
  font-family:Verdana;
  font-size:8pt;
  color:red;
  vertical-align:middle;
  }
  

</style> 


<style type="text/css">

.drag{
position:relative;
cursor:hand;
z-index: 100;
}

</style>

<script  src="popupCtrl.js" type="text/javascript">
</script>

</head>

<body onresize="resizing_trends('trends');" scroll="no">
<script type="text/javascript" src="Kalendar.js"></script>
<script type="text/javascript" src="report.js"></script>
<script type="text/javascript" src="url.js"></script>
<div id="header"></div>
<form name="formX"  method="POST" runat="server" action="datatable_main.aspx">
<script  type="text/javascript">DrawCalendarLayout();</script>
     
<div style="position:absolute;top:8px;left:5px;"><img alt="0" border="0" src="images/report.jpg"/></div>
<div class="dist_select" style="position:absolute;top:8px;left:50px;">
	<div class="title"><font face="Verdana" size="1" color="#5F7AFC"><b>Select District:</b></font></div>
	<div class="Dropdown" id="Dropdown"><asp:DropDownList ID="DropDownList1" runat="server" Font-Bold="True" ForeColor="Blue" Width="124px"  >
   </asp:DropDownList>
        
        
        </div>
   
</div>
<div class="report_select" id="report_select">
    <div class="title">
    <table>
        <tr>
            <td style="font-size:12px;">Hrs:</td>
            <td><asp:DropDownList ID="time" runat="server" Font-Bold="true" ForeColor="blue" Width="40px"></asp:DropDownList></td>
            <td style="font-size:12px;">Min:</td>
            <td><asp:DropDownList ID="Min" runat="server" Font-Bold="true" ForeColor="blue" Width="40px"></asp:DropDownList></td>
        </tr>
    </table>       
    </div>
</div>



<div class="date_select" id="dateselect">
	<div class="title"><font face="Verdana" size="1" color="#5F7AFC"><b>Select a Date:</b></font></div>
	<div class="box" id="SelectDate"></div>
    <div class="cal" onclick="ShowCalendar('SelectDate', 300, 50);"><img border="1" src="images/Calendar.jpg" width="19" height="14" /></div>
</div>

<div class="submission_box" onclick="submission();"><img src="images/Submit_s.jpg" border="0" id="IMG1"/></div>
<div class="saveexcel_box" onclick="save2excel();"><img src="images/SaveExcel.jpg" border="0" /></div>
<div class="print_box" onclick="print_the_frame();"><img src="images/print.jpg" border="0" /></div> 
</form>
<div id="trends"></div><IFRAME id="_excel" name="_excel" style="width:100px;height:100px;position:absolute;top:3px;left:4px;display:none;" frameborder=0 scrolling=yes marginwidth=0 src="datatable_load.aspx" marginheight=0></iframe>

<div  align=center   id="mydiv"  style="position:relative;background:#ffffff; top:122px; height:150px;  display:none;width: 200px; left: 120px;z-index: 100;"    >
<table border="0"   bgcolor=LightSteelBlue  >
  
 <tr>
        <td id="dragbar" style="cursor:hand; cursor:pointer; height: 10px;" width="100%" onMousedown="initializedrag(event)">
        <ilayer width="100%" onSelectStart="return false"><layer width="100%" onMouseover="dragswitch=1;if (ns4) drag_dropns(mydiv)" onMouseout="dragswitch=0"><font face="Verdana"
        color=black size="2"><b>Contacts</b></font></layer></ilayer></td>
        <td style="cursor:hand; height: 10px; width: 10px;"><a href="#" onclick="window.parent.closediv();"><img src="images/cross.gif" border=0 style="width: 10px; height: 10px"></a></td>
      </tr>

<tr>
<td colspan="2"  align=center >
 <iframe    id="frmSrc" style="width:500px; height:270px " src="Contacts.aspx"  >
 </iframe>
</td>
</tr>
</table>
</div>
</body>
</html>

<script language="javascript" type="text/javascript">
var now = new Date();
document.getElementById("SelectDate").innerHTML="<%=strBeginDate%>"; 
//document.getElementById("time").value=now.getHours();

//alert(now.getHours());

resizing_trends('trends');
submission();
</script>