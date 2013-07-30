require 'spec_helper'

describe "User authorization" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    visit login_path
    within(".login-box") do
      fill_in("Email Address", :with => @user.email)
      fill_in("Password", :with => @user.password)
      click_button "Access account"
    end
    current_path.should eq(current_month_path)
  end

  it "can visit expenses page" do
    visit expenses_path
    current_path.should eq(expenses_path)
  end

  it "can visit incomes page" do
    visit incomes_path
    current_path.should eq(incomes_path)
  end

  it "can visit savings page" do
    visit savings_path
    current_path.should eq(savings_path)
  end

  it "can visit account information page" do
    visit account_information_path
    current_path.should eq(account_information_path)
  end

  it "can add and delete a new expense", :js => true do
    visit expenses_path
    within(".new_expense") do
      fill_in("Expense Name", :with => "New expense in test suite")
      fill_in("Dollar Amount", :with => "$344.80")
      fill_in("expense[date_added]", :with => Time.zone.now.to_date)
      click_button "Add this Expense"
    end
    page.should have_content("New expense added!")
    click_link "remove"
    page.driver.browser.switch_to.alert.accept
    page.should have_content("This expense has been removed.")
    current_path.should eq(expenses_path)
  end

  it "can add and delete a new income", :js => true do
    visit incomes_path
    within(".new_income") do
      fill_in("Income Source", :with => "New income in test suite")
      fill_in("Dollar Amount", :with => "$344.80")
      fill_in("income[date_added]", :with => Time.zone.now.to_date)
      click_button "Add this Income"
    end
    page.should have_content("New income added!")
    click_link "remove"
    page.driver.browser.switch_to.alert.accept
    page.should have_content("This income has been removed.")
    current_path.should eq(incomes_path)
  end

  it "can reset the saving goal", :js => true do
    visit savings_path
    within(".new_saving") do
      fill_in("saving[amount]", :with => "$500.00")
      click_button "Set Goal"
    end
    page.should have_content("Updated your saving goal for #{Time.zone.now.strftime("%B")}")
    current_path.should eq(savings_path)
    within(".new_saving") do
      fill_in("saving[amount]", :with => "$250.00")
      click_button "Set Goal"
    end
    page.should have_content("Updated your saving goal for #{Time.zone.now.strftime("%B")}")
    current_path.should eq(savings_path)
  end

  it "can change user first and last name", :js => true do
    visit account_information_path
    page.should have_content("Logged in as #{@user.email}")
    within(".edit_user") do
      fill_in("user[first_name]", :with => "Kelsey")
      fill_in("user[last_name]", :with => "Ein")
      click_button "Update Account Information"
    end
    page.should have_content("Logged in as Kelsey Ein")
    current_path.should eq(current_month_path)
  end

  it "cannot change user first and last name for another account", :js => true do
    7.times do
      FactoryGirl.create(:user)
    end
    visit "/users/3/edit"
    page.should have_content("Please log into your account to access this section.")
    current_path.should eq(root_path)
  end

end
