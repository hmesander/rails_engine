class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :result, :invoice_id, :credit_card_number
end
