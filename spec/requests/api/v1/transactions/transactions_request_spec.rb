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

  it 'can find all transaction by credit_card_number' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, credit_card_number: 123, invoice_id: invoice.id)
    transaction2 = create(:transaction, credit_card_number: 123, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?credit_card_number=123"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
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

  it 'can find all transactions by result' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice_with_transactions, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/transactions/find_all?result=success"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(5)
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

  it 'can find all Transactions by created_at' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, created_at: Date.today, invoice_id: invoice.id)
    transaction2 = create(:transaction, created_at: Date.today, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?created_at=#{transaction.created_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
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

  it 'can find all Transactions by updated_at' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, updated_at: Date.today, invoice_id: invoice.id)
    transaction2 = create(:transaction, updated_at: Date.today, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?updated_at=#{transaction.updated_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end
end
