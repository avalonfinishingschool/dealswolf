require 'spec_helper'

describe Email do
  it "should have valid factory" do
  	FactoryGirl.create(:email).should be_valid
  end
  it "should have a valid details" do
  	FactoryGirl.build(:deal, :person_id => nil, :value => nil).should_not be_valid
  end
end
