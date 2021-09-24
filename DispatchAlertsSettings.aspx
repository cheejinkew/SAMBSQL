<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DispatchAlertsSettings.aspx.vb" Inherits="DispatchAlertsSettings" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dispatch Alerts Setings</title>
      <style type="text/css">/* Show only to IE PC \*/
* html .boxhead h2 {height: 1%;} /* For IE 5 PC */
 
.sidebox {
	/* margin: 0 auto; /* center for now */
	/* width:450px; /* ems so it will grow */
	/* background: url(images/sbbody-r.gif) no-repeat bottom right;
	font-size: 100%;*/
}
.boxhead {
	background: url(images/sbhead-r.gif) no-repeat top right;
	margin: 0;
	padding: 0;
	width:490px;
	text-align: center;
}
.boxhead h2 {
	background: url(images/sbhead-l.gif) no-repeat top left;
	margin: 0;padding: 22px 30px 5px;color: white;font-weight: bold;font-size: 1.2em;text-shadow: rgba(0,0,0,.4) 0px 2px 5px;
	 /* Safari-only, but cool */
}
.boxbody {
	/*background: url(images/sbbody-l.gif) no-repeat bottom left;
	margin: 0;
	padding: 5px 5px 31px;*/
}
.FormDropdown 
  {
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  color:#5F7AFC;
  width: 158px;
  border: 1 solid #CBD6E4;
  }

.inputStyle
{
  border-width: 1px;
  border-style: solid;
  border-color: #5F7AFC;
  font-family: Verdana;
  font-size: 10pt;
  color: #3952F9;
  height: 20px
}
a.button:hover
 {
 	color:White;
	text-shadow: 0 1px 0 #fff;
	border: 1px solid #2F5BB7 !important;
	
	background: #3F83F1;
	background: -webkit-linear-gradient(top, #4D90FE, #357AE8);
	background: -moz-linear-gradient(top, #4D90FE, #357AE8);
	background: -ms-linear-gradient(top, #4D90FE, #357AE8);
	background: -o-linear-gradient(top, #4D90FE, #357AE8);
	
 }
a.button
{
	text-align:center;
	font: bold 11px Helvetica, Arial, sans-serif;
	cursor: pointer;
	text-decoration :none;
	text-shadow: 0 1px 0 #fff;
	display: inline-block;
	width:74px;
	border: 1px solid #3079ED !important;
	color:White;
	height:14px;

	background: #4B8DF8;
	background: -webkit-linear-gradient(top, #4C8FFD, #4787ED);
	background: -moz-linear-gradient(top, #4C8FFD, #4787ED);
	background: -ms-linear-gradient(top, #4C8FFD, #4787ED);
	background: #4B8DF8;
	
	-webkit-transition: border .20s;
	-moz-transition: border .20s;
	-o-transition: border .20s;
	transition: border .20s;
	margin: 5px;
	padding: 3px 5px 5px 3px;
}

.action {
	border: 1px solid #D8D8D8 !important;
	text-shadow: 0 1px 0 #fff;
	background: #4D90FE;
	background: -webkit-linear-gradient(top, #F5F5F5, #F1F1F1);
	background: -moz-linear-gradient(top, #F5F5F5, #F1F1F1);
	background: -ms-linear-gradient(top, #F5F5F5, #F1F1F1);
	background: -o-linear-gradient(top, #F5F5F5, #F1F1F1);
	
	-webkit-transition: border .20s;
	-moz-transition: border .20s;
	-o-transition: border .20s;
	transition: border .20s;
}
.blue {
	border: 1px solid #3079ED !important;
	color:White;
	text-shadow: 0 1px 0 #fff;

	background: #4B8DF8;
	background: -webkit-linear-gradient(top, #4C8FFD, #4787ED);
	background: -moz-linear-gradient(top, #4C8FFD, #4787ED);
	background: -ms-linear-gradient(top, #4C8FFD, #4787ED);
	background: -o-linear-gradient(top, #4C8FFD, #4787ED);
	
	-webkit-transition: border .20s;
	-moz-transition: border .20s;
	-o-transition: border .20s;
	transition: border .20s;
}
.blue:hover {
	border: 1px solid #2F5BB7 !important;
	
	background: #3F83F1;
	background: -webkit-linear-gradient(top, #4D90FE, #357AE8);
	background: -moz-linear-gradient(top, #4D90FE, #357AE8);
	background: -ms-linear-gradient(top, #4D90FE, #357AE8);
	background: -o-linear-gradient(top, #4D90FE, #357AE8);
}



.red {
	border: 1px solid #FF0000 !important;
	color:White;
	text-shadow: 0 1px 0 #fff;

	background: #FF0000;
	background: -webkit-linear-gradient(top, #FF0000, #FF0000);
	background: -moz-linear-gradient(top, #FF0000, #FF0000);
	background: -ms-linear-gradient(top, #4C8FFD, #FF0000);
	background: -o-linear-gradient(top, #FF0000, #FF0000);
	
	-webkit-transition: border .20s;
	-moz-transition: border .20s;
	-o-transition: border .20s;
	transition: border .20s;
}
.red:hover {
	border: 1px solid #FF0000 !important;
	
	background: #FF0000;
	background: -webkit-linear-gradient(top, #FF0000, #FF0000);
	background: -moz-linear-gradient(top, #FF0000, #FF0000);
	background: -ms-linear-gradient(top, #FF0000, #FF0000);
	background: -o-linear-gradient(top, #FF0000, #FF0000);
}


.td_label{font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;color:#5F7AFC;font-weight:bold;text-align:right}
</style>
 <script type="text/javascript" language="javascript" src="js/jquery.js"></script>
     <script type="text/javascript" language="javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" >
    function checkall(chkobj) {
        var chkvalue = chkobj.checked;
        for (i = 0; i < document.forms[0].elements.length; i++) {
            elm = document.forms[0].elements[i]
            if (elm.type == 'checkbox') {
                document.forms[0].elements[i].checked = chkvalue;
            }
        }
    }

    
        function collecttodelete() {
        var chekpos=new Array();
        var checked = false;
        var siteid;
        var dispatchno;
            for (var i = 0; i < document.forms[0].elements.length; i++) {
                elm = document.forms[0].elements[i]
                if (elm.type == 'checkbox') {
                    if (elm.checked == true) {
                        chekpos.push(elm.id);
                    }
                }
            }

            for (var j = 0; j < chekpos.length; j++) {
                siteid = chekpos[j].split(",")[0];
                dispatchno = chekpos[j].split(",")[1];
                Deletesetting(siteid, dispatchno);

            }
//            window.location.reload();
        }
  


    function Deletesetting(siteid, dispatchno) {
      var res;
        if (confirm('Do you want to delete ' + siteid + ' with Dispatch Number ' + dispatchno + ' ?')) {
            var resp;
            var lastXhr = $.getJSON("Geteventsjson.aspx?siteid=" + siteid + "&dis=" + dispatchno + "&opr=5", resp, function (data) {
                if (data.length > 0) {
                    if (data[0][0] == 1) {
                        res = 1;
                    }
                    else {
                        res = data[0][0];
                    }
                }
            });
        }
    }


</script>

<script type="text/javascript">
    function confirmation() {
        if (confirm('are you sure you want to delete  ?')) {
            return true;
        } else {
            return false;
        }
    }
    </script> 
</head>
<body style="margin: 0 0 0 0; font-family: Verdana;">
    <form id="form1" runat ="server"  >
    <div align="center" >
            <div style="width: 100%; height: 40px; background-image: url(header_bg.gif)">
                <table style="width: 100%;" border="0">
                    <tr>
                        <td align="center" style="vertical-align: middle; color: #336699; font-weight: bold;
                            font-size: 12px;">
                        </td>
                    </tr>
                </table>
            </div>
             <table style="width: 700px;" border="0">
             <tr>
             <td align="left" style="width:500px;vertical-align: middle; color: #336699; font-weight: bold; font-size: 12px;" >
              District :  <asp:DropDownList ID="ddlDistics" runat="server" Width="160px" AutoPostBack="True" CssClass ="FormDropdown" OnSelectedIndexChanged="ddlDistics_SelectedIndexChanged"> </asp:DropDownList>
             </td>
             <td align="right" style="width:200px; text-align :right ;padding-right :0px;"   > <a class="button"  href="SajWtpBhpAlertsSetting.aspx?opr=0"  title="Add New">Add New</a></td></tr>
              <tr><td colspan="3">
            <div align="center" > 
         
                <asp:GridView ID="GvAlertsSettings" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" EnableModelValidation="True" ForeColor="#333333" 
                    GridLines="None" Width ="700px" >
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>

                        <%--<asp:TemplateField ItemStyle-HorizontalAlign="Left"  HeaderStyle-HorizontalAlign ="Left"  >
                         <HeaderTemplate >
                         <input type ="checkbox" id="chkh" onclick ="checkall(this)"/>
                        </HeaderTemplate>
                        <ItemTemplate >
                         <input type ="checkbox" id="<%# eval("siteid")%>"  />
                        </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:TemplateField>--%>
                        <asp:BoundField DataField="Sno" HeaderText="Sno" />

                        <asp:TemplateField HeaderText="Site Name">
                        <ItemTemplate>
                        <asp:LinkButton ID ="lnksitename"  runat ="server" Text='<%# eval("Sitename") %>' onclick="lnksitename_Click" 
                                 ></asp:LinkButton>
                        </ItemTemplate>
                       
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Site Id" >
                        <ItemTemplate>
                        <asp:Label ID="LinkButton1" runat ="server" Text='<%#eval("siteid") %> '></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Dispatch No" >
                        <ItemTemplate >
                        <asp:DropDownList ID="ddlmobile" runat ="server" Width ="150px" 
                                onselectedindexchanged="ddlmobile_SelectedIndexChanged" 
                                AutoPostBack="True" ></asp:DropDownList>
                        </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:BoundField DataField="alerts" HeaderText="Alerts/Events" HtmlEncode="false"/>
                         <asp:TemplateField >
                        <ItemTemplate>
                        <asp:Button ID="imgactive" runat ="server"  CssClass ="action blue"  Style="margin-right: 0px; 
                        font-family: Verdana; font-size: small; cursor:pointer ;" Text ="Active" onclick="imgactive_Click" ></asp:Button>
                        </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField >
                        <ItemTemplate>
                        <asp:ImageButton  ID="imgdelete" runat ="server" ImageUrl ="~/images/delete.png"  ToolTip ="Delete"
                                Height ="20px" OnClientClick="return confirmation();" onclick="imgdelete_Click"></asp:ImageButton>
                        </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Size="11px"  />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB"  Font-Size="11px"/>
                    
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
          
           </div>
           </td></tr>
             </table>
    </div>
    </form>
</body>
</html>
