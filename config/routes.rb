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
        get ':id/revenue', to: 'revenue#show'
        get 'revenue', to: 'revenue#index'
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get ':id/customers_with_pending_invoices', to: 'customers#index'
        get ':id/favorite_customer', to: 'customers#show'
      end
      namespace :transactions do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      namespace :invoices do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/transactions', to: 'transactions#index'
        get ':id/invoice_items', to: 'invoice_items#index'
        get ':id/items', to: 'items#index'
        get ':id/customer', to: 'customer#show'
        get ':id/merchant', to: 'merchant#show'
      end

      namespace :items do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'most_revenue', to: 'revenue#index'
        get 'most_items', to: 'most_items#index'
      end
      namespace :invoice_items do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      namespace :customers do
        get ':id/favorite_merchant', to: 'merchants#show'
      end

      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end

end
