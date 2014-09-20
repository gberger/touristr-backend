require 'securerandom'

class User < ActiveRecord::Base
  has_many :trips

  validates_presence_of :provider, :uid, :name, :oauth_token, :oauth_token_expires_at

  private

  before_create :generate_api_key!
  def generate_api_key!
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end

end
