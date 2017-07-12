require 'spec_helper'

describe Plan do
   it "should have valid factory" do
  	FactoryGirl.create(:plan).should be_valid
  end
   it "should have valid name" do
  	FactoryGirl.build(:plan, :name => nil).should_not be_valid
  end
   it "should not have duplicate name" do
  	FactoryGirl.create(:plan, :name => "one")
  	FactoryGirl.build(:plan, :name => "one").should_not be_valid
  end
it "should have valid price" do
  	FactoryGirl.build(:plan, :price => nil).should_not be_valid
  end
  it "should have floating price" do
  	FactoryGirl.build(:plan, :price => "nil").should_not be_valid
  end
  it "should have valid price" do
  	FactoryGirl.build(:plan, :price => nil).should_not be_valid
  end
  it "should have valid price >0 " do
  	FactoryGirl.build(:plan, :price => -5).should_not be_valid
  end
   it "should have duration >0 " do
  	FactoryGirl.build(:plan, :duration => -1).should_not be_valid
  end
  it "should have number users >0 " do
  	FactoryGirl.build(:plan, :number_users => -1).should_not be_valid
  end
end
