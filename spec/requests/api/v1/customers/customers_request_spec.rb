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

  it 'can find single customer from given params' do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    expect(response).to have_http_status(200)

    returned = JSON.parse(response.body)

    expect(returned['first_name']).to eq(customer.first_name)
  end

  it 'can find all customers from given params' do
    create_list(:customer, 3, first_name: 'Haley')
    name = 'Sam'
    create_list(:customer, 5, first_name: name)

    get "/api/v1/customers/find_all?first_name=#{name}"

    expect(response).to have_http_status(200)

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(5)
    customers.each do |customer|
      expect(customer['first_name']).to eq(name)
    end
  end

  it 'can return a random customer' do
    customers = create_list(:customer, 8)

    get '/api/v1/customers/random'

    expect(response).to have_http_status(200)

    customer = JSON.parse(response.body)

    expect(customer[0]['first_name']).to eq(customers[1].first_name)
  end
end
