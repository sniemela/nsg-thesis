(function() {
  var addListener, app, eventFeed, express, feed, io, listeners, notifyListeners;
  express = require('express');
  app = express.createServer();
  io = require('socket.io').listen(app);
  feed = require('./feed');
  io.set('log level', 1);
  app.use(express.bodyParser());
  app.listen(1337);
  listeners = {};
  addListener = function(observable, listener) {
    if (!listeners[observable]) {
      listeners[observable] = [];
    }
    return listeners[observable].push(listener);
  };
  notifyListeners = function(observable, action, data) {
    var listener, observableListeners, _i, _len, _results;
    observableListeners = listeners[observable] || [];
    _results = [];
    for (_i = 0, _len = observableListeners.length; _i < _len; _i++) {
      listener = observableListeners[_i];
      _results.push(listener.onAction(action, data));
    }
    return _results;
  };
  eventFeed = new feed.EventFeed(io.of('/events'));
  eventFeed.init();
  addListener('event', eventFeed);
  app.post('/event_added', function(req, res) {
    notifyListeners('event', 'add', req.body);
    return res.send(200);
  });
  app.post('/event_updated', function(req, res) {
    notifyListeners('event', 'update', req.body);
    return res.send(200);
  });
  app.post('/event_removed', function(req, res) {
    notifyListeners('event', 'remove', req.body);
    return res.send(200);
  });
}).call(this);
