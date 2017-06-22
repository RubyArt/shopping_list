FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "scarlet_witch#{n}@user.com" }
    sequence(:first_name) { |n| "wanda_#{n}@user.com" }
    sequence(:last_name) { |n| "maximoff_#{n}@user.com" }
    password 'secret12'
    password_confirmation 'secret12'
  end
end
