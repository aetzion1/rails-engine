Rails.application.routes.draw do
# MERCHANTS routes
namespace :api do
  namespace :v1 do
    namespace :revenue do
      get '/merchants', to: 'merchants#index'
      get '/items', to: 'items#index'
    end
    namespace :merchants do
      get '/find', to: 'search#show', as: :find_merchant
      get '/most_items', to: 'most_items#index'
    end
    resources :merchants, only: [:index, :show] do
      get '/items', to: 'merchants/items#index', as: :find_items
    end
    namespace :items do
      get '/find_all', to: 'search#index'
    end
    resources :items, only: [:index, :show, :create, :new, :update, :destroy] do
      get '/merchant', to: 'items/merchants#show'
    end
    resources :revenue, only: [:index]
  end
end

end
