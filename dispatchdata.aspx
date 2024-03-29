<%@ Page Language="VB" Debug="true" %>
<%--#include file="kont_id.aspx"--%>
<%@ Import Namespace="ADODB" %>

  <Script Runat="Server">
      Dim strbegindate As String
      Dim strConn = ConfigurationSettings.AppSettings("DSNPG")
      Dim objConn
      Dim sqlRs
      Dim strError
      Dim arryControlDistrict
      Dim strControlDistrict
      Dim strKontID As String = "'8688'"
      
      Sub Page_Load()
          Dim i
          If Page.IsPostBack = False Then
              arryControlDistrict = Split(Request.Cookies("Telemetry")("ControlDistrict"), ",")
         
          
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

              strbegindate = Now().ToString("yyyy/MM/dd")
              txtBeginDate.Text = strbegindate
              objConn = New ADODB.Connection()
              sqlRs = New ADODB.Recordset()
              
              objConn.open(strConn)
              If arryControlDistrict(0) <> "ALL" Then
                  sqlRs.Open("select distinct sitedistrict from telemetry_site_list_table where sitedistrict in (" & strControlDistrict & ") order by sitedistrict", objConn)
                  
              Else
                  sqlRs.Open("select distinct sitedistrict from telemetry_site_list_table order by sitedistrict", objConn)
                 
              End If
              Dim strDistrict As String
              dddistrict.Items.Add(New ListItem("- Select District -", "0"))
              Do While Not sqlRs.EOF
                  strDistrict = sqlRs("sitedistrict").value
                  dddistrict.Items.Add(New ListItem(strDistrict, strDistrict))
                  sqlRs.movenext()
              Loop
             
              sqlRs.close()
              objConn.close()
              objConn = Nothing
          End If
      End Sub
      Sub Selection_Change(ByVal sender As Object, ByVal e As EventArgs)
          
          objConn = New ADODB.Connection()
          sqlRs = New ADODB.Recordset()
         
 
      
          objConn.open(strConn)

          sqlRs.Open("SELECT distinct siteid, sitename from telemetry_site_list_table where sitedistrict='" & dddistrict.SelectedValue & "' and siteid NOT IN ("& strKontID &") and sitetype not in('AMR')", objConn)

          Dim strSiteName As String
          Dim strsiteid As String
          Dim t As New Data.DataTable
          t.Columns.Add(New Data.DataColumn("Siteid"))
          t.Columns.Add(New Data.DataColumn("Sitename"))
          Dim r As Data.DataRow
          Do While Not sqlRs.EOF
             

              strSiteName = sqlRs("sitename").value
            
         
             
              strsiteid = sqlRs("siteid").value
              
              
             
             
            
             
              r = t.NewRow
              r(0) = strsiteid
              r(1) = strSiteName
              t.Rows.Add(r)
              sqlRs.movenext()
          Loop
          dg.DataSource = t
          dg.DataBind()
          sqlRs.close()
          objConn.close()
          objConn = Nothing
      End Sub
      Sub ImageButton1_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
    
          Dim str = ConfigurationSettings.AppSettings("DSNPG")
          Dim sqlSp
          objConn = New ADODB.Connection()
          objConn.open(str)
          
          Dim sqlRs1 = New ADODB.Recordset()
          Dim sqlRs2 = New ADODB.Recordset()
          Dim rule
          Dim simeno
          Dim s
          Dim dt
          Dim sit
          Dim pos
          Dim i, j As Integer
          For i = 0 To dg.Items.Count - 1
              sit = dg.Items(i).Cells(0).Text
              dt = txtBeginDate.Text
              For j = 0 To 2
                  dt = txtBeginDate.Text
                  If j = 0 Then
                      dt = dt & " 07:00:00"
                      s = CType(dg.Items(i).Cells(2).FindControl("t0"), TextBox).Text
                  End If
                  If j = 1 Then
                      dt = dt & " 15:00:00"
                      s = CType(dg.Items(i).Cells(3).FindControl("t1"), TextBox).Text
                  End If
                  If j = 2 Then
                      dt = dt & " 18:00:00"
                      s = CType(dg.Items(i).Cells(4).FindControl("t2"), TextBox).Text
                  End If
                  pos = 2

                
                      
                  If Val(s) > 0 Then
                      Try
                          sqlRs1.Open("SELECT distinct ruleid from telemetry_rule_list_table where siteid='" & sit & "'", objConn)
                          If Not IsDBNull(sqlRs1("ruleid").value) Then

                              rule = sqlRs1("ruleid").value
                          Else
                              rule = "0"
                      
                          End If
                          If rule <> "0" Then
                      
                
                              sqlRs2.Open("SELECT simno from telemetry_dispatch_list_table where ruleid='" & rule & "'", objConn)
                              If Not IsDBNull(sqlRs2("simno").value) Then

                                  simeno = sqlRs2("simno").value
                              Else
                                  simeno = "0"
                      
                              End If
                          Else
                              simeno = "0"
                      
                          End If
                          
                          sqlSp = "insert into telemetry_dispatch_history_table values('" & rule & "','" & simeno & "',1,'none','none','" & dt & "','" & sit & "','" & dg.Items(i).Cells(1).Text & "','None','" & dt & "'," & Val(s) & ")"
                          
                          ' sqlSp = "insert into telemetry_dispatch_history_table values('" & sit & "',0," & pos & ",'" & dt & "'," & Val(s) & ")"
                 
  
                          objConn.Execute(sqlSp)
                          s = 0
                          
                          
                          sqlRs1.close()
                          sqlRs2.close()
                 
                      Catch ex As Exception
                      
                          sqlRs1.close()
                          sqlRs2.close()
                     
                      End Try
                  Else
                      s = 0
                     
                        
                  End If
              Next
          Next
 
         
          objConn.close()
          objConn = Nothing
          dg.DataSource = Nothing
          dg.DataBind()
          dddistrict.SelectedValue = 0
          
          strbegindate = Now().ToString("yyyy/MM/dd")
          strError = "Data Inserted succefully"
          txtBeginDate.Text = strbegindate
      End Sub



</Script>

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
}
</style>


</head>
<body bgcolor="#FFFFFF">
<script language="JavaScript" src="TWCalendar.js"></script>
       
<form name="Form1"  method="POST" runat=server>
<script language="javascript">DrawCalendarLayout();</script>

<div align="center" style="top:20">
<br>
<p ><img border="0" src="images/Dispatch.jpg">
<br>
<div align="center" style="top:20">
  <center>
    
 <table border="0" cellpadding="0" cellspacing="0" width="70%" >
    <tr >
      <td width="100%" >
        <div align="center" style="top:20">
          <table border="0" cellspacing="1" width="100%">
          
          <tr >
	
<td colspan=4 height=30  ><div align="center" id="Error"><font color="green" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div></td>
            </tr>
<tr >
	<td width="4%"> </td>
	<td width="30%" align=right ><font face="Verdana" size="1" color="#5F7AFC"><b>District</b></font></td>
	<td width="3%" align =center ><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>	
 	
          
                   <td  style="width: 25%"><asp:DropDownList id="dddistrict"
                    AutoPostBack="True" class="FormDropdown"  OnSelectedIndexChanged="Selection_Change"
                    
                    runat="server">

                 

               </asp:DropDownList>
              </td>
<td></td>
            </tr>
           
            <tr>
              <td width="4%"></td>
              <td width="16%" align=right><font face="Verdana" size="1" color="#5F7AFC"><b>Begin Date</b></font></td>
              <td width="3%"><font face="Verdana" size="1" color="#5F7AFC"><b>:</b></font></td>
              <td width="40%"><font class="bodytxt">
               <asp:TextBox ID="txtBeginDate" runat="server" ForeColor =blue ></asp:TextBox>&nbsp; </font>
                 <a href="javascript:ShowCalendar('txtBeginDate', 310, 120);">
                   <img border="1" src="images/Calendar.jpg" width="19" height="14">
                   &nbsp;
                 </a>
                &nbsp;
                
                                 
              </td>
   <td  align="left">               
                
              </td>
            </tr>
     
            <td>&nbsp;
            </td>
            </center>
          </table>
        </div>
      </td>
    </tr>
  </table>
</div>
</div>
<div align="center" id="divWait" style="font-family:Verdana; font-size:8pt; color:red;">&nbsp;</div>
<!-*******************************************************************************************************
   DISPATCH REPORT GENERATION style="display:none"
  *******************************************************************************************************!>

<div id="print"align="right">

<table cellspacing="0" width="100%" id="ds" style="display:none"> 
<center>
<tr>
<td align="center" ><img border="0" src="images/DispatchReport.jpg"></td>
</tr>
<tr><td></td>

<tr><td align="right" width="90%">Date :</td></tr>
<tr height="10%"><td height="10%"><td></tr>
</table>


  <table border="0" cellspacing="0" width="50%">
 <center>
 <tr><td></td></tr>
    <tr >
      <td align="center" height="20" width="40%" colSpan="4">
      
      
      
      <asp:datagrid id="dg" runat="server" Width="656px" AutoGenerateColumns="False">
								<AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
								<ItemStyle Font-Size="8pt" Font-Names="Verdana" CssClass="griditem"></ItemStyle>
								<HeaderStyle Font-Size="9pt" Font-Names="Verdana" HorizontalAlign="Center" ForeColor="White"
									CssClass="gridheader" BackColor="RoyalBlue" Font-Bold="True"></HeaderStyle>
								<Columns>
									
									<asp:BoundColumn DataField="siteid" HeaderText="siteid" Visible=false ></asp:BoundColumn>
									<asp:BoundColumn DataField="sitename" HeaderText="sitename"></asp:BoundColumn>
									<asp:TemplateColumn HeaderText="07 AM">
										
										
										<ItemTemplate>
											
											<asp:TextBox ID="t0"  onblur ="javascript:validateNo(this.value);" runat =server></asp:TextBox>
										
										</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="03 PM">
										
										
										<ItemTemplate>
											
											<asp:TextBox ID="t1"  onblur ="javascript:validateNo(this.value);" runat =server ></asp:TextBox>
										
										</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="06 PM">
										
										
										<ItemTemplate>
											
											<asp:TextBox ID="t2"  onblur ="javascript:validateNo(this.value);" runat =server ></asp:TextBox>
										
										</ItemTemplate>
										</asp:TemplateColumn>
										
									
									
								</Columns>
							</asp:datagrid></td>
      
    </tr>

     
<tr> <td align =right >                </td></tr>   
  </table>
</div>


<p align="center">&nbsp;</p>
           <div >  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:ImageButton ID="ImageButton1"  ImageUrl="images/Submit_s.jpg" runat="server" OnClick="ImageButton1_Click"/></div>
<input type="hidden" name="txtSubmit" value="">
<input type="hidden" name="txtdistrictname" value="">
<p align="center" style="margin-bottom: 15">
  <font size="1" face="Verdana" color="#5373A2">
    Copyright � 2005 Gussmann Technologies Sdn Bhd. All rights reserved.
  </font>
</p>

</form>
<p>&nbsp;</p>

</body>

</html>
<script language="javascript">
  
     
  
  function ShowCalendar(strTargetDateField, intLeft, intTop)
  {
    txtTargetDateField = strTargetDateField;
    divTWCalendar.style.visibility = 'visible';
    divTWCalendar.style.left = intLeft;
    divTWCalendar.style.top = intTop;
  }
  function fun(o)
  {
  alert(o);
  }

function validateNo(o) 
				{
				var valid = ".0123456789";
				var ok = "yes";
				var temp;
				
				for (var i=0; i<o.length; i++) 
				{
					temp = "" + o.substring(i,i+1);
					if (valid.indexOf(temp) == "-1") 
					{
					ok = "no";
					}
				}
				
				
				if (ok == "no") 
				{
					alert("Invalid Entry! Please Enter Numbers only!");
					//document.Form1.all[""+o+""].value="";
					//document.Form1.all[""+o+""].focus();
					return false;
					
				}
				
			}


  var strSession = 'true';
  if (strSession != "true")
  {
    top.location.href = "login.aspx";
  }
  
</script>
