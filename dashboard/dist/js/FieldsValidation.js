
$(function () {
});

function validate(ctrlid, ctrltype, msg) {
    var Result = new Array();
    var ctrldata = $("#" + ctrlid).val();
    if (ctrltype == "text") {
        if (ctrldata.trim() == "") {
            Result[0] = false;
            Result[1] = msg;
        }
        else {
            Result[0] = true;
            Result[1] = "Success";
        }
    }
    else if (ctrltype == "ddl") {
        if (ctrldata.trim() == "0") {
            Result[0] = false;
            Result[1] = msg;
        }
        else {
            Result[0] = true;
            Result[1] = "Success";
        }
    }
    else if (ctrltype == "phone") {
        var phoneNumberPattern = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;

        if (phoneNumberPattern.test(ctrldata) == false) {
            Result[0] = false;
            Result[1] = msg;
        }
        else {
            Result[0] = true;
            Result[1] = "Success";
        }
    }
    else if (ctrltype == "email") {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (re.test(ctrldata) == false) {
            Result[0] = false;
            Result[1] = msg;
        }
        else {
            Result[0] = true;
            Result[1] = "Success";
        }
    }
    return Result;
}
function alertshow(msg) {
    $("#lblAlert").show();
    $("#SpAlert").html(msg);
}

