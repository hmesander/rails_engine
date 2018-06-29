class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.favorite_customer(merchant_id)
    Customer.joins(:transactions, :merchants)
            .group(:id)
            .where(transactions: {result: "success"},  merchants: {id: merchant_id})
            .order("count(transactions) DESC")
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

  def total_revenue(filter = {})
    invoice_items
      .joins(:transactions)
      .where(filter)
      .merge(Transaction.success)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.top_merchants(quantity)
    Merchant.joins(invoice_items: [:transactions])
    .order("sum(invoice_items.quantity*invoice_items.unit_price) DESC")
    .group(:id)
    .where(transactions: {result: "success"})
    .limit(quantity)
  end

  def self.rank_by_items(merch_num)
    joins(invoice_items: [:transactions])
    .order('sum(invoice_items.quantity) DESC')
    .where(transactions:{result: "success"})
    .group(:id)
    .limit(merch_num)
  end
end
