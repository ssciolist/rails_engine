require 'rails_helper'

describe 'Transactions API relations' do
  it '\loads a collection of invoices associated with one transaction' do
    merchant = create(:merchant)
    item = merchant.items.create!(attributes_for(:item))
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = Transaction.create(attributes_for(:transaction, invoice_id: invoice.id))

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices['id']).to eq(invoice.id)
  end
end
