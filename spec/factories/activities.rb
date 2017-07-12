# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    name "Let's go eat dinner"
    deal_id 1
    team_id 1
    person_id 1
    organization_id 1
    type_id 1
    note "We chilled today"
    date "2013-12-22 18:28:33"
    length 20
    user_id 1
    done false
  end
end
