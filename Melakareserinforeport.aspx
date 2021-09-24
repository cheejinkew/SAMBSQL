<%@ Page Language="VB" Debug="true" %>
<!--#include file="../kont_id.aspx"-->
<%@ Import Namespace="ADODB" %>

<script runat="server">
    Dim okmessage
    Dim ar() As String = {"Tangki Air Bkt.Perah k.Berang", "Tangki Air Bkt.Perah k.Berang(ADJV)", "Tangki Air Bkt.Perah Ajil", "Tangki Air Kejir", "Tangki Air FELDA Bukit Bading", "Tangki Air FELDA Jerangau", "Tangki Air Bukit Batu Beragaram", "Tangki Air Tadok", "Tangki Air Bulkit Kulim", "Tangki Air lerak", "Tangki Air Bukit Kepah", "Tangki Air Payong", "Tangki Air  Mardi", " FELDA Tersat", "Tangki Air FELDA Tersat", " Tangki Air Mengkawang", "Tangki Air Gawi", "Tangki Air Bukilt Jalin", "Tangki Air Bukit Lada", " Tangki Air FELDA Cador", "Tangki Air TOK Randok", "Tangki Air kUALA tELEMONG", "Tangki Air pENGKALAN uTAMA"}
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Button2.Attributes.Add("Onclick", "javascript:btnprintfun();")
        Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
        Dim objConn
        Dim sqlRs As ADODB.Recordset
        Dim strDistrict
        If Page.IsPostBack = False Then
            Dim s As String
          
            Dim i
            Dim strControlDistrict
   
            Dim arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
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
            
            ' ddsite.Items.Add(New ListItem("-Select Site--", "0"))
            dddistrict.Items.Add(New ListItem("-Select District--", "0"))
            objConn = New ADODB.Connection()
            sqlRs = New ADODB.Recordset()
            objConn = New ADODB.Connection()
            'objConn.open(strConn)
            'If arryControlDistrict(0) <> "ALL" Then
            '    sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ")", objConn)
            'Else
            '    sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table", objConn)
            'End If
            
            'Do While Not sqlRs.EOF
            strDistrict = "Melaka" 'sqlRs("sitedistrict").Value
           
    
            dddistrict.Items.Add(New ListItem(strDistrict, strDistrict))
                
           

            'sqlRs.MoveNext()
            'Loop
                
            'sqlRs.Close()
            'objConn.close()
            'objConn = Nothing
        End If
    End Sub

    Protected Sub ddsite_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If dddistrict.SelectedIndex <> "0" Then
            okmessage = "ok"
        Else
            okmessage = "no"
        End If
       
        
    End Sub
</script>

<html>
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div align="center">
            <div align="center">
                <img border="0" src="images/SiteMgmt.jpg"><br />
                <br />
                &nbsp;</div>
            <div align="center">
                <font face="Verdana" size="2" color="#3952F9"><b>District:</b></font><asp:DropDownList
                    ID="dddistrict" runat="server" Width="214px" OnSelectedIndexChanged="ddsite_SelectedIndexChanged"
                    AutoPostBack="true" ForeColor="Blue">
                </asp:DropDownList><br />
                <br />
                &nbsp;</div>
            <% If okmessage = "ok" Then%>
            <table border="0" width="150%" style="font-family: Verdana; font-size: 8pt" id="ta">
                <tr style="color: #ffffff; background-color: #465ae8">
                    <th colspan="1" style="height: 15px" width="20%">
                    </th>
                    <th style="height: 15px" colspan="17" width="20%">
                        Reservoir's Info</th>
                    <th colspan="1" style="height: 15px" width="20%">
                    </th>
                </tr>
                <tr style="color: #ffffff; background-color: #465ae8">
                    <th style="height: 15px" width="20%">
                        <% =dddistrict.SelectedItem.Text%>
                    </th>
                    <th colspan="4" style="height: 15px" width="4%">
                        Dimension(Meter)</th>
                    <th style="height: 15px" width="4%">
                        Capacity</th>
                    <th colspan="4" style="height: 15px" width="4%">
                        Inlet Pipe</th>
                    <th colspan="4" style="height: 15px" width="4%">
                        Outlet Pipe</th>
                    <th style="height: 15px" width="4%">
                    </th>
                    <th style="height: 15px" width="4%">
                    </th>
                    <th style="height: 15px" width="4%">
                        Hight Of
                    </th>
                    <th style="height: 15px" width="4%">
                        Year Built</th>
                    <th style="height: 15px" width="12%">
                        Distribution Areas</th>
                </tr>
                <tr style="background-color: #465AE8; color: #FFFFFF">
                    <th width="20%" style="height: 15px">
                    </th>
                    <th width="4%" style="height: 15px" colspan="2">
                        Circular</th>
                    <th width="4%" style="height: 15px" colspan="2">
                        Square</th>
                    <th width="4%" style="height: 15px">
                    </th>
                    <th width="4%" style="height: 15px" colspan="2">
                        Pipe Size</th>
                    <th width="4%" style="height: 15px" colspan="2">
                        Zone Meter</th>
                    <th width="4%" style="height: 15px" colspan="2">
                        Pipe Size</th>
                    <th width="4%" style="height: 15px" colspan="2">
                        Zone Meter</th>
                    <th width="4%" style="height: 15px">
                        TWL</th>
                    <th width="4%" style="height: 15px">
                        BWL</th>
                    <th width="4%" style="height: 15px">
                        Tower</th>
                    <th width="4%" style="height: 15px">
                    </th>
                    <th width="12%" style="height: 15px">
                    </th>
                </tr>
                <tr style="background-color: #465AE8; color: #FFFFFF">
                    <th width="20%" style="height: 5px">
                    </th>
                    <th width="4%" style="height: 5px">
                        Type</th>
                    <th width="4%" style="height: 5px">
                        &#216;</th>
                    <th width="4%" style="height: 5px">
                        Type</th>
                    <th width="4%" style="height: 5px">
                        L*B</th>
                    <th width="4%" style="height: 5px">
                        M<sup>3</sup></th>
                    <th width="4%" style="height: 5px">
                        mm</th>
                    <th width="4%" style="height: 5px">
                        Type</th>
                    <th width="4%" style="height: 5px">
                        mm</th>
                    <th width="4%" style="height: 5px">
                        Type</th>
                    <th width="4%" style="height: 5px">
                        mm</th>
                    <th width="4%" style="height: 5px">
                        Type</th>
                    <th width="4%" style="height: 5px">
                        mm</th>
                    <th width="4%" style="height: 5px">
                        Type</th>
                    <th width="4%" style="height: 5px">
                        Meter</th>
                    <th width="4%" style="height: 5px">
                        Meter</th>
                    <th width="4%" style="height: 5px">
                    </th>
                    <th width="4%" style="height: 5px">
                    </th>
                    <th width="12%" style="height: 5px">
                    </th>
                </tr>
                <%
                    Dim intNum = 0
                    Dim cont As Int32 = 0
                    Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
                    Dim objConn
                    Dim sqlRs = New ADODB.Recordset()
          
               
                    objConn = New ADODB.Connection()
                    objConn.open(strConn)
                    sqlRs.Open("select r.*,s.sitename from reservoirinfo r,telemetry_site_list_table s where s.siteid IN ("& strKontID &") and r.siteid=s.siteid", objConn)
                    ''"select siteid, unitid, sitename, sitetype, associate " & _
                    '          " from telemetry_site_list_table " & _
                    '          " where sitedistrict ='" & strSelectedSiteDistrict & "'" & _
                    '          " order by sitetype, sitename", objConn)
             
           
                    Do While Not sqlRs.EOF
               
                        cont += 1

                        If intNum = 0 Then
                            intNum = 1

                %>
                <tr bgcolor="#FFFFFF">
                    <%
                    ElseIf intNum = 1 Then
                        intNum = 0
                    %>
                    <tr bgcolor="#E7E8F8">
                        <%
                        End If
                        %>
                        <td style="margin-left: 5" align="left">
                            <b>
                                <%=sqlRs("sitename").value%>
                            </b>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("dim_cir_type").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("dim_cir_tita").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("dim_squ_type").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("dim_squ_lb").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("capacity").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("inlet_pipe_mm").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("inlet_pipe_type").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("inlet_zone_mm").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("inlet_zone_type").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("outlet_pipe_mm").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("outlet_pipe_type").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("outlet_zone_mm").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("outlet_zone_type").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("twl_meter").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("bwl_meter").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("highoftower").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("year_built").value%>
                        </td>
                        <td style="margin-left: 5" align="center">
                            <%=sqlRs("destribution_area").value%>
                        </td>
                    </tr>
                    <%
               
                        sqlRs.movenext()
                    Loop
                    If cont > 0 Then
                        If intNum = 0 Then
                            intNum = 1

                    %>
                    <tr bgcolor="#FFFFFF">
                        <%
                        ElseIf intNum = 1 Then
                            intNum = 0
                        %>
                        <tr bgcolor="#E7E8F8">
                            <%
                            End If
                            %>
                            <td style="margin-left: 5" align="left">
                                <b>
                                    P Perhentian Besar
                                </b>
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                               -
                            </td>
                            <td style="margin-left: 5" align="center">
                               -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                               -
                            </td>
                            <td style="margin-left: 5" align="center">
                               -
                            </td>
                            <td style="margin-left: 5" align="center">
                               -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                               -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                            <td style="margin-left: 5" align="center">
                                -
                            </td>
                        </tr>
                        <%
                        End If
                        sqlRs.close()
                        objConn.close()
                        sqlRs = Nothing
                        objConn = Nothing
                        %>
            </table>
        </div>
        <div align="center">
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" Text="Print" /></div>
        <%End If%>
    </form>
</body>

<script language="javascript">
function btnprintfun()
		{
			var winvalue;
			winvalue=window.document.body.innerHTML;
			window.document.body.innerHTML=document.form1.all["ta"].innerHTML;
			window.print();
			window.document.body.innerHTML=winvalue;
			return false;
		}
</script>

</html>
