class Invoice < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
  belongs_to :customer, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  enum status: [:unshipped, :shipped]

  scope :date_between, -> (start_date, end_date) {
		where("invoices.updated_at >= ? AND invoices.updated_at <= ?", start_date, end_date)
  }
end
