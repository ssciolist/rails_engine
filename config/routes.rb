Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/items', to: 'items#index'
        get ':id/invoices', to: 'invoices#index'
        get 'most_items', to: 'most_items#index'
        get ':id/customers_with_pending_invoices', to: 'customers#index'
        get ':id/favorite_customer', to: 'customers#show'
      end
      namespace :transactions do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end

end
