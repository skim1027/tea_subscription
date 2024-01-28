class Api::V1::SubscriptionsController < ApplicationController
  def index
    render json: SubscriptionSerializer.new(Subscription.all)
    require 'pry'; binding.pry
  end
  
  def create
    new_subscription = Subscription.new(subscription_params)
    if new_subscription.save
      render json: SubscriptionSerializer.new(new_subscription), status: :created
    else
      render json: { errors: [title: 'Please input all the information to create a subscription', status: "400"]}, status: :bad_request
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    if params.key?(:status)
      subscription.update(update_subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else
      render json: { errors: [title: 'Only status can be updated', status: "422"] }, status: :unprocessable_entity
    end
  end

  private
  
  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :status, :customer_id, :tea_id)
  end

  def update_subscription_params
    params.fetch(:subscription).permit(:status)
  end
end