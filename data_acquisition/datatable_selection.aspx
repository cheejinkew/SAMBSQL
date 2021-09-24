    <%@ Page Language="VB" Debug="true" %>

<script runat="server">
    Dim strControlDistrict As String
    Dim ds As System.Data.DataSet
    Dim obj As New Methods
   Dim strconn
	

Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim arryControlDistrict
        dim GetCon as integer = 0


         Dim userid =Request.QueryString("uid")
        'Dim strconn = ConfigurationSettings.AppSettings("DSNPG1")
  
          if userid = "28" then 
            
              
                strconn = ConfigurationSettings.AppSettings("DSNPG1")
                GetCon = 0
            else 
            
                strconn = ConfigurationSettings.AppSettings("DSNPGI")
                GetCon = 1
                  
	        end if


        Try
            If Page.IsPostBack = False Then
				if userid = "" then
					arryControlDistrict = "Jasin,Melaka Tengah,Alor Gajah"
				else
					arryControlDistrict = GetDistrict(strconn, userid)
				end if
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
                ds = New System.Data.DataSet
                If arryControlDistrict(0) <> "ALL" Then
                    ds = obj.CALL_PROC_SP("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ")")
                Else
                    ds = obj.CALL_PROC_SP("SELECT distinct(sitedistrict) from telemetry_site_list_table")
                End If
                
                If ds.Tables(0).Rows.Count > 0 Then
                    For i = 0 To ds.Tables(0).Rows.Count - 1
                        DropDownList1.Items.Add(ds.Tables(0).Rows(i).Item(0))
                    Next
                    ds.Dispose()
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub
	
Function GetDistrict(strconn As String,strUser As String) As String   
   Dim nOConn
   Dim RS
   Dim Words
   nOConn = new ADODB.Connection()
   RS = new ADODB.Recordset()   
   nOConn.open(strConn)
   
   RS.open("select control_district from telemetry_user_table where userid='" & _
	        strUser & "'", nOConn)   
   
   if not RS.eof then   
		do until RS.EOF
				Words = RS("control_district").value
				RS.MoveNext
		loop
		'Words = Words.Replace(",", "|,|")
   end if
   
   GetDistrict = Words
   
   RS.close
   nOConn.close
   RS = nothing
   nOConn = nothing
   
End Function
</script>

<html>
<head>

<!--#include file="report_style.inc"-->

<title>Telemetry SMS Data Acquisition Table</title>
</head>
<body onresize="resizing_trends('trends');" scroll="no">
<script type="text/javascript" src="Kalendar.js"></script>
<script type="text/javascript" src="report.js?r=1"></script>
<script type="text/javascript" src="url.js"></script>
<div id="header"></div>
<form name="formX"  method="POST" runat=server>
<script lanaguage="javascript">DrawCalendarLayout();</script>

<div style="position:absolute;top:8px;left:5px;visibility:hidden" onclick="javascript:history.back();"><img border="0" src="../images/report.jpg"></div>
<div class="dist_select" style="position:absolute;top:8px;left:50px;">
	<div class="title"><font face="Verdana" size="1" color="#5F7AFC"><b>Select District:</b></font></div>
	<div class="Dropdown" id="Dropdown"><asp:DropDownList ID="DropDownList1" runat="server" Font-Bold="True" ForeColor="Blue" Width="124px"  >
    <asp:ListItem Value ="Jasin">Jasin</asp:ListItem>
    <asp:ListItem Value ="Melaka Tengah">Melaka Tengah</asp:ListItem>
    <asp:ListItem Value ="Alor Gajah">Alor Gajah</asp:ListItem>

   </asp:DropDownList>
        &nbsp;</div>
   
</div>
<div class="report_select" id="report_select">
    <div class="title">
        Report:</div>
    <div class="left_arrow" onclick="rotate_report(-1);"><img src="../images/leftwhite.gif"></div>
    <div class="box" id="report_type" >12:00AM-8:00AM</div>
    <div class="right_arrow" onclick="rotate_report(1);"><img src="../images/rightwhite.gif"></div>
</div>

<div class="date_select" id=dateselect>
	<div class="title"><font face="Verdana" size="1" color="#5F7AFC"><b>Select a Date:</b></font></div>
	<div class="box" id="SelectDate"></div>
    <div class="cal" onclick="ShowCalendar('SelectDate', 300, 50);"><img border="1" src="../images/Calendar.jpg" width="19" height="14"></div>
</div>

<div class="submission_box" onclick="submission();"><img src="../images/Submit_s.jpg" border=0 id="IMG1"></div>
<div class="saveexcel_box" onclick="save2excel();"><img src="../images/SaveExcel.jpg" border=0>&nbsp;</div>
<div class="print_box" style="visibility:hidden;" onclick="print_the_frame();"><img src="../images/print.jpg" border=0>
    </div>
</form>
<div id="trends"></div><IFRAME id="_excel" name="_excel" style="width:100px;height:100px;position:absolute;top:0;left:0;display:none;" frameborder=0 scrolling=yes marginwidth=0 src="about:blank" marginheight=0></iframe>
<div id="back" style="top:3px;left:3px" onclick="window.location='http://www.g1.com.my/extension/total_monitoring/menu.html?tab=1';" title="back to menu!"></div>
</body>
</html>
<script language="javascript">

resizing_trends('trends');
load_firstDate();


</script>