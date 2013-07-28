FactoryGirl.define do
  factory :user do
    email "martin.causey@gmail.com"
    password "testing_password"
    password_confirmation "testing_password"
  end
end
