
var oTable;
var oTable1;
$(function () {
    refreshTable();
    $('#txtCaption').attr("disabled", true);
    $('#txtOsdintervel').attr("disabled", true);
    $('#txtIntervelmin').attr("disabled", true);
    $('input:radio[name=osdemail]').on('ifChecked', function (event) {
        var osdormail = $('input:radio[name=osdemail]:checked').val();
        if (osdormail == "0") {
            $('#txtCaption').attr("disabled", true);
            $('#divOsddisplay :input').removeAttr('disabled');
            $('#divOsdType :input').removeAttr('disabled');
            $('#divOsdFrequency :input').removeAttr('disabled');
            $('#divMsgDuration :input').removeAttr('disabled');
            $('#divIntervel :input').removeAttr('disabled');
            var freq = $('input:radio[name=Frequency]:checked').val();
            if (freq == "0") {
                $('#txtOsdintervel').attr("disabled", true);
                $('#txtMduration').removeAttr('disabled');
            }
            else {
                $('#txtOsdintervel').removeAttr('disabled');
                $('#txtMduration').attr('disabled', true);
            }
        }
        else {
            $('#txtCaption').removeAttr('disabled');
            $('#divOsddisplay :input').attr('disabled', true);
            $('#divOsdType :input').attr('disabled', true);
            $('#divOsdFrequency :input').attr('disabled', true);
            $('#divMsgDuration :input').attr('disabled', true);
            $('#divIntervel :input').attr('disabled', true);
        }
    });
    $('input:radio[name=Frequency]').on('ifChecked', function (event) {
        var freq = $('input:radio[name=Frequency]:checked').val();
        if (freq == "0") {
            $('#txtOsdintervel').attr("disabled", true);
            $('#txtMduration').removeAttr('disabled');
        }
        else {
            $('#txtOsdintervel').removeAttr('disabled');
            $('#txtMduration').attr('disabled', true);
        }
    });

    $('input:radio[name=noofdisplay]').on('ifChecked', function (event) {
        var freq = $('input:radio[name=noofdisplay]:checked').val();
        if (freq == "0") {
            $('#txtIntervelmin').attr("disabled", true);
            $('#txttimes').removeAttr('disabled');
        }
        else {
            $('#txtIntervelmin').removeAttr('disabled');
            $('#txttimes').attr('disabled', true);

        }
    });
    $('input:radio[name=fptype]').on('ifChecked', function (event) {
        var type = $('input:radio[name=fptype]:checked').val();
        if (type == "0") {
            $('#ddlfpChannel').val(0);
            $('#ddlfpChannel').attr("disabled", true);
        }
        else {
            $('#ddlfpChannel').removeAttr('disabled');
            $('#ddlfpChannel').val(0);
        }
    });

    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-green',
        radioClass: 'iradio_flat-green'
    });

    $('input[type="radio"].flat-red').on('ifChecked', function (event) {
        checkpaytype(this);
    });

});

function alertbox(message) {
    $("#alertmsg").html(message);
    $("#modal-Alert").modal('show');
}

function poPupClose() {
    $("#OperationModal").modal('hide');
}

function OsdMailPopup(scard, sender, isglobal) {
   
    $('#txtCaption').val("");
    $('#txtMessage').val("");
    $("#btnSave").attr("onclick", "sendOsdmail('" + scard + "','" + sender + "','" + isglobal + "')");
    $("#ModalOSD").modal('show');
}

function FPPopup(scard, sender, isglobal) {
    $('#ddlfpChannel').val(0);
    $("#btnfpSave").attr("onclick", "SendFingerPrint('" + scard + "','" + sender + "','" + isglobal + "')");
    $("#ModalFingerPrint").modal('show');
}


var pkgs = new Array();
function SendSubscribercommand(operation) {
    Openloader();
    var subno = $("#txtSubid").val();
    var paymode = $("#hidpaymode").val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/SuspendSubscriber",
        data: '{subscriberno:  \"' + subno + '\",paymode: \"' + paymode + '\",packagename: ' + JSON.stringify(pkgs) + ',operation: \"' + operation + '\"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#OperationModal").modal('hide');
            refreshTable();
        },
        failure: function (response) {
            alert("Failed");
        },
        async: false
    });
    Closeloader();
}

function DeletePackage(pkno, startdate, enddate) {
    Openloader();
    var subno = $("#txtSubid").val();
    var stbno = $("#txtStb").val();
    var scnum = $("#txtSmartcard").val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/DeletePackage",
        data: '{subid:  \"' + subno + '\",stbnum:  \"' + stbno + '\",scnumber:  \"' + scnum + '\",PackageNumber: ' + pkno + ',startdate:\"' + startdate + '\",enddate: \"' + enddate + '\"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#OperationModal").modal('hide');
        },
        failure: function (response) {
            alert("Failed");
        },
        async: false
    });
    Closeloader();
}

function sendOsdmail(scard, username, isglobal) {
    Openloader();
    var sccards = new Array();
    sccards.push(scard);
    var global = "0";
    if (isglobal == "0") {
        global = "0";
    }
    else if (isglobal == "1") {
        global = "1";
    }
    var osdormail = $('input:radio[name=osdemail]:checked').val();
    var osddiaplay = $('input:radio[name=osddisplay]:checked').val();
    var osdType = $('input:radio[name=osdType]:checked').val();
    var osdFequency = $('input:radio[name=Frequency]:checked').val();
    var Slocation = $('#ddlScroll').val();
    var channelno = $('#ddlChannel').val();
    var duration = $('#txtMduration').val();
    var intervel = $('#txtOsdintervel').val();
    var caption = $('#txtCaption').val();
    var message = $('#txtMessage').val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/SendOSDMails",
        data: '{isglobal:\"' + global + '\",strCard:' + JSON.stringify(sccards) + ',osdormail:\"' + osdormail + '\",osddisplay:\"' + osddiaplay + '\",osdlocation:\"' + Slocation + '\",osdtype:\"' + osdType + '\",channel:\"' + channelno + '\",msgduration:\"' + duration + '\",sender:\"' + username + '\",caption:\"' + caption + '\",message:\"' + message + '\"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#ModalOSD").modal('hide');
        },
        failure: function (response) {
            alert("Failed");
        },
        async: false
    });

    Closeloader();
}

function SendFingerPrint(scard, username, isglobal) {
    Openloader();
    var sccards = new Array();
    sccards.push(scard);
    var global = false;
    if (isglobal == "0") {
        global = false;
    }
    else if (isglobal == "1") {
        global = true;
    }
    var ecmchannel = $('#ddlfpChannel').val();
    var fpchannel;
    if (ecmchannel == 0) {
        fpchannel = false;
    }
    else {
        fpchannel = true;
    }
    var fptype = $('#ddlFptype').val();
    var fpDisplay = $('#ddlFpDisplay').val();
    var fpTranceperency = $('#txtTransparency').val();
    var fontcolor = $('#ddltextColor').val();
    var bgcolor = $('#ddlbgColor').val();
    var fontsize = $('#ddlFontsize').val();
    var Cycletime = $('#txtCycletime').val();
    var duration = $('#txtDurationtime').val();
    var displaycnt = $('#txtDisCnt').val();
    var locationtype = $('#ddlLocation').val();
    var location = $('#txtLocation').val();
    var random;
    if ($("#chkRandom").is(':checked')) {
        random = true;
    }
    else {
        random = false;
    }

    var diaplaytimes = $('input:radio[name=noofdisplay]:checked').val();
    var nooftimes = $('#txttimes').val();
    var displaytime = $('#txtIntervelmin').val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/SendFingerprint",
        data: '{position:\"' + location + '\",isglobal:' + global + ',fpchannel:' + fpchannel + ',strCard:' + JSON.stringify(sccards) + ',fptime:\"' + duration + '\",fpbackcolor:' + bgcolor + ',fptextcolor:' + fontcolor + ',fpcycletime:\"' + Cycletime + '\",fpdisplycnt:\"' + displaycnt + '\",fpfontsize:' + fontsize + ',fpfonttype:' + fptype + ',fpdiaplay:' + fpDisplay + ',fptrancparency:\"' + fpTranceperency + '\",fplocationtype:' + locationtype + ',random:' + random + ',channel:' + ecmchannel + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#ModalFingerPrint").modal('hide'); 
        },
        failure: function (response) {
            alert("Failed");
        },
        async: false
    });
    Closeloader();
}

function SuspendSub(subno, smartcardno, stbno, name, lco, paymode, status) {
    Openloader();
    $("#txtSubid").val(subno);
    $("#txtSmartcard").val(smartcardno);
    $("#txtStb").val(stbno);
    $("#txtName").val(name);
    $("#txtLco").val(lco);
    $("#hidpaymode").val(paymode);
    pkgs.length = 0;
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/getSubpackageDetails",
        data: '{subno:  \"' + subno + '\",paymode: \"' + paymode + '\",opr: \"0\"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var json = response;
            table = $('#tblPackages').DataTable({
                "destroy": true,
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "columnDefs": [
                                            { "sortable": false, "targets": [0] },
                                            { "sortable": false, "targets": [1] }
                                            ]
            });
            // table._fnProcessingDisplay(true);
            oSettings = table.settings();
            table.clear();
            for (var i = 0; i < response.length; i++) {
                table.row.add(response[i]);
                pkgs.push(response[i][2])
                // table.oApi._fnAddData(oSettings, response[i]);
            }

            table.draw();

        },
        failure: function (response) {
            alertbox("Failed");
        },
        async: false

    });
    $('#tblPackages').DataTable({
        "destroy": true,
        "paging": false,
        "lengthChange": false,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "scrollY": "300px"
    });
    if (status == "Active") {

        $("#btnResume").attr("disabled", true);
        $("#btnSuspend").attr("disabled", false);
    }
    else if (status == "In Active") {
        $("#btnResume").attr("disabled", false);
        $("#btnSuspend").attr("disabled", true);
    }
    else {
        $("#btnResume").attr("disabled", true);
        $("#btnSuspend").attr("disabled", true);
        $("#btnUpdatepkg").attr("disabled", true);
    }

    $("#OperationModal").modal('show');
    Closeloader();
}

function RenewalSub(subno, smartcardno, stbno, name, lco, paymode, status) {
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/getSubpackageDetails",
        data: '{subno:  \"' + subno + '\",paymode: \"' + paymode + '\",opr: \"1\"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var json = response;
            table = $('#tblRenewpkgs').DataTable({
                "destroy": true,
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "columnDefs": [
                                            { "sortable": false, "targets": [0] },
                                            { "sortable": false, "targets": [1] }
                                            ]
            });
            // table._fnProcessingDisplay(true);
            oSettings = table.settings();
            table.clear();
            for (var i = 0; i < response.length; i++) {
                table.row.add(response[i]);
                pkgs.push(response[i][2])
                // table.oApi._fnAddData(oSettings, response[i]);
            }

            table.draw();

        },
        failure: function (response) {
            alertbox("Failed");
        },
        async: false

    }); 
    $("#btnRenew").attr("onclick", "RenewalPackage('" + subno + "','" + smartcardno + "','" + stbno + "','" + name + "','" + lco + "','" + paymode + "','" + status + "')")
    $("#ModalRenew").modal('show');

}

function RenewalPackage(subid, scnum, stbnum, name, lcoid, paymode, status) { 
 
    var durationtype = $('#ddlRDuration').val();
    var distype = $('#ddlRDisType').val();
    var tax = $('#txtRTax').val();
    var vat = $('#txtRVat').val();
    var paidamt = $('#txtRpaidMoney').val();
    var paytype = paymenttype;
    var paymentamt = $('#txtRPayamount').val();
    var returnamt = $('#txtRReturnAmt').val();
    var CardType = $('#ddlRCType').val();
    var CardName = $('#ddlRBankName').val();
    var ApprCode = $('#txtRappcode').val();
    var RrefCode = $('#txtRrefcode').val();

    if (paidamt.trim() == "") {
        alertbox("Please Enter Paid Amount");
    }
    else if (paymentamt.trim() == "") {
        alertbox("Please Enter Payment Amount");
    }
    else if (chekitems.length == 0) {
        alertbox("Please Select Packages to Add");
    }
    else {
        $.ajax({
            type: "POST",
            url: "SmartSubscriber.aspx/RenewalPackage",
            data: '{subid:  \"' + subid + '\",stbnum:  \"' + stbnum + '\",scnumber:  \"' + scnum + '\" ,existpkgs: ' + JSON.stringify(pkgs) + ',renualpkgs: ' + JSON.stringify(chekitems) + ',duration_type: \"' + durationtype + '\",dis_type: \"' + distype + '\", tax: \"' + tax + '\" ,vat: \"' + vat + '\" ,paidamt:  ' + paidamt + ' ,paytype: \"' + paytype + '\",paymentamt: ' + paymentamt + ' ,returnamt: ' + returnamt + ' ,CardType: \"' + CardType + '\" ,CardName: \"' + CardName + '\" ,ApprCode: \"' + ApprCode + '\",RrefCode: \"' + RrefCode + '\",lcoid: \"' + lcoid + '\"  }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $("#OperationModal").modal('hide');
            },
            failure: function (response) {
                alert("Failed");
            },
            async: false
        });
    }
    Closeloader();

}




function OpenAddPkgPopup() {
    Openloader();
    var subno = $('#txtSubid').val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/FillUnAssignedPackages",
        data: '{subno:  \"' + subno + '\" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var json = response;
            table = $('#tblNewPackages').DataTable({
                "destroy": true,
                "paging": false,
                "lengthChange": false,
                "searching": false,
                "columnDefs": [
                                            { "sortable": false, "targets": [0] },
                                            { "sortable": false, "targets": [1] }
                                            ]
            });
            // table._fnProcessingDisplay(true);
            oSettings = table.settings();
            table.clear();
            for (var i = 0; i < response.length; i++) {
                table.row.add(response[i]);
                // table.oApi._fnAddData(oSettings, response[i]);
            }

            table.draw();

        },
        failure: function (response) {
            alertbox("Failed");
        },
        async: false

    });

    $("#ModalAddPkg").modal('show');
    Closeloader();
}





function Addpackage() {
    Openloader();
    var scnum = $("#txtSmartcard").val();
    var subid = $('#txtSubid').val();
    var stbnum = $('#txtSmartcard').val();
    var lcoid = $('#txtLco').val();
    var durationtype = $('#ddlDuration').val();
    var distype = $('#ddlDisType').val();
    var tax = $('#txtTax').val();
    var vat = $('#txtVat').val();
    var paidamt = $('#txtpaidMoney').val();
    var paytype = paymenttype;
    var paymentamt = $('#txtPayamount').val();
    var returnamt = $('#txtReturnAmt').val();
    var CardType = $('#ddlCType').val();
    var CardName = $('#ddlBankName').val();
    var ApprCode = $('#txtappcode').val();
    var RrefCode = $('#txtrefcode').val();

    if (paidamt.trim() == "") {
        alertbox("Please Enter Paid Amount");
    }
    else if (paymentamt.trim() == "") {
        alertbox("Please Enter Payment Amount");
    }
    else if (addedpkgs.length == 0) {
        alertbox("Please Select Packages to Add");
    }
    else {
        $.ajax({
            type: "POST",
            url: "SmartSubscriber.aspx/AddPackage",
            data: '{subid:  \"' + subid + '\",stbnum:  \"' + stbnum + '\",scnumber:  \"' + scnum + '\" ,existpkgs: ' + JSON.stringify(pkgs) + ',packagename: ' + JSON.stringify(addedpkgs) + ',duration_type: \"' + durationtype + '\",dis_type: \"' + distype + '\", tax: \"' + tax + '\" ,vat: \"' + vat + '\" ,paidamt:  ' + paidamt + ' ,paytype: \"' + paytype + '\",paymentamt: ' + paymentamt + ' ,returnamt: ' + returnamt + ' ,CardType: \"' + CardType + '\" ,CardName: \"' + CardName + '\" ,ApprCode: \"' + ApprCode + '\",RrefCode: \"' + RrefCode + '\",lcoid: \"' + lcoid + '\"  }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $("#OperationModal").modal('hide');
            },
            failure: function (response) {
                alert("Failed");
            },
            async: false
        });
    }
    Closeloader();

}


function Deletesubscriber() {
    Openloader(); 
    var scnum = $("#txtSmartcard").val();
    var subid = $('#txtSubid').val();
    var stbnum = $('#txtSmartcard').val();
    var lcoid = $('#txtLco').val();  
        $.ajax({
            type: "POST",
            url: "SmartSubscriber.aspx/DeleteSubscriber",
            data: '{subid:  \"' + subid + '\",stbnum:  \"' + stbnum + '\",scnumber:  \"' + scnum + '\" ,existpkgs: ' + JSON.stringify(pkgs) + '  }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $("#OperationModal").modal('hide');
            },
            failure: function (response) {
                alert("Failed");
            }
        }); 
    Closeloader();

}


function confirmDialog(message) {
    var fClose = function () {
        modal.modal("hide");
    };
    var modal = $("#modal-Conform");
    modal.modal("show");
    $("#confmmsg").empty().html(message);
    $("#confirmok").one('click', Deletesubscriber);
    $("#confirmok").one('click', fClose); 
}

function Computefee() { 
    var durationtype = $('#ddlDuration').val();
    var distype = $('#ddlDisType').val();
    var tax = $('#txtTax').val();
    var vat = $('#txtVat').val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/CaliculatePkgfee",
        data: '{pkgids: ' + JSON.stringify(addedpkgs) + ',duration_type:  \"' + durationtype + '\",dis_type: ' + distype + ',tax: ' + tax + ',vat: ' + vat + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#txtTotmoney").val(response.d.total.toFixed(2))
        },
        failure: function (response) {
            alert("Failed");
        },
        async: false
    });
}

function Computerenewfee() {
    var durationtype = $('#ddlRDuration').val();
    var distype = $('#ddlRDisType').val();
    var tax = $('#txtRTax').val();
    var vat = $('#txtRVat').val();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/CaliculatePkgfee",
        data: '{pkgids: ' + JSON.stringify(chekitems) + ',duration_type:  \"' + durationtype + '\",dis_type: ' + distype + ',tax: ' + tax + ',vat: ' + vat + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#txtRTotmoney").val(response.d.total.toFixed(2))
        },
        failure: function (response) {
            alert("Failed");
        },
        async: false
    });
}


var paymenttype = "Cash Amount";
function checkpaytype(paymode) {
    if (paymode.value == "Cash") {
        $("#carddiv").css("display", "none");
        $("#cashdiv").css("display", "block");
        paymenttype = "Cash Amount";
    }
    else if (paymode.value == "Card") {
        $("#carddiv").css("display", "block");
        $("#cashdiv").css("display", "none");
        paymenttype = "Card Amount";
    }
}

function getreturnAmt() {

    var payamt = $("#txtpaidMoney").val();
    var paymentAmt = $("#txtPayamount").val();
    $("#txtReturnAmt").val((paymentAmt - payamt).toFixed(2));
}
function getRenewreturnAmt() {

    var payamt = $("#txtRpaidMoney").val();
    var paymentAmt = $("#txtRPayamount").val();
    $("#txtRReturnAmt").val((paymentAmt - payamt).toFixed(2));
}
function refreshTable() {
    Openloader();
    $.ajax({
        type: "POST",
        url: "SmartSubscriber.aspx/FillData",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var s = response;
            table = $('#example2').DataTable({
               "destroy": true,
                "paging": false,
                "lengthChange": false,
                "searching": true,
                "ordering": true,
                "info": true,
                "autoWidth": false,
                "scrollY": "600px",
                "columnDefs": [
                                            { "sortable": false, "targets": [0] },
                                            { "sortable": false, "targets": [1] }

                                            ]
            });
            // table._fnProcessingDisplay(true);
            oSettings = table.settings();
            table.clear();
            for (var i = 0; i < s.length; i++) {
                for (var j = 0; j < s[i].length - 2; j++) {
                    if (j != 10) {
                        if (s[i][j] == "--") {
                            s[i][j] = "<p class='text-red'>--</p>";
                        } 
                    }
                    else {
                        s[i][j] = "<a style='cursor:pointer;' class='btn btnsma' title='Settings' onclick=\"javascript :SuspendSub('" + s[i][2] + "','" + s[i][5] + "','" + s[i][4] + "','" + s[i][3] + "','" + s[i][3] + "','" + s[i][11] + "','" + s[i][12] + "')\"><i class='fa fa-2x fa-wrench'></i></a><a style='cursor:pointer;' class='btn btnsma' title='Renewal' onclick=\"javascript :RenewalSub('" + s[i][2] + "','" + s[i][5] + "','" + s[i][4] + "','" + s[i][3] + "','" + s[i][3] + "','" + s[i][11] + "','" + s[i][12] + "')\"><i class='fa fa-2x fa-arrow-up'></i></a>  <a style='cursor:pointer;'  class='btn btnsma' title='Send OSD or EMAIL' onclick=\"javascript :OsdMailPopup('" + s[i][5] + "','HCIT','0')\"><i class='fa fa-2x  fa-envelope' style=color:#f39c12;'></i><a style='cursor:pointer;' title='Send Fingerprint'  class='btn btnsma' onclick=\"javascript :FPPopup('" + s[i][5] + "','HCIT','0')\"><i class='fa fa-2x  fa-forumbee' style=color:#e712f3;'></i></a>";
                    }
                }
                table.row.add(s[i]);
            }
            table.draw();
        },
        failure: function (response) {
            alertbox("Failed");
        }
    });
    Closeloader();
}

var chekitems = new Array();
function checkall(chkobj, type) {
  var tablepkg ;
  if (type == "0") {
      tablepkg = document.getElementById('tblPackages').getElementsByTagName('tbody')[0];
  }
  else if (type == "1") {
      tablepkg = document.getElementById('tblRenewpkgs').getElementsByTagName('tbody')[0];
  }
    var chkvalue = chkobj.checked;
    for (i = 0; i < tablepkg.rows.length; i++) {
        elm = $("#chk" + tablepkg.rows[i].cells[2].innerText);
        if (elm[0].type == 'checkbox') {
            elm[0].checked = chkvalue;
            if (elm[0].id != 'chkh') {
                if (chkvalue == false) {
                    chekitems.splice($.inArray($(elm[0]).val(), chekitems), 1);
                }
                else {
                    chekitems.push($(elm[0]).val());
                }

            }

        }
    }
}
function check(chkobj) {
    var chkvalue = chkobj.checked;
    if (chkvalue == false) {
        chekitems.splice($.inArray($(chkobj).val(), chekitems), 1);
    }
    else {
        chekitems.push($(chkobj).val());
    }
}

var addedpkgs = new Array();
function checkaddall(chkobj) {
    var tablenewpkg = document.getElementById('tblNewPackages').getElementsByTagName('tbody')[0];
    var chkvalue = chkobj.checked;
    for (i = 0; i < tablenewpkg.rows.length; i++) {
        elm = $("#chk" + tablenewpkg.rows[i].cells[2].innerText);
        if (elm[0].type == 'checkbox') {
            elm[0].checked = chkvalue;
            if (elm[0].id != 'chkh') {
                if (chkvalue == false) {
                    addedpkgs.splice($.inArray($(elm[0]).val(), addedpkgs), 1);
                }
                else {
                    addedpkgs.push($(elm[0]).val());
                }

            }

        }
    }
}
function checkadd(chkobj) {
    var chkvalue = chkobj.checked;
    if (chkvalue == false) {
        addedpkgs.splice($.inArray($(chkobj).val(), addedpkgs), 1);
    }
    else {
        addedpkgs.push($(chkobj).val());
    }
}

function Openloader() {
    $("#floatingBarsG").removeClass("hideen");
    $("body").addClass("opacity");
}
function Closeloader() {
    $("#floatingBarsG").addClass("hideen");
    $("body").removeClass("opacity");
}

$(document).ajaxStart(function (event, request, settings) {
    Openloader();
});

$(document).ajaxComplete(function (event, request, settings) {
    Closeloader();
});    
     