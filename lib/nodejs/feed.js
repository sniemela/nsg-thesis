(function() {
  var EventFeed, feed;
  feed = exports;
  feed.EventFeed = EventFeed = (function() {
    function EventFeed(sockets) {
      this.sockets = sockets;
    }
    EventFeed.prototype.init = function() {
      return this.sockets.on('connection', function(socket) {});
    };
    EventFeed.prototype.onAction = function(action, data) {
      return this.sockets.emit(action, data);
    };
    return EventFeed;
  })();
}).call(this);
