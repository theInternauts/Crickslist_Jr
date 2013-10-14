require_relative './secret_url'
require_relative './user'

class Post < ActiveRecord::Base
  has_one :secret_url, dependent: :destroy
  belongs_to :user
  
  def set_secret_url
  	temp_secret = Digest::MD5.hexdigest(Random.new_seed.to_s)
    sec = self.build_secret_url
    sec.secret = temp_secret
    sec.save
    sec.secret
  end
end