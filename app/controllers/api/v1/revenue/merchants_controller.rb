class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.sort_by_revenue(params[:quantity])
    # require 'pry'; binding.pry
    render json: RevenueSerializer.new(@merchants)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
