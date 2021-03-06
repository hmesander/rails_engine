class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :result, :invoice_id, :credit_card_number

  def credit_card_number
    object.credit_card_number.to_s
  end
end
