require 'cgi'
require 'erb'
require 'pg'


cgi = CGI.new
view = ERB.new(File.read('views/crops.html.erb'))

connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"


filter = cgi['quality']
pageTitle = "pageTitle"

if filter.downcase == 'true'
	pageTitle = "crops of good quality"
	query = "SELECT length, weight, give_for, date FROM crops WHERE quality = true;"
else
	pageTitle = "crops of bad quality"
	query = "SELECT length, weight, give_for, date FROM crops WHERE quality = false;"
end


results = []

begin
	results = connection.exec(query)
ensure
	connection.finish
end


cgi.out("type" => "text/html", "charset" => "UTF-8") {
	view.result()
}
