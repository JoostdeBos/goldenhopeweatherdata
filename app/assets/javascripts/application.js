// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require gmaps4rails/googlemaps.js
//= require_tree .

//wait until dom is ready
$(document).ready(function() {
	//fade error flashes
	$('#error').fadeTo(8000, 0.0, function() {
    	$("#error").slideUp(1000, function() {
		});
    });
    //remove error messages when the 'x' is clicked
    $('.close').click(function() {
	  $(".alert-message").slideUp(1000, function() {
		});
	});
	
});