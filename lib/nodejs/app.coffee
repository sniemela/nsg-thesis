app = require('http').createServer((req,res) -> handleRequest(req, res))
io = require('socket.io').listen(app)
chat = require('./chat')

app.listen 5959

handleRequest = (req, res) ->
  return res.end('hello world')

chatHandler = new chat.Chat(io.of('/chat'))
chatHandler.init