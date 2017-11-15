require 'factory_bot'
FactoryBot.define do

  factory :post do
    title 'Title'
    description 'Description'
    tag 'tag'
    thumbnail ''
    user_id 1
  end
end