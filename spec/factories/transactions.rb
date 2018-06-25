FactoryBot.define do
  factory :transaction do
    invoice nil
    credit_card_number ""
    credit_card_expiration_date "2018-06-25 17:28:34"
    result "MyString"
  end
end
