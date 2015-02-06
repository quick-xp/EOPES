function set_material(material_count) {
    var count = material_count
    var data = "id=price_change";
    data += "&data_count=" + count;
    for (var i = 0; i < count; i++) {
        data += "&price_" + i + "=" + $("#price_" + i).val();
    }
    $.ajax({
        url: "set_material",
        type: "GET",
        datatype: "html",
        data: data
    });
}

function set_location() {
    var region_id = $("#region_id").val();
    $.ajax({
        url: "set_location",
        type: "GET",
        datatype: "html",
        data: 'id=region_id_change&region_id=' + region_id
    });
}