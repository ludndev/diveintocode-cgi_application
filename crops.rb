require 'cgi'
require 'erb'
require 'pg'


cgi = CGI.new
view = ERB.new(File.read('views/crops.html.erb'))

connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"


filter = cgi['quality']
pageTitle = "filter crops"

def filter_crops(filter)
	if filter.downcase == 'true'
		return "SELECT length, weight, give_for, date FROM crops WHERE quality = true;"
	else
		return "SELECT length, weight, give_for, date FROM crops WHERE quality = false;"
	end
end


results = []

begin
	results = connection.exec(filter_crops(filter))
ensure
	connection.finish
end


cgi.out("type" => "text/html", "charset" => "UTF-8") {
	view.result()
}
