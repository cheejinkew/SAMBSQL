function cubic_meter_per_hour2litre_per_sec(w) {
    var _value = (w * 1000) / 3600;
    return Math.round(_value * 100) / 100;
}

function meter2feet(w) {
    return Math.round((w * 39.370079 / 12) * 100) / 100;
}

function SetPumpOnOff(mode) {

    var body = $("#form1");

    if ($("#setPump").length > 0) {

        $("#overlay_popup").show();
        $("#setPump").show();
    }
    else {

        var dv_overlay = $('<div />').attr('id', 'overlay_popup').attr('class', 'overlay_popup').appendTo(body);
        var dv_setPump = $('<div />').attr('id', 'setPump').attr('class', 'setPump_popup').appendTo(body);
        var center_popup = $('<center />').appendTo(dv_setPump);

        var table_popup = $('<table />').appendTo(center_popup);
        var tr_popup_1 = $('<tr />').appendTo(table_popup);
        var td_popup_1 = $('<td />').appendTo(tr_popup_1);

        var fieldset_popup = $('<fieldset />').appendTo(td_popup_1);
        var legend_popup = $('<legend />').appendTo(fieldset_popup).html("<b>Password : </b>");

        $('<input />').attr('type', 'password').attr('id', 'txtPwd').css('width', '150px').appendTo(fieldset_popup).val("");
        $('<input />').attr('type', 'button')
                        .click(function () {

                            setPump(SiteID, $('#txtPwd').val(), mode);

                        }).appendTo(fieldset_popup).val("OK");

        $('<p />').attr('class', 'p_popup').appendTo(fieldset_popup).html("*Password must be keyed, in order to use this function.");
        $('<p />').attr('class', 'p_popup').attr('id', 'setpump_status').appendTo(fieldset_popup).html('');

        var tr_popup_2 = $('<tr />').appendTo(table_popup);
        var td_popup_2 = $('<td />').appendTo(tr_popup_2);

        $('<div />').attr('class', 'btnClose_popup')
                    .click(function () {

                        $("#txtPwd").val("");
                        $("#overlay_popup").hide();
                        $("#setPump").hide();
                    })
                    .html("<b>Close</b>")
                    .appendTo(td_popup_2);

        $("#overlay_popup").show();
        $("#setPump").show();
        document.getElementById("txtPwd").focus();
    }
}

function setPump(id, pwd, status) {

    $('#setpump_status').css('color', 'black').html('Loading...');

    $.ajax({
        type: "POST",
        url: "ajx/Home.asmx/checkUnitPassword",
        data: "{'siteid' : '" + id + "', 'pwd' : '" + pwd + "', 'mode' : '" + status + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {

            if (msg == '1') {

                $('#setpump_status').css('color', 'green').html('Set Pump ' + status + ' Success.');
            }
            else {
                $('#setpump_status').css('color', 'red').html('Incorrect Password, Please Try Again.');
            }
        },
        error: function (msg) {

            $('#setpump_status').css('color', 'red').html('Unexpecred Error Occured, Please Try Again or Contact Administrator.');
        }
    });
}