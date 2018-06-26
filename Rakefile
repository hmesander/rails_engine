# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :import_all => [:environment, "db:drop","db:create", "db:migrate"] do
  require 'CSV'
  CSV.foreach('./data/customers.csv', headers: true) do |row|
    Customer.create!(first_name: row["first_name"],
                     last_name: row["last_name"],
                     created_at: row["created_at"],
                     updated_at: row["updated_at"]
                    )
  end
  puts "Customers created"
  CSV.foreach('./data/merchants.csv', headers: true) do |row|
    Merchant.create!(name: row["name"],
                     created_at: row["created_at"],
                     updated_at: row["updated_at"])
  end
  puts "Merchants created"
  CSV.foreach('./data/items.csv', headers: true) do |row|
    Item.create!(name: row["name"],
                     description: row["description"],
                     merchant_id: row["merchant_id"].to_i,
                     unit_price: row["unit_price"].to_i,
                     created_at: row["created_at"],
                     updated_at: row["updated_at"])
  end
  puts "Item created"
  CSV.foreach('./data/invoices.csv', headers: true) do |row|
    Invoice.create!(customer_id: row["customer_id"].to_i,
                     merchant_id: row["merchant_id"].to_i,
                     status: row["status"],
                     created_at: row["created_at"],
                     updated_at: row["updated_at"])
  end
  puts "Invoices created"

  CSV.foreach('./data/invoice_items.csv', headers: true) do |row|
    InvoiceItem.create!(item_id: row["item_id"].to_i,
                     invoice_id: row["invoice_id"].to_i,
                     quantity: row["quantity"].to_i,
                     unit_price: row["unit_price"].to_i,
                     created_at: row["created_at"],
                     updated_at: row["updated_at"])
  end
  puts "Invoice items created"

  CSV.foreach('./data/transactions.csv', headers: true) do |row|
    Transaction.create!(invoice_id: row["invoice_id"].to_i,
                     credit_card_number: row["credit_card_number"].to_i,
                     credit_card_expiration_date: row["credit_card_expiration_date"],
                     result: row["result"],
                     created_at: row["created_at"],
                     updated_at: row["updated_at"])
  end
  puts "Transactions created"

end
