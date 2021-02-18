class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]

    @merchants = Merchant.most_revenue(revenue_params[:quantity])
    render json: RevenueSerializer.new(@merchants)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
