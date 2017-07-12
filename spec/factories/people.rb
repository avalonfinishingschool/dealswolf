# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "Rahul Dravid"
    organization_id 1
    user_id 1
    team_id 1
    visibility_id 1
  end
end
