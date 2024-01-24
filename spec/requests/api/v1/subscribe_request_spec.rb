require 'rails_helper'

describe "subscription API" do
  it 'creates a subscription for a customer' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    headers = {"CONTENT_TYPE" => "application/json"}

    subscription = Subscription.create!(customer_id: customer.id, title: '2 teas', price: '$10', status: )

    post 'api/v1/subscriptions', headers: headers
  end
end