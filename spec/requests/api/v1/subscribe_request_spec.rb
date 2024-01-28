require 'rails_helper'

describe "subscription API" do
  it 'creates a subscription for a customer' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    
    subscription_request = {
      title: 'Green Tea 1 per week', 
      price: '$ 10',
      frequency: '1 per week',
      status: 1,
      tea_id: tea1.id,
      customer_id: customer.id
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post '/api/v1/subscriptions', headers: headers, params: subscription_request.to_json

    expect(response.status).to eq(201)

    subscription = JSON.parse(response.body, symbolize_names: true)  

    expect(subscription).to have_key(:data)

    expect(subscription[:data]).to have_key(:id)
    expect(subscription[:data]).to have_key(:type)
    expect(subscription[:data]).to have_key(:attributes)

    expect(subscription[:data][:attributes]).to have_key(:title)
    expect(subscription[:data][:attributes]).to have_key(:price)
    expect(subscription[:data][:attributes]).to have_key(:status)
    expect(subscription[:data][:attributes]).to have_key(:frequency)
    expect(subscription[:data][:attributes]).to have_key(:customer_id)
    expect(subscription[:data][:attributes]).to have_key(:tea_id)
  end

  it 'does not create subscription with missing information' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    
    subscription_request = {
      title: 'Green Tea 1 per week', 
      price: '$ 10',
      frequency: '1 per week',
      status: 1,
      customer_id: customer.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}
    post '/api/v1/subscriptions', headers: headers, params: subscription_request.to_json

    expect(response.status).to eq(400)

    subscription = JSON.parse(response.body, symbolize_names: true)  

    expect(subscription[:errors].first[:status]).to eq('400')
    expect(subscription[:errors].first[:title]).to eq('Please input all the information to create a subscription')
  end

  it 'updates a subscription for a customer' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    subscription = Subscription.create!(title: 'Green Tea 1 per week', price: '$ 10', frequency: '1 per week', status: 1, tea_id: tea1.id, customer_id: customer.id)

    subscription_params = { status: 0 }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: subscription_params.to_json
    updated_subscription = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq(200)
    expect(updated_subscription[:attributes][:status]).to eq('cancelled')
  end

  it 'only updates status for the subscription' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    subscription = Subscription.create!(title: 'Green Tea 1 per week', price: '$ 10', frequency: '1 per week', status: 1, tea_id: tea1.id, customer_id: customer.id)

    subscription_params = { title: 'Black Tea 1 per month' }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: subscription_params.to_json

    expect(response.status).to eq(422)

    subscription = JSON.parse(response.body, symbolize_names: true)  

    expect(subscription[:errors].first[:status]).to eq('422')
    expect(subscription[:errors].first[:title]).to eq('Only status can be updated')
  end

  it 'shows you all the subscriptions active and cancelled' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    tea2 = Tea.create!(title: 'Green Tea', description: 'Green Tea', temperature: 160, brew_time: '3 minutes')
    subscription1 = Subscription.create!(title: 'Green Tea 1 per week', price: '$ 10', frequency: '1 per week', status: 1, tea_id: tea1.id, customer_id: customer.id)
    subscription2 = Subscription.create!(title: 'Green Tea 1 per week', price: '$ 10', frequency: '1 per week', status: 0, tea_id: tea2.id, customer_id: customer.id)

    get '/api/v1/subscriptions'

    expect(response).to be_successful

    subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(subscriptions.count).to eq(2)

    expect(subscriptions[0][:attributes][:status]).to eq('active')
    expect(subscriptions[1][:attributes][:status]).to eq('cancelled')
  end
end