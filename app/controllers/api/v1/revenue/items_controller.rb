class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]

    @items = Item.most_revenue(revenue_params[:quantity])
    render json: ItemNameRevenueSerializer.new(@items)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
