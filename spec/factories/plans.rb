# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    name "Lite"
    number_users 20
    duration 1
    price 10.5
  end
end
