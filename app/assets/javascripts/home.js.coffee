$(document).ready ->
  $("#sign-in").hover ->
    $(".login-form").toggleClass 'hidden'
  $(".login-form").hover ->
    $(this).toggleClass 'hidden'
    $("#sign-in").toggleClass 'active-element'


