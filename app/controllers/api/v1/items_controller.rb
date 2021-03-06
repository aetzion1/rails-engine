class Api::V1::ItemsController < ApplicationController
  def index
    @items = if params.fetch(:per_page, 20).to_i >= 250_000
               Item.all
             else
               Item.limit(per_page).offset(page)
             end
    render json: ItemSerializer.new(@items.sorted)
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
  end

  def create
    @item = Item.create(item_params)
    render json: ItemSerializer.new(@item), status: '201'
  end

  def update
    if params[:merchant_id]
      if Merchant.exists?(id: params[:merchant_id])
        @item = Item.update(params[:id], item_params)
      else
        return render text: 'Merchant Not Found', status: '404'
      end
    elsif Item.exists?(id: params[:id])
      @item = Item.update(params[:id], item_params)
    else
      return render text: 'Merchant Not Found', status: '404'
    end
    render json: ItemSerializer.new(@item)
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :unit_price,
      :merchant_id
    )
  end

  def page
    return 0 if params[:page].nil?

    return 0 if params[:page].to_i <= 0

    # QUESTION: ASK INSTRUCTORS IF ABOVE IS OK. DID NOT WANT TO DEFAULT TO 1.
    (params.fetch(:page).to_i - 1) * 20
  end

  def per_page
    [
      params.fetch(:per_page, 20).to_i,
      100
    ].min
  end
end
