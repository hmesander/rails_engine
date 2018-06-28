class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :merchant_id, :description, :unit_price

  def unit_price
    '%.2f' % (object.unit_price.to_f / 100)
  end
end
