require 'rails_helper'

describe "Invoices API" do
  it 'should return an index of invoices' do
    create_list(:invoice, 5)
    get '/api/v1/invoices'
    expect(response).to be_successful 
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(5)
  end

  it 'should return a specific invoice by id' do
    invoice_id = create(:invoice).id

    get "/api/v1/invoices/#{invoice_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_id)
  end

  it 'should find an invoice with arbitrary params' do
    invoice =  create(:invoice)
    create_list(:invoice, 4)
    get "/api/v1/invoices/find?status=#{invoice.status}"

    returned_invoice = JSON.parse(response.body)
    
    expect(response).to be_successful
    expect(returned_invoice["status"]).to eq(invoice.status)
    expect(returned_invoice["id"]).to eq(invoice.id)
  end

  it 'should return all invoices with certain params' do
    status = "some status"
    create_list(:invoice, 10, status: status)
    create_list(:invoice, 3, status: "another, different status")

    get "/api/v1/invoices/find_all?status=#{status}"
    returned_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(returned_invoices.count).to eq(10)

  end

  it 'should return a random invoice' do
    create_list(:invoice, 10)
    possible_ids = Invoice.all.map{|invoice| invoice.id}

    get '/api/v1/invoices/random'
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(possible_ids).to include(invoice[0]["id"])
  end
end

