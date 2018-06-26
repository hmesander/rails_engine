FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status Faker::Hipster.sentence
  end
end
