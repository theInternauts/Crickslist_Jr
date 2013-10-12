$LOAD_PATH.unshift(File.expand_path('.'))

require 'sinatra'
require 'sinatra/activerecord'

# require_relative './models/user'
require_relative './models/post'

begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end

set :database, ENV['DATABASE_URL']

get '/' do
  @all_posts = Post.all
  erb :index
end

get '/add' do
  erb :form_add_post
end

post '/post-add' do
  Post.create!({title: params[:title], description: params[:desc], price: params[:price]})
  redirect '/'
end
