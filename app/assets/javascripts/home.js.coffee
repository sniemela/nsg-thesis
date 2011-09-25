# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require databuffer

eventFeed = io.connect 'http://' + node_app_host + ':1337/events'
eventDataBuffer = new $.DataBuffer

applyUpdates = ->
  for data in eventDataBuffer.getBuffer()
    callback = data.method
    callback(data.param)
  eventDataBuffer.reset()

showUpdatesAvailableMessage = (data) ->
  $('.available_updates').show();
  $('.update_content_link').attr('id', 'update_event_content')
  $('#update_event_content').click ->
    applyUpdates()
    $('.update_content_link').attr('id', '')
    $('.available_updates').hide()


eventDataBuffer.onData(showUpdatesAvailableMessage)


eventFeed.on 'add', (event) ->
  eventDataBuffer.push
    method: addEventToList,
    param: event


eventFeed.on 'update', (event) ->
  eventDataBuffer.push
    method: updateEventDom,
    param: event


eventFeed.on 'remove', (event) ->
  eventDataBuffer.push
    method: removeEventFromDom,
    param: event


addEventToList = (event) ->
  console.log 'added'


updateEventDom = (event) ->
  eventDiv = $('#event-' + event.id)
  
  if eventDiv
    $('#event-name-' + event.id).html(event.name)
    $('#event-description-' + event.id).html(event.description)


removeEventFromDom = (event) ->
  eventDiv = $('#event-' + event.id)
  eventDiv.hide() if eventDiv
