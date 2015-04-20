/**
 * Overlay object
 */
(function ($) {
    $.fn.overlay = function (options) {
        options = $.extend({
            color: "#000",
            opacity: 0.5
        }, options);
        $(this).css('position', 'relative');
        $(this).append(
            $('<div/>', {
                class: 'overlay'
            }).append($('<img/>', {
                    src: '/assets/loading.gif'
                })));
        $(this).find('.overlay').show();
    }
})(jQuery);
