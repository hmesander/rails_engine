require 'rails_helper'

describe 'Merchants API' do
  it 'sends revenue for an individual merchant' do
    merchant = create(:merchant)
    items = create_list(:item, 2, merchant_id: merchant.id)
    invoice = create(:invoice)
    create_list(:invoice_item, 2, item: items[0], invoice: invoice)
    create_list(:invoice_item, 3, item: items[1], invoice: invoice)
    create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    returned = JSON.parse(response.body)
    expected = '%.2f' % (merchant.total_revenue.to_f / 100)

    expect(returned['revenue']).to eq(expected)
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
    items = create_list(:item, 2, merchant_id: merchant.id)
    invoice = create(:invoice)
    create_list(:invoice_item, 2, item: items[0], invoice: invoice)
    create_list(:invoice_item, 3, item: items[1], invoice: invoice)
    create(:transaction, invoice: invoice)
    desired_date = invoice.created_at.to_s

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{desired_date}"

    returned = JSON.parse(response.body)
    expected = '%.2f' % (merchant.total_revenue('06-27-2018').to_f / 100)

    expect(returned['revenue']).to eq(expected)
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

    get '/api/v1/merchants/most_sold/revenue?quantity=3'

    returned = JSON.parse(response.body)

    expect(returned.length).to eq(3)
    expect(returned[0]['name']).to eq(merchants[2].name)
    expect(returned[1]['name']).to eq(merchants[4].name)
    expect(returned[2]['name']).to eq(merchants[0].name)
  end
end
