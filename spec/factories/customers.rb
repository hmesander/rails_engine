FactoryBot.define do
  factory :customer do
    first_name Faker::Lebowski.actor
    last_name Faker::Lebowski.actor
  end
end
