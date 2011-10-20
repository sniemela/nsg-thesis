$.DataBuffer = class DataBuffer
  construct: ->

  push: (data) ->
    @getBuffer().push(data)
    @notifyListeners(data)

  getBuffer: ->
    if not @buffer
      @buffer = []
    return @buffer
  
  isEmpty: ->
    return @buffer and @buffer.length == 0

  notifyListeners: (data) ->
    for listener in @getListeners()
      listener(data)
  
  reset: ->
    @buffer = []

  getListeners: ->
    if not @listeners
      @listeners = []
    return @listeners

  onData: (fn) ->
    @getListeners().push fn
