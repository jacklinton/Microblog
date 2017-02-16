require "sinatra"
require "sinatra/activerecord"
require "./models"

Sinatra::register Gon::Sinatra::Rabl

set :database, "/////"

get "/" do 

end