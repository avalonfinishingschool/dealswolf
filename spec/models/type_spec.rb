require 'spec_helper'

describe Type do
  it "must have a valid factory" do
  	FactoryGirl.create(:type).should be_valid
  end
  it "should have valid name" do
  	FactoryGirl.build(:type, :name => nil).should_not be_valid
  end
   it "should not have duplicate name" do
  	FactoryGirl.create(:type, :name => "one")
  	FactoryGirl.build(:type, :name => "one").should_not be_valid
  end
end
