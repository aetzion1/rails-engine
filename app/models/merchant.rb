class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy


  # scope :sorted, -> { order(id: :asc) }

  def self.sort_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .where("invoices.status = ? AND transactions.result = ?", 'shipped', 'success')
    .group("merchants.id")
    .order("revenue DESC")
    .limit(quantity)
  end
end
