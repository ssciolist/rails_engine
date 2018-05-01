Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/items', to: 'items#index'
      end
      resources :merchants, only: [:index, :show] 
      resources :invoices, only: [:index, :show]
    end
  end

end
