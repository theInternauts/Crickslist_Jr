require 'faker'
require_relative '../models/secret_url'
require_relative '../models/post'
require_relative '../models/user'

module Generator
  # Fill the database with Users and associated posts and secret links (secret_urls)	
  def self.fake_data(num)
  	num.times do 
  		user = User.create!({email: Faker::Internet.email, password: '12345'})
  		rand(num/5).times do
  			post = user.posts.create!({title:Faker::Commerce.product_name, description:Faker::Company.catch_phrase, price:Faker::Number.regexify(/\d{4}/)})
  			post.set_secret_url
  		end
  	end
  end
  
  # Just create fake users
  def self.fake_users(num)
  	num.times do 
  		user = User.create!({email: Faker::Internet.email, password: '12345'})
  	end
  end

  # Just create fake posts and associated secret links (secret_urls)
  def self.fake_posts(num)
  	num.times do 
		item = Post.create!({title:Faker::Commerce.product_name, description:Faker::Company.catch_phrase, price:Faker::Number.regexify(/\d{4}/)})
		item.set_secret_url
  	end
  end
 
end