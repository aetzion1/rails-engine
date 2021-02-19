require 'rails_helper'

describe 'Item Merchant API' do
  describe 'index happy paths' do
    it 'sends a list merchant for an item' do
      merchant = create(:merchant_with_items)
      item1 = merchant.items.first

      get "/api/v1/items/#{item1.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a Hash
      expect(merchant[:data]).to be_an Hash

      expect(merchant[:data].size).to eq(3)
    end
  end

  describe 'index sad path' do
    xit 'returns 404 if bad integer provided' do
      get "/api/v1/items/78453/merchant"

      expect(response).to_not be_successful
    end

    xit 'returns 404 if string id provided' do
      get "/api/v1/items/hsdksaf/merchant"

      expect(response).to_not be_successful
    end
  end

end
