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

  def best_day
    invoices
      .merge(Invoice.success)
      .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items)
      .group('invoices.created_at')
      .order('revenue DESC, invoices.created_at DESC')
      .first
      .created_at
  end

  def self.most_items(quantity)
    select('SUM(invoice_items.quantity) AS total_sold, items.*')
      .joins(:invoice_items)
      .group(:id)
      .order('total_sold DESC')
      .limit(quantity)
  end
end
