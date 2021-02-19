class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]
    return render json: { error: 'Specify a quantity' }, status: '400' if params[:quantity].to_i < 0
    return render json: { error: 'Specify a quantity' }, status: '400' if params[:quantity].to_i == 0
    if params[:quantity].to_i > 1000
      params[:quantity] = Item.count
    end
    @items = Item.most_revenue(revenue_params[:quantity])
    render json: ItemNameRevenueSerializer.new(@items)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
