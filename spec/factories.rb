FactoryGirl.define do
  factory :user do
    sequence(:name)       { |n| "User-#{n}" }
    sequence(:email)      { |n| "user-#{n}@mail.com" }
    password              "xxxxxxxx"
    password_confirmation "xxxxxxxx"
  end
end