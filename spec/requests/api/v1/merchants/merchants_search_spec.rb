require 'rails_helper'

describe 'Merchant Search API' do
  describe 'show happy paths' do
    it 'finds a merchant by fragment' do
      lolly = create(:merchant, name: 'Mr LollyPopz Boutique')

      get '/api/v1/merchants/find', params: { name: 'Lolly' }

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key :data
      expect(merchant).to be_a Hash

      expect(merchant[:data]).to have_key :type
      expect(merchant[:data][:type]).to be_a String

      expect(merchant[:data]).to have_key :id
      expect(merchant[:data][:id]).to be_a String

      expect(merchant[:data]).to have_key :attributes
      expect(merchant[:data][:attributes]).to be_a Hash

      expect(merchant[:data][:attributes]).to have_key :name
      expect(merchant[:data][:attributes][:name]).to be_a String
    end
  end

  describe 'show sad paths' do
    it 'unable to find merchant when no match' do
      lolly = create(:merchant, name: 'Mr LollyPopz Boutique')

      get '/api/v1/merchants/find', params: { name: 'Qr' }

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key :data
      expect(merchant).to be_a Hash

      expect(merchant[:data]).to eq({})
      expect(merchant[:data][:type]).to eq(nil)

      expect(merchant[:data]).to_not have_key :attributes
    end

    it 'unable to find merchant when no fragment provided' do
      lolly = create(:merchant, name: 'Mr LollyPopz Boutique')

      get '/api/v1/merchants/find'

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key :data
      expect(merchant).to be_a Hash

      expect(merchant[:data]).to eq({})
      expect(merchant[:data][:type]).to eq(nil)

      expect(merchant[:data]).to_not have_key :attributes
    end
  end
end
