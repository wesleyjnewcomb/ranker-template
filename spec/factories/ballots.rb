FactoryGirl.define do
  factory :ballot do
    contestant1 { FactoryGirl.create(:contestant) }
    contestant2 { FactoryGirl.create(:contestant) }

    contestant1_wins { rand(100) }
    contestant2_wins { rand(100) }
  end
end
