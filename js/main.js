$(function() {
    $('.menu-icon').on('click', function() {
        var $menu = $('menu');
        if ($menu.is(':visible')) {
            $menu.slideUp();
        } else {
            $menu.slideDown();
        }
    });
});
