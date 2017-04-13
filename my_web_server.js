var http = require('http');

http.createServer(function (req, res) {
	console.log(req.url);
	res.writeHead(200, {'Content-Type': 'text/plain'});
  	res.end(/main.html);
}).listen(8080);

console.log('Server running on port 8080.');

