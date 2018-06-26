class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
<<<<<<< HEAD
=======
  has_many :invoices, through: :invoice_items
>>>>>>> WIP total revenue for merchant
end
