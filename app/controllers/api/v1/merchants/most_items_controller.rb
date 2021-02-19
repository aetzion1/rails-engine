class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]

    @merchants = Merchant.most_items(params[:quantity])
    render json: ItemsSoldSerializer.new(@merchants)
  end

  private

  def most_items
    params.permit(:quantity)
  end
end
