require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of invoices belonging to a customer' do
    customer = create(:customer)
    create_list(:invoice, 5, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to have_http_status(200)

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(5)
  end
end
