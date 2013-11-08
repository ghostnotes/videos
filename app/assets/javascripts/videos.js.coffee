# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.fancybox-media').fancybox({
    openEffect  : 'none',
    closeEffect : 'none',
    helpers : {
      media : {}
    }
  })

NProgress.configure(
  { speed: 350 }
)

$(document).ready ->
  NProgress.start();

$(window).load ->
  NProgress.done();

