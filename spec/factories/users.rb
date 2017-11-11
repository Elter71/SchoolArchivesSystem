require 'factory_bot'
FactoryBot.define do

  factory :user do
    email 'some@example.com'
    first_name 'Bob'
    last_name 'Some'
    password '123456'
    role_id 1
    trait :admin do
      role_id 2
    end

  end
end