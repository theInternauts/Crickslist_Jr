require_relative './post'

class User < ActiveRecord::Base
	has_many :posts
end