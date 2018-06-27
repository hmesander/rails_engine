class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :result, :invoice_id, :credit_card_number, :credit_card_expiration_date
end
