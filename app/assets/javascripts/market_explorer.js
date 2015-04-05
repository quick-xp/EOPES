$(document).ready(function () {
    $('#jstree_categories').jstree({
        'core': {
            'data': {
                'url': function (node) {
                    return '/market_explorer/market_groups';
                }
            }
        },

        "plugins": ["search", "types"]
    });

    var to = false;
    $('#jstree_categories_search').keyup(function () {
        if (to) {
            clearTimeout(to);
        }
        to = setTimeout(function () {
            var v = $('#jstree_categories_search').val();
            console.log(v);
            console.log(v.length);
            if (v.length > 4) {
                $('#jstree_categories').jstree(true).search(v);
            }
        }, 250);
    });

    $('#jstree_categories')
        // listen for event
        .on('changed.jstree', function (e, data) {
            var i, j, r = [];
            for (i = 0, j = data.selected.length; i < j; i++) {
                r.push(data.instance.get_node(data.selected[i]).id);
            }
            // 100000以上は末端
            if (r > 100000) {
                var region_id = $("#region_id").val();
                var solar_system_id = $("#solar_system_id").val();
                $.ajax({
                    url: "get_market",
                    type: "GET",
                    datatype: "html",
                    data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
                        + "&type_id=" + r
                });
            }

        })

});

function set_location(change_item) {
    var region_id = $("#region_id").val();
    var solar_system_id = $("#solar_system_id").val();
    if (change_item == "region") {
        solar_system_id = "";
    }

    $.ajax({
        url: "set_location",
        type: "GET",
        datatype: "html",
        data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
    });
};

