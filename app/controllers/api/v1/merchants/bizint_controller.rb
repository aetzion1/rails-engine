class Api::V1::Merchants::BizintController < ApplicationController
  def most_items
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]

    @merchants = Merchant.most_items(most_items_params[:quantity])
    render json: ItemsSoldSerializer.new(@merchants)
  end

  private

  def most_items_params
    params.permit(:quantity)
  end
end
