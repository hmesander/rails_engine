require 'rails_helper'

describe 'Invoice Items API' do
  it 'sends the invoice associated with an invoice item' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    item = create(:item, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to have_http_status(200)

    invoice = JSON.parse(response.body)

    expect(invoice['id']).to eq(invoice.id)
  end
end
