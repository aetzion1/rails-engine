class Item < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
	has_many :invoices, through: :invoice_items
	# has_many :transactions, through: :invoices

  validates :merchant_id, presence: true
  validates :name, presence: true
	validates :unit_price, presence: true, numericality: {only_float: true}
	validates :description, presence: true

  scope :sorted, -> { order(id: :asc) }

  def self.most_revenue(limit)
    joins(invoice_items: {invoice: :transactions})
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .where("invoices.status = ? AND transactions.result = ?", 'shipped', 'success')
    .group("items.id")
    .order("revenue DESC")
    .limit(limit || 10)
  end
end
