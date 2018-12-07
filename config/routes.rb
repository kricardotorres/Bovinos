Rails.application.routes.draw do
  resources :carnets
  resources :nutritional_controls
  resources :aliments
       # Serve websocket cable requests in-process
   mount ActionCable.server => '/cable' 
  get 'rooms/show'

  resources :cow_histories
  resources :arduino_devices do 
    get "get_report"
    get "get_last_moves_x"
    get "get_last_moves_y"
    get "get_last_moves_z"
    match 'search' => 'arduino_devices#search', via: [:get, :post], as: :search
    get "get_last_moves"
     
  end
  resources :farms
  resources :cows do
      get "delete"
      collection do
      get 'filter'
    end
  end
  resources :veterinaries do
      get "delete"
      collection do
      get 'filter'
    end
  end
  resources :roles
   devise_for :users
   get 'welcome/index'
  namespace :admin do
    resources :users do
      get "delete"
      collection do
      get 'filter'
    end
    end
  end	
  root 'welcome#index'

  namespace :api do 
    resources :cow_histories
  end
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
