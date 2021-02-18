Rails.application.routes.draw do
# MERCHANTS routes
namespace :api do
  namespace :v1 do
    namespace :merchants do
      get '/find', to: 'search#show', as: :find_merchant
    end
    resources :merchants, only: [:index, :show] do
      get '/items', to: 'merchants/items#index'
    end
    resources :items, only: [:index, :show, :create, :new, :update, :destroy] do
      get '/merchant', to: 'items/merchants#show'
    end
    # namespace :items do
    #   get '/find', to: 'search#index'
    # end

  end
end

end
