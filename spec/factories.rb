
FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testing.bot#{n}@rainybudget.com" }
    password "secret"
    password_confirmation "secret"
    time_zone "Arizona"
  end
end
