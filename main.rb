require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "gon-sinatra"
require 'rabl'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'builder'
require "./models"

Rabl.register!
Sinatra::register Gon::Sinatra::Rabl



configure(:development){set :database, "sqlite3:microblog.sqlite3"}


enable :sessions





get "/" do 
	render :rabl, :foo, :format => "json"
	@posts = Post.all
	@users = User.all
	@groups = Group.all
	@comments = Comment.all
	@i = 1

	if session[:user_id]
		@current_user = User.find(session[:user_id])
		
		if @current_user.group_id
			@groupie = true
			@gname = Group.where(id: @current_user.group_id).first
		end

	end

	
	erb :index

end



##Navigation actions
#Go to home page

#View this user's profile
get "/users/profile" do
	
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
		group = Group.where(name: user.group_name).first
		user.group_id = group.id
	end

	user.save

	session[:user_id] = user.id

	flash[:notice] = "You are now signed in with a new account!"
	flash[:get_started] = "You can start by making your first post at the Make New Post link in the menu bar abive."
	
	redirect "/"
end

#Logging in a user that already exists
get "/sign/in" do



	erb :"users/signin"
end

post "/log/in" do
	user = User.where(username: params[:username]).first
	
	if user.password == params[:password]
		flash[:notice] = "You are now logged in."
		session[:user_id] = user.id
		redirect "/users/profile"
	else
		flash[:notice] = "Incorrect login credentials."
	end

	redirect "/sign/in"
end

#Logging out a user
get "/log/out" do
	session.clear

	redirect "/"
end

#Viewing a user's profile
get "/users/view/:id" do
	profile =  User.find(:id)

	erb :"users/user"
end

#Editing this user's profile
post "/users/edit/avatar/:id" do
	user = User.find(params[:id])
	user.avatar = params[:avatar]
	user.save
	redirect "users/profile"
end

post "/users/edit/username/:id" do
	user = User.find(params[:id])
	user.username = params[:username]
	user.save
	redirect "/users/profile"
end

post "/users/edit/password/:id" do
	user = User.find(params[:id])
	user.password = params[:password]
	user.save
	redirect "/users/profile"
end

post "/users/edit/group/:id" do
	user = User.find(params[:id])
	user.group_name = params[:group_name]
	if params[:group_name]
		group = Group.where(name: user.group_name).first
		user.group_id = group.id
	end
	user.save
	redirect "users/profile"
end


##Post related actions
#Creating a new post
get "/post/new" do
	

	erb :"posts/post"
end


post "/posts" do
	# or Post.create(title: params["title"], body: params["body"])


	post = Post.new

	post.title = params[:title]

	if params[:body] == nil
		post.meme = params[:memeUrl]
	else
		post.meme = params[:body]
	end

	post.user_id = session[:user_id]

	post.save

	redirect "/"
end

#Editing a post
get '/posts/edit/:id' do
  @post = Post.find(params[:id])
  

  erb :"posts/post_view"
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

##Comment related actions
#Adding a new comment
post "/comment/add/:post_id/:user_id" do
	
	comment = Comment.new
	comment.post_id = params[:post_id]
	comment.user_id = params[:user_id]
	comment.body = params[:comment]

	comment.save

	redirect "/"
end

#Deleting a comment
get "/comments/delete/:id" do
	comment = Comment.find(params[:id])

	comment.destroy
	redirect "/"
end


##Group related actions
#Starting a new group

#Viewing a group's profile page

#Showing and hiding hidden messages







