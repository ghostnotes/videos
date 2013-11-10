# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.filter').hide()
  NProgress.start()

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

$(window).load ->
  NProgress.done()

  $('.category-link').each ->
    $(this).bind 'click', (event) =>
      $('.filter').show()
      location.href = '/categories/' + this.innerText
