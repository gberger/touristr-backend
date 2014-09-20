require 'rails_helper'

describe User do
  describe 'relations' do
    # it { should have_many :chat_messages }
  end

  describe 'validations' do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:oauth_token) }
    it { should validate_presence_of(:oauth_token_expires_at) }
  end

end
