FactoryBot.define do
  factory :transaction do
    invoice
<<<<<<< HEAD
    credit_card_number Faker::Number.number(12)
    credit_card_expiration_date "2018-06-25 17:28:34"
    result Faker::Ancient.god
=======
    credit_card_number Faker::Number.number(16)
    credit_card_expiration_date "2018-06-25 17:28:34"
    result Faker::Food.dish
>>>>>>> Implements searching for a single transaction endpoint ATP
  end
end
