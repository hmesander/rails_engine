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

  def self.total_rev_on_date(date)
    date = DateTime.parse(date)

    Merchant.joins(invoice_items: [:transactions])
    .where(invoices: {created_at: date.beginning_of_day..date.end_of_day})
    .where(transactions: {result: "success"})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def total_revenue(date = {})
    invoice_items
      .joins(:transactions)
      .where(date)
      .merge(Transaction.success)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
