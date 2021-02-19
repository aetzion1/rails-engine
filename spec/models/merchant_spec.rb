require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe 'class methods' do
    before(:each) do
      @nameco = create(:merchant, name: 'THE NAME CO')
      @item1 = create(:item, merchant_id: @nameco.id)
      @invoice1 = create(:invoice, merchant: @nameco, status: 1)
      create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 10, unit_price: 10.00)
      create(:transaction, invoice: @invoice1)
      @merchant2 = create(:merchant_with_items)
      @invoice2 = create(:invoice, merchant: @merchant2, status: 1)
      @invoice3 = create(:invoice, merchant: @merchant2, status: 0)
      @invoice4 = create(:invoice, merchant: @merchant2, status: 1)
      create(:invoice_item, item: @merchant2.items.first, invoice: @invoice2, quantity: 20, unit_price: 10.00)
      create(:invoice_item, item: @merchant2.items.second, invoice: @invoice2, quantity: 1, unit_price: 100.00)
      create(:invoice_item, item: @merchant2.items.third, invoice: @invoice3, quantity: 1, unit_price: 100.00)
      create(:invoice_item, item: @merchant2.items.fourth, invoice: @invoice4, quantity: 1, unit_price: 100.00)
      create(:transaction, invoice: @invoice2)
      create(:transaction, invoice: @invoice3)
      create(:transaction, invoice: @invoice4, result: 'failed')
    end

    it 'most_revenue' do
      merchants = Merchant.most_revenue(2)
      expect(merchants).to be_an ActiveRecord::Relation
    end

    it 'most_items' do
      merchants = Merchant.most_items(2)

      expect(merchants).to be_an ActiveRecord::Relation
    end

    it 'revenue_by_date' do
      start_date = '2012-10-01'
      end_date = '2012-12-01'
      revenue = Merchant.revenue_by_date(start_date, end_date)
      
      expect(revenue).to be_an Numeric
    end
  end
end