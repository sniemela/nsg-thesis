#= require databuffer

eventFeed = io.connect 'http://' + node_app_host + ':1337/events'
eventDataBuffer = new $.DataBuffer

window.incrementEventLikedCount = (plusone) ->
  $.get(plusone.href + '/like')

applyUpdates = ->
  for data in eventDataBuffer.getBuffer()
    callback = data.method
    callback(data.param)
  eventDataBuffer.reset()

showUpdatesAvailableMessage = (data) ->
  event = data.param
  return if not event.approved
  
  $('.available_updates').show();
  $('.update_content_link').attr('id', 'update_event_content')
  $('#update_event_content').click ->
    applyUpdates()
    $('.update_content_link').attr('id', '')
    $('.available_updates').hide()


incrementUnconfirmedEvents = (data) ->
  action = data.action
  event = data.param
  wrapper = $('#unapproved_events_count')
  count = parseInt(wrapper.html())
  
  if action == 'remove'
    if not event.approved
      count -= 1
  if action == 'add'
    if not event.approved
      count += 1

  wrapper.html(count)


eventDataBuffer.onData(showUpdatesAvailableMessage)
eventDataBuffer.onData(incrementUnconfirmedEvents)


eventFeed.on 'add', (event) ->
  eventDataBuffer.push
    action: 'add',
    method: addEventToList,
    param: event


eventFeed.on 'update', (event) ->
  eventDataBuffer.push
    action: 'update',
    method: updateEventDom,
    param: event


eventFeed.on 'remove', (event) ->
  eventDataBuffer.push
    action: 'remove',
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

$ ->
  $('.datepicker').live 'mouseover', ->
    $(this).datetimepicker
      dateFormat: "yy-mm-dd"
      
settings = { start:1, change:false }
$("#event-nav ul").idTabs(settings,true)
