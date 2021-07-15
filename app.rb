require 'webrick'

server = WEBrick::HTTPServer.new({
	:DocumentRoot => '.',
	:CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
	:Port => '3000',
})

['INT', 'TERM'].each {|signal|
	Signal.trap(signal){ server.shutdown }
}

server.mount('/', WEBrick::HTTPServlet::CGIHandler, 'home.rb')
server.mount('/crops.cgi', WEBrick::HTTPServlet::CGIHandler, 'crops.rb')
server.mount('/self_consumption.cgi', WEBrick::HTTPServlet::CGIHandler, 'self_consumption.rb')

server.start
