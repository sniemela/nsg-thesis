express = require('express')
app = express.createServer()
io = require('socket.io').listen(app)
feed = require('./feed')

io.set 'log level', 1

app.use express.bodyParser()
app.listen 1337

listeners = {}

addListener = (observable, listener) ->
  listeners[observable] = [] unless listeners[observable]
  listeners[observable].push listener

notifyListeners = (observable, action, data) ->
  observableListeners = listeners[observable] || []
  
  for listener in observableListeners
    listener.onAction action, data

eventFeed = new feed.EventFeed(io.of('/events'))
eventFeed.init()
addListener('event', eventFeed)

# Mappings

app.post '/event_added', (req, res) ->
  notifyListeners 'event', 'add', req.body
  res.send 200

app.post '/event_updated', (req, res) ->
  notifyListeners 'event', 'update', req.body
  res.send 200

app.post '/event_removed', (req, res) ->
  notifyListeners 'event', 'remove', req.body
  res.send 200
