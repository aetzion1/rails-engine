Rails.application.routes.draw do
namespace :api do
  namespace :v1 do

    namespace :revenue do
      get '/', to: 'revenue#between_dates', as: :revenue_between_dates
      get '/merchants', to: 'revenue#merchants', as: :merchants_revenue
      get '/merchants/:id', to: 'revenue#merchant', as: :merchant_revenue
    end

    namespace :merchants do
      get '/find', to: 'search#find_one', as: :findone
      get '/most_items', to: 'bizint#most_items', as: :bizint_most_items
      get '/:id/items', to: 'items#index', as: :items
    end

    
    namespace :items do
      get '/find_all', to: 'search#index'
    end

    resources :merchants, only: [:index, :show]

    resources :items, only: [:index, :show, :create, :new, :update, :destroy] do
      get '/merchant', to: 'items/merchants#show'
    end
    # resources :revenue, only: [:index]
  end
end

end
