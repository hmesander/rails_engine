require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to have_http_status(200)

    customers = JSON.parse(response.body)

    expect(customers.length).to eq(5)
  end

  it 'can get one customer by its id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(customer['id']).to eq(id)
  end
end
