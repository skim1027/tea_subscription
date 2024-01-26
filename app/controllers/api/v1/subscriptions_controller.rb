class Api::V1::SubscriptionsController < ApplicationController
  def create
    new_subscription = Subscription.new(subscription_params)
    if new_subscription.save
      render json: SubscriptionSerializer.new(new_subscription), status: :ok
    else

    end
  end

  def update
    require 'pry'; binding.pry
  end
  private
  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :status, :customer_id, :tea_id)
  end
end