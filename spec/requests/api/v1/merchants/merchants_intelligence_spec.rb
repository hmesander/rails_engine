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

    expect(returned["revenue"]).to eq("25.00")
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
    item0 = create(:item, merchant_id: merchants[0].id)
    item1 = create(:item, merchant_id: merchants[1].id)
    item2 = create(:item, merchant_id: merchants[2].id)
    item3 = create(:item, merchant_id: merchants[3].id)
    item4 = create(:item, merchant_id: merchants[4].id)
    invoice = create(:invoice)
    create(:invoice_item, item: item0, invoice: invoice, quantity: 5)
    create(:invoice_item, item: item1, invoice: invoice, quantity: 2)
    create(:invoice_item, item: item2, invoice: invoice, quantity: 9)
    create(:invoice_item, item: item3, invoice: invoice, quantity: 3)
    create(:invoice_item, item: item4, invoice: invoice, quantity: 7)

    get '/api/v1/merchants/most_items?quantity=3'

    returned = JSON.parse(response.body)

    expect(returned.length).to eq(3)
    expect(returned[0]['name']).to eq(merchants[2].name)
    expect(returned[1]['name']).to eq(merchants[4].name)
    expect(returned[2]['name']).to eq(merchants[0].name)
  end
end
