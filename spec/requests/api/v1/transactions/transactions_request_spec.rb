require 'rails_helper'

describe 'Transactions API index' do
  it 'sends a list of all transactions' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(5)
  end

  it 'can show one transaction by its id' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)
    transaction = invoice.transactions.first

    get "/api/v1/transactions/#{transaction.id}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(transaction.id)
  end

  it 'can find a transaction by invoice_id' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)
    transaction = invoice.transactions.first

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(transaction[:name])
    expect(result['id']).to eq(transaction[:id])
  end

  it 'can find a transaction by credit_card_number' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)
    transaction = invoice.transactions.first

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(transaction[:name])
    expect(result['id']).to eq(transaction[:id])
  end

  it 'can find a transaction by result' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)
    transaction = invoice.transactions.first

    get "/api/v1/transactions/find?result=#{transaction.result}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(transaction[:name])
    expect(result['id']).to eq(transaction[:id])
  end

  it 'can find a transaction by created_at' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)
    transaction = invoice.transactions.first

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(transaction[:name])
    expect(result['id']).to eq(transaction[:id])
  end

  it 'can find a transaction by updated_at' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)
    transaction = invoice.transactions.first

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['name']).to eq(transaction[:name])
    expect(result['id']).to eq(transaction[:id])
  end
end
