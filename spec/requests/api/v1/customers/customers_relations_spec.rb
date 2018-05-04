require 'rails_helper'

describe 'Customers API relations' do
  it '/customers returns invoices associated with one customer' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice1 = create(:invoice_with_transactions, customer: customer, merchant: merchant)

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(1)
    invoices.each { |invoice| expect(invoice['id']).to eq(invoice1.id)}
  end

  it '/customers returns transactions associated with one customer' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice1 = create(:invoice_with_transactions, customer: customer, merchant: merchant)

    get "/api/v1/customers/#{customer.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(5)
  end

end
