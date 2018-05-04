require 'rails_helper'

describe 'Customers API index' do
  it 'sends a list of all customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end

  it 'can show one customer by its id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer['id']).to eq(id)
  end

  it 'can find a customer by first name' do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=Hot"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['first_name']).to eq(customer[:first_name])
    expect(result['id']).to eq(customer[:id])
  end

  it 'can find a customer by upcased first name' do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=HOT"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['first_name']).to eq(customer[:first_name])
    expect(result['id']).to eq(customer[:id])
  end

  it 'can find a customer by last name' do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=Buns"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['first_name']).to eq(customer[:first_name])
    expect(result['id']).to eq(customer[:id])
  end

  it 'can find a customer by odd caps last name' do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=bUNs"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['first_name']).to eq(customer[:first_name])
    expect(result['id']).to eq(customer[:id])
  end

  it 'can find a customer by id' do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['first_name']).to eq(customer[:first_name])
    expect(search_result['id']).to eq(customer[:id])
  end

  it 'can find a customer by created_at' do
    customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['first_name']).to eq(customer[:first_name])
    expect(search_result['id']).to eq(customer[:id])
  end

  it 'can find all customers by created_at' do
    customer1 = create(:customer, created_at: Date.new(2011, 2, 3))
    customer2 = create(:customer, created_at: Date.new(2011, 2, 3))
    customer3 = create(:customer, created_at: Date.new(2014, 5, 8))

    get "/api/v1/customers/find_all?created_at=#{customer1.created_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end

  it 'can find a customer by updated_at' do
    customer = create(:customer)

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['first_name']).to eq(customer[:first_name])
    expect(search_result['id']).to eq(customer[:id])
  end

  it 'can find all customers by updated_at' do
    customer1 = create(:customer, updated_at: Date.new(2011, 2, 3))
    customer2 = create(:customer, updated_at: Date.new(2011, 2, 3))
    customer3 = create(:customer, updated_at: Date.new(2014, 5, 8))

    get "/api/v1/customers/find_all?updated_at=#{customer1.updated_at}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end

  it 'can return a random customer' do
    create_list(:customer, 3)

    get '/api/v1/customers/random'

    result = JSON.parse(response.body)

    expect(result['first_name'].is_a?(String))
  end
end
