class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    require 'pry'; binding.pry
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
