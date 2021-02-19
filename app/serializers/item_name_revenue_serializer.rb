class ItemNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id
  attribute :revenue do |object|
        object.revenue = (object.revenue.to_f).to_f
      end
end
