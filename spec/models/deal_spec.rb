require 'spec_helper'

describe Deal do
  it "should have valid factory" do
  	FactoryGirl.create(:deal).should be_valid
  end
  it "should have a valid title" do
  	FactoryGirl.build(:deal, :title => nil).should_not be_valid
  end
  it "should have a value that's not nil" do
  	FactoryGirl.build(:deal, :value => nil).should_not be_valid
  end
  it "should have a value that's integer" do
  	FactoryGirl.build(:deal, :value => "nil").should_not be_valid
  end
  it "should have a value that's positive" do
  	FactoryGirl.build(:deal, :value => -5).should_not be_valid
  end
  it "should have a status that is either won lost or pending" do
  	FactoryGirl.build(:deal, :status => "nil").should_not be_valid
  end
  it "should have a valid visibility" do
  	FactoryGirl.build(:deal, :visibility_id => nil).should_not be_valid
  end
  it "should have a valid user" do
  	FactoryGirl.build(:deal, :user_id => nil).should_not be_valid
  end
  it "should have a valid stage" do
  	FactoryGirl.build(:deal, :stage_id => nil).should_not be_valid
  end
  it "should have a valid team" do
  	FactoryGirl.build(:deal, :team_id => nil).should_not be_valid
  end
  it "should have valid dates" do
  	FactoryGirl.build(:deal, :start_date => nil).should_not be_valid
  end
end
