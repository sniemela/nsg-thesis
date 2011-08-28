(function() {
  var app, chat, chatHandler, handleRequest, io;
  app = require('http').createServer(function(req, res) {
    return handleRequest(req, res);
  });
  io = require('socket.io').listen(app);
  chat = require('./chat');
  app.listen(5959);
  handleRequest = function(req, res) {
    return res.end('hello world');
  };
  chatHandler = new chat.Chat(io.of('/chat'));
  chatHandler.init;
}).call(this);
