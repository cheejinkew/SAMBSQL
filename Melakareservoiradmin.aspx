<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="ADODB" %>
<!--#include file="../kont_id.aspx"-->
<script runat="server">
    Dim dimen
    Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
    Dim objConn
    Dim sqlRs As ADODB.Recordset
    Dim strDistrict = "Melaka"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        selecting.Attributes.Add("onchange", "sele_drop();")
       
        
        If Page.IsPostBack = False Then
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
                      
            For i = 1980 To Now.Year
                yearbuilt.Items.Add(New ListItem(i))
            Next
               
            ddsite.Items.Add(New ListItem("-Select Site--", "0"))
            dddistrict.Items.Add(New ListItem("-Select District--", "0"))
            objConn = New ADODB.Connection()
            sqlRs = New ADODB.Recordset()
            objConn = New ADODB.Connection()
            'objConn.open(strConn)
            'If arryControlDistrict(0) <> "ALL" Then
            '    sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ")", objConn)
            'Else
            '    sqlRs.Open("SELECT distinct(sitedistrict) from telemetry_site_list_table ", objConn)
            'End If
            
            'Do While Not sqlRs.EOF
            '    strDistrict = sqlRs("sitedistrict").Value
            '    dddistrict.Items.Add(New ListItem(strDistrict, strDistrict))
            '    sqlRs.MoveNext()
            'Loop
                
            'sqlRs.Close()
            'objConn.close()
            'objConn = Nothing
            dddistrict.Items.Add(New ListItem(strDistrict, strDistrict))
            tbl.Visible = False
            leg1.Visible = False
            img.Visible = False
            
            
            'pipe2.Visible = False
        End If
        
    End Sub

    Protected Sub img_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim sqlSp
        objConn = New ADODB.Connection()
        objConn.open(strConn)
        sqlSp = "insert into reservoirinfo(siteid,dimension_id,capacity,inlet_pipe_mm,inlet_pipe_type,inlet_zone_mm,inlet_zone_type,outlet_pipe_mm,outlet_pipe_type,outlet_zone_mm,outlet_zone_type,twl_meter,bwl_meter,highoftower,year_built,destribution_area,type_id) values('" & ddsite.SelectedValue & "'," & selecting.SelectedValue & ",'" & cap_m.Text & "','" & inlet_pipe_mm.Text & "'," & inlet_pipe_type.SelectedValue & ",'" & inlet_zone_mm.Text & "'," & inlet_zone_type.SelectedValue & ",'" & outlet_pipe_mm.Text & "'," & outlet_pipe_type1.SelectedValue & ",'" & outlet_zone_mm.Text & "'," & outlet_zone_type1.SelectedValue & ",'" & twl_meter.Text & "','" & bwl_meter.Text & "','" & hightof.Text & "','" & yearbuilt.Text & "','" & drstribuation.Text & "'," & ddselect.SelectedValue & ")"
        objConn.Execute(sqlSp)
        
        
        
        Dim sqlSp1
        Dim objConn1
        objConn1 = New ADODB.Connection()
        sqlSp1 = New ADODB.Recordset()
        objConn1.open(strConn)
        sqlSp1 = "insert into res_dimension_table values(" & selecting.SelectedValue & ",'" & die_cir_type.Text & "','" & die_cir_tita.Text & "','" & ddsite.SelectedValue & "')"
        objConn1.Execute(sqlSp1)
       
        ''dimen = "ce2"
        'tbl.Rows(5).Cells(0).InnerHtml() = Hidden1.Value
        
       
        Dim sqlSp2
        Dim objConn2
        objConn2 = New ADODB.Connection()
        sqlSp2 = New ADODB.Recordset()
        objConn2.open(strConn)
        If (check1.Checked) Then
            sqlSp2 = "insert into res_outletpipe_table values('" & TextBox1.Text & "'," & outlet_pipe_type2.SelectedValue & ",'" & TextBox2.Text & "'," & outlet_zone_type2.SelectedValue & ",'" & ddsite.SelectedValue & "')"
            objConn2.Execute(sqlSp2)
        End If
        
        ddsite.SelectedIndex = "0"
        objConn.close()
        objConn1.close()
        objConn2.close()
        objConn = Nothing
        Response.Redirect("reservoir.aspx?dist=" & dddistrict.SelectedValue)
        die_cir_type.Text = ""
        die_cir_tita.Text = ""
        cap_m.Text = ""
        
        inlet_pipe_mm.Text = ""
        inlet_pipe_type.Text = ""
        inlet_zone_mm.Text = ""
        inlet_zone_type.Text = ""
       
        outlet_pipe_mm.Text = ""
        outlet_pipe_type1.Text = ""
        outlet_zone_mm.Text = ""
        outlet_zone_type1.Text = ""
        twl_meter.Text = ""
        bwl_meter.Text = ""
        hightof.Text = ""
        yearbuilt.Text = ""
        drstribuation.Text = ""
        
        
        ddsite.Items.Clear()
        ddsite.Items.Add(New ListItem("-Select Site--", "0"))
        tbl.Visible = False
        
        
        'pipe2.Visible = False
    End Sub

   
    Protected Sub ddsite_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If ddsite.SelectedIndex <> "0" Then
            tbl.Visible = True
            leg1.Visible = True
            img.Visible = True
            
        Else
            tbl.Visible = False
            leg1.Visible = False
            img.Visible = False
        End If
    End Sub

    Protected Sub dddistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If dddistrict.SelectedIndex <> "0" Then
            'tbl.Visible = True
            'leg1.Visible = True
            'img.Visible = True
           
            
            
            
            Dim s As New ArrayList
            Dim i As Integer
            Dim sites As String = ""
            objConn = New ADODB.Connection()
            sqlRs = New ADODB.Recordset()
            objConn = New ADODB.Connection()
            objConn.open(strConn)
            'sqlRs.Open("SELECT siteid from reservoirinfo where siteid in ('STEF','STF1','STF0',F330')", objConn)
            'Do While Not sqlRs.EOF
            '    sites += "'" & sqlRs("siteid").Value & "',"
            '    sqlRs.MoveNext()
            'Loop
            'If sites.Length > 1 Then
            '    sites = sites.Remove(sites.Length - 1, 1)
            'End If
            'sqlRs.Close()
            'objConn.close()
            
            'objConn.open(strConn)
            sqlRs.Open("SELECT sitename, siteid,site_tele from telemetry_site_list_table where siteid IN ("& strKontID &") and siteid not in (select siteid from reservoirinfo) order by site_tele ", objConn)
            'sqlRs.Open("SELECT sitename, siteid, site_tele from telemetry_site_list_table where siteid in ('STEF','STF1','STF0','F330') and siteid not in (" & sites & ") order by site_tele ", objConn)
            ddsite.Items.Clear()
            ddsite.Items.Add(New ListItem("-Select Site--", "0"))
           
            Do While Not sqlRs.EOF
                s.Add(sqlRs("site_tele").Value)
                ddsite.Items.Add(New ListItem(sqlRs("sitename").Value, sqlRs("siteid").Value))
                sqlRs.MoveNext()
            Loop
                       
            For i = 0 To s.Count - 1
                
                If s.Item(i) = True Then
                    ddsite.Items(i + 1).Attributes.Add("style", "color:blue")
                Else
                    ddsite.Items(i + 1).Attributes.Add("style", "color:red")
                End If
            Next
                     
            sqlRs.Close()
            objConn.close()
            objConn = Nothing
            'tbl.Visible = False
            'ddsite.Items.Add(New ListItem("P Perhentian Besar", "F330"))
            'ddsite.Items(i + 1).Attributes.Add("style", "color:blue")
        Else
            ddsite.Items.Clear()
            ddsite.Items.Add(New ListItem("-Select Site--", "0"))
            ddsite.SelectedIndex = "0"
            tbl.Visible = False
            leg1.Visible = False
            img.Visible = False
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
//          document.getElementById('td1').style.font="bold";
         }                                    
         else
         {
         x[0].innerHTML="<B> Diameter </B>"
         document.getElementById('tbl').style.color="#0066ff";
         document.getElementById('tbl').style.fontFamily ="verdana";
         document.getElementById('td1').style.verticalAlign="middle";
         document.getElementById('td1').style.fontSize =10;
//         document.getElementById('td1').style.font="bold";
         }
//      document.getElementById('Hidden1').value=x[0].innerHTML;
}
function check1_sele(s)
{
if(!s.checked)
{
document.getElementById("divt").style.visibility='hidden';
document.getElementById("tbl").align='center';
}
else
{
document.getElementById("divt").style.visibility='visible';
document.getElementById("divt").style.left=668;
document.getElementById("tbl").align='left';


}
}

 </script>
</head>
<body bgcolor="#ffffff" style="background-color: #ffffff">


<form id="Form1" name="frmanalysis" method="post" runat="server">

   <div align="center" style="background-color: #ffffff"><img border="0" src="images/SiteMgmt.jpg" style="color: #0066ff; background-color: #ffffff"/>
   <br /><br />
        <font face="Verdana" size="2" color="#3952F9"><b style="background-color: #ffffff; color: #0066ff; font-family: Verdana;">
            &nbsp;&nbsp;
       District:</b></font><asp:DropDownList ID="dddistrict"  runat="server" Width="214px" OnSelectedIndexChanged="dddistrict_SelectedIndexChanged" AutoPostBack="true" ForeColor="Blue" style="background-color: #ffffff; color: #0066ff;" >
    </asp:DropDownList><br />
       <br />
    <font face="Verdana" size="2" color="#3952F9"><b style="background-color: #ffffff; color: #0066ff; font-family: Verdana;">
      SiteName:</b></font><asp:DropDownList ID="ddsite" runat="server" Width="214px" OnSelectedIndexChanged="ddsite_SelectedIndexChanged" AutoPostBack="true" ForeColor="Blue" style="background-color: #ffffff; color: #0066ff;" >
    </asp:DropDownList></div>
       &nbsp; &nbsp; &nbsp;
   <asp:ImageButton ID="img" runat="server" src="images/Submit_s.jpg" OnClick="img_Click" style="position:relative; left :604px; top: -1px" />
        &nbsp;
        
   <div id="divt"  runat="server" style="visibility:hidden; position:absolute; left:0px; top:304px">
   <table border="0" runat="server" id="pipe2" bgcolor="FloralWhite" align="right" style="background-color: #ffffff; left: -4px; position: absolute; top: 22px; width: 36px; border-right: #99adf1 thin solid; border-top: #99adf1 thin solid; border-left: #99adf1 thin solid; border-bottom: #99adf1 thin solid; height: 117px;">
    <tr bgcolor="#99adf1">
    <td align="center" colspan ="4" style="height: 49px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000; font-family: Verdana"> Outlet Pipe2</b></font></td>
    </tr>
    <tr bgcolor="#bec9ff">
    <td align="center" colspan="2" style="width: 1557px; height: 23px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Pipe Size</b></font></td>
            <td align="center" colspan="2" style="width: 1557px; height: 23px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Zone Meter</b></font></td>
    </tr>
    <tr>
    <td align="center" colspan="1" style="height: 30px; width: 60px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="height: 30px; width: 24px;">
                <asp:TextBox ID="TextBox1" runat="server" maxlength="5" Width="80" style="background-color: #ffffff; font-family: Verdana;"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 41px; height: 30px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 1343px; height: 30px;">
                <asp:TextBox ID="TextBox2" runat="server" maxlength="5" Width="80" style="background-color: #ffffff; font-family: Verdana;"></asp:TextBox></td>
    </tr>
    <tr>
    <td align="center" colspan="1" style="width: 60px; height: 19px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 19px; width: 1343px;">
                <asp:DropDownList ID="outlet_pipe_type2" runat="server" style="background-color: #ffffff; color: #336699; font-family: Verdana;" Width="80px">
                    <asp:ListItem Value="0">AC</asp:ListItem>
                    <asp:ListItem Value="1">MS</asp:ListItem>
                    <asp:ListItem Value="2">DI</asp:ListItem>
                </asp:DropDownList></td>
            <td align="center" colspan="1" style="width: 41px; height: 19px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 19px; width: 1343px;">
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
  
  <center id="div1" runat="server">
    <table border="0" runat="server" id="tbl"  width="25" align="center" style="background-color: white; top:300px; border-right: #99adf1 thin solid; border-top: #99adf1 thin solid; border-left: #99adf1 thin solid; border-bottom: #99adf1 thin solid;" >
        <tr bgcolor="#99adf1">
            <td colspan="8" align="center" style="height: 33px;" ><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 10pt; color: black; font-family: Verdana"> Reservoir Info</b></font></td>
        </tr>
        <tr bgcolor="#bec9ff">
            <td align="center" colspan ="4" style="height: 25px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #0066ff; font-family: Verdana"> Dimension(Meter)</b></font></td>
            <td align="center" colspan ="4" style="height: 25px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #0066ff; font-family: Verdana"> Capacity</b></font></td>
        </tr>
        <tr>
        <td align="center" colspan="2" style="width: 356px; height: 26px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Tank use</b></font></td>
        <td align="center" colspan="2" style="height: 26px; width: 1343px; border-top-style: none; border-right-style: none; border-left-style: none; border-right-color: #99adf1; border-bottom-style: none;"><asp:DropDownList ID="ddselect" runat="server"  Width="89px" style="font-weight: lighter; font-size: 10pt; color: #006699; font-family: Verdana;" >
                    <asp:ListItem Value="1">Servicing</asp:ListItem>
                    <asp:ListItem Value="2">Balancing</asp:ListItem>
                     </asp:DropDownList></td> 
       </tr>
        <tr>
        <td align="center" colspan="2" style="width: 356px; height: 26px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Tank type</b></font></td>
        <td align="center" colspan="2" style="height: 21px; width: 1343px;"><asp:DropDownList ID="selecting" runat="server"  Width="89px" style="font-weight: lighter; font-size: 10pt; color: #006699; font-family: Verdana;" >
                    <asp:ListItem Value="1">CIRCULAR</asp:ListItem>
                    <asp:ListItem Value="2">SQUARE</asp:ListItem>
                     </asp:DropDownList></td>           
        </tr>
        <tr>
            <td align="center" colspan="2" style="width: 356px; height: 18px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Type</b></font></td>
            <td align="center" colspan="2" style="height: 18px; width: 1343px;;">
                <asp:TextBox ID="die_cir_type" runat="server" maxlength="10" Width="89px"  style="background-color: #ffffff; color: #336699;" Height="24px"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 1343px; height: 18px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 7pt; color: #0066ff"> M <sup>3</sup></b></font> </td>
            <td align="center" colspan="1" style="width: 1343px; height: 18px;">
                <asp:TextBox ID="cap_m" runat="server" maxlength="10" Width="80" style="background-color: #ffffff; color: #336699;"></asp:TextBox></td>
        </tr>
        <tr >
            <td id="td1" align="center" colspan="2" style="width: 356px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana; vertical-align: middle; text-align: center;">Diameter</b></font></td>
            <td align="center" colspan="2" style="width: 1343px;">
                <asp:TextBox ID="die_cir_tita" runat="server" maxlength="5" Width="89px" style="background-color: #ffffff; color: #336699;" Height="23px"></asp:TextBox></td>
            </tr>
        <tr bgcolor="#99adf1">
            <td align="center" colspan ="4" style="height: 51px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000; font-family: Verdana; border-left-color: #99ccff; border-bottom-color: #99ccff; border-top-style: none; border-top-color: #99ccff; border-right-style: none; border-left-style: none; border-right-color: #99ccff; border-bottom-style: none;"> Inlet Pipe</b></font></td>
            <td align="center" colspan ="4" style="height: 51px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: black; font-family: Verdana; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;"> Outlet Pipe1&nbsp;
               <input type="checkbox" runat="server" name="check1" id="check1" onclick ="javascript:check1_sele(this)" value="1"/></b><b style="font-size: 8pt; color: black; font-family: Verdana">Add Outlet Pipe2</b></font></td>
         </tr>
         <tr bgcolor="#bec9ff">
            <td align="center" colspan="2" style="width: 1557px; height: 24px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Pipe Size</b></font></td>
            <td align="center" colspan="2" style="width: 1557px; height: 24px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Zone Meter</b></font></td>
            <td align="center" colspan="2" style="width: 1557px; height: 24px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Pipe Size</b></font></td>
            <td align="center" colspan="2" style="width: 1557px; height: 24px;">
            <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff"> Zone Meter</b></font></td>
        </tr>
        <tr>
             <td align="center" colspan="1" style="height: 28px; width: 356px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 1343px; height: 28px">
                <asp:TextBox ID="inlet_pipe_mm" runat="server" maxlength="5" Width="80"  style="background-color: #ffffff"></asp:TextBox></td>
            <td align="center" colspan="1" style="height: 28px; width: 356px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;"> Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 1343px; height: 28px">
                <asp:TextBox ID="inlet_zone_mm" runat="server" maxlength="5" Width="80"  style="background-color: #ffffff"></asp:TextBox></td>
            <td align="center" colspan="1" style="height: 28px; width: 60px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;"> Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="height: 28px;">
                <asp:TextBox ID="outlet_pipe_mm" runat="server" maxlength="5" Width="80" style="background-color: #ffffff"></asp:TextBox></td>
            <td align="center" colspan="1" style="width: 41px; height: 28px;">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;"> Diameter(mm)</b></font></td>
            <td align="center" colspan="1" style="width: 1300px; height: 28px;">
                <asp:TextBox ID="outlet_zone_mm" runat="server" maxlength="5" Width="88px" style="background-color: #ffffff"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="center" colspan="1" style="height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="inlet_pipe_type" runat="server" style="background-color: #ffffff; color: #336699; font-family: Verdana;" Width="80px">
                    <asp:ListItem Value="0">AC</asp:ListItem>
                    <asp:ListItem Value="1">MS</asp:ListItem>
                    <asp:ListItem Value="2">DI</asp:ListItem>
                </asp:DropDownList></td>
            <td align="center" colspan="1" style="height: 21px; width: 356px;">
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="inlet_zone_type" runat="server" Width="120px" Style="background-color: #ffffff; color: #336699; font-family: Verdana;">
                    <asp:ListItem Value="0">ABB</asp:ListItem>
                    <asp:ListItem Value="1">SIEMEN</asp:ListItem>
                    <asp:ListItem Value="1">DANFOSS</asp:ListItem>
                    <asp:ListItem Value="4">ENDRESS&HAUSER</asp:ListItem>
                    <asp:ListItem Value="4">ISOIN</asp:ListItem>
               </asp:DropDownList></td>
            <td align="center" colspan="1" style="width: 60px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1343px;">
                <asp:DropDownList ID="outlet_pipe_type1" runat="server" style="background-color: #ffffff; color: #336699; font-family: Verdana;" Width="80px">
                    <asp:ListItem Value="0">AC</asp:ListItem>
                    <asp:ListItem Value="1">MS</asp:ListItem>
                    <asp:ListItem Value="2">DI</asp:ListItem>
                </asp:DropDownList></td>
            <td align="center" colspan="1" style="width: 41px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Type</b></font></td>
            <td align="center" colspan="1" style="height: 21px; width: 1300px;">
                <asp:DropDownList ID="outlet_zone_type1" runat="server" Width="120px" Style="background-color: #ffffff; color: #336699; font-family: Verdana;">
                    <asp:ListItem Value="0">ABB</asp:ListItem>
                    <asp:ListItem Value="1">SIEMEN</asp:ListItem>
                    <asp:ListItem Value="1">DANFOSS</asp:ListItem>
                    <asp:ListItem Value="4">ENDRESS&HAUSER</asp:ListItem>
                    <asp:ListItem Value="4">ISOIN</asp:ListItem>
               </asp:DropDownList></td>
        </tr>
        <tr bgcolor="#99adf1">
            <td align="center" colspan ="4" style="height: 28px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: #000000; font-family: Verdana"> Top Water Level</b></font></td>
            <td align="center" colspan ="4" style="height: 28px"><font face="Verdana" size="1" color="#5F7AFC"><b style="font-size: 8pt; color: black; font-family: Verdana"> Bottom Water Level</b></font></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="width: 81px; height: 21px;"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp;Meter</b></font></td>
            <td align="center" colspan="2" style="width: 107px; height: 21px;">
                <asp:TextBox ID="twl_meter" runat="server" maxlength="10" Width="80" style="background-color: #ffffff"></asp:TextBox></td>
            <td align="center" style="width: 150px; height: 21px" colspan="2"><font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;"> Meter</b></font></td>
            <td align="center" colspan="2" style="width: 107px; height: 21px;">
                <asp:TextBox ID="bwl_meter" runat="server" maxlength="10" Width="80" style="background-color: #ffffff"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="center" colspan="2" >
               <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;"> Height Of Tower/Reservoir</b></font></td>
            <td align="center" colspan="2" style="width: 107px; height: 21px">
                <asp:TextBox ID="hightof" runat="server" Width="80" style="background-color: #ffffff"></asp:TextBox></td>
            <td align="center" colspan="2" style="width: 150px; height: 21px">
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Year Built</b></font></td>
            <td align="center" colspan="2" style="width: 107px; height: 21px;">
                <asp:DropDownList ID="yearbuilt" runat="server" DataMember="Datetime" Width="80px" style="font-family: Verdana">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="height: 27px" >
                <font face="Verdana" size="1" color="#5F7AFC"><b style="color: #0066ff; font-family: Verdana;">Distribution Areas</b></font>
            </td>
            <td align="center" colspan="6" style="width: 107px; height: 27px" rowspan="3">
                <asp:TextBox ID="drstribuation" runat="server" Width="442px" style="background-color: #ffffff" ></asp:TextBox></td>
        </tr>
    </table>
    </center>
    <br />
    
  <legend id="leg1" runat="server"><font face="Verdana" size="1" color="#5F7AFC">
      <b style=" font-size: 8pt; color: #0066ff; height: 48px; left: 69px; position: absolute; top: 584px;" id="B1"> 
     RC = Reinforced concrete<br />
     PG = Permaglass<br />
     AL = Aluminium</b></font></legend>
    <br />
    <input type="hidden" runat="server" id="Hidden1" style="color: black"  value=""/>
    <input type="hidden" runat="server" id="ce2" style="color: black"  value=""/>
    </form>
 <%-- <script type="text/javascript">
var x=document.getElementById('tbl').rows[5].cells;
x[0].innerHTML=document.getElementById('Hidden1').value;
alert(document.getElementById('Hidden1').value);
</script>--%>
  </body>
</html>
