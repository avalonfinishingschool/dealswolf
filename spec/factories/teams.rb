# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name "My cool team"
    user_id 1
    plan_id 1
    renewal_date "2013-12-22 18:18:52"
    stripe_customer_token "tok_kebkfbkbw"
  end
end
