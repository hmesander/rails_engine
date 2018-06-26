class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
<<<<<<< HEAD
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.favorite_customer(merchant_id)
    Customer.joins(:transactions, :merchants)
    .group(:id)
    .where(transactions: {result: "success"},  merchants: {id: merchant_id})
    .order("count(transactions)")
    .limit(1)
    .first

  def total_revenue
=======
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def total_revenue
    invoice_items
      .joins(:transactions)
      .where(Transaction.success)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def format_revenue
    ('%.2f' % (total_revenue / 100).to_f)
>>>>>>> WIP total revenue for merchant
  end
end
