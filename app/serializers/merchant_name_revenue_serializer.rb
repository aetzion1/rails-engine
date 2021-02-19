class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :revenue do |object|
    object.revenue = object.revenue.to_f.to_f
  end
end
