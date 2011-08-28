(function() {
  var Chat;
  module.exports.Chat = Chat = (function() {
    function Chat(chat) {
      this.chat = chat;
    }
    Chat.prototype.init = function() {
      return this.chat.on('connection', function(socket) {
        return socket.on('join', function(nick) {
          return socket.broadcast.emit('user joined', {
            nick: nick
          });
        });
      });
    };
    return Chat;
  })();
}).call(this);
