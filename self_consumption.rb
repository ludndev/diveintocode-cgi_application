require 'cgi'
require 'erb'
require 'pg'


cgi = CGI.new
view = ERB.new(File.read('views/crops.html.erb'))

connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"


pageTitle = "Self Consumption GOYA"

# 自家消費 mean self consumption
query = "SELECT length, weight, give_for, date FROM crops WHERE NOT give_for = '自家消費' ;"

results = []


begin
	results = connection.exec(query)
ensure
	connection.finish
end


cgi.out("type" => "text/html", "charset" => "UTF-8") {
	view.result()
}
