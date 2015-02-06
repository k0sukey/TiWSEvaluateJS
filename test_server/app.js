var WebSocketServer = require('ws').Server,
	wss = new WebSocketServer({
		port: 8888
	});

wss.on('connection', function(ws){
	ws.on('message', function(message){
		console.log(message);
	});

	ws.send('var win = Ti.UI.createWindow({backgroundColor:"#000"}); win.open(); setTimeout(function(){win.backgroundColor = "#f00";}, 1000)');
});