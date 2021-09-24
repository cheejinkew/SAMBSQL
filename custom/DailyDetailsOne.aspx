<%@ Page Language="VB" Debug="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
  
    Public strConn = ConfigurationSettings.AppSettings("DSNPG")
    ' Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"
    
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim StrDate
        Dim lab = Request.QueryString("lab")
        Dim StrSiteName = Request.QueryString("sitename")
        Dim strSiteId = Request.QueryString("siteid")
        StrDate = Request.QueryString("date")
            
        Dim dt As New Data.DataTable
        Dim dr As Data.Odbc.OdbcDataReader
        Dim RW As Data.DataRow
        dt.Columns.Add("Time")
        dt.Columns.Add("Flow Rate (m3 /h)")
        'dt.Columns.Add("Pressure  (bar)")
            
        'If GetSiteComment(strConn, strSiteId) = "TM SERVER" Then
        '    strConn = TM_Conn
        'End If
        
        Dim con As New Data.Odbc.OdbcConnection(strConn)
        
        Dim str As String = "SELECT  Distinct to_char(sequence,'HH24:MI:SS') as sequence, value as minval FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and sequence between '" & StrDate & "  " & "00:00:00""' and '" & StrDate & "  " & "23:59:59""' and position='2' group by sequence,value order by sequence"
        ' "SELECT  distinct(to_char(sequence, 'HH24:mm:ss')) AS sequence, value as minval, value as minpressure, position as position1, position as position2 FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and to_char(sequence, 'yyyy/MM/dd') ='" & StrDate & "' and position='2' group by to_char(sequence, 'HH24:mm:ss'),value,position order by to_char(sequence, 'HH24:mm:ss') desc "
        con.Open()
        Dim cmd As New Data.Odbc.OdbcCommand(str, con)
        dr = cmd.ExecuteReader()
        While (dr.Read())
            RW = dt.NewRow()
            RW(0) = dr(0)
            RW(1) = dr(1)
            'RW(2) = "0"
            dt.Rows.Add(RW)
        End While
       
        con.Close()
              
        'str = "SELECT  Distinct to_char(sequence,'HH24:MI:SS') as sequence, value as minval FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and sequence between '" & StrDate & "  " & "00:00:00""' and '" & StrDate & "  " & "23:59:59""' and position='1' group by sequence,value order by sequence"
        'con.Open()
        'cmd = New Data.Odbc.OdbcCommand(str, con)
        'dr = cmd.ExecuteReader()
        'Dim count As Int16 = 0
        'Dim i As Integer
        
        'For i = 1 To dt.Rows.Count
        '    If dr.Read() And i <= dt.Rows.Count Then
            
               
        '        dt.Rows(count)(2) = dr(2)
        '        count += 1
        '    End If
        'Next
        'If dr.Read() And i > dt.Rows.Count Then
        '    While (dr.Read())
        '        dt.Rows(count)(0) = dr(0)
        '        dt.Rows(count)(1) = ""
        '        dt.Rows(count)(2) = dr(2)
        '        count += 1
        '    End While
        'End If
       
        'con.Close()
        Me.GridView1.DataSource = dt
        Me.GridView1.DataBind()
      
        
        'Me.SqlDataSource1.SelectCommand = "SELECT Distinct value as minval, to_char(sequence, 'HH24:mm:ss') AS sequence FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and  to_char(sequence, 'yyyy/MM/dd') ='" & StrDate & "' order by sequence "
        ''SelectCommand="SELECT MIN(&quot;value&quot;) AS minval, MAX(&quot;value&quot;) AS maxval, SUM(&quot;value&quot;) AS TotVal, to_char(sequence, 'dd-Mon-yyyy') AS sequence FROM &quot;public&quot;.telemetry_log_table WHERE (siteid ='<%=strSiteId %>') GROUP BY to_char(sequence, 'dd-Mon-yyyy') ORDER BY to_char(&quot;sequence&quot;, 'dd-Mon-yyyy') "
        
        'Me.GridView1.DataSourceID = "SqlDataSource1"
        
    End Sub
    
    Function GetSiteComment(ByVal strConn As String, ByVal strSite As String) As String
        Dim nOConn
        Dim RS
        nOConn = New ADODB.Connection()
        RS = New ADODB.Recordset()
        nOConn.open(strConn)

        RS.Open("select address from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
        If Not RS.EOF Then
            If IsDBNull(RS("address").value) = False Then
                GetSiteComment = Server.HtmlEncode(RS("address").value)
            Else
                GetSiteComment = ""
            End If
        Else
            GetSiteComment = ""
        End If
       

        RS.close()
        nOConn.close()
        RS = Nothing
        nOConn = Nothing

    End Function
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>DailyDetailsOne</title>
    <script type="text/javascript" language="javascript">
   function fun()
   {
     window.setInterval("fun1()",2000);
   }
   function fun1()
   {
   document.getElementById("Map").innerHTML="";
    document.getElementById("cont").style.visibility="visible";
   }
   </script>
</head>
<body onload="fun()">
    <form id="form1" runat="server">
     <div id="cont" style="visibility:hidden;">
    <table border="0" cellspacing="0" cellpadding="0" style="position: absolute; font-family:Verdana; font-size:0.2in; width:90%; height:15%; color:white; font-weight:bolder ; left: 40px; top: 10px;">
    <tr>
      <td  style="width: 25%; background-color:#aab9fd"  colspan="2">
        <p align="center">
         Day Of <%=Request("lab")%> Summary Details</p></td>
            </tr>
             <tr> <td  style=" background-color:#aab9fd;"  align="left">Site Name: <%=Request("sitename")%></td>
        <td  style=" background-color:#aab9fd;" align="right"> Site ID: <%=Request("siteid")%>
        </td>
    </tr>
    <tr>
      <td style=" font-size:0.15in; width: 25%; background-color:#aab9fd" colspan="2"> 
         <p align="center">  
         on
         <%=String.Format("{0:yyyy/MM/dd }", Date.Parse(Request.QueryString("date")))%>  
        </p>
    </td>
    </tr>  
    </table><br />
    <br />    
        <div style="left: 165px; width: 160px; position: absolute; top: 88px; height: 192px">
          
            <asp:GridView ID="GridView1" BackColor="#aab9fd" runat="server" AutoGenerateColumns="False" CaptionAlign="Left"
                Width="300px" CellSpacing="1" GridLines="None"  >
                <Columns>
                    <asp:BoundField DataField="Time" HeaderText="Time"  SortExpression="Time" >
                        <ItemStyle Font-Names="Verdana" Font-Size="10pt" HorizontalAlign="Center" Width="30px" />
                        <HeaderStyle Font-Names="Verdana" Font-Size="10pt" Width="30px" />
                        <ControlStyle Font-Names="Verdana" Font-Size="10pt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Flow Rate (m3 /h)" HeaderText="Flow Rate (m3 /h)" SortExpression="Flow Rate (m3 /h)" >
                        <ItemStyle Width="140px" />
                    </asp:BoundField>
                    <%--<asp:BoundField DataField="Pressure  (bar)" HeaderText="Pressure  (bar)" SortExpression="Pressure  (bar)" >
                        <ItemStyle Width="140px" />
                    </asp:BoundField>--%>
                 </Columns>
                <RowStyle Font-Names="Verdana" Font-Size="10pt"
                    HorizontalAlign="Center" BackColor="White" />
                <PagerStyle VerticalAlign="Middle" />
                <HeaderStyle Font-Names="Verdana" Font-Size="10pt" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" />
            </asp:GridView>
         <div > <center><p> <a  href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p></center></div>
        </div>
    
    </div>
    <div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="../images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
            </div>
    </form>
</body>
</html>
