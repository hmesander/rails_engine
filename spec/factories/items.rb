FactoryBot.define do
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Coffee.notes
    merchant
    unit_price ""
  end
end
