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
      end
      namespace :transactions do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      namespace :invoices do
        get ':id/transactions', to: 'transactions#index'
        get ':id/invoice_items', to: 'invoice_items#index'
        get ':id/items', to: 'items#index'
        get ':id/customer', to: 'customers#show'
        get ':id/merchant', to: 'merchants#show'
      end
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end

end
