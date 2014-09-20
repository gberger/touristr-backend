require 'securerandom'

class User < ActiveRecord::Base
  has_many :trips

  validates_presence_of :provider, :uid, :name, :oauth_token, :oauth_token_expires_at, :api_key

  def self.new_from_params(params)
    u = User.new(params)
    u.api_key = SecureRandom.hex
    u
  end
end
