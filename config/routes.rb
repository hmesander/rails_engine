Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'revenue', to: 'revenue_date#show'
        get ':id/items', to: 'merchant_items#index'
        get ':id/invoices', to: 'merchant_invoices#index'
        get ':id/favorite_customer', to: 'favorite_customer#show'
        get ':id/revenue', to: 'merchant_revenue#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :items do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/invoice_items', to: 'item_invoice_items#index'
        get ':id/merchant', to: 'item_merchant#index'
        get '/most_revenue', to: 'most_revenue#show'
      end
      resources :items, only: [:index, :show]

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoices', to: 'customer_invoices#index'
        get ':id/transactions', to: 'customer_transactions#index'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get 'random', to: 'random#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/transactions', to: 'invoice_transactions#index'
        get ':id/invoice_items', to: 'invoice_invoice_items#index'
        get ':id/items', to: 'invoice_items#index'
        get ':id/customer', to: 'invoice_customer#index'
        get ':id/merchant', to: 'invoice_merchant#index'
      end
      resources :invoices, only: [:index, :show]

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: 'transaction_invoice#index'
      end
      resources :transactions, only: [:index, :show]

      namespace :invoice_items do
        get ':id/invoice', to: 'invoice_item_invoice#show'
        get ':id/item', to: 'invoice_item_item#show'
      end
    end
  end
end
