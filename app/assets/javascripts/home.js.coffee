# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
eventFeed = io.connect 'http://localhost:1337/events'

eventFeed.on 'add', (event) ->
  addEventToList event


eventFeed.on 'update', (event) ->
  updateEventDom event


eventFeed.on 'remove', (event) ->
  removeEventFromDom event


addEventToList = (event) ->
  console.log 'added'


updateEventDom = (event) ->
  eventDiv = $('#event-' + event.id)
  
  if eventDiv
    $('#event-name-' + event.id).html(event.name)
    $('#event-description-' + event.id).html(event.description)


removeEventFromDom = (event) ->
  
