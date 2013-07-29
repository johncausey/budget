require 'spec_helper'

describe "User authentication" do

  it "creates a new user" do
    user = FactoryGirl.build(:user)
    visit signup_path
    within(".new_user") do
      fill_in("Email Address", :with => user.email)
      fill_in("Password", :with => user.password)
      fill_in("Confirm Password", :with => user.password)
      click_button "Create my new account"
    end
    current_path.should eq(current_month_path)
  end

end
