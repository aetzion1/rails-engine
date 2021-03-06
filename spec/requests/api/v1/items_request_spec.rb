require 'rails_helper'

describe 'Items API' do
  describe 'index happy paths' do
    it 'sends a list of all items' do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)
      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
    end

    it 'responds with all items if per_page is very large' do
      create_list(:item, 30)

      get '/api/v1/items', params: { per_page: 250_000, page: 1 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(30)
      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
    end


    it 'responds with paginated results and page 1 gets first 20' do
      create_list(:item, 30)

      get '/api/v1/items', params: { per_page: 10, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(10)

      get '/api/v1/items', params: { page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(20)
      expect(items[:data].first[:id].to_i).to eq(Item.first.id)
      expect(items[:data].last[:id].to_i).to eq(Item.all[19].id)
    end

    it 'can respond with page 2 of 20 results' do
      create_list(:item, 51)

      get '/api/v1/items', params: { page: 2 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(20)
    end

    it 'can respond with first page of 50 results' do
      create_list(:item, 51)

      get '/api/v1/items', params: { per_page: 50, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(50)
    end

    it 'can respond with first page of 0 results' do
      create_list(:item, 51)

      get '/api/v1/items', params: { per_page: 0, page: 1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(0)
    end
  end

  describe 'index sad paths' do
    it 'can respond with page 1 if page is 0' do
      create_list(:item, 51)

      get '/api/v1/items', params: { page: -1 }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].size).to eq(20)
      expect(items[:data].first[:id].to_i).to eq(Item.first.id)
      expect(items[:data].last[:id].to_i).to eq(Item.all[19].id)
    end
  end

  describe 'show happy path' do
    it 'can return a specific item' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key :data
      expect(item).to be_a Hash

      expect(item[:data]).to have_key :type
      expect(item[:data][:type]).to be_a String

      expect(item[:data]).to have_key :id
      expect(item[:data][:id]).to be_a String

      expect(item[:data]).to have_key :attributes
      expect(item[:data][:attributes]).to be_a Hash

      expect(item[:data][:attributes]).to have_key :name
      expect(item[:data][:attributes][:name]).to be_a String
    end
  end

  describe 'show sad path' do
    xit 'returns 404 if bad integer provided' do
      get '/api/v1/items/100013'

      expect(response).to_not be_successful
    end

    xit 'returns 404 if string id provided' do
      get '/api/v1/items/ashkjf'

      expect(response).to_not be_successful
    end
  end

  describe 'create happy path' do
    it 'allows you to create and delete an item' do 
      create_list(:item, 3)
      merchant = create(:merchant)
      item_params = {name: "Floss",
        description: "blahhdy blah",
        unit_price: 10.00,
        merchant_id: merchant.id}

      headers = {'CONTENT_TYPE' => 'application/json'}

			post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(Item.count).to eq(4)

      new_item = Item.last

      expect(response).to be_successful

      delete "/api/v1/items/#{new_item.id}"

      expect(Item.count).to eq(3)
    end
  end

  describe 'update happy path' do
    it 'allows you to update an item' do 
      merchant = create(:merchant)
      old_item = create(:item, name: "name1", merchant_id: merchant.id)
      
      item_params = {name: "New Name",
        description: "newdescriptive words",
        unit_price: 100.01,
        merchant_id: old_item.merchant_id}
      
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{old_item.id}", headers: headers, params: JSON.generate(item: item_params)

      item = Item.find_by(id: old_item.id)
      expect(response).to be_successful
      expect(item.name).to_not eq(old_item.name)
      expect(item.name).to eq(item_params[:name])
    end

    it 'allows you to update partial data' do
      old_item = create(:item)
      item_params = {name: "New Name"}
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{old_item.id}", headers: headers, params: JSON.generate(item: item_params)

      item = Item.find_by(id: old_item.id)
      expect(response).to be_successful

      expect(item.name).to_not eq(old_item.name)
      expect(item.name).to eq(item_params[:name])

      expect(item.description).to eq(old_item.description)
      expect(item.unit_price).to eq(old_item.unit_price)
      expect(item.merchant_id).to eq(old_item.merchant_id)
    end
  end

  describe 'update sad path' do
    it "can't update if the merchant_id is bad" do
      merchant = create(:merchant)
      old_item = create(:item, name: "name1", merchant_id: merchant.id)
      
      item_params = {name: "New Name",
        description: "newdescriptive words",
        unit_price: 100.01,
        merchant_id: 435356734}
      
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{item_params[:merchant_id]}", headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
    end
  end
end