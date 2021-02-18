class Item < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
  validates :merchant_id, presence: true

  scope :sorted, -> { order(id: :asc) }

  # self.top_items_by_revenue do 
  #   joins(invoice_items: {invoices: :transactions})
  #     .where("invoices.status = 'shipped' AND transactions.result = 'success'")
  #     .group("items.id")
  #     .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
  #     .order("revenue DESC")
  #     .limit(10)
  # end

  # Item.joins(invoice_items: {invoices: :transactions}).where("invoices.status = 'shipped' AND transactions.result = 'success'").group("items.id").select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC").limit(10)

    # find_by_sql(
    #   SELECT items.*, SUM(invoice)items.quanitty * invoice_items.unit_price) AS revenue
    #   FROM items
    #   JOIN invoice_items ON items.id = invoice_items.item_id
    #   JOIN invoices ON invoice_items.invoice_id = invoices.id
    #   JOIN transactions ON transactions.invoice_id = invoices.id
    #   WHERE invoices.status = 'shipped' AND transactions.result = 'success'
    #   GROUP BY items.id
    #   ORDER BY 'revenue' DESC
    #   LIMIT 10
    #   ;
    # )
end
