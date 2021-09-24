<%@ Page Language="VB" Debug="true"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Public strConn = ConfigurationSettings.AppSettings("DSNPG")
    'Public TM_Conn = "DSN=TM;UID=tmp;PWD=tmp;"
    Public Finaldate As String
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim StrDate
        Dim enddate As Date
        Dim da As String
        Dim tdays As String
        Dim cr
        Dim ck
        
            
        Dim lab = Request.QueryString("lab")
        Dim StrSiteName = Request.QueryString("sitename")
        Dim strSiteId = Request.QueryString("siteid")
        StrDate = Request.QueryString("date")
        txt1.Text = StrDate
        
        Dim strweek As Date = txt1.Text
        Dim DayStr As String = strweek.Month
        If DayStr.Length = 1 Then
            cr = "0" & strweek.Month
            tdays = strweek.DaysInMonth(strweek.Year, cr)
            enddate = strweek.AddDays(6)
            ck = "0" & enddate.Month
        Else
            cr = strweek.Month
            tdays = strweek.DaysInMonth(strweek.Year, cr)
            enddate = strweek.AddDays(6)
            ck = enddate.Month
        End If
        
        
        da = enddate.Day
        If da.Length = 1 Then
            da = "0" & enddate.Day
        Else
            da = enddate.Day
        End If
        
        If enddate.Year = strweek.Year Then
            
            If ck = cr Then
                If enddate.Day <= tdays Then
                    Finaldate = enddate.Year & "/" & ck & "/" & da
                    txt2.Text = Finaldate
                End If
            Else
                Finaldate = strweek.Year & "/" & cr & "/" & tdays
                txt2.Text = Finaldate
            End If
        Else
            Finaldate = strweek.Year & "/" & cr & "/" & strweek.Day
            txt2.Text = Finaldate
        End If
        
        'If GetSiteComment(strConn, strSiteId) = "TM SERVER" Then
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

        Dim str As String = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MIN(value) AS maxpressure,position FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and  to_char(sequence, 'yyyy/mm/dd')>='" & StrDate & "' and to_char(sequence, 'yyyy/mm/dd')<='" & txt2.Text & "' and position='2'  GROUP BY to_char(sequence, 'yyyy/mm/dd'),position order by sequence "
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
            RW(4) = "<a href='DailyTrendDetails.aspx?date=" & dr(0) & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Graphical</a>" & "  " & "<a href='DailyDetailsOne.aspx?date=" & dr(0) & "&lab=" & Request.QueryString("lab") & "&siteid=" & Request.QueryString("siteid") & "&sitename=" & Request.QueryString("sitename") & "'>Tabular</a>"
            dt.Rows.Add(RW)
        End While
        con.Close()

        'str = "SELECT to_char(sequence,'yyyy/mm/dd') as sequence,MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal,MIN(value) AS minpressure,MAX(value) AS maxpressure FROM telemetry_log_table WHERE (siteid = '" & strSiteId & "') and  to_char(sequence, 'yyyy/mm/dd')>='" & StrDate & "' and to_char(sequence, 'yyyy/mm/dd')<='" & txt2.Text & "' and position='1' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence "
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
        
      
        ''Response.Write(StrDate + " To ")
        ''Response.Write(Finaldate + " : ")
        ''Response.Write("   Report  ")
        
               
        ''Me.SqlDataSource1.SelectCommand = "SELECT MIN(value) AS minval, MAX(value) AS maxval, (round(cast(SUM(value) as numeric),3)) AS TotVal, to_char(sequence,'yyyy/mm/dd') AS sequence FROM telemetry_log_table WHERE (siteid='" & strSiteId & "') and  to_char(sequence, 'yyyy/mm/dd')>='" & StrDate & "' and to_char(sequence, 'yyyy/mm/dd')<='" & txt2.Text & "' GROUP BY to_char(sequence, 'yyyy/mm/dd') order by sequence"
        ' ''SELECT MIN(value) AS minval, MAX(value) AS maxval, SUM(value) AS TotVal,to_char(sequence,'yyyy/mm/dd') as sequence FROM telemetry_log_table WHERE (siteid = '" & StrSiteId & "') GROUP BY to_char(sequence, 'yyyy/mm/dd')order by sequence 
        ''Me.GridView1.DataSourceID = "SqlDataSource1"
        
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
    <title>Week Details</title>
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
    <table cellspacing="0" cellpadding="0" border="0"  style="position: absolute; font-family:Verdana; font-size:0.2in; width:97%; height:15%; color:white; font-weight:bolder ">
    <tr>
      <td colspan="3" style="background-color:#aab9fd" align=center>      
         Week Summary Details </td>
         </tr>
         <tr>
         <td colspan="1" style="background-color:#aab9fd"  align="left">Site Name: <%=Request("sitename")%>  </td>
         <td colspan="1" style="background-color:#aab9fd" align="right"> Site ID:  <%=Request("siteid")%> </td>
    </tr>
    <tr>
      <td colspan="3" style=" font-size:0.15in; width: 100%; background-color:#aab9fd" > 
         <p align="center">  
          From :
         <%=String.Format("{0:yyyy/MM/dd }", Date.Parse(Request.QueryString("date")))%>  To  <%=String.Format("{0:yyyy/MM/dd }", Finaldate)%> 
        </p>
    </td>
    </tr>  
    </table><br />
    <br />    
    <div style="left: 8px; width: 704px; position: absolute; top: 100px; height: 210px">
                &nbsp; &nbsp; &nbsp;
                
                
                <asp:GridView ID="GridView1" BackColor="#aab9fd" EnableViewState="False"   runat="server" ForeColor="Black" AutoGenerateColumns=False 
                    Width="728px" DataMember="DefaultView" CellSpacing="1" GridLines="None" >
                    <RowStyle Font-Names="Verdana" Font-Size="10pt" BackColor="white" HorizontalAlign="Center" />
                    <PagerStyle VerticalAlign="Middle" />
                    <HeaderStyle Font-Names="Tahoma" BackColor="white" Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" />
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
               
                
                 <asp:Image Id="imgdata" runat="server" ImageUrl="~/images/NoDataWide.jpg" Visible="False" Height="120px" Width="368px" />
                
                
                
                <p align="center"><a href="javascript:history.back();" target="main"><img border="0" src="../images/Back.jpg"></a></p>
                <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>--%>
           
            </div>
        <asp:TextBox ID="txt1" runat="server" Visible="False"></asp:TextBox><br />
        <asp:TextBox ID="txt2" runat="server" Visible="False"></asp:TextBox>
       </div>
       <div id="map" style="position: absolute; left: 288px; top: 264px;">
            <img alt="loading" src="../images/loading.gif" />&nbsp;<b style="color: Red; font-family: Verdana;
                font-size: small; ">Loading...</b>
            </div>
    </form>
</body>
</html>
