// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar
//= require fullcalendar/lang/ja
//= require tempusdominus-bootstrap-4.js
//= require turbolinks
//= require_tree .

// tooltipの設定
$(document).on('turbolinks:load', function () {
  $('[data-toggle="tooltip"]').tooltip()
});

// fullcalendar
function eventCalendar() {
  return $('#calendar').fullCalendar({
  	header: {
  		left: 'prev,next today',
        center: 'title',
        right: 'month agendaWeek agendaDay'
  	},
    selectable: true,
    selectHelper: true,
  	titleFormat: 'M月',
  	timeFormat: 'H:mm',
  	// eventsのjsonのパス
  	events: location.pathname + '.json',
  	// eventをクリックしたときにモーダルで詳細を表示
  	eventClick: function(info) {
      $(`#event${info.id}`).modal('toggle');
    },
  });
};
function clearCalendar() {
  $('#calendar').html('');
};
$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);


// refileの投稿時のプレビュー
$(document).on('turbolinks:load', function() {
 function readURL(input) {
   if (input.files && input.files[0]) {
     var reader = new FileReader();
     reader.onload = function (e) {
       $('#img-prev').attr('src', e.target.result);
     }
     reader.readAsDataURL(input.files[0]);
   }
 }
 $("#profile").change(function(){
   readURL(this);
 });
});