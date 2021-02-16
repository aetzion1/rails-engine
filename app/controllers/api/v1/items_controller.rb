class Api::V1::ItemsController < ApplicationController
  def index
    if params[:id].nil?
      @items = Item.all
    else
      @items = Item.find_by(merchant_id: params[:id])
    end
    render json: ItemSerializer.new(@items)
  end

  def show
    @item = Item.find(params[:id])
    ItemSerializer.new(@item)

    # options[:include] = [:stores, :'stores.name']
    # serializable_hash = BookSerializer.new([@book], options).serializable_hash
    # require 'pry'; binding.pry
  end

  # def create
  #   render json: Book.create(book_params)
  # end

  # def update
  #   render json: Book.update(params[:id], book_params)
  # end

  # def destroy
  #   render json: Book.delete(params[:id])
  # end

  private
    def item_params
      params.require(:item).permit(
                                    :name,
                                    :description,
                                    :unit_price
                                  )
    end
end
