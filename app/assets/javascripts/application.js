// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require best_in_place
//= require best_in_place.purr
//= require bootstrap
//= require_tree .


$(document).ready(function() {
  console.log('loaded');
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  $('.carousel').carousel({
      interval: 3500
  });
  $('.carousel').carousel('cycle');

  $('#remove-space').hide();
  $('#remove-space-show').click(function() {
  	$('#remove-space-show').hide();
    $('#remove-space').show();
  });
  $('#remove-space-hide').click(function() {
  	$('#remove-space-show').show();
    $('#remove-space').hide();
  });

  $('#from_booking').datepicker({ dateFormat: 'yy-mm-dd', defaultDate: "+1w", minDate: "+0D", maxDate: new Date(2013, 2, 28), onClose: function(selectedDate) {
    var date = $('#from_booking').datepicker('getDate');
    if (date === null) return;
    date.setDate(date.getDate() + 1);
    $('#to_booking').datepicker( "option", "minDate", date);
    var startDate = $('#from_booking').datepicker('getDate');
    var endDate = $('#to_booking').datepicker('getDate');
    if (startDate && endDate) {
      update_amounts(startDate, endDate);
    }
  }
  });
  $('#to_booking').datepicker({ dateFormat: 'yy-mm-dd', defaultDate: "+1w", minDate: "+1D", maxDate: new Date(2013, 2, 28),  onClose: function(selectedDate) {
    var date = $('#to_booking').datepicker('getDate');
    if (date === null) return;
    date.setDate(date.getDate() - 1);
    $('#from_booking').datepicker("option", "maxDate", date);
    var startDate = $('#from_booking').datepicker('getDate');
    var endDate = $('#to_booking').datepicker('getDate');
    if (startDate && endDate) {
      update_amounts(startDate, endDate);
    }
  }
  });
  function update_amounts(startDate, endDate)
  {
    var price = parseInt($('#total_amount').data('price'), 10);
    var type = $('#total_amount').data('type');
    var guests = $('#booking_request_guests').val();

    var days = 86400000;
    var numdays = Math.abs(endDate-startDate)/days;
    var total = numdays*price;
    if (type === 'Shared room')
      total = guests*numdays*price;
    $('#days_booking').html(numdays);
    $('#guests_booking').html(guests);
    $('#total_amount').html("&#x20B9; " + total);
  }

  $('#booking_request_guests').change(function() {
    var startDate = $('#from_booking').datepicker('getDate');
    var endDate = $('#to_booking').datepicker('getDate');
    if (startDate && endDate) {
      update_amounts(startDate, endDate);
    }
  })

});