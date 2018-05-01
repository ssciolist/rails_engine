require 'rails_helper'

describe 'Invoices API index' do
  skip 'sends a list of all invoices' do
    create_list(:customer, 3)
    create_list(:merchant, 3)
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  skip 'can show one invoice by its id' do
    create_list(:customer, 3)
    create_list(:merchant, 3)
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice['id']).to eq(id)
  end
end
