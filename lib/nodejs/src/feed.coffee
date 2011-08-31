feed = exports

feed.EventFeed = class EventFeed
  constructor: (@sockets) ->

  init: ->
    @sockets.on 'connection', (socket) ->
      # do nothing
  
  onAction: (action, data) ->
    @sockets.emit action, data