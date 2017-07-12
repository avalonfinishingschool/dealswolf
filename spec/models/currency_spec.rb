require 'spec_helper'

describe Currency do
  it "should have valid factory" do
  	FactoryGirl.create(:currency).should be_valid
  end
  it "should fail if either country or extension fail" do
  	FactoryGirl.build(:currency, :country => nil, :extension => nil).should_not be_valid
  end
end
