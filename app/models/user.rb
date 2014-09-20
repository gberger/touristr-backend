require 'securerandom'

class User < ActiveRecord::Base
  has_many :trips

  validates_presence_of :provider, :uid, :name, :oauth_token, :oauth_token_expires_at

  def self.new_from_facebook(params)
    user = self.new
    user.provider = "facebook"
    user.uid = params[:userID]
    user.oauth_token = params[:accessToken]
    user.oauth_token_expires_at = Time.now + params[:expiresIn].to_i.seconds

    f = FbGraph::User.me(user.oauth_token)
    user.name = f.first_name || "???"
    user.email = f.email
    user
  end

  private

  before_create :generate_api_key!
  def generate_api_key!
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end

end
