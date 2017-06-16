FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@user.com" }
    password 'secret1234!'
    password_confirmation 'secret1234!'
  end
end
