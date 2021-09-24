<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SajWtpBhpAlertsSetting.aspx.vb" Inherits="SajWtpBhpAlertsSetting" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript" src="js/jquery.js"></script>
     <script type="text/javascript" language="javascript" src="js/jquery-ui.js"></script>
     <link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
     <style type ="text/css" >
     .FormDropdown
     { width :150px;
         }
  
     </style>
    <script language="javascript" type ="text/javascript"  >

        $(document).ready(function () {
           
            $("#dialog-message").dialog({
                resizable: false,
                draggable: false,
                title:"Event Values",
                modal: true,
                autoOpen: false,
                width: 330,
                minHeight: 330,
                height: 330,
                buttons: {

                    Save: function () {
                        var opr = $("#hidopr").val();
                        Saveeventvalues(opr);
                    },
                    Cancel: function () {
                        var chkid = $("#hidchkid").val();
                        $("#chk" + chkid).prop('checked', false);
                        $(this).dialog("close");
                    }

                }
            });
           
        });

        var chekpos = new Array();
        var chekvalues = new Array();
        function check(chkobj) {
            var chkvalue = chkobj.checked;
            if (chkvalue == false) {
              
            }
            else {
                if (parseInt($(chkobj).val().substring(0, 2)) >= 48) {
                    checkeventvalues($("#ddlSite").val(), $(chkobj).val().substring(0, 2), $(chkobj).val());
                }
            }
        }

        function collectpositions() {
            var checked = false;
           
            for (i = 0; i < document.forms[0].elements.length; i++) {
                elm = document.forms[0].elements[i]
                if (elm.type == 'checkbox') {
                    if (elm.checked == true) {
                        chekpos.push(elm.value);
                    }
                }
            }

        }
        function checkall(chkobj) {
            var chkvalue = chkobj.checked;
            for (i = 0; i < document.forms[0].elements.length; i++) {
                elm = document.forms[0].elements[i]
                if (elm.type == 'checkbox') {
                    document.forms[0].elements[i].checked = chkvalue;
                }
            }
        }



        function onchangetxt(id) {
            var txtid = id.substring(1)
            var posid = id.substring(4);
            chekvalues[getPosition(chekpos, posid)] = $("#f" + txtid).val() + ":" + $("#t" + txtid).val();
        }
        function getPosition(arrayName, arrayItem) {
            for (var i = 0; i < arrayName.length; i++) { 
             if(arrayName[i]==arrayItem)
             return i;
            }
     }

     function checkduplicate(id) {
         var value = $("#" + id).val();
         var search = 0;
         for (var hd = 1; hd <= 10; hd++) {
             var mob = $("#mob" + hd).val();
             if (mob == value) {
                 alert("This contact allready selected..Please choose another one");
                 $("#" + id).val(0);
                 search = search + 1;
                 break;
             }
         }
         if (search == 0) {
             var idno = id.split("ddlcont")[1];
             $("#mob" + idno).val(value);
         }


     }

     function changecategory(id) {
         var catval = $("#" + id).val();
         var catidno = id.split("ddlcateg")[1];
         $("#categ" + catidno).val(catval);
      }





     function addtosettings(opr) {
         collectpositions();
         var unitinf = $('#ddlSite').val();
         $("#siteid").val(unitinf);
         var mobnums = "";
         var categories = "";
         for (var no = 1; no < 11; no++) {
             if (mobnums == "") {
                 if ($("#mob" + no).val() != "0")
                     mobnums = $("#mob" + no).val();
                 categories = $("#categ" + no).val();
             }
             else {
                 if ($("#mob" + no).val() != "0")
                     mobnums = mobnums + "," + $("#mob" + no).val();
                 categories = categories + "," + $("#categ" + no).val();
             }
         }

         var positions="";
         var values="";

         for (var i = 0; i < chekpos.length; i++) {
             if (positions == "") {
                 positions = chekpos[i];
             }
             else {
                 positions = positions + "," + chekpos[i];
             }
         }
         $("#pos").val(positions);
         $("#values").val(values);
         $("#opr").val(opr);
         $("#mobilenos").val(mobnums);
         $("#categs").val(categories);
         var excelformobj = document.getElementById("savesettings");
         excelformobj.submit();
     }

     function Getsettings(siteid, pos, value,mobile,category) {
         $("#ddlSite").val(siteid);
         var disnums = mobile.split(",");
         var num = 0;
         for (var k = 0; k < disnums.length; k++) {
             num = k + 1;
             $("#ddlcont" + num).val( disnums[k].trim());
             $("#mob" + num).val( disnums[k].trim());
         }
        
         $("#ddlcateg1").val(category);
         $("#categ1").val(category);
         var posis;
         posis = pos.split(",");
          chekvalues = value.split(",");
          var value;
          var frto;
          var posvalue="";
          for (var i = 1; i < posis.length; i++) {
              if (posis[i] <= 35)
                  $('#chk' + posis[i]).prop('checked', true);
         }
          fillequpmentvals(siteid, mobile);
        
     }
     function getequpments(value) {
         var resp;
         var lastXhr = $.getJSON("Geteventsjson.aspx?siteid=" + value+"&opr=0", resp, function (data) {
             if (data.length > 0) {
                 $("#tbevents").empty();
                 for (var i = 0; i < data.length; i++) {
                     $("#tbevents").append("<tr>");
                     $("#tbevents").append("<td><span style='cursor:pointer;text-decoration:underline;' onclick='javascript: openUpdatePopup(\"" + $("#ddlSite").val() + "\",\"" + data[i][0] + "\")'>" + data[i][1] + "<span></td>");
                     $("#tbevents").append("<td><input id='chk" + data[i][0] + "LL' type='checkbox' value='" + data[i][0] + "LL' onclick='check(this)' /></td>");
                     $("#tbevents").append("<td><input id='chk" + data[i][0] + "L' type='checkbox' value='" + data[i][0] + "L' onclick='check(this)' /></td>");
                     $("#tbevents").append("<td><input id='chk" + data[i][0] + "NN' type='checkbox' value='" + data[i][0] + "NN' onclick='check(this)' /></td>");
                     $("#tbevents").append("<td><input id='chk" + data[i][0] + "H' type='checkbox' value='" + data[i][0] + "H' onclick='check(this)' /></td>");
                     $("#tbevents").append("<td><input id='chk" + data[i][0] + "HH' type='checkbox' value='" + data[i][0] + "HH' onclick='check(this)' /></td>");
                     $("#tbevents").append("</tr>");
                 }
             }
         });
     }

     function  checkeventvalues(siteid,position,id) { 
      var resp;
      var lastXhr = $.getJSON("Geteventsjson.aspx?siteid=" + siteid + "&p=" + position + "&opr=2", resp, function (data) {
          if (data.length > 0) {
              if (data[0][0] == 0) {
                  addpopup(position,id);
              }
          }
      });
     }
     function mysubmit() {
         if (document.getElementById("txtname").value == "") {
             alert("Please enter Name of Dispatch Event Name");
             return false;
         }
         else if (document.getElementById("txtllmin").value == "") {
             alert("Please enter LL Min value");
             return false;
         }
         else if (document.getElementById("txtllmax").value == "") {
             alert("Please enter LL Max value");
             return false;
         }

         else if (document.getElementById("txtlmin").value == "") {
             alert("Please enter L Min value");
             return false;
         }
         else if (document.getElementById("txtlmax").value == "") {
             alert("Please enter L Max value");
             return false;
         }
         else if (document.getElementById("txtnnmin").value == "") {
             alert("Please enter NN Min value");
             return false;
         }
         else if (document.getElementById("txtnnmax").value == "") {
             alert("Please enter NN Max value");
             return false;
         }
         else if (document.getElementById("txthmin").value == "") {
             alert("Please enter H Min value");
             return false;
         }
         else if (document.getElementById("txthmax").value == "") {
             alert("Please enter H Max value");
             return false;
         }
         else if (document.getElementById("txthhmin").value == "") {
             alert("Please enter HH Min value");
             return false;
         }
         else if (document.getElementById("txthhmax").value == "") {
             alert("Please enter HH Max value");
             return false;
         }
         else
             return true;
        
     }
     function Saveeventvalues(subopr) {
         var resp;
         var res = mysubmit();
         if (res == true) {
             var lastXhr = $.getJSON("Geteventsjson.aspx?siteid=" + $("#hidsiteid").val() + "&p=" + $("#hidpos").val() + "&pname=" + $("#txtname").val() + "&llmin=" + $("#txtllmin").val() + "&llmax=" + $("#txtllmax").val() + "&lmin=" + $("#txtlmin").val() + "&lmax=" + $("#txtlmax").val() + "&nnmin=" + $("#txtnnmin").val() + "&nnmax=" + $("#txtnnmax").val() + "&hmin=" + $("#txthmin").val() + "&hmax=" + $("#txthmax").val() + "&hhmin=" + $("#txthhmin").val() + "&hhmax=" + $("#txthhmax").val() + "&tlimit1=" + $("#txttlimit1").val() + "&tlimit2=" + $("#txttlimit2").val() + "&opr=3&subopr=" + subopr + "", resp, function (data) {
                 if (data.length > 0) {
                     if (data[0][0] == 0) {
                         var chkid = $("#hidchkid").val();
                         $("#chk" + chkid).prop('checked', false);
                     }
                     else {
                         $("#dialog-message").dialog("close");
                     }
                 }
             });
         }
     }


     function addpopup(position,id) {
         $("#hidsiteid").val($("#ddlSite").val());
         $("#hidpos").val(position);
         $("#hidchkid").val(id);
         $("#dialog-message").dialog("open");
         $("#hidopr").val(0);
         $("#txtname").val("");
         $("#txtllmin").val("");
         $("#txtllmax").val("");
         $("#txtlmin").val("");
         $("#txtlmax").val("");
         $("#txtnnmin").val("");
         $("#txtnnmax").val("");
         $("#txthmin").val("");
         $("#txthmax").val("");
         $("#txthhmin").val("");
         $("#txthhmax").val("");
         $("#txttlimit1").val("");
         $("#txttlimit2").val("");
     }
     function openUpdatePopup(siteid, position) {
         $("#hidsiteid").val(siteid);
         $("#hidopr").val(1);
         $("#hidpos").val(position);
         var resp;
         var lastXhr = $.getJSON("Geteventsjson.aspx?siteid=" + siteid + "&p=" + position + "&opr=4", resp, function (data) {
             if (data.length > 0) {
                 $("#txtname").val(data[0][0]);
                 $("#txtllmin").val(data[0][1]);
                 $("#txtllmax").val(data[0][2]);
                 $("#txtlmin").val(data[0][3]);
                 $("#txtlmax").val(data[0][4]);
                 $("#txtnnmin").val(data[0][5]);
                 $("#txtnnmax").val(data[0][6]);
                 $("#txthmin").val(data[0][7]);
                 $("#txthmax").val(data[0][8]);
                 $("#txthhmin").val(data[0][9]);
                 $("#txthhmax").val(data[0][10]);
                 $("#txttlimit1").val(data[0][11]);
                 $("#txttlimit2").val(data[0][12]);
                 if (data[0][11] == "0")
                     $("#hidopr").val(0);
                 else
                     $("#hidopr").val(1);
             }
         });
         $("#dialog-message").dialog("open");
     }
     function fillequpmentvals(siteid, dispatchno) {
         var resp;
         var positions="LL,L,NN,H,HH";
         var values = new Array(7);
         var pos;
         var find=0;
         var lastXhr = $.getJSON("Geteventsjson.aspx?siteid=" + siteid + "&dis=" + dispatchno + "&opr=1", resp, function (data) {
             if (data.length > 0) {
                 $("#tbevents").empty();
                 for (var i = 0; i < data.length; i++) {
                     values = data[i].split(",");
                     pos = positions.split(",");
                     $("#tbevents").append("<tr>");
                     $("#tbevents").append("<td><span style='cursor:pointer;text-decoration:underline;' onclick='javascript: openUpdatePopup(\"" + $("#ddlSite").val() + "\",\"" + values[1] + "\")'>" + values[0] + "<span></td>");
                     for (var k = 0; k < pos.length; k++) {
                         for (var l = 2; l < values.length; l++) {
                             if (pos[k] == values[l].substring(2)) {
                                 $("#tbevents").append("<td><input id='chk" + values[l] + "' type='checkbox' checked='true'  value='" + values[l] + "' onclick='check(this)' /></td>");
                                 find = 1;
                                 break;
                             }
                         }
                         if (find != 1)
                             $("#tbevents").append("<td><input id='chk" + values[1] + pos[k] + "' type='checkbox'   value='" + values[1] + pos[k] + "' onclick='check(this)' /></td>");
                         else
                             find = 0;

                     }
                     //                    $("#tbevents").append("<td><input id='chk" + values[0] + "LL' type='checkbox'   value='" + values[0] + "LL' onclick='check(this)' /></td>");
                     //                     $("#tbevents").append("<td><input id='chk" + values[0] + "L' type='checkbox' value='" + values[0] + "L' onclick='check(this)' /></td>");
                     //                     $("#tbevents").append("<td><input id='chk" + values[0] + "NN' type='checkbox' value='" + values[0] + "NN' onclick='check(this)' /></td>");
                     //                     $("#tbevents").append("<td><input id='chk" + values[0] + "H' type='checkbox' value='" + values[0] + "H' onclick='check(this)' /></td>");
                     //                     $("#tbevents").append("<td><input id='chk" + values[0] + "HH' type='checkbox' value='" + values[0] + "HH' onclick='check(this)' /></td>");
                     $("#tbevents").append("</tr>");
                 }
             }
         });
     }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center >
    <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
      <td>
<p align="center">
<br>
<div align="center" style="font-family :Verdana;font-size:16px; color:#5373A2;font-weight:bold;" >Add Alert Settings</div>
<%--<div align="center" id="Error"><font color="<%=strErrorColor%>" size="2" face="Verdana"><b>&nbsp;<%=strError%></b></font></div>--%>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0" width="400" height="100" style="border: 2 double #CFD9E7">
    <tr>
      <td>
        <div align="center">
          <br>
          <table  cellpadding="5" width="800" height="20" frame="box" >
            <tr>
            <td colspan ="3">
             <table width ="100%" ><tr>
              <td  height="15" style ="text-align :left;"><b><font size="1" face="Verdana" color="#5373A2">Site Name</font></b></td>
              <td  height="15"><b><font color="#5373A2">:</font></b></td>
              <td  height="15" align="left" >
               <asp:DropDownList ID="ddlSite" runat ="server" CssClass ="FormDropdown" 
                      Width="220px" onChange="getequpments(this.value)"></asp:DropDownList>
              </td>
             </tr>
             </table>
            </td>
             
            </tr>
            <tr><td colspan='3'>
            <fieldset title="Contacts " text="Select Contacts">
              <legend><b><font size="2" face="Verdana" color="#5373A2" >Contacts list</font></b></legend>
            <table width ="100%">
            <tr><td align="left" ><b><font size="1" face="Verdana" color="#5373A2">Contact 1</font></b></td><td><select class='FormDropdown' id='ddlcont1' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg1'  onchange='changecategory(this.id)'><option value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td><td align="left"><b><font size="1" face="Verdana" color="#5373A2">Contact 6</font></b></td><td><select class='FormDropdown' id='ddlcont6' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg6'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td></tr>
             <tr><td align="left" ><b><font size="1" face="Verdana" color="#5373A2">Contact 2</font></b></td><td><select class='FormDropdown' id='ddlcont2' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg2'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td><td align="left"><b><font size="1" face="Verdana" color="#5373A2">Contact 7</font></b></td><td><select class='FormDropdown' id='ddlcont7' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg7'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td></tr>
              <tr><td align="left" class="style1" ><b><font size="1" face="Verdana" color="#5373A2">Contact 3</font></b></td>
                  <td class="style1"><select class='FormDropdown' id='ddlcont3' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg3'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td>
                  <td align="left" class="style1"><b><font size="1" face="Verdana" color="#5373A2">Contact 8</font></b></td>
                  <td class="style1"><select class='FormDropdown' id='ddlcont8' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg8'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td></tr>
               <tr><td align="left" ><b><font size="1" face="Verdana" color="#5373A2">Contact 4</font></b></td><td><select class='FormDropdown' id='ddlcont4' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg4'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td><td align="left"><b><font size="1" face="Verdana" color="#5373A2">Contact 9</font></b></td><td><select class='FormDropdown' id='ddlcont9' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg9'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td></tr>
                <tr><td align="left" ><b><font size="1" face="Verdana" color="#5373A2">Contact 5</font></b></td><td><select class='FormDropdown' id='ddlcont5' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg5'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option value ="2">Categ 2</option><option value ="3">Both</option></select></td><td align="left"><b><font size="1" face="Verdana" color="#5373A2">Contact 10</font></b></td><td><select class='FormDropdown' id='ddlcont10' onchange='checkduplicate(this.id)' ><option value='0'>SELECT CONTACT</option><%=sb1 .ToString () %></select> </td><td><select id='ddlcateg10'  onchange='changecategory(this.id)'><option  value ="1">Categ 1</option><option  value ="2">Categ 2</option><option value ="3">Both</option></select></td></tr>
            </table>
            </fieldset>
            </td></tr>
            <tr>
          <td style="width:40%;vertical-align:top ;">
          <fieldset style ="height :80px;" >
          <legend ><font size="2" face="Verdana" color="#5373A2" >Power Alerts</font></legend>
            <table style="width:100%;text-align:left;font-family :Verdana;font-size:11px; color:#5373A2;" align="right" >
             <tbody >
             <tr><td style ="width :40%;"><input id="chk2" type="checkbox" name="chk1" value="2" onclick="check(this)" />AC Status  </td></tr>
             <tr><td style ="width :60%;"><input id="chk3" type="checkbox" name="chk1" value="3" onclick="check(this)" />DC Status</td></tr>
          
            </tbody>
            </table>
          </fieldset>
          </td>
          <td colspan="2" style="width:60%;vertical-align:top ;">
            <fieldset  style ="height :80px;" >
          <legend ><font size="2" face="Verdana" color="#5373A2" >Level Alerts</font> </legend>
           <table style="width:100%;text-align:left;font-family :Verdana;font-size:11px; color:#5373A2;" align="right" >
            <thead align ="left" >
             <tr><th style ="width :20%;">Level </th><th style ="width :20%;">LL Status </th><th style ="width :20%;">L Status</th><th style ="width :20%;">H Status </th><th style ="width :20%;">HH Status </th></tr>
            </thead>
            <tbody >
            <tr><td >Level1</td><td><input id="chk32" type="checkbox" name="chk4" value="32" onclick="check(this)" /></td><td><input id="chk28" type="checkbox" name="chk4" value="28" onclick="check(this)" /></td><td><input id="chk29" type="checkbox" name="chk1" value="29" onclick="check(this)" /></td><td><input id="chk33" type="checkbox" name="chk1" value="33" onclick="check(this)" /></td></tr>
            <tr><td>Level2</td><td><input id="chk34" type="checkbox" name="chk1" value="34" onclick="check(this)" /></td> <td ><input id="chk30" type="checkbox" name="chk1" value="30" onclick="check(this)" /></td><td><input id="chk31" type="checkbox" name="chk1" value="31" onclick="check(this)" /></td><td><input id="chk35" type="checkbox" name="chk1" value="35" onclick="check(this)" /></td></tr> 
           
            </tbody>
            </table>
            </fieldset>
          </td>
          </tr>
          <tr>
          <td style="vertical-align:top ;" >
          <fieldset >
          <legend ><font size="2" face="Verdana" color="#5373A2" >Pump Alerts</font></legend>
           <table style="width:100%;text-align:left;font-family :Verdana;font-size:11px; color:#5373A2;" align="right" >
            <thead align ="left" >
             <tr><th style ="width :20%;">Pump </th><th style ="width :20%;">Status </th><th style ="width :25%;">Trip Status </th><th style ="width :35%;">Remote Status </th></tr>
            </thead>
            <tbody >
             <tr><td>Pump 1</td><td><input id="chk4" type="checkbox" name="chk4" value="4" onclick="check(this)" /></td><td><input id="chk5" type="checkbox" name="chk1" value="5" onclick="check(this)" /></td><td><input id="chk6" type="checkbox" name="chk1" value="6" onclick="check(this)" /></td></tr>
             <tr><td>Pump 2</td><td><input id="chk7" type="checkbox" name="chk4" value="7" onclick="check(this)" /> </td><td><input id="chk8" type="checkbox" name="chk1" value="8" onclick="check(this)" /></td><td><input id="chk9" type="checkbox" name="chk1" value="9" onclick="check(this)" /></td></tr>
             <tr><td>Pump 3</td><td><input id="chk10" type="checkbox" name="chk4" value="10" onclick="check(this)" /></td><td><input id="chk11" type="checkbox" name="chk1" value="11" onclick="check(this)" /></td><td><input id="chk12" type="checkbox" name="chk1" value="12" onclick="check(this)" /></td></tr>
             <tr><td>Pump 4</td><td><input id="chk13" type="checkbox" name="chk4" value="13" onclick="check(this)" /> </td><td><input id="chk14" type="checkbox" name="chk1" value="14" onclick="check(this)" /></td><td><input id="chk15" type="checkbox" name="chk1" value="15" onclick="check(this)" /></td></tr>
             <tr><td>Pump 5</td><td><input id="chk16" type="checkbox" name="chk4" value="16" onclick="check(this)" /></td><td><input id="chk17" type="checkbox" name="chk1" value="17" onclick="check(this)" /></td><td><input id="chk18" type="checkbox" name="chk1" value="18" onclick="check(this)" /></td></tr>
             <tr><td>Pump 6</td><td><input id="chk19" type="checkbox" name="chk4" value="19" onclick="check(this)" /> </td><td><input id="chk20" type="checkbox" name="chk1" value="20" onclick="check(this)" /></td><td><input id="chk21" type="checkbox" name="chk1" value="21"  onclick="check(this)" /></td></tr>
             <tr><td>Pump 7</td><td><input id="chk22" type="checkbox" name="chk4" value="22" onclick="check(this)" /> </td><td><input id="chk23" type="checkbox" name="chk1" value="23"  onclick="check(this)"/></td><td><input id="chk24" type="checkbox" name="chk1" value="24" onclick="check(this)" /></td></tr>
             <tr><td>Pump 8</td><td><input id="chk25" type="checkbox" name="chk4" value="25" onclick="check(this)" /></td><td><input id="chk26" type="checkbox" name="chk1" value="26" onclick="check(this)" /></td><td><input id="chk27" type="checkbox" name="chk1" value="27" onclick="check(this)" /></td></tr>
          </tbody>
           </table>
          </fieldset>
          </td>
            <td style="vertical-align:top ;"  colspan="2" >
             <fieldset id="evtdata">
            <legend ><font size="2" face="Verdana" color="#5373A2" >Events</font> </legend>


            <table style='width:100%;text-align:left;font-family :Verdana;font-size:11px; color:#5373A2;' align='right' >
                <thead  align="left" ><tr><th >Event </th><th >LL </th><th >L </th><th >NN </th><th >H</th><th >HH </th></tr></thead>
                <tbody id="tbevents">

                </tbody>
            </table>
            </fieldset>
            </td>
        
          </tr>
          <tr><td colspan="3">
          
           </td></tr>
           <tr>
           <td colspan="3">
          
            </td></tr>
          </table>
         </div>
          </td>
          </tr>
          <%  If opr = 0 Then %>
                <tr><td colspan="9" align="right" ><a href="javascript:addtosettings(0)"><img src="images/Submit_s.jpg" border=0></a></td></tr>
                  <% ElseIf opr = 1 Then %>

                      <tr><td colspan="9" align="right" ><a href="javascript:addtosettings(1)"><img src="images/Submit_s.jpg" border=0></a></td></tr>
                  <% End If%>
          </table>
        </div>
        <input type="hidden" id="hidopr" value="0" />
         <input type="hidden" id="mob1" runat="server" value="0" />
          <input type="hidden" id="mob2" runat="server" value="0" />
           <input type="hidden" id="mob3" runat="server" value="0" />
            <input type="hidden" id="mob4" runat="server" value="0" />
             <input type="hidden" id="mob5" runat="server" value="0" />
              <input type="hidden" id="mob6" runat="server" value="0" />
               <input type="hidden" id="mob7" runat="server" value="0" />
                <input type="hidden" id="mob8" runat="server" value="0" />
                 <input type="hidden" id="mob9" runat="server" value="0" />
                  <input type="hidden" id="mob10" runat="server" value="0" />
                     <input type="hidden" id="categ1" runat="server" value="1" />
          <input type="hidden" id="categ2" runat="server" value="1" />
           <input type="hidden" id="categ3" runat="server" value="1" />
            <input type="hidden" id="categ4" runat="server" value="1" />
             <input type="hidden" id="categ5" runat="server" value="1" />
              <input type="hidden" id="categ6" runat="server" value="1" />
               <input type="hidden" id="categ7" runat="server" value="1" />
                <input type="hidden" id="categ8" runat="server" value="1" />
                 <input type="hidden" id="categ9" runat="server" value="1" />
                  <input type="hidden" id="categ10" runat="server" value="1" />
                  
                   <input type="hidden" id="hidsiteid" value="0" />
                     <input type="hidden" id="hidpos" value="0" />
    <input type="hidden" id="hidchkid" value="0" />
    </td>
    </tr>
    </table>
  </center>
    </div>
    <div style ="width :300px;" id="dialog-message">
   <table style='width:100%;text-align:left;font-family :Verdana;font-size:11px; color:#5373A2;' align='right' >
    <tr><td >Name</td><td colspan ="2"><input type ="text" id="txtname" style="width:150px;" /></td></tr>
    <thead><tr align="left" ><th></th><th>Min</th><th>Max</th></tr></thead>
    <tbody>
    <tr><td>LL</td><td><input type ="text" id="txtllmin" style="width:50px;" /></td><td><input type ="text" id="txtllmax" style="width:50px;" /></td></tr>
    <tr><td>L</td><td><input type ="text" id="txtlmin" style="width:50px;" /></td><td><input type ="text" id="txtlmax" style="width:50px;" /></td></tr>
    <tr><td>NN</td><td><input type ="text" id="txtnnmin" style="width:50px;" /></td><td><input type ="text" id="txtnnmax" style="width:50px;" /></td></tr>
    <tr><td>H</td><td><input type ="text" id="txthmin" style="width:50px;" /></td><td><input type ="text" id="txthmax" style="width:50px;" /></td></tr>
    <tr><td>HH</td><td><input type ="text" id="txthhmin" style="width:50px;" /></td><td><input type ="text" id="txthhmax" style="width:50px;" /></td></tr>
     <tr><td colspan ="2">SMS Send Time For Category 1</td><td><input type ="text" id="txttlimit1" style="width:50px;" /></td></tr>
    <tr><td colspan ="2">SMS Send Time For Category 2 </td><td><input type ="text" id="txttlimit2" style="width:50px;" /></td></tr>
    </tbody>
    </table>
    </div>
    </form>
       <form id="savesettings" method="post" action="HelperPages/AddUpdateSettingsHelper.aspx">
       <input type="hidden" id="siteid" name="siteid" value="" />
        <input type="hidden" id="pos" name="pos" value="" />
        <input type="hidden" id="values" name="values" value="" />
          <input type="hidden" id="mobilenos" name="mobilenos" value="" />
           <input type="hidden" id="categs" name="categs" value="" />
            <input type="hidden" id="opr" name="opr" value="" />
    </form>
</body>
</html>
