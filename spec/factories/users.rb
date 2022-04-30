FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:username) { |n| "username#{n}" }

  factory :user do
    name     { Faker::Name.name }
    email    { generate :email }
    username { generate :username }
    password { "validpassword10" }
  end
end
