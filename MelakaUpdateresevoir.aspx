<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>

<script runat="server">
    Dim dimen
    Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
    Dim objConn
    Dim sqlRs As ADODB.Recordset
    Dim strDistrict
    Public strSiteDistrict
    Public vis As String = "no"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        selecting.Attributes.Add("onchange", "sele_drop();")
        
        
        Dim i
        For i = 1980 To Now.Year
            yearbuilt.Items.Add(New ListItem(i))
        Next
        
        If Page.IsPostBack = False Then
            Dim intSiteID = Request.Form("txtSiteID")
            ddsite.Items.Add(New ListItem("-Select Site--", "0"))
            'dddistrict.Items.Add(New ListItem("-Select District--", "0"))
            Call filldistrict()
            
            objConn = New ADODB.Connection()
            sqlRs = New ADODB.Recordset()
            objConn = New ADODB.Connection()
            objConn.open(strConn)
            sqlRs.Open("SELECT sitedistrict from telemetry_site_list_table where siteid='" & intSiteID & "'", objConn)
            Do While Not sqlRs.EOF
                dddistrict.SelectedValue = sqlRs("sitedistrict").Value
                sqlRs.MoveNext()
            Loop
            sqlRs.Close()
            objConn.close()
            objConn = Nothing
            
            Call fillsite(dddistrict.SelectedValue)
            ddsite.SelectedValue = intSiteID
            '  strSiteDistrict = dddistrict.SelectedValue
            objConn = New ADODB.Connection()
            sqlRs = New ADODB.Recordset()
            objConn = New ADODB.Connection()
            objConn.open(strConn)
            sqlRs.Open("SELECT *  from reservoirinfo where siteid ='" & intSiteID & "'", objConn)
                
            Do While Not sqlRs.EOF
                
                cap_m.Text = sqlRs("capacity").Value
                inlet_pipe_mm.Text = sqlRs("inlet_pipe_mm").Value
                inlet_pipe_type.Text = sqlRs("inlet_pipe_type").Value
                inlet_zone_mm.Text = sqlRs("inlet_zone_mm").Value
                inlet_zone_type.Text = sqlRs("inlet_zone_type").Value
                outlet_pipe_mm.Text = sqlRs("outlet_pipe_mm").Value
                outlet_pipe_type1.Text = sqlRs("outlet_pipe_type").Value
                outlet_zone_mm.Text = sqlRs("outlet_zone_mm").Value
                outlet_zone_type1.Text = sqlRs("outlet_zone_type").Value
                twl_meter.Text = sqlRs("twl_meter").Value
                bwl_meter.Text = sqlRs("bwl_meter").Value
                hightof.Text = sqlRs("highoftower").Value
                yearbuilt.Text = sqlRs("year_built").Value
                drstribuation.Text = sqlRs("destribution_area").Value
                ddselect.Text = sqlRs("type_id").Value
                sqlRs.MoveNext()
            Loop
                               
            Dim sqlSp1
            Dim objConn1
            objConn1 = New ADODB.Connection()
            sqlSp1 = New ADODB.Recordset()
            objConn1.open(strConn)
            sqlSp1.open("select * from res_dimension_table where siteid='" & ddsite.SelectedValue & "'", objConn1)
            Do While Not sqlSp1.EOF
                selecting.Text = sqlSp1("dimension_id").Value
                If selecting.Text = 2 Then
                    Label1.Text = "L*B"
                Else
                    Label1.Text = "Diameter"
                End If
                die_cir_type.Text = sqlSp1("dim_type").Value
                die_cir_tita.Text = sqlSp1("dim_lb").Value
                
                sqlSp1.MoveNext()
            Loop
            
                            
            Dim sqlSp2
            Dim objConn2
            objConn2 = New ADODB.Connection()
            sqlSp2 = New ADODB.Recordset()
            objConn2.open(strConn)
            sqlSp2.open("select * from res_outletpipe_table where siteid='" & ddsite.SelectedValue & "'", objConn2)
            divt.Visible = True
                Do While Not sqlSp2.EOF
                vis = "yes"
                childdata.Value = "yes"
                check1.Checked = True
                
                    TextBox1.Text = sqlSp2("outlet_pipe_mm").Value
                outlet_pipe_type2.Text = sqlSp2("outlet_pipe_type").Value
                    TextBox2.Text = sqlSp2("outlet_zone_mm").Value
                outlet_zone_type2.Text = sqlSp2("outlet_zone_type").Value
                divt.Attributes.Add("style", "visibility:visible")
                'pipe2.Attributes.Add("style", "top:1000px")
                'divt.Attributes.Add("style", "left:808px;")
                'pipe2.Attributes.Add("style", "bgcolor:lightgrey")
                'tbl.Attributes.Add("style", "left:116px;")
                'pipe2.Attributes.Add("style", "position:absolute")
                'position:absolute; left:633px; top:400px"
                    sqlSp2.MoveNext()
                Loop
                 
            objConn.close()
            objConn1.close()
            objConn2.close()
            objConn = Nothing
        End If
    End Sub
    Private Sub fillsite(ByVal s As String)
         
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        objConn = New ADODB.Connection()
        objConn.open(strConn)
        sqlRs.Open("SELECT sitename, siteid from telemetry_site_list_table where sitedistrict='" & s & "'", objConn)
        
        
               
             
        ddsite.Items.Clear()
        ddsite.Items.Add(New ListItem("-Select Site--", "0"))
        Do While Not sqlRs.EOF
            ddsite.Items.Add(New ListItem(sqlRs("sitename").Value, sqlRs("siteid").Value))
            
            sqlRs.MoveNext()
        Loop
                
        sqlRs.Close()
        objConn.close()
        objConn = Nothing
    End Sub
    
    Private Sub filldistrict()
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
                 
        ddsite.Items.Add(New ListItem("-Select Site--", "0"))
        dddistrict.Items.Add(New ListItem("-Select District--", "0"))
        objConn = New ADODB.Connection()
        sqlRs = New ADODB.Recordset()
        objConn = New ADODB.Connection()
        objConn.open(strConn)
        If arryControlDistrict(0) <> "ALL" Then
            sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") ", objConn)
        Else
            sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table ", objConn)
        End If
        Do While Not sqlRs.EOF
            strDistrict = sqlRs("sitedistrict").Value
            dddistrict.Items.Add(New ListItem(strDistrict, strDistrict))
            
            sqlRs.MoveNext()
        Loop
                
        sqlRs.Close()
        objConn.close()
        objConn = Nothing
            
            
              
    End Sub
    Protected Sub img_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        
        Dim sqlsp
        objConn = New ADODB.Connection()
        sqlsp = New ADODB.Recordset()
        objConn.open(strConn)
        ' sqlSp = "insert into reservoirinfo values('" & ddsite.SelectedValue & "','" & die_cir_type.Text & "','" & die_cir_tita.Text & "','" & die_squ_type.Text & "','" & die_squ_tita.Text & "','" & cap_m.Text & "','" & inlet_pipe_mm.Text & "','" & inlet_pipe_Type.Text & "','" & inlet_zone_mm.Text & "','" & inlet_pipe_Type.Text & "','" & outlet_pipe_mm.Text & "','" & outlet_pipe_type.Text & "','" & outlet_zone_mm.Text & "','" & outlet_zone_type.Text & "','" & twl_meter.Text & "','" & bwl_meter.Text & "','" & hightof.Text & "','" & yearbuilt.Text & "','" & drstribuation.Text & "')"
        sqlsp = "update reservoirinfo set dimension_id=" & selecting.SelectedValue & ",capacity='" & cap_m.Text & "',inlet_pipe_mm='" & inlet_pipe_mm.Text & "',inlet_pipe_type=" & inlet_pipe_type.SelectedValue & ",inlet_zone_mm='" & inlet_zone_mm.Text & "',inlet_zone_type=" & inlet_zone_type.SelectedValue & ",outlet_pipe_mm='" & outlet_pipe_mm.Text & "',outlet_pipe_type=" & outlet_pipe_type1.SelectedValue & ",outlet_zone_mm='" & outlet_zone_mm.Text & "',outlet_zone_type=" & outlet_zone_type1.SelectedValue & ",twl_meter='" & twl_meter.Text & "',bwl_meter='" & bwl_meter.Text & "',highoftower='" & hightof.Text & "',year_built='" & yearbuilt.Text & "',destribution_area='" & drstribuation.Text & "',type_id=" & ddselect.SelectedValue & " where siteid='" & ddsite.SelectedValue & "'"
        objConn.Execute(sqlsp)
        
        
       
        Dim sqlSp1
        Dim objConn1
        objConn1 = New ADODB.Connection()
        sqlSp1 = New ADODB.Recordset()
        objConn1.open(strConn)
        sqlSp1 = "update res_dimension_table set dimension_id=" & selecting.SelectedValue & ",dim_type='" & die_cir_type.Text & "',dim_lb='" & die_cir_tita.Text & "' where siteid='" & ddsite.SelectedValue & "'"
        objConn1.Execute(sqlSp1)
      
        'dimen = "ce2"
        'tbl.Rows(5).Cells(0).InnerHtml() = Hidden1.Value
        
        Dim sqlSp2
        Dim objConn2
        objConn2 = New ADODB.Connection()
        sqlSp2 = New ADODB.Recordset()
        objConn2.open(strConn)
     
        If (check1.Checked) Then
            If childdata.Value = "no" Then
                sqlSp2 = "insert into res_outletpipe_table values('" & TextBox1.Text & "'," & outlet_pipe_type2.SelectedValue & ",'" & TextBox2.Text & "'," & outlet_zone_type2.SelectedValue & ",'" & ddsite.SelectedValue & "')"
                objConn2.Execute(sqlSp2)
            Else
                sqlSp2 = "update res_outletpipe_table set outlet_pipe_mm='" & TextBox1.Text & "',outlet_pipe_type=" & outlet_pipe_type2.SelectedValue & ",outlet_zone_mm='" & TextBox2.Text & "',outlet_zone_type=" & outlet_zone_type2.SelectedValue & "where siteid='" & ddsite.SelectedValue & "'"
                objConn2.Execute(sqlSp2)
            End If
        End If
               
        Dim sqlsp3
        Dim objConn3
        objConn3 = New ADODB.Connection()
        sqlsp3 = New ADODB.Recordset()
        objConn3.open(strConn)
        If (check2.Checked) Then
            sqlsp3 = "delete from res_outletpipe_table where siteid='" & ddsite.SelectedValue & "'"
            objConn3.Execute(sqlsp3)
        End If
       
       
        objConn.close()
        objConn1.close()
        objConn2.close()
        objConn3.close()
        objConn = Nothing
        Response.Redirect("reservoir.aspx?dist=" & dddistrict.SelectedValue)
    End Sub
   
    Protected Sub ddsite_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'If ddsite.SelectedIndex <> "0" Then
        '    tbl.Visible = True
        'Else
        '    tbl.Visible = False
        'End If
    End Sub

    Protected Sub dddistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If dddistrict.SelectedIndex <> "0" Then
            Call fillsite(dddistrict.SelectedValue)
        Else
            ddsite.Items.Clear()
            ddsite.Items.Add(New ListItem("-Select Site--", "0"))
            ddsite.SelectedIndex = "0"
        End If
    End Sub
    
    
</script>

<html>
<head>
<style>

.bodytxt 
  {
  font-weight: normal;
  font-size: 11px;
  color: #333333;
  line-height: normal;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  }

 a {text-decoration: none;} 
.FormDropdown 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 180px;
  border: 1 solid #CBD6E4;
  }
.FormDropdown1
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 295px;
  border: 1 solid #CBD6E4;
  }
.FormDropdown2 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 50px;
  border: 1 solid #CBD6E4;
  }
.inputStyle
{
color: #0B3D62;
font-size: 10pt;
font-family: Verdana;
border-width: 1px;
border-style: solid;
border-color: #CBD6E4;
.txtcls
{
    FONT-SIZE: 12px;
    WIDTH: 125px;
    FONT-FAMILY: Arial;
    /*border-style:groove;*/
}
}
</style>

<script language="JavaScript" src="TWCalendar.js"></script>

<script type="text/javascript">

function sele_drop()
{
  var x=document.getElementById('tbl').rows[5].cells
  var y=document.getElementById('selecting')
       if (y.options[y.selectedIndex].text=="SQUARE")
         {
          x[0].innerHTML="<B> L*B </B>"
          document.getElementById('tbl').style.color="#0066ff";
          document.getElementById('tbl').style.fontFamily ="verdana";
          document.getElementById('td1').style.verticalAlign="middle";
          document.getElementById('td1').style.fontSize =10;
         // document.getElementById('td1').style.font="bold";
         }                                    
         else
         {
         x[0].innerHTML="<B> Diameter </B>"
         document.getElementById('tbl').style.color="#0066ff";
         document.getElementById('tbl').style.fontFamily ="verdana";
         document.getElementById('td1').style.verticalAlign="middle";
         document.getElementById('td1').style.fontSize =10;
        // document.getElementById('td1').style.font="bold";
         }
       
}

function fun()
{
<% if (check1.checked) then %>
document.getElementById ("div2").style.visibility ='visible';
document.getElementById ("tbl").style.left='0';
document.getElementById ("pipe2").style.left='653';
<%else %>
document.getElementById ("tbl").style.left='60';
<%end if %>
}

function check1_sele(s)
{
 if(s.checked)
 {
 document.getElementById("divt").style.visibility='visible';
 document.getElementById ("div2").style.visibility ='visible';
 document.getElementById ("tbl").style.left='0';
 document.getElementById ("pipe2").style.left='653';
 }  
 else
 {
 document.getElementById ("tbl").style.left='60';
 document.getElementById("divt").style.visibility='hidden';
 document.getElementById ("div2").style.visibility ='hidden';
 }
}

function check2_sele(b)
{
if(b.checked)
{
document.getElementById ("divt").style.visibility ='hidden';
document.getElementById ("tbl").style.left='60';
}
} 


</script>
</head>

<body bgcolor="#ffffff" onload="fun();">
       
<form id="Form1" name="frmanalysis" method="POST" runat="server" >

<div align="center"><img border="0" src="images/UpdateSite.jpg"><br />
        &nbsp;</div>

 <div align="center"> <font face="Verdana" size="2" color="#3952F9"><b>&nbsp; &nbsp;&nbsp;
        District:</b></font><asp:DropDownList ID="dddistrict" runat="server" Width="214px" OnSelectedIndexChanged="dddistrict_SelectedIndexChanged"  ForeColor="Blue"  Enabled=false style="border-right: #336699 thin solid; border-top: #336699 thin solid; border-left: #336699 thin solid; border-bottom: #336699 thin solid"  >
    </asp:DropDownList>     
        </div><br />
    <div align="center"> <font face="Verdana" size="2" color="#3952F9"><b>Site Name:</b></font>
    <asp:DropDownList ID="ddsite" runat="server" Width="214px" Enabled="false" ForeColor="Blue" style="border-right: #336699 thin solid; border-top: #336699 thin solid; border-left: #336699 thin solid; border-bottom: #336699 thin solid" >
    </asp:DropDownList><br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" src="images/Submit_s.jpg" OnClick="img_Click" style="right: 448px; top: 0px" /></div>
        
        
       <!-- sadkf sadkfsadfjsakdfksdajfkk--> 
   <div id="divt" style="visibility:hidden;" bgcolor="lightgrey" runat="server" >
    <table border="0" runat="server" id="pipe2" bgcolor="lightgrey" align="right" style="background-color: white; width:25%; height: 100px; left: 704px; position: absolute; top: 344px; color: #0066ff; overflow: auto; border-right: #99adf1 thin solid; border-top: #99adf1 thin solid; border-left: #99adf1 thin solid; border-bottom: #99adf1 thin solid;">
    <tr bgcolor="#99adf1">
    <td align="center" colspan ="4" style="height: 45px; "><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000"> Outlet Pipe2</b></font></td>
    </tr>
    <tr bgcolor="#bec9ff">
    <td align="center" colspan="2" style="width: 1557px; height: 25px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Pipe Size</b></font></td>
            <td align="center" colspan="2" style="width: 1557px; height: 25px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Zone Meter</b></font></td>
    </tr>
    <tr>
            <td align="center" colspan="1" style="height: 28px; width: 60px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="height: 28px; width: 24px;">
                <asp:TextBox ID="TextBox1" runat="server" maxlength="5" Width="80" style="background-color: #ffffff; color: #336699;"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 41px; height: 28px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 5px; height: 28px;">
                <asp:TextBox ID="TextBox2" runat="server" maxlength="5" Width="80" style="background-color: #ffffff; color: #336699;"></asp:TextBox></td>
    </tr>
    <tr >
    <td align="center" colspan="1" style="width: 60px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="outlet_pipe_type2" runat="server" style="background-color: #ffffff; color: #336699; font-family: Verdana;" Width="80px">
                    <asp:ListItem Value="0">AC</asp:ListItem>
                    <asp:ListItem Value="1">MS</asp:ListItem>
                    <asp:ListItem Value="2">DI</asp:ListItem>
                </asp:DropDownList></td>
            <td align="center" colspan="1" style="width: 41px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="outlet_zone_type2" runat="server" Width="120px" Style="background-color: #ffffff; color: #336699; font-family: Verdana;">
                    <asp:ListItem Value="0">ABB</asp:ListItem>
                    <asp:ListItem Value="1">SIEMEN</asp:ListItem>
                    <asp:ListItem Value="1">DANFOSS</asp:ListItem>
                    <asp:ListItem Value="4">ENDRESS&HAUSER</asp:ListItem>
                    <asp:ListItem Value="4">ISOIN</asp:ListItem>
               </asp:DropDownList></td>
    </tr>
   </table>
  </div>
  
   
   <table border="0" align="center" runat="server" id="tbl" bgcolor="lightgrey"  style="width: 25%; position: absolute; top: 168px;  left:112px; color: #0066ff; border-right: #99adf1 thin solid; border-top: #99adf1 thin solid; border-left: #99adf1 thin solid; border-bottom: #99adf1 thin solid; background-color: #ffffff;" >
        <tr bgcolor="#99adf1">
            <td colspan="8" align="center" style="height: 31px" ><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 10pt; color: #000000;"> Reservoir Info</b></font></td>
        </tr>
        <tr bgcolor="#bec9ff">
            <td align="center" colspan ="4" style="height: 28px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #0066ff"> Dimension(Meter)</b></font></td>
            <td align="center" colspan ="4" style="height: 28px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #0066ff"> Capacity</b></font></td>
        </tr>
        <tr>
        <td align="center" colspan="2" style="width: 356px; height: 26px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Tank use</b></font></td>
        <td align="center" colspan="2" style="height: 26px; width: 1343px; border-right: #99adf1 thin; border-top-style: none; border-left-style: none; border-bottom-style: none;"><asp:DropDownList ID="ddselect" runat="server"  Width="89px" style="font-weight: lighter; font-size: 10pt; color: #006699; font-family: Verdana;" >
                    <asp:ListItem Value="1">Servicing</asp:ListItem>
                    <asp:ListItem Value="2">Balancing</asp:ListItem>
                     </asp:DropDownList></td> 
       </tr>
        <tr>
        <td align="center" colspan="2" style="width: 356px; height: 26px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Tank type </b></font></td>
        <td align="center" colspan="2" style="height: 21px; width: 1343px; border-right: #99adf1 thin; border-top-style: none; border-left-style: none; border-bottom-style: none;"><asp:DropDownList ID="selecting" runat="server"  Width="89px" style="color: #336699; font-family: Verdana" >
                    <asp:ListItem Value="1">CIRCULAR</asp:ListItem>
                    <asp:ListItem Value="2">SQUARE</asp:ListItem>
                     </asp:DropDownList></td>           
        </tr>
        <tr>
            <td align="center" colspan="2" style="width: 356px; height: 26px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">  Type</b></font></td>
            <td align="center" colspan="2" style="height: 26px; width: 1343px;; border-right: thin; border-top-style: none; border-left-style: none; border-bottom-style: none;">
                <asp:TextBox ID="die_cir_type"  runat="server" maxlength="10" Width="89px" Font-Size="Small" style="font-size: smaller; color: #336699;"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 1343px; height: 26px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> M <sup>3</sup></b></font> </td>
            <td align="center" colspan="1" style="width: 1343px; height: 26px;">
                <asp:TextBox ID="cap_m" runat="server" maxlength="10" Width="80" style="color: #336699"></asp:TextBox></td>
            
        </tr>
        <tr>
            <td id="td1" align="center" colspan="2" style="height: 21px; width: 356px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; vertical-align: middle; font-family: Verdana; text-align: center;"> 
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Smaller" ForeColor="RoyalBlue"
                        Style="font-size: xx-small; color: #0066ff; font-family: Verdana" Width="75px"></asp:Label></b></font></td>
            <td align="center" colspan="2" style="width: 1343px; height: 26px; border-right: #99adf1 thin; color: #99adf1; border-top-style: none; border-left-style: none; border-bottom-style: none;">
                <asp:TextBox ID="die_cir_tita" runat="server" maxlength="5" Width="89px" style="color: #336699"></asp:TextBox></td>
            
        </tr>
        <tr bgcolor="#99adf1">
            <td align="center" colspan ="4" style="height: 8px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000"> Inlet Pipe</b></font></td>
            <td align="center" colspan ="4" style="height: 8px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: black; font-family: Verdana; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;"> 
                <br />
                Outlet Pipe1 &nbsp;&nbsp;
               <input type="checkbox" runat="server" name="check1" id="check1"  onclick ="javascript:check1_sele(this);" value="1" /></b><b style="font-size: 8pt; color: #000000; left:10px">Add Outlet Pipe2</b><br />
               <div id="div2" style="visibility:hidden" runat="server">   
                 <input id="check2" name="check2" runat="server" value="1" style="left: 471px; position: absolute; top: 207px" type="checkbox" onclick ="javascript:check2_sele(this)" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b style="font-size: 8pt; color: #000000">Drop outlet pipe2</b>
                  </div>
               </font></td>
        </tr>
        <tr bgcolor="#bec9ff">
            <td align="center" style="width: 150px; height: 26px;" colspan="2"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Pipe Size</b></font></td>
            <td align="center" style="width: 170px; height: 26px;" colspan="2">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Zone Meter</b></font></td>
            <td align="center" style="width: 150px; height: 26px" colspan="2"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff;" > Pipe Size</b></font></td>
            <td align="center" style="width: 170px; height: 26px" colspan="2"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Zone Meter</b></font></td>
        </tr>
        <tr>
            <td align="center" colspan="1" style="width: 305px">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 2201px">
                <asp:TextBox ID="inlet_pipe_mm" runat="server"  maxlength="5" Width="80"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 107px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 1343px">
                <asp:TextBox ID="inlet_zone_mm" runat="server" maxlength="5" Width="80"> </asp:TextBox></td>
            <td align="center" style="width: 150px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 1343px">
                <asp:TextBox ID="outlet_pipe_mm" runat="server" maxlength="5" Width="80" style="color: #336699"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 92px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Diameter(mm)</b></font></td>
            <td align="center" style="width: 5px">
                <asp:TextBox ID="outlet_zone_mm" runat="server" maxlength="5" Width="80" style="color: #336699"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="center" colspan="1" style="height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 2201px;">
                <asp:DropDownList ID="inlet_pipe_type" runat="server" style="background-color: #ffffff; color: #336699; font-family: Verdana;" Width="80px">
                    <asp:ListItem Value="0">AC</asp:ListItem>
                    <asp:ListItem Value="1">MS</asp:ListItem>
                    <asp:ListItem Value="2">DI</asp:ListItem>
                </asp:DropDownList></td>
            <td align="center" colspan="1" style="height: 21px; width: 356px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="inlet_zone_type" runat="server" Width="120px" Style="background-color: #ffffff; color: #336699; font-family: Verdana;">
                    <asp:ListItem Value="0">ABB</asp:ListItem>
                    <asp:ListItem Value="1">SIEMEN</asp:ListItem>
                    <asp:ListItem Value="1">DANFOSS</asp:ListItem>
                    <asp:ListItem Value="4">ENDRESS&HAUSER</asp:ListItem>
                    <asp:ListItem Value="4">ISOIN</asp:ListItem>
               </asp:DropDownList>
            </td>
            <td align="center" style="width: 150px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="outlet_pipe_type1" runat="server" style="background-color: #ffffff; color: #336699; font-family: Verdana;" Width="80px">
                    <asp:ListItem Value="0">AC</asp:ListItem>
                    <asp:ListItem Value="1">MS</asp:ListItem>
                    <asp:ListItem Value="2">DI</asp:ListItem>
                </asp:DropDownList></td>
            <td align="center" colspan="1" style="width: 92px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Type</b></font></td>
           <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="outlet_zone_type1" runat="server" Width="120px" Style="background-color: #ffffff; color: #336699; font-family: Verdana;">
                    <asp:ListItem Value="0">ABB</asp:ListItem>
                    <asp:ListItem Value="1">SIEMEN</asp:ListItem>
                    <asp:ListItem Value="1">DANFOSS</asp:ListItem>
                    <asp:ListItem Value="4">ENDRESS&HAUSER</asp:ListItem>
                    <asp:ListItem Value="4">ISOIN</asp:ListItem>
               </asp:DropDownList></td>
        </tr>
        <tr bgcolor="#99adf1">
            <td align="center" colspan ="4" style="height: 28px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000"> Top Water Level</b></font></td>
            <td align="center" colspan ="4" style="height: 28px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000"> Bottom Water Level</b></font></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="width: 81px; height: 30px;"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp;Meter</b></font></td>
            <td align="center" colspan="2" style="width: 107px; height: 30px;">
                <asp:TextBox ID="twl_meter" runat="server" maxlength="10" Width="80" style="color: #336699"></asp:TextBox></td>
            <td align="center" style="width: 150px; height: 30px" colspan="2"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Meter</b></font></td>
            <td align="center" colspan="2" style="width: 92px; height: 30px">
                <asp:TextBox ID="bwl_meter" runat="server" maxlength="10" Width="80" style="color: #336699"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="center" colspan="2" >
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Height Of Tower/Reservoir</b></font></td>
            <td align="center" colspan="2" style="width: 107px; height: 21px">
                <asp:TextBox ID="hightof" runat="server" Width="80" style="color: #336699"></asp:TextBox></td>
            <td align="center" colspan="2" style="width: 150px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Year Built</b></font></td>
            <td align="center" colspan="2" style="width: 92px; height: 30px">
                <asp:DropDownList ID="yearbuilt" runat="server" Width="80px" style="left: 452px; position: absolute; top: 376px; color: #336699; font-family: Verdana;" Height="24px">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td align="center" colspan="2" >
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff">Distribution Areas</b></font>
            </td>
            <td align="center" colspan="6" style="width: 107px; height: 21px" rowspan="3">
                <asp:TextBox ID="drstribuation" runat="server" Width="442px" style="color: #336699" ></asp:TextBox></td>
        </tr>
    </table>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
   
    <legend id="leg1" runat="server"><font face="Verdana" size="1" color="#5F7AFC"><b style="left: 112px; position: absolute; top: 616px; width: 168px; font-size: 8pt; color: #0066ff; height: 48px;" > 
     RC = Reinforced concrete<br />
     PG = Permaglass<br />
     AL = Aluminium</b>
      </font></legend>    
   <br />
    <%--<input type="hidden" runat="server" id="Hidden1" value="" style="color: black"  />--%>
   <input type="hidden" runat="server" id="childdata" value="no" style="color: black"  />
  
  
  </form>
 <%--  <script type="text/javascript">
var x=document.getElementById('tbl').rows[5].cells;
x[0].innerHTML=Hidden1.value;
//document.getElementById('Hidden1').value=x[0].innerHTML;
</script>--%>
 </body>
</html>