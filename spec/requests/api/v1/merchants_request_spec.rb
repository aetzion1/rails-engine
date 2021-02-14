require 'rails_helper'

describe "Merchants API" do
  describe "index" do
    it "sends a list of all merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful
      
      merchants = JSON.parse(response.body, symbolize_names: true)

      # WHY DO I NOW NEED TO DO MERCHANTS[:DATA]? DID NOT BEFORE IMPLEMENTING FAST JSON
      expect(merchants[:data].count).to eq(3)
      require 'pry'; binding.pry
      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
      end
    end

    xit "responds with paginated results" do
      create_list(:merchant, 20)

      get '/api/v1/merchants', params: { per_page: 10, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      merchants = JSON.parse(response.body, symbolize_names: true)
      
      # expect(merchants.count).to eq(10)
      expect(merchants['data'].size).to eq(10)

      # expect(merchants['links']['first'])).to eq('http://www.example.com/api/v1/merchants?per_page=10&page=1')
      # expect(merchants['links']['last'])).to eq('http://www.example.com/api/v1/merchants?per_page=10&page=2')
      # expect(merchants['links']['prev'])).to eq('http://www.example.com/api/v1/merchants?per_page=10&page=1')
      # expect(merchants['links']['next'])).to eq('http://www.example.com/api/v1/merchants?per_page=10&page=2')
    end
  end
end