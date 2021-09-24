<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Public StrSiteId As String
    Public StrSiteName As String
    Public StrDate As String
    Public lab As String
    Public dis As String
    Public strConn = ConfigurationSettings.AppSettings("DSNPG")
    'Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        lab = Request.QueryString("lab")
        'dis = Request.QueryString("root")
        StrSiteId = Request.QueryString("siteid")
        StrSiteName = Request.QueryString("sitename")
        'StrDate = Request.QueryString("date")
       
        'If GetSiteComment(strConn, StrSiteId) = "TM SERVER" Then
        '    strConn = TM_Conn
        'End If
        
        Dim dt As New Data.DataTable
        Dim dr As Data.Odbc.OdbcDataReader
        Dim RW As Data.DataRow
        dt.Columns.Add("Date")
        dt.Columns.Add("Min Flow Rate (m3 /h)")
        dt.Columns.Add("Max Flow Rate (m3 /h)")
        dt.Columns.Add("Total Inflow (m3)")
        'dt.Columns.Add("Min pressure(bar)")
        'dt.Columns.Add("Max pressure(bar)")
        dt.Columns.Add("Trending")

        Dim con As New Data.Odbc.OdbcConnection(strConn)

        Dim str As String = "SELECT to_char(sequence,'yyyy/mm') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='2'  GROUP BY to_char(sequence, 'yyyy/mm'),position order by sequence desc"
        con.Open()
        Dim cmd As New Data.Odbc.OdbcCommand(str, con)
        dr = cmd.ExecuteReader()
        While (dr.Read())
            RW = dt.NewRow()
            RW(0) = dr(0)
            RW(1) = dr(1)
            RW(2) = dr(2)
            RW(3) = dr(3)
            'RW(4) = "0"
            'RW(5) = "0"
            RW(4) = "<a href='DailyTrendDetails.aspx?date=" & dr(0) & "&Ndays=" & 7 & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Graphical</a>"
            dt.Rows.Add(RW)
        End While
        con.Close()

        'str = "SELECT to_char(sequence,'yyyy/mm') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='1' GROUP BY to_char(sequence, 'yyyy/mm') order by sequence desc"
        'con.Open()
        'cmd = New Data.Odbc.OdbcCommand(str, con)
        'dr = cmd.ExecuteReader()
        'Dim count As Int16 = 0
        'While (dr.Read())
        '    dt.Rows(count)(4) = dr(4)
        '    dt.Rows(count)(5) = dr(5)
        '    count += 1
        'End While
        'con.Close()

        Me.GridView1.DataSource = dt
        GridView1.DataBind()

        If Me.GridView1.Rows.Count = 0 Then
            imgdata.Visible = True
        ElseIf GridView1.Rows.Count > 0 Then
            imgdata.Visible = False
        End If

        
        'Dim str As String = "SELECT MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal, to_char(sequence, 'yyyy/mm') AS sequence FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "')  GROUP BY to_char(sequence, 'yyyy/mm') order by to_char(sequence,'yyyy/mm') "
        'SqlDataSource1.SelectCommand = str
        'Me.GridView1.DataSourceID = "SqlDataSource1"
        'If GridView1.Rows.Count = 0 Then
        '    imgdata.Visible = True
        'Else
        '    imgdata.Visible = False
        'End If
        'Response.Write(StrSiteName)
    End Sub
    
    'Function GetSiteComment(ByVal strConn As String, ByVal strSite As String) As String
    '    Dim nOConn
    '    Dim RS
    '    nOConn = New ADODB.Connection()
    '    RS = New ADODB.Recordset()
    '    nOConn.open(strConn)

    '    RS.Open("select address from telemetry_site_list_table where siteid='" & strSite & "'", nOConn)
    '    If Not RS.EOF Then
    '        If IsDBNull(RS("address").value) = False Then
    '            GetSiteComment = Server.HtmlEncode(RS("address").value)
    '        Else
    '            GetSiteComment = ""
    '        End If
    '    Else
    '        GetSiteComment = ""
    '    End If
       

    '    RS.close()
    '    nOConn.close()
    '    RS = Nothing
    '    nOConn = Nothing

    'End Function
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Monthly Summary</title>
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
    <img src="../images\monthly_sum_report.jpg" style="left: 152px; position: absolute; top: 16px; vertical-align: middle; width: 432px; text-align: center; height: 32px;" />
    
    
        <div style="left: 16px; width: 728px; position: absolute; top: 72px; height: 176px">
            &nbsp; &nbsp; &nbsp;
          <table border="0" style="left:8px; position: absolute; top: 16px;" id="tb1">
          <tr><td style="left:16px"><b>SiteName :</b></td>
            <td  style="width: 350px"><%=StrSiteName %></td>
            <td style="left:16px"><b>SiteID :</b></td>
            <td  style="width: 165px"><%=StrSiteId%></td>
            </tr>
            </table><br /><br /><br />
            
            
            
            <asp:GridView ID="GridView1" BackColor="#aab9fd" EnableViewState="False"   runat="server" ForeColor="Black" AutoGenerateColumns=False 
                    Width="728px" DataMember="DefaultView" CellSpacing="1" GridLines="None" >
                    <RowStyle Font-Names="Verdana" Font-Size="10pt" BackColor="white"  HorizontalAlign="Center" />
                    <PagerStyle VerticalAlign="Middle" />
                    <HeaderStyle Font-Names="Tahoma"  BackColor="white" Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"  >
                            <ItemStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Min Flow Rate (m3 /h)" HeaderText="Min Flow Rate (m3 /h)" SortExpression="Min Flow Rate (m3 /h)" />
                        <asp:BoundField DataField="Max Flow Rate (m3 /h)" HeaderText="Max Flow Rate (m3 /h)" SortExpression="Max Flow Rate (m3 /h)"  />
                        <asp:BoundField DataField="Total Inflow (m3)" HeaderText="Totalizer (m3)" SortExpression="Total Inflow (m3)"  />
                        <%--<asp:BoundField DataField="Min pressure(bar)" HeaderText="Min pressure(bar)" SortExpression="Min pressure(bar)"  />
                        <asp:BoundField DataField="Max pressure(bar)" HeaderText="Max pressure(bar)" SortExpression="Max pressure(bar)"  />--%>
                         <asp:BoundField DataField="Trending" HtmlEncode="False"  HeaderText="Trending"  >
                             <HeaderStyle Width="130px" />
                             <ItemStyle Width="130px" />
                         </asp:BoundField>
                    </Columns>
                    
                </asp:GridView>
            
             <asp:Image Id="imgdata" runat="server" ImageUrl="~/images/NoDataWide.jpg" Visible="False" />
             <p align="center"><a href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p>
        </div>
    
    </div>
    <div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="../images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
            </div>
    </form>
</body>
</html>
