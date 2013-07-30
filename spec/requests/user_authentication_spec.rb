require 'spec_helper'

describe "User authentication" do

  it "creates a new user", :js => true do
    user = FactoryGirl.build(:user)
    visit signup_path
    within(".new_user") do
      fill_in("Email Address", :with => user.email)
      fill_in("Password", :with => user.password)
      fill_in("Confirm Password", :with => user.password)
      find("option[value='Arizona']").click
      click_button "Create my new account"
    end
    current_path.should eq(current_month_path)
  end

  it "will not allow a user to create another user" do
    @user = FactoryGirl.create(:user)
    visit login_path
    within(".login-box") do
      fill_in("Email Address", :with => @user.email)
      fill_in("Password", :with => @user.password)
      click_button "Access account"
    end
    current_path.should eq(current_month_path)
    visit signup_path
    page.should have_content("You are already logged into an account.")
    current_path.should eq(current_month_path)
  end

end
