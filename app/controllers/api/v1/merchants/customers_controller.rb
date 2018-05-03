class Api::V1::Merchants::CustomersController < ApplicationController
  def index

  end

  def show
    favorite = Customer.joins(invoices: :transactions)
                          .where(transactions: {result: "success"}, invoices: {merchant_id: params[:id]})
                          .order('count_id desc')
                          .group(:id)
                          .count(:id)
                          .first
    render json: Customer.find(favorite[0])
  end
end
