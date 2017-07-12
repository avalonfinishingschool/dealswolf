# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pending_invitation, :class => 'PendingInvitations' do
    team_id 1
    email "MyString"
  end
end
