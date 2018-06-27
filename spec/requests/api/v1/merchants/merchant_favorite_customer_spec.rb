require 'rails_helper'

describe 'Merchants API favorite customer' do
  it 'should return the customer with the highest number of successful transactions' do
    merchant = create(:merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)

    invoice1 = create(:invoice, merchant: merchant, customer: customer1)
    invoice2 = create(:invoice, merchant: merchant, customer: customer2)
    invoice3 = create(:invoice, merchant: merchant, customer: customer3)

    create_list(:transaction, 10, invoice: invoice1, result: "success")
    create_list(:transaction, 5, invoice: invoice2, result: "fail")
    create_list(:transaction, 2, invoice:invoice3, result: "fail")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    returned_customer = JSON.parse(response.body)


    expect(returned_customer["id"]).to eq(customer1.id)
  end
end