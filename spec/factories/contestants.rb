require 'faker'

FactoryGirl.define do
  factory :contestant do
    name { Faker::Name.name }
    img_url { Faker::LoremPixel.image }
  end
end
