$(document).ready(function () {
    $('#jstree_categories').jstree({
        'core': {
            'data': {
                'url': function (node) {
                    return '/market_explorer/market_groups';
                }
            }
        },

        "plugins": ["search","types"]
    });
});