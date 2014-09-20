FactoryGirl.define do
  factory :user do
    provider "facebook"
    sequence(:uid) {|n| (500000 + n).to_s }
    sequence(:name) {|n| "Bob#{n}" }
    sequence(:oauth_token) {|n| (123456 + n).to_s }
    oauth_token_expires_at (Time.now + 1.year)

    factory :user_with_short_password do
      password "abc"
    end
  end
end
