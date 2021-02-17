Rails.application.routes.draw do
# MERCHANTS routes
namespace :api do
  namespace :v1 do
    resources :merchants, only: [:index]
    resources :merchants, :show do
      # resources :items, only: [:index]
      get '/items', to: 'merchants/items#index'
    end
    resources :items, only: [:index, :show, :create, :new, :update, :destroy]
  end
end

end
