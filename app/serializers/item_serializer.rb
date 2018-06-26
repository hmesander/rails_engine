class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :merchant_id

  def unit_price
    number_to_currency(object.unit_price)
  end
end
