function set_material(material_count) {
    var count = material_count;
    var data = "id=price_change";
    var me = $('#estimate_form_estimate_blueprints_me').val();
    var te = $('#estimate_form_estimate_blueprints_te').val();
    var runs = $('#estimate_form_estimate_blueprints_runs').val();
    data += "&data_count=" + count;
    for (var i = 0; i < count; i++) {
        data += "&price_" + i + "=" + $("#price_" + i).val() + "&me=" + me + "&runs=" + runs
        + "&te=" + te;
    }
    $.ajax({
        url: "set_material",
        type: "GET",
        datatype: "html",
        data: data
    }).done(function () {
        set_location_change_solar_system();
    });

}

function set_location_change_solar_system() {
    var region_id = $("#region_id").val();
    var solar_system_id = $("#solar_system_id").val();

    $.ajax({
        url: "set_location",
        type: "GET",
        datatype: "html",
        data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
    }).done(function () {
        set_result();
    });
}

function set_location_change_region() {
    var region_id = $("#region_id").val();
    var solar_system_id = "";

    $.ajax({
        url: "set_location",
        type: "GET",
        datatype: "html",
        data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
    }).done(function () {
        set_result();
    });
}


function set_result() {
    var sell_price = $("#estimate_sell_price").val();
    $.ajax({
        url: "set_result",
        type: "GET",
        datatype: "html",
        data: 'id=set_result&sell_price=' + sell_price
    });
}

function set_sell_market_list() {
    var region_id = $("#sell_region_id").val();
    $.ajax({
        url: "set_sell_market_list",
        type: "GET",
        datatype: "html",
        data: 'id=set_sell_market_list&sell_region_id=' + region_id
    });
}

$(document).ready(function () {
    $('#lists').dataTable();

});