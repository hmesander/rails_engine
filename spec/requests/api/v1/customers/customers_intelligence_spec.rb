describe 'Customers API' do
  it 'sends favorite merchant for an individual customer' do
    customer = create(:customer)
    merchants = create_list(:merchant, 3)
    invoice0 = create(:invoice, merchant: merchants[0], customer: customer)
    invoice1 = create(:invoice, merchant: merchants[1], customer: customer)
    invoice2 = create(:invoice, merchant: merchants[2], customer: customer)
    create_list(:transaction, 2, invoice: invoice0, result: 'success')
    create_list(:transaction, 10, invoice: invoice1, result: 'success')
    create_list(:transaction, 3, invoice: invoice2, result: 'success')

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to have_http_status(200)

    returned = JSON.parse(response.body)
    expect(returned['name']).to eq(merchants[1].name)
  end
end
