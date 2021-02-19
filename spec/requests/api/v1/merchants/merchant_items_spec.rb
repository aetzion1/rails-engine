require 'rails_helper'

describe 'Merchant Items API' do
  describe 'index happy paths' do
    it 'sends a list of all items for a merchant' do
      merchant = create(:merchant_with_items)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items[:data]).to be_an Array

      expect(items[:data].size).to eq(5)
    end
  end

  describe 'index sad path' do
    xit 'returns 404 if bad integer provided' do
      get '/api/v1/merchants/100013/items'

      expect(response).to_not be_successful
    end

    xit 'returns 404 if string id provided' do
      get '/api/v1/merchants/ashkjf/items'

      expect(response).to_not be_successful
    end
  end

end
