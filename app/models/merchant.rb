class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.favorite_customer(merchant_id)
    Customer.joins(:transactions, :merchants)
    .group(:id)
    .where(transactions: {result: "success"},  merchants: {id: merchant_id})
    .order("count(transactions)")
    .limit(1)
    .first
  end

  def total_revenue
    invoice_items
      .joins(:transactions)
      .merge(Transaction.success)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
