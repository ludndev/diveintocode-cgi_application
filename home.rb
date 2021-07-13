require 'cgi'
require 'erb'


cgi = CGI.new
view = ERB.new(File.read('views/home.html.erb'))


pageTitle = "Home"


cgi.out("type" => "text/html", "charset" => "UTF-8") {
	view.result()
}
