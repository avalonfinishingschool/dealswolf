require 'spec_helper'

describe Stage do
  it "must have a valid factory" do
  	FactoryGirl.create(:stage).should be_valid
  end
  it "must not be valid if name is invalid." do
  	FactoryGirl.build(:stage, :name => nil).should_not be_valid
  end
  it "must not be valid if invalid team" do
  	FactoryGirl.build(:stage, :team_id => nil).should_not be_valid
  end
end
