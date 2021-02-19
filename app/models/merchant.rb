class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  # scope :sorted, -> { order(id: :asc) }

  private

  def self.most_revenue(limit)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .where("invoices.status = ? AND transactions.result = ?", 'shipped', 'success')
    .group("merchants.id")
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_items(limit)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity) AS count")
    .where("invoices.status = ? AND transactions.result = ?", 'shipped', 'success')
    .group("merchants.id")
    .order("count DESC")
    .limit(limit)
  end

  def self.revenue_by_date(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
    .where("invoices.status = ? AND transactions.result = ?", 'shipped', 'success')
    .merge(Invoice.date_between(start_date, end_date))
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end
