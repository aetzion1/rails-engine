Rails.application.routes.draw do
# MERCHANTS routes
namespace :api do
  namespace :v1 do
    resources :merchants, only: [:index, :show] do
      resources :items, only: [:index]
    end
    resources :items, only: [:index, :show, :create, :new, :update, :destroy]
  end
end

end
