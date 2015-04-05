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

});