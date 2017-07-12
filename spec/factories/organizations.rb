# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "Infosys"
    address "60/45 Someplace, somewhere"
    user_id 1
    team_id 1
    visibility_id 1
  end
end
