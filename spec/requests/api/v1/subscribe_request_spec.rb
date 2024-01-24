require 'rails_helper'

describe "subscription API" do
  it 'creates a subscription for a customer' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    tea2 = Tea.create!(title: 'Green Tea', description: 'Gentle Tea', temperature: 160, brew_time: '3 minutes')
    subscription = Subscription.create!(customer_id: customer.id, title: '1 tea', price: '$10', status: 1, frequency: 'Every week')
    
    subscription_request = {
      customer: customer,
      subscription: subscription,
      tea: tea1
    }

    headers = {"CONTENT_TYPE" => "application/json"}
    post '/api/v1/subscription_teas', headers: headers, params: subscription_request.to_json

    expect(response.status).to eq(200)
  end
end