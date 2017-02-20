require "sinatra"
require "sinatra/activerecord"

require "gon-sinatra"
require 'rabl'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'builder'

Rabl.register!
Sinatra::register Gon::Sinatra::Rabl



set :database, "sqlite3:microblog.sqlite3"
require "./models"
enable :sessions

def page_stuff
	render :rabl, :foo, :format => "json"
	@posts = Post.all
	@users = User.all
	@groups = Group.all

	if session[:id]
		@current_user = User.find(session[:id]
	end

	if @current_user.group_id
		@groupie = true
		@gname = Group.find(@current_user.group_id).
	end
end

get "/" do 
	render :rabl, :foo, :format => "json"
	@posts = Post.all
	@users = User.all
	@groups = Group.all

	if session[:id]
		@current_user = User.find(session[:id]
	end

	if @current_user.group_id
		@groupie = true
		@gname = Group.find(@current_user.group_id).
	end
	erb :index

end



##Navigation actions
#Go to home page

#View this user's profile
get "users/profile/"


	erb :"users/user"
end
#View group profile





## User related actions
# Creating a new user
get "/users/new" do


	erb :"register/registration"
end
post "/users/new" do
	user = User.create

	user.username = params[:username]
	user.password = params[:password]
	user.group_name = params[:group_name]
	
	if params[:group_name]
		user.group_id = Group.find(params[:group_name])
	end

	user.save

	session[:user_id] = user.id

	flash[:notice] = "You are now signed in with a new account!"
	flash[:get_started] = "You can start by making your first post at the Make New Post link in the menu bar abive."
	
	redirect "/"
end

#Logging in a user that already exists
get "/sign_in" do
	erb :sign_in
end

post "/users/login" do
	
	user = User.where(email: params[:email]).first

	if user.password == params[:password]
		flash[:notice] = "You are now logged in."
		session[:user_id] = user.id
	else
		flash[:notice] = "Incorrect login credentials."
	end
	redirect "/"
end

#Logging out a user
post "/log/out" do
	session.clear

	redirect "/"
end

#Viewing a user's profile
get "/users/view/:id" do
	profile =  User.find(:id)

	redirect "/users/profile/#{profile.username}"
end

#Editing a user's profile
get "users/profile/edit/:username" do
	profile = User.find(:username)

	if session[:user_id] == profile.user_id
		redirect "users/frofile/edit/#{profile.username}"
	else
		flash[:notice] = "You only have permission to delete your own posts."
	end

end






##Post related actions
#Creating a new post
post "/posts" do
	# or Post.create(title: params["title"], body: params["body"])


	post = Post.new

	post.title = params["title"]
	post.body = params["body"]
	post.user_id = session[:user_id]

	post.save

	redirect "/"
end

#Editing a post
get '/posts/edit/:id' do
  @post = Post.find(params[:id])

  erb :post_edit
end

post '/posts/edit/:id' do
	@post = Post.find(params[:id])
	
	@post.title = params[:title]
	@post.body = params[:body]
	
	@post.save
	
	redirect "/posts/#{@post.id}"
end

#Deleting a post
get "/posts/delete/:id" do
	post = Post.find(params[:id])

	if session[:user_id] == post.user_id
		post.destroy
	else
		flash[:notice] = "You only have permission to delete your own posts."
	end
	
	redirect "/"
end


##Group related actions
#Starting a new group

#Viewing a group's profile page

#Showing and hiding hidden messages







