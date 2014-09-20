# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    trip_a_id 1
    trip_b_id 1
    message "MyText"
  end
end
