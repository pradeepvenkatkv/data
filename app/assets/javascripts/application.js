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
//= require turbolinks
//= require bootstrap.js
//= require bootstrap
//= require bootstrap-sprockets
//= require_tree .
//= require bootstrap-datepicker


$(document).ready(function(){
setTimeout(function(){
$('.alert-info').fadeOut();
}, 2000);
})


$(document).ready(function () {

    $('#example1').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true
    });
    
    $('#example2').datepicker({
        format: "dd/mm/yyyy"
    }).on('change', function () {
        $('.datepicker').hide();
    });
});


$(".alert" ).fadeOut(2000);  
$(".alert-success" ).fadeOut(2000);
$(".alert-warning" ).fadeOut(2000);

