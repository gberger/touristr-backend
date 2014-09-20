# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    user nil
    city "MyString"
    start_date "2014-09-20"
    end_date "2014-09-20"
  end
end
