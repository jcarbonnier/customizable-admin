// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/sortable
//= require jquery_ujs
// require turbolinks
//= require_tree ./bootstrap
//= require_tree ./utils
//= require_self

function ready() {

    // Tooltips, popovers, ...
    $("a[rel~=popover], .has-popover").popover();
    $("a[rel~=tooltip], .has-tooltip").tooltip({container: 'body'});

    // Pagination
    $('#items th a, #items .pagination * a').on('click', function () {
        $('#items').closest('.panel').attr('style', 'position: relative');
        $('#items').closest('.panel').overlay();
        $.get(this.href, null, null, 'script')
            .done(function () {
                trace('Done !!');
            })
            .fail(function () {
                trace("Fail !!");
            })
            .always(function () {
                trace("Reset !!");
                $('.overlay').remove();
            })
//            $.getScript(this.href);
        return false;
    });

    // Search form
    $('#form_search select').on('change', function () {
        trace("Search");
        $('#form_search').submit();
    });
    $('#form_search').submit(function () {
        $('#items').closest('.panel').attr('style', 'position: relative');
        $('#items').closest('.panel').overlay();
        $.get($('#form_search').attr('action'), $(this).serialize(), null, 'script')
            .done(function () {
                trace('Done !!');
                //$('*').css('cursor', 'wait');
            })
            .fail(function () {
                trace("Fail !!");
            })
            .always(function () {
                trace("Reset !!");
                $('.loading-btn').button('reset');
                $('.overlay').remove();
            });
        return false;
    });

    // Collapses management
    $('.btn-collapse').on('click', function () {
        if ($(this).find('.glyphicon').hasClass('glyphicon-chevron-up')) {
            $(this).find('.glyphicon').addClass('glyphicon-chevron-down');
            $(this).find('.glyphicon').removeClass('glyphicon-chevron-up');
        } else {
            $(this).find('.glyphicon').addClass('glyphicon-chevron-up');
            $(this).find('.glyphicon').removeClass('glyphicon-chevron-down');
        }
    });
};

// Turbolinks, force loading javasripts
$(document).ready(ready);
$(document).on('page:load', ready);