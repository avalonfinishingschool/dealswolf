require 'spec_helper'

describe Visibility do
  it "must have a valid factory" do
  	FactoryGirl.create(:visibility).should be_valid
  end
  it "should have valid name" do
  	FactoryGirl.build(:visibility, :name => nil).should_not be_valid
  end
   it "should not have duplicate name" do
  	FactoryGirl.create(:visibility, :name => "one")
  	FactoryGirl.build(:visibility, :name => "one").should_not be_valid
  end
end
