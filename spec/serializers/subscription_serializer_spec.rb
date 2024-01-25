require 'rails_helper'

RSpec.describe SubscriptionSerializer do
  it 'creates data with id, type and attributes with subscription data' do
    customer = Customer.create!(first_name: 'Tom', last_name: 'Riddle', email: 'triddle@email.com', address: '4 Privet Drive, Surrey, England')
    tea1 = Tea.create!(title: 'Earl Grey', description: 'England Tea', temperature: 150, brew_time: '5 minutes')
    subscription_details = {
      title: 'Green Tea 1 per week', 
      price: '$ 10',
      frequency: '1 per week',
      status: 1,
      tea_id: tea1.id,
      customer_id: customer.id
    }
    
    subscription = SubscriptionSerializer.new(Subscription.create(subscription_details)).serializable_hash

    expect(subscription[:data][:attributes]).to have_key(:title)
    expect(subscription[:data][:attributes]).to have_key(:price)
    expect(subscription[:data][:attributes]).to have_key(:frequency)
    expect(subscription[:data][:attributes]).to have_key(:status)
    expect(subscription[:data][:attributes]).to have_key(:tea_id)
    expect(subscription[:data][:attributes]).to have_key(:customer_id)
    
    expect(subscription[:data][:attributes][:title]).to eq('Green Tea 1 per week')
    expect(subscription[:data][:attributes][:price]).to eq('$ 10')
    expect(subscription[:data][:attributes][:frequency]).to eq('1 per week')
    expect(subscription[:data][:attributes][:status]).to eq('active')
    expect(subscription[:data][:attributes][:tea_id]).to eq(tea1.id)
    expect(subscription[:data][:attributes][:customer_id]).to eq(customer.id)
  end
end