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
  return if $.liveMode

  event = data.param
  return if not event.approved
  
  $('.available_updates').slideDown('fast')
  $('.update_content_link').attr('id', 'update_event_content')
  $('#update_event_content').click (e) ->
    e.preventDefault()
    applyUpdates()
    $('.update_content_link').attr('id', '')
    $('.available_updates').slideUp('fast')


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
  if $.liveMode
    applyUpdates() unless eventDataBuffer.isEmpty()
    addEventToList(event)
  else
    eventDataBuffer.push
      action: 'add',
      method: addEventToList,
      param: event


eventFeed.on 'update', (event) ->
  if $.liveMode
    applyUpdates() unless eventDataBuffer.isEmpty()
    updateEventDom(event)
  else
    eventDataBuffer.push
      action: 'update',
      method: updateEventDom,
      param: event


eventFeed.on 'remove', (event) ->
  if $.liveMode
    applyUpdates() unless eventDataBuffer.isEmpty()
    removeEventFromDom(event)
  else
    eventDataBuffer.push
      action: 'remove',
      method: removeEventFromDom,
      param: event


addEventToList = (event) ->
  console.log 'added'


updateEventDom = (event) ->
  eventDiv = $('#event-' + event.id)
  
  if eventDiv
    updateEvent(event.id, 'name', event.name)
    updateEvent(event.id, 'description', event.description)


updateEvent = (id, element, content) ->
  element = $('#event-' + element + '-' + id)
  element.hide()
  element.html(content)
  element.fadeIn()


removeEventFromDom = (event) ->
  eventDiv = $('#event-' + event.id)

  if eventDiv
    eventDiv.wrap('<div class="removed"></div>')
    name = $('#event-name-' + event.id)
    name.attr('href', '#')
    name.click (e) ->
      e.preventDefault()
      return false

$ ->
  $('.datepicker').live 'mouseover', ->
    $(this).datetimepicker
      dateFormat: "yy-mm-dd"
      
settings = { start:1, change:false }
$("#event-nav ul").idTabs(settings,true)
