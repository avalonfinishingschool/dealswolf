require 'spec_helper'

describe Person do
  it "should have valid factory" do
  	FactoryGirl.create(:person).should be_valid
  end
  it "should have a valid details" do
  	FactoryGirl.build(:person, :name => nil, :team_id => nil, :user_id => nil, :visibility_id => nil).should_not be_valid
  end
end
