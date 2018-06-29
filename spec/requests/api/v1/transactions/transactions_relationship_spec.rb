require 'rails_helper'

describe 'Transactions API' do
  it 'returns the associated invoice' do
    invoice = create(:invoice)
    create_list(:invoice, 4)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to have_http_status(200)

    returned_invoice = JSON.parse(response.body)

    expect(returned_invoice['status']).to eq(invoice.status)
    expect(returned_invoice['id']).to eq(invoice.id)
  end
end
