require 'spec_helper'

describe "PasswordResets" do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "emails user when requesting password to be reset" do
    visit "/password_resets/new"
    within(".password-reset-form") do
      fill_in("Email Address", :with => @user.email)
      click_button "Request new Password"
    end
    last_email.to.should include(@user.email)
    page.should have_content("Email sent with password reset instructions.")
  end

  it "pretends to email but fails silently" do
    visit "/password_resets/new"
    within(".password-reset-form") do
      fill_in("Email Address", :with => "totally-not-an-email")
      click_button "Request new Password"
    end
    last_email.should == nil
    page.should have_content("Email sent with password reset instructions.")
  end
end
