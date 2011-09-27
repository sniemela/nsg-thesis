# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#logo').click (e) ->
    $('#page_nav').slideDown('fast')
    e.stopPropagation()

  $(document).bind 'click', ->
    if $('#page_nav').is(':visible')
      $('#page_nav').hide()
