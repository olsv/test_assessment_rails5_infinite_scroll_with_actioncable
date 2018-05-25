# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  if $('.pagination').length && $('.order-list').length
    tbody = $('.user-list .users')

    tbody.scroll ->
      url = $('.pagination a[rel=next]').attr('href')

      if url && (tbody[0].scrollHeight - tbody[0].clientHeight - tbody.scrollTop() < 50)
        $('.pagination').text('loading more...')
        $.getScript(url)

    $(window).scroll()
