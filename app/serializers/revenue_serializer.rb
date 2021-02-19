class RevenueSerializer
  def self.get_revenue(revenue)
    { data: { id: nil, type: 'revenue', attributes: { revenue: revenue } } }
  end
end
