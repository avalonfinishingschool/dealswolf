# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do
    person_id 1
    organization_id 1
    title "Easy Deal"
    value 300
    currency_id 1
    close_date "2013-12-25 18:18:52"
    start_date "2013-12-22 18:18:52"
    status "Won"
    phone "9741863192"
    visibility_id 1
    email "mercurialmercenary@gmail.com"
    user_id 1
    team_id 1
    stage_id 1
  end
end
