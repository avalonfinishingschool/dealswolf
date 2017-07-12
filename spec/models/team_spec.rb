require 'spec_helper'

describe Team do
  it "must have a valid factory" do
  	FactoryGirl.create(:team).should be_valid
  end
  it "must not be valid if name is invalid." do
  	FactoryGirl.build(:team, :name => nil).should_not be_valid
  end
  it "must not be valid if user is present." do
  	FactoryGirl.build(:team, :user_id => nil).should_not be_valid
  end
  it "must not be valid if plan is present." do
  	FactoryGirl.build(:team, :plan_id => nil).should_not be_valid
  end
end
