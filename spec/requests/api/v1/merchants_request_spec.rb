require 'rails_helper'

describe 'Merchants API' do
  describe 'index happy paths' do
    it 'sends a list of all merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(3)
      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'responds with paginated results and page 1 gets first 20' do
      create_list(:merchant, 30)

      get '/api/v1/merchants', params: { per_page: 10, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].size).to eq(10)

      get '/api/v1/merchants', params: { page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].size).to eq(20)
      expect(merchants[:data].first[:id].to_i).to eq(Merchant.first.id)
      expect(merchants[:data].last[:id].to_i).to eq(Merchant.all[19].id)
    end

    it 'can respond with page 2 of 20 results' do
      create_list(:merchant, 51)

      get '/api/v1/merchants', params: { page: 2 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].size).to eq(20)
    end

    it 'can respond with first page of 50 results' do
      create_list(:merchant, 51)

      get '/api/v1/merchants', params: { per_page: 50, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].size).to eq(50)
    end

    it 'can respond with first page of 0 results' do
      create_list(:merchant, 51)

      get '/api/v1/merchants', params: { per_page: 0, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].size).to eq(0)
    end
  end

  describe 'index sad paths' do
    it 'can respond with page 1 if page is 0' do
      create_list(:merchant, 51)

      get '/api/v1/merchants', params: { page: -1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].size).to eq(20)
      expect(merchants[:data].first[:id].to_i).to eq(Merchant.first.id)
      expect(merchants[:data].last[:id].to_i).to eq(Merchant.all[19].id)
    end
  end

  describe 'show happy path' do
    it 'can return a specific merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

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

  describe 'show sad path' do
    xit 'returns 404 if bad integer provided' do
      get '/api/v1/merchants/100013'

      expect(response).to_not be_successful
    end

    xit 'returns 404 if string id provided' do
      get '/api/v1/merchants/ashkjf'

      expect(response).to_not be_successful
    end
  end
end
