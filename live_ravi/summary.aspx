<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<script runat="server">
    Public arr1 As New ArrayList, arr2 As New ArrayList, arr As New ArrayList, objConn, newarr As Array
    Public objConn2 = New ADODB.Connection()
    Public sqlRs2 = New ADODB.Recordset()
    Public i As Integer
    Public Function removedist(ByVal arr, ByVal count, ByVal i)
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                    Response.Write(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    End Function

    Sub Application_OnStart()
        Application("distcont") = arr.Count
      
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        'distcount.Text=<%arr.count%>
    End Sub
</script>

<html>
<head>

<!--#include file="table_style.inc"-->
<%  
    Dim objConn
    Dim strConn
    Dim s, s1, i, u
    Dim sqlRs, st
    Dim uid = Request.QueryString("StrUserID")
    strConn = ConfigurationSettings.AppSettings("DSNPG")
    objConn = New ADODB.Connection()
    sqlRs = New ADODB.Recordset()
    objConn.open(strConn)

    If uid = 116 Then
        st = "select control_district from telemetry_user_table where userid=" & 116
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        sqlRs.close()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
       
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
        distcount.Text = arr.Count
        '''' 'Try
        'Dim a As String
        'a = distcount.Text
        'Response.Redirect("graphs.aspx?a=" & a)
        ' '' ''Catch ex As Exception
        ' '' ''    Label1.Text = ex.Message
        ' '' ''End Try
        
        
    ElseIf uid = 120 Then
        st = "select control_district from telemetry_user_table where userid=" & 120
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        sqlRs.close()
        'Call removedist()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    ElseIf uid = 124 Then
        st = "select control_district from telemetry_user_table where userid=" & 124
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
       
        sqlRs.close()
        'Call removedist(arr, arr.Count, i)             
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
        
    ElseIf uid = 125 Then
        st = "select control_district from telemetry_user_table where userid=" & 125
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
          
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        
        sqlRs.close()
        'Call removedist(arr, i)
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    ElseIf uid = 126 Then
        st = "select control_district from telemetry_user_table where userid=" & 126
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        
        sqlRs.close()
        '    Call removedist(arr, arr.Count, i)
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
        
    ElseIf uid = 129 Then
        st = "select control_district from telemetry_user_table where userid=" & 129
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
        
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        
        sqlRs.close()
        'Call removedist()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    ElseIf uid = 130 Then
        st = "select control_district from telemetry_user_table where userid=" & 130
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        sqlRs.close()
        'Call removedist()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    ElseIf uid = 131 Then
        st = "select control_district from telemetry_user_table where userid=" & 131
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        sqlRs.close()
        'Call removedist()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    ElseIf uid = 9 Then
        st = "select control_district from telemetry_user_table where userid=" & 9
        sqlRs.Open(st, objConn)
        If Not sqlRs.eof Then
            Do Until sqlRs.EOF
                s = sqlRs("control_district").value
                sqlRs.MoveNext()
            Loop
            s1 = "All," & s
            Dim split1 = s1.Split(",")
            Dim spit
            For i = 0 To split1.length - 1
                spit = split1(i)
                arr.Add(spit)
            Next
        End If
        sqlRs.close()
        'Call removedist()
        Dim l As Integer
        Dim st1 As String, t As String
        For l = 0 To arr.Count - 1
            t = arr.Item(l)
            If t = "All" Then
            Else
                st1 = "select sitedistrict from telemetry_site_list_table where sitedistrict='" & t & "'"
                sqlRs2.Open(st1, objConn)
                Dim k As String
                If Not sqlRs2.eof Then
                    k = sqlRs2("sitedistrict").value
                    arr1.Add(k)
                Else
                    arr2.Add(t)
                End If
                sqlRs2.close()
            End If
        Next
        For i = 0 To arr2.Count - 1
            arr.Remove(arr2(i))
        Next
    End If
    objConn.close()
  
    %>

</head>
<body onresize="resizing_trends('trends');" scroll="no">
<script type="text/javascript" src="table.js"></script>
<script type="text/javascript" src="url.js"></script>

<div id="header"></div>

	<div id="xloading">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
	<div class="xboxcontent"><img style="position:absolute;top:13px;left:9px; z-index: 102;" border="0" src="../images/loading.gif">
        
        <span id="loading_text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Retrieving data...</span></div>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>	
	<div id="xlogo">
	<b class="xtop"><b class="xb1"></b><b class="xb2"></b><b class="xb3"></b><b class="xb4"></b></b>
		<%  If uid = 126 Then %>
	      <div class="xboxcontent"><img border="0" src="../images/LABUAN.GIF" id="IMG">
              <asp:TextBox ID="distcount" runat="server" Style="z-index: 100; left: 747px; position: absolute;
                  top: 5px" Visible="False"></asp:TextBox>
              <asp:Label ID="Label1" runat="server" Style="z-index: 107; left: 130px; position: absolute;
                  top: 0px" Text="Label" Width="103px"></asp:Label>
          </div>
          <% ElseIf uid = 124 Then%>  
          <div class="xboxcontent"><img border="0" src="../images/SELANGOR.GIF" id="IMG1" style="width: 206px" ></div>
	  <%  End If%>
	  <%  If uid = 116 Then%>	
        <div class="xboxcontent"><img border="0" src="../images/AKSBADMIN.GIF" id="IMG2" style="width: 203px"></div>
      <% ElseIf uid = 120 Then%>  
         <div class="xboxcontent"><img border="0" src="../images/JBAN9ADMIN.GIF" id="IMG3" style="width: 209px" >&nbsp;</div>           
	  <%  End If%>
	  <%  If uid = 125 Then%>
	        <div class="xboxcontent"><img border="0" src="../images/SABAH.GIF" id="IMG4" style="width: 216px"></div>
	  <%  End If%>	  
	  <%  If uid = 9 Then%>
	      <div class="xboxcontent"><img border="0" src="../images/LAKUADMIN.gif" id="IMG5"></div>
      <% ElseIf uid = 129 Then%>  
          <div class="xboxcontent"><img border="0" src="../images/PERAKADMIN.GIF" id="IMG6" style="width: 206px" ></div>
	  <%  End If%>	    
	  <%  If uid = 130 Then%>
	      <div class="xboxcontent"><img border="0" src="../images/PHGADMIN.GIF" id="IMG7" style="width: 209px"></div>
      <% ElseIf uid = 131 Then%>  
          <div class="xboxcontent"><img border="0" src="../images/SWKADMIN.GIF" id="IMG8" style="width: 206px" ></div>
	  <%  End If%>
	  
	  
	<%--<div class="xboxcontent"><img border="0" src="../images/logo_small.jpg" id="IMG1" runat="server"></div>	--%>
	<b class="xbottom"><b class="xb4"></b><b class="xb3"></b><b class="xb2"></b><b class="xb1"></b></b>
	</div>
	<div id="live_logo"><img border="0" src="live.png" ></div>
<%--	<div id="beta_logo" onclick="alert(change2bit(flag1) + ' ' + change2bit(flag2) + ' ' + change2bit(flag3));">BETA</div>--%>
<form name="formX" action="TrendDetails.aspx" method="POST">
<%--<asp:TextBox ID="distcount1" Style="z-index: 106; left: 117px; position: absolute;
            top: 366px" runat="server"></asp:TextBox>--%>
          <div style="position:absolute;top:1px;left:2px; z-index: 103;"></div>
<div class="report_select" id="report_select">
    <div class="title" id="report_title">Reservoirs Incoming Log Data Table for</div>
    <div class="left_arrow" onclick="rotate_report(-1);"><img src="../images/leftwhite.gif"></div>
    <div class="box" id="report_type">Status</div>
    <div class="right_arrow" onclick="rotate_report(1);"><img src="../images/rightwhite.gif"></div>
</div>
<div class="district_select" id="district_select">
	<div class="title">District</div>
	<%--<div class="left_arrow" onclick="district_retrive(-1);submission();"><img src="../images/leftwhite.gif"></div>--%>
    <div class="left_arrow" onclick="rotate_district(-1);submission();"><img src="../images/leftwhite.gif"></div>
    <div class="box" id="district">Select District</div>
    <%--<div class="right_arrow" onclick="district_retrive(1);submission();"><img src="../images/rightwhite.gif"></div>--%>
    <div class="right_arrow" onclick="rotate_district(1);submission();"><img src="../images/rightwhite.gif"></div>
</div>

<div class="date_select">	
	<div class="box1" id="SelectDate"></div>
	<div class="box2" id="ShowedDate" onclick="fetch_datatable();"></div>    
</div>

<div class="submission_box" onclick="submission();" style="visibility:hidden"><img src="../images/Submit_s.jpg" border=0></div>
<div class="print_box" onclick="print_the_frame();"><img src="../images/print.jpg" border=0></div>
</form>
<div id="trends"></div><IFRAME id="_excel" name="_excel" style="width:100px;height:100px;position:absolute;top:35px;left:76px;display:none; z-index: 104;" frameborder=0 scrolling=yes marginwidth=0 src="about:blank" marginheight=0></iframe>
<div id="footnote" style="position:absolute;top:90px;right:5px; z-index: 105;">*daily, weekly & monthly selection based on hourly logged data.<br /> Daily data logged between 0:00 to 23:59.</div>
<div id="tempo" style="position:absolute;top:1px;right:1px;visibility:hidden; z-index: 106;">ssssssssssss</div>
</body>
</html>
<script language="javascript">

var xmlHttpfeed_1;
var running = false;
var requesting = false;
var the_fetch;
var time,value,status;
var uid='<%=uid%>';
resizing_trends('trends');
var newarr=new Array();
<%for k as int16=0 to arr.count-1%>
newarr.push('<%=arr(k)%>');
 <%next%>;
window.onload = load_firstDate;
</script>