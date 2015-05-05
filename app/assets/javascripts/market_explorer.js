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
            //4文字以上入力されたら検索する
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
                //jump数用に現在のStation取得
                var current_solar_system_id = $("#current_solar_system_id").val();
                //取得するMarketの種類を取得(Sell or Buy)
                var market_kind = $("#hidden_market_kind").val();
                dispLoading();
                $.ajax({
                    url: "get_market",
                    type: "GET",
                    datatype: "html",
                    data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
                        + "&current_solar_system_id=" + current_solar_system_id
                        + "&market_kind=" + market_kind
                        + "&type_id=" + r
                });
            }

        });

    //☓ボタン treeを閉じる
    $('#close').click(function () {
            $('#jstree_categories').jstree(true).search("");
            $('#jstree_categories_search').val("");
            $('#jstree_categories').jstree(true).close_all();
        }
    );

});

//Market のプルダウン設定
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

//Current Location のプルダウン設定
function set_current_location(change_item) {
    var region_id = $("#current_region_id").val();
    var solar_system_id = $("#current_solar_system_id").val();
    if (change_item == "region") {
        solar_system_id = "";
    }
    $.ajax({
        url: "set_current_location",
        type: "GET",
        datatype: "html",
        data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
    });
};

function dispLoading() {
    $("#market").html("<h2><i class='fa fa-refresh fa-spin'></i> Now Loading...</h2>");
};


function refresh_market(){
    var region_id = $("#region_id").val();
    var solar_system_id = $("#solar_system_id").val();
    //jump数用に現在のStation取得
    var current_solar_system_id = $("#current_solar_system_id").val();
    //取得するMarketの種類を取得(Sell or Buy)
    var market_kind = $("#hidden_market_kind").val();
    // 100000 を足した数をtype_id とする(後の計算で100000引くため)
    var hidden_type_id = $("#hidden_type_id").val();
    hidden_type_id = Number(hidden_type_id) + 100000;
    dispLoading();
    $.ajax({
        url: "get_market",
        type: "GET",
        datatype: "html",
        data: 'id=region_id_change&region_id=' + region_id + "&solar_system_id=" + solar_system_id
            + "&current_solar_system_id=" + current_solar_system_id
            + "&market_kind=" + market_kind
            + "&type_id=" + hidden_type_id
    });
};
