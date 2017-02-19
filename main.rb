require "sinatra"
require "sinatra/activerecord"
require "./models"
require "gon-sinatra"
require 'rabl'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'builder'

Rabl.register!
Sinatra::register Gon::Sinatra::Rabl



# set :database, "/////"

get "/" do 
	render :rabl, :foo, :format => "json"


	erb :index

end