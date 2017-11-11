require 'factory_bot'
FactoryBot.define do

  factory :post do
    title 'Title'
    description 'Description'
    tag 'tag'
    thumbnail ''
  end
end