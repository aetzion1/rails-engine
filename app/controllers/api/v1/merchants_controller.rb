class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    merchants = Merchant.page(page).per_page(per_page)
    render json: MerchantSerializer.new(merchants)
  end

  private

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 20
  end
end

# respond_with. merchants, meta: {
#   current_page: merchants.current_page,
#   next_page: merchants.next_page,
#   prev_page: merchants.prev_page,
#   total_pages: merchants.total_pages,
#   total_count: merchants.total_count
# }