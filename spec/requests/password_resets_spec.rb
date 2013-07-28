require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password to be reset" do
    user = FactoryGirl.create(:user)
    visit new_password_reset_path
    fill_in("email", :with => user.email, :match => :prefer_exact)
    click_button "Request new Password"
    page.should have_content("Email sent with password reset instructions.")
  end
end
