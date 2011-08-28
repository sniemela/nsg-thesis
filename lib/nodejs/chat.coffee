module.exports.Chat = class Chat
  constructor: (@chat) ->
  
  init: ->
    @chat.on 'connection', (socket) ->
      socket.on 'join', (nick) ->
        socket.broadcast.emit 'user joined', nick: nick
    