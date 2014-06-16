// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require bootstrap
//= require coffee


$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});

$(document).ready(function () {

    $('.is_tooltip').tooltip();
    $('.is_popover').popover({
        html : true,
        container: 'body',
        title: function() {
            return $("#popover-head").html();
        },
        content: function() {
            return $('#'+$(this).data('id')).html();
        }
    });

    $('.is_popover_auto').popover({
        html : true,
        container: 'body',
        content: function() {
            return $('#' + $(this).data('id')).html();
        }
    });


    $.each($(".cool"), function(i, el){
        $(el).css("opacity","0");
        setTimeout(function(){
            $(el).css('opacity', '1');
            $(el).addClass('fadeInUp animated-05');
        },500 + ( i * 200 ));

    });


    $.each($(".cool2"), function(i, el){
        $(el).css("opacity","0");
        setTimeout(function(){
            $(el).css('opacity', '1');
            $(el).addClass('flipInY animated');
        },500 + ( i * 200 ));

    });



});

$('html').on('click', function (e) {
    $('[data-toggle="popover"]').each(function () {
        //the 'is' for buttons that trigger popups
        //the 'has' for icons within a button that triggers a popup
        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
            $(this).popover('hide');
        }
    });
});


