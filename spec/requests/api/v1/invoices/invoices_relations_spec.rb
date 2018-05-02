require 'rails_helper'

describe 'Invoices API relations' do
  it '/transactions returns transactions associated with one invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice_with_transactions, customer: customer, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(5)
    transactions.each { |transaction| expect(transaction['invoice_id']).to eq(invoice.id)}

  end
  it '/invoice_items returns invoice_items associated with one invoice' do
  end
  it '/items returns items associated with one invoice' do
  end
  it '/customer returns the associated customer of an invoice' do
  end
  it '/merchant returns the associated merchant of an invoice' do
  end
end
