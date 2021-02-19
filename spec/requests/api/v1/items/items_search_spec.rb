require 'rails_helper'

describe 'Item Search API' do
  describe 'show happy paths' do
    it 'finds all items matching a pattern' do
      catleash = create(:item, name: 'cat leash')
      dogleash = create(:item, name: 'dog leash')
      lizardleash = create(:item, name: 'lizard leash')
      fishfood = create(:item, name: 'fish food')

      get '/api/v1/items/find_all', params: { name: 'leash' }

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key :data
      expect(item).to be_a Hash

      expect(item[:data].size).to eq(3)
    end
  end

  describe 'show sad paths' do
    it 'unable to find item when no match' do
      catleash = create(:item, name: 'cat leash')
      dogleash = create(:item, name: 'dog leash')
      lizardleash = create(:item, name: 'lizard leash')
      fishfood = create(:item, name: 'fish food')

      get '/api/v1/items/find_all', params: { name: 'kqr' }

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key :data
      expect(item).to be_a Hash

      expect(item[:data]).to eq([])
    end

    it 'unable to find item when no fragment provided' do
      catleash = create(:item, name: 'cat leash')
      dogleash = create(:item, name: 'dog leash')
      lizardleash = create(:item, name: 'lizard leash')
      fishfood = create(:item, name: 'fish food')

      get '/api/v1/items/find_all'

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key :data
      expect(item).to be_a Hash

      expect(item[:data]).to eq([])
    end
  end
end
