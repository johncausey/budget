require 'spec_helper'

describe "Contact Message Mailer" do

  before(:each) do
    @full_name = "Ashley Bretton"
    @email_address = "ashley.bretton@rainybudget.com"
    @email_body = "This is the body content for the email."
    @support_email = "support@rainybudget.com"
  end

  it "sends an email to support if not a user", :js => true do
    visit contact_us_path
    within(".new_message") do
      fill_in("Full Name", :with => @full_name)
      fill_in("Email Address", :with => @email_address)
      fill_in("Message Content", :with => @email_body)
      click_button "Contact us!"
    end
    page.should have_content("Thank you! We will respond as soon as we can through email.")
    current_path.should eq(root_path)
    last_email.to.should include(@support_email)
  end

  it "sends an email to support when logged in as a user", :js => true do
    user = FactoryGirl.create(:user)
    visit login_path
    within(".login-box") do
      fill_in("Email Address", :with => user.email)
      fill_in("Password", :with => user.password)
      click_button "Access account"
    end
    current_path.should eq(current_month_path)
    visit contact_us_path
    within(".new_message") do
      fill_in("Full Name", :with => @full_name)
      fill_in("Email Address", :with => @email_address)
      fill_in("Message Content", :with => @email_body)
      click_button "Contact us!"
    end
    page.should have_content("Thank you! We will respond as soon as we can through email.")
    current_path.should eq(root_path)
    last_email.to.should include(@support_email)
  end

end
