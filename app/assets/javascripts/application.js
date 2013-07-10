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
//= require jquery.ui.datepicker
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .


// Fades notice boxes after a short while, then hides
$(document).ready(function(){
   setTimeout(function(){
  $("div.alert-box").fadeOut("slow", function () {
  $("div.alert-box").remove();
      });
 
  }, 2000);
});

// For Foundation CSS Framework
$(document).foundation();

// For jQuery UI Datepicker
$(function() {
  return $("#datepicker").datepicker({
    dateFormat: 'yy-mm-dd',
    stepMonths: 0
  });
});
