## for [ti-stats-hook](https://github.com/k0sukey/ti-stats-hook) and [YaTriple](https://github.com/k0sukey/YaTriple)

**Do not use for product.**

### Usage

1. Boot WebSocket server
2. Boot Titanium app
3. Send Titanium JavaScript code from WebSocket server

#### Server

node.js WebSocket server example.
See [test_server](test_server).

```js
var WebSocketServer = require('ws').Server,
	wss = new WebSocketServer({
		port: 8888
	});

wss.on('connection', function(ws){
	ws.send('var win = Ti.UI.createWindow({backgroundColor:"#000"}); win.open(); setTimeout(function(){win.backgroundColor = "#f00";}, 1000)');
});
```

#### App

See [test_app](test_app).

1. Install the this module
2. Writing ```<property name="evaluate-host" type="string">ws://localhost:8888</property>``` in tiapp.xml
3. Build!
