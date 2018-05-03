class Api::V1::Merchants::CustomersController < ApplicationController
  def index

  end

  def show
    render json: Customer.favorite_customer(params[:id])
  end
end
