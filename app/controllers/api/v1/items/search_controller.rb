class Api::V1::Items::SearchController < ApplicationController
  def index
    @items = if item_params[:name].blank?
               nil
             else
               Item.where('LOWER(name) LIKE ?', "%#{item_params[:name].downcase}%")
             end
    # ternary operator
    render json: (@items ? ItemSerializer.new(@items) : { data: [] })
  end

  private

  def item_params
    params.permit(
      :name,
      :description,
      :unit_price,
      :merchant_id
    )
  end
end
