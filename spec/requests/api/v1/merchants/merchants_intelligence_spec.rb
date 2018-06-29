require 'rails_helper'

describe 'Merchants API' do
  it 'sends revenue for an individual merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant)
    create(:invoice_item, item: item, invoice: invoice, unit_price: 300, quantity: 5)
    create(:transaction, invoice: invoice, result: 'success')

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    returned = JSON.parse(response.body)

    expect(returned['revenue']).to eq('15.00')
  end

  it 'should return the total revenue for all merchant for a certain date' do
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant, created_at: DateTime.parse("2012-03-16"))
    invoice2 = create(:invoice, merchant: merchant, created_at: DateTime.parse("2012-03-18"))

    create_list(:invoice_item, 5, invoice: invoice1, quantity: 5, unit_price: 100)
    create_list(:invoice_item, 5, invoice: invoice2, quantity: 5, unit_price: 100)

    create(:transaction, result: "success", invoice: invoice1)

    get "/api/v1/merchants/revenue?date=2012-03-16"

    returned = JSON.parse(response.body)

    expect(returned["total_revenue"]).to eq("25.00")
  end

  it 'sends revenue for an individual merchant on a specific date' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, created_at: '2012-03-25 09:54:09 UTC', merchant: merchant)
    create(:invoice_item, item: item, invoice: invoice, unit_price: 300, quantity: 5)
    create(:invoice_item, item: item, invoice: invoice, unit_price: 200, quantity: 4)
    create(:transaction, invoice: invoice, result: 'success')

    get "/api/v1/merchants/#{merchant.id}/revenue?date=2012-03-25"

    returned = JSON.parse(response.body)

    expect(returned['revenue']).to eq('23.00')
  end

  it 'sends returns top merchants based on most items sold' do
    merchants = create_list(:merchant, 5)
    item0 = create(:item, merchant: merchants[0])
    item1 = create(:item, merchant: merchants[1])
    item2 = create(:item, merchant: merchants[2])
    item3 = create(:item, merchant: merchants[3])
    item4 = create(:item, merchant: merchants[4])
    invoice0 = create(:invoice, merchant: merchants[0])
    invoice1 = create(:invoice, merchant: merchants[1])
    invoice2 = create(:invoice, merchant: merchants[2])
    invoice3 = create(:invoice, merchant: merchants[3])
    invoice4 = create(:invoice, merchant: merchants[4])
    create(:transaction, invoice: invoice0, result:'success')
    create(:transaction, invoice: invoice1, result:'success')
    create(:transaction, invoice: invoice2, result:'success')
    create(:transaction, invoice: invoice3, result:'success')
    create(:transaction, invoice: invoice4, result:'success')

    create(:invoice_item, item: item0, invoice: invoice0, quantity: 5)
    create(:invoice_item, item: item1, invoice: invoice1, quantity: 2)
    create(:invoice_item, item: item2, invoice: invoice2, quantity: 9)
    create(:invoice_item, item: item3, invoice: invoice3, quantity: 3)
    create(:invoice_item, item: item4, invoice: invoice4, quantity: 7)
    get '/api/v1/merchants/most_items?quantity=3'

    returned = JSON.parse(response.body)
        expect(returned.length).to eq(3)
    expect(returned[0]['name']).to eq(merchants[2].name)
    expect(returned[1]['name']).to eq(merchants[4].name)
    expect(returned[2]['name']).to eq(merchants[0].name)
  end

  it 'should return the top x merchants by revenue' do
    merchant1 = create(:merchant, name:"Top merchant")
    merchant2 = create(:merchant, name:"not a Top merchant")
    merchant3 = create(:merchant, name:"another Top merchant")
    merchant4 = create(:merchant, name:"not Top merchant")

    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice4 = create(:invoice, merchant: merchant4)

    create_list(:invoice_item, 5, quantity: 5, unit_price: 1000, invoice: invoice1) 
    create_list(:invoice_item, 5, quantity: 3, unit_price: 900, invoice: invoice2) 
    create_list(:invoice_item, 5, quantity: 2, unit_price: 600, invoice: invoice3) 
    create_list(:invoice_item, 5, quantity: 1, unit_price: 400, invoice: invoice4) 

    create(:transaction, invoice: invoice1, result: "success")
    create(:transaction, invoice: invoice3, result: "success")

    get '/api/v1/merchants/most_revenue?quantity=2'

    merchants_returned = JSON.parse(response.body)

    expect(merchants_returned.size).to eq(2)
    expect(merchants_returned[0]["name"]).to eq(merchant1.name)
    expect(merchants_returned[1]["name"]).to eq(merchant3.name)
  end
  it 'should return customers with pending invoices' do
    merchant = create(:merchant)
    customer1 = create(:customer, first_name:"not pending")
    customer2 = create(:customer, first_name:"pending")
    customer3 = create(:customer, first_name:"not pending")
    customer4 = create(:customer, first_name:"not pending")
    invoice1 = create(:invoice, customer: customer1, merchant: merchant)
    invoice2 = create(:invoice, customer: customer2, merchant: merchant)
    invoice3 = create(:invoice, customer: customer3, merchant: merchant)
    invoice4 = create(:invoice, customer: customer4, merchant: merchant)
    create(:transaction, invoice: invoice1,result: 'success')
    create(:transaction, invoice: invoice1,result: 'success')

    create(:transaction, invoice: invoice2,result: 'failed')
    create(:transaction, invoice: invoice2,result: 'failed')

    create(:transaction, invoice: invoice3,result: 'success')
    create(:transaction, invoice: invoice3,result: 'failed')
    create(:transaction, invoice: invoice3,result: 'failed')

    create(:transaction, invoice: invoice4,result: 'failed')
    create(:transaction, invoice: invoice4,result: 'success')

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    returned_customers = JSON.parse(response.body)

    expect(returned_customers.size).to eq(1)
    expect(returned_customers[0]["first_name"]).to eq(customer2.first_name)
  end
end
