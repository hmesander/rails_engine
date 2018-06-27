require 'rails_helper'

describe 'Transactions API' do
  it 'returns the associated invoice' do
    merchant = create(:merchant)
    create_list(:merchant, 4)
    transaction = create(:transaction, merchant: merchant)

    get "/api/v1/transactions/#{transaction.id}/merchant"

    expect(response).to have_http_status(200)

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq(merchant.name)
    expect(merchant["id"]).to eq(merchant.id)
  end
end