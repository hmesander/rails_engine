class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_items(quantity)
    Item.joins(invoices: [:transactions])
    .joins(:invoice_items)
    .order("sum(invoice_items.quantity * invoice_items.unit_price)DESC")
    .group(:id)
    .where(transactions: {result: "success"})
    .limit(quantity)
  end
end
