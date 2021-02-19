class InvoiceItem < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :invoice, dependent: :destroy

  validates :unit_price, presence: true
  validates :quantity, presence: true

  # def self.revenue
  #   joins(invoices: :transactions)
  #   .where("invoices.status = ? AND transactions.result = ?", 'shipped', 'success')
  #   .sum('invoice_items.quantity * invoice_items.unit_price')
  # end
end
