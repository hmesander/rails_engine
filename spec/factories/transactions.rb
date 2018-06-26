FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number Faker::Number.number(12)
    credit_card_expiration_date "2018-06-25 17:28:34"
    result Faker::Ancient.god
  end
end
