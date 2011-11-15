$(document).ready ->
  $("#error").fadeTo 8000, 0.0, ->
    $("#error").slideUp 1000, ->

  $(".close").click ->
    $(".alert-message").slideUp 1000, ->

	$(".close").click ->
  	$("#chart-modal, .modal-backdrop").fadeOut 300, ->
  		$(this).remove()
  
  $ ->
	  $("#datepicker").datepicker
	    minDate: -20
	    maxDate: +0
	    dateFormat: 'mm/dd/yy'