Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/items', to: 'merchant_items#index'
        get ':id/invoices', to: 'merchant_invoices#index'
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
