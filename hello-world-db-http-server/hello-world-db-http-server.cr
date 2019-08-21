# A very basic HTTP server
require "http/server"
require "db"
require "mysql"
require "pg"

db = DB.open(ENV["DATABASE_URL"])

server = HTTP::Server.new do |context|
  db.query("SELECT title from sample_data") do |rs|
    context.response.content_type = "text/html"
    ECR.embed("index.html.ecr", context.response)
  end
end

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen
db.close
