require 'spec_helper'

describe Activity do
  it "must have a valid factory" do
  	FactoryGirl.create(:activity).should be_valid
  end
  it "must not be valid if name is invalid." do
  	FactoryGirl.build(:activity, :name => nil).should_not be_valid
  end
   it "must not be valid if team id is invalid." do
  	FactoryGirl.build(:activity, :team_id => nil).should_not be_valid
  end
   it "must not be valid if type id is invalid." do
  	FactoryGirl.build(:activity, :type_id => nil).should_not be_valid
  end
   it "must not be valid if date is invalid." do
  	FactoryGirl.build(:activity, :date => nil).should_not be_valid
  end
   it "must not be valid if user id is invalid." do
  	FactoryGirl.build(:activity, :user_id => nil).should_not be_valid
  end
   it "must not be valid if length < 0 ." do
  	FactoryGirl.build(:activity, :length => -5).should_not be_valid
  end
  it "must not be valid if length is a string." do
  	FactoryGirl.build(:activity, :length => "stri").should_not be_valid
  end
end
