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
//= require tether

//commented these out temporarily, I think the main jquery ui library includes these.
// require jquery.ui.draggable
// require jquery.ui.droppable

//= require cocoon
//= require moment
//= require bootstrap-datetimepicker
//= require backpages/gsap/main-gsap.js
//= require backpages/bootstrap.min
//= require backpages/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js
//= require backpages/joinable.js
//= require backpages/resizeable.js
//= require backpages/neon-api.js
//= require backpages/jvectormap/jquery-jvectormap-1.2.2.min.js
//= require backpages/jvectormap/jquery-jvectormap-europe-merc-en.js
//= require backpages/jvectormap/jquery-jvectormap-world-mill-en.js
//= require backpages/jquery.sparkline.min.js
//= require backpages/neon-chat.js
//= require backpages/neon-custom.js


var do_on_load = function() {
    // Hack cause I'm not able to apply form-control to everything but checkboxes
    $('input[type="checkbox"]').removeClass('form-control');

    setTimeout(function() {
        // Do something every 2 seconds
        $(".alert").css({
            display: 'none'
        });
    }, 10000);

    $(".draggable").draggable({
        containment: '.scroll-body',
        scroll: true
    });

    $('.droppable').droppable({
        drop: function(event, ui) {
            $new_stage_id = $(this).attr('id');
            $deal_stage_id = ui.draggable.data('stage-id');
            $deal_id = ui.draggable.attr('id');
            $team_id = $('.scroll-body').attr('id');
            console.log('Dropped into ' + $new_stage_id + ' ' + $deal_stage_id + ' ' + $deal_id);
            if (true) { //($deal_stage_id != $new_stage_id) {
                url = '/teams/' + $team_id + '/deals/' + $deal_id;
                $.ajax({
                    type: "PUT",
                    dataType: "script",
                    contentType: "application/json; charset=utf-8",
                    url: url,
                    data: JSON.stringify({
                        deal: {
                            stage_id: $new_stage_id
                        }
                    })
                });
                return false;
            }
        }
    })

    $('.datetimepicker').datetimepicker({
        pickTime: false,
        format: 'DD/MM/YYYY'
    });

    $('.monthfirst').datetimepicker({
        pickTime: false,
        format: 'MM/DD/YYYY'
    });

    if ($('.modal').hasClass('open')) {
        $('.modal').modal('show')
    }

    // var Adjust = function() {
    //   $height = $('.deals-body').height();
    //   $('.scrollable, .scroll-column').height($height);
    // }
    // $(window).on('load', Adjust);
    // $(window).on('resize', Adjust);

    $('.plan-gold').click(function() {
        alert("Gold plan selected.");
        $("#team_plan_id").val(2);
        $("#team_plan_id").selectmenu('refresh');
    })

    $('.plan-silver').click(function() {
        alert("Silver plan selected.");
        $("#team_plan_id").val(1);
        $("#team_plan_id").selectmenu('refresh');
    })
    $('.plan-platinum').click(function() {
        alert("Platinum plan selected.");
        $("#team_plan_id").val(3);
        $("#team_plan_id").selectmenu('refresh');
    })

    $('.edit_team').on('cocoon:after-insert', function() {
        // e.g. set the background of inserted task
        //added_task.($('input.ordd').val('22'));
        $vb1 = ($('.edit_team > div').length) - 1;
        $('.edit_team .nested-fields > .order > input').last().val($vb1);
    })

    $('#search').keyup(function() {
        if (!$(this).val()) {
            $('#groups').css("display", "none");
        } else {
            $('#groups').css("display", "block");
        }
    })
    $('#search').keyup(function() {
        $.get($("#gs").attr("action"), $("#gs").serialize(), null, "script");
        return false;
    })
}
$(document).ready(do_on_load);
$(document).ajaxComplete(do_on_load);
// $(window).bind('page:change', do_on_load);
