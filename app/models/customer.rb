class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants
      .joins(:invoices, :transactions)
      .merge(Transaction.success)
      .group(:id)
      .order('COUNT(invoices.id) DESC')
      .limit(1)
  end

  def self.pending_customers(merch_id)
    find_by_sql ["SELECT customers.* FROM customers
      INNER JOIN invoices
      ON invoices.customer_id = customers.id
      INNER JOIN merchants
      ON invoices.merchant_id = merchants.id
      INNER JOIN transactions
      ON transactions.invoice_id = invoices.id
      WHERE merchants.id = ?
      EXCEPT
        SELECT customers.* FROM customers
        INNER JOIN invoices
        ON invoices.customer_id = customers.id
        INNER JOIN merchants
        ON invoices.merchant_id = merchants.id
        INNER JOIN transactions
        ON transactions.invoice_id = invoices.id
        WHERE merchants.id = ? AND transactions.result = 'success'", merch_id, merch_id]
  end
end
