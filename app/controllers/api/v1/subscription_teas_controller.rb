class Api::V1::SubscriptionTeasController < ApplicationController
  def create
    require 'pry'; binding.pry

  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end