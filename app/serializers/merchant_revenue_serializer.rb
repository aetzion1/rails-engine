class MerchantRevenueSerializer
  def self.get_revenue(revenue, params)
    { data: { id: params, type: 'merchant_revenue', attributes: { revenue: revenue } } }
  end
end
