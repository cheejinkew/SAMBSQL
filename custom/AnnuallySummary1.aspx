<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Public StrSiteId As String
    Public StrSiteName As String
    Public strConn = ConfigurationSettings.AppSettings("DSNPG")
    ' Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        StrSiteId = Request.QueryString("siteid")
        StrSiteName = Request.QueryString("sitename")
            
        
        Dim dt As New Data.DataTable
        Dim dr As Data.Odbc.OdbcDataReader
        Dim RW As Data.DataRow
        dt.Columns.Add("Date")
        dt.Columns.Add("Min Flow Rate (m3 /h)")
        dt.Columns.Add("Max Flow Rate (m3 /h)")
        dt.Columns.Add("Total Inflow (m3)")
        'dt.Columns.Add("Min pressure(bar)")
        'dt.Columns.Add("Max pressure(bar)")
        
        'If GetSiteComment(strConn, StrSiteId) = "TM SERVER" Then
        '    strConn = TM_Conn
        'End If
      
        Dim con As New Data.Odbc.OdbcConnection(strConn)

        Dim str As String = "SELECT to_char(sequence,'yyyy') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,position FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='2'  GROUP BY to_char(sequence, 'yyyy'),position order by sequence desc "
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
            dt.Rows.Add(RW)
        End While
        con.Close()

        'str = "SELECT to_char(sequence,'yyyy') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') and position='1' GROUP BY to_char(sequence, 'yyyy') order by sequence desc"
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

        
        
        
        ''Dim str As String = "SELECT MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal, to_char(sequence, 'yyyy') as sequence FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "')  GROUP BY to_char(sequence, 'yyyy') order by sequence "
        ''SqlDataSource1.SelectCommand = str
        ''Me.GridView1.DataSourceID = "SqlDataSource1"
        ''If GridView1.Rows.Count = 0 Then
        ''    imgdata.Visible = True
        ''Else
        ''    imgdata.Visible = False
        ''End If
        ''Response.Write(Me.GridView1.Columns(7).HeaderText())
        ''Response.Write(StrSiteName)
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
    <title>Annually Summary</title>
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
    <img src="../images\anually_sum_report.jpg" style="left: 128px; position: absolute; top: 16px; width: 440px; height: 40px;" />
    
        <div style="left: 8px; width: 632px; position: absolute; top: 80px; height: 200px">
            &nbsp; &nbsp; &nbsp;
            <table border="0" style="left:8px; position: absolute; top: 16px;" id="tb1"><tr>
           <td style="left:16px"><b>SiteName :</b></td>
            <td  style="width: 350px"><%=StrSiteName %></td>
            <td style="left:16px"><b>SiteID :</b></td>
            <td  style="width: 165px"><%=StrSiteId%></td>
            </tr>
            </table><br /><br /><br />
            
            
            
            
            <asp:GridView ID="GridView1" BackColor="#aab9fd" EnableViewState="False"   runat="server" CaptionAlign="Left" ForeColor="Black" AutoGenerateColumns=False 
                    Width="680px" DataMember="DefaultView" CellSpacing="1" GridLines="None"  >
                    <RowStyle Font-Names="Verdana" Font-Size="10pt" BackColor="white" HorizontalAlign="Center" />
                    <PagerStyle VerticalAlign="Middle" />
                    <HeaderStyle Font-Names="Tahoma" BackColor="white" Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"  >
                            <ItemStyle Width="100px" />
                            <HeaderStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Min Flow Rate (m3 /h)" HeaderText="Min Flow Rate (m3 /h)" SortExpression="Min Flow Rate (m3 /h)" />
                        <asp:BoundField DataField="Max Flow Rate (m3 /h)" HeaderText="Max Flow Rate (m3 /h)" SortExpression="Max Flow Rate (m3 /h)"  />
                        <asp:BoundField DataField="Total Inflow (m3)" HeaderText="Totalizer (m3)" SortExpression="Total Inflow (m3)"  />
                       <%-- <asp:BoundField DataField="Min pressure(bar)" HeaderText="Min pressure(bar)" SortExpression="Min pressure(bar)"  />
                        <asp:BoundField DataField="Max pressure(bar)" HeaderText="Max pressure(bar)" SortExpression="Max pressure(bar)"  />--%>
                        
                      
                    </Columns>
                    
                </asp:GridView>
                      
           <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>--%>
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
