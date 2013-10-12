class Post < ActiveRecord::Base
  has_many :HashUrl
  
  def create_hash_url
    # @hash_url = HashUrl.create!({})
  end
end