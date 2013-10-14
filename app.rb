$LOAD_PATH.unshift(File.expand_path('.'))

require 'sinatra'
require 'sinatra/activerecord'
# require 'rack-flash'  # including this throws errors that I can't resolve
require 'sinatra/redirect_with_flash'  

require_relative './models/secret_url'
require_relative './models/post'
require_relative './models/user'


begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end
# 3600 = 1 hour
# 86400 = 1 day
# 2592000 = 30 days
enable :sessions
use Rack::Session::Pool, :expire_after => 1200
set :session_secret, "The Thunderbirds are a 'GO'!"
set :protection, :session => true

set :database, ENV['DATABASE_URL']

get '/' do
	@all_posts = Post.all.order("created_at DESC")
	erb :index
end

get '/post/:id' do
	@post = Post.find(params[:id])
	erb :detail_post
end

get '/add' do
	erb :form_add_post
end

post '/post-add' do
	new_post = Post.create!({title: params[:title], description: params[:desc], price: params[:price]})
	session[:edit_key] = new_post.set_secret_url
	redirect '/p/complete'
end

post '/post-edit' do
	post = Post.find(params[:id])
	post.update({title: params[:title], description: params[:desc], price: params[:price]})
	redirect "/post/#{post.id}"
end

get '/p/complete' do
	if session[:edit_key]
		@secret = session[:edit_key]
		session[:edit_key] = nil  #clear this for security
		erb :success_post
	else
		redirect '/'
	end
end

get '/p/:key' do
	id = SecretUrl.find_by secret: params[:key]
	if id
		id = id.post_id
		@post = Post.find(id)	
		if @post != nil
			erb :form_edit_post
		else
			erb :notice_expired
		end
	else
		erb :notice_expired
	end
end

#completely insecure.  Doens't check for login, session, cookie, nada
get '/edit/:id' do
	@post = Post.find(params[:id])
	if @post
		erb :form_edit_post		
	else
		redirect '/'
	end
end
