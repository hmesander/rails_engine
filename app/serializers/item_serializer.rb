class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :merchant_id, :description, :unit_price

  def price
    number_to_currency(object.unit_price)
  end
end
