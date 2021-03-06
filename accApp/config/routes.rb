AccApp::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'applications#index'
  
  match "/404", :to => "errors#page_notFound", via: 'get'
  match "/400", :to => "errors#bad_request", via: 'get'
  match "/500", :to => "errors#server_error", via: 'get'
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :applications
  
  get 'admin' => 'admin#index', as: :admin
  get 'removeApp' => 'admin#destroy', as: :adminDestroy
  
  get 'apikeys' => 'apikeys#show', as: :apikey
  
  post 'login' => 'applications#login', as: :login
  get 'logout' => 'applications#logout', as: :logout
  
  post '/userAuth' => 'users#userAuth', as: :userAuth
  
  get 'register' => 'applications#new', as: :register
  get 'documentation' => 'applications#documentation', as: :documentation
  
  get 'search' => 'resources#search', as: :search
  
  resources :users do
    resources :resources
  end
  
  resources :resource_types do
    resources :resources
  end
  
  resources :licences do
    resources :resources
  end
  
  match '(*foo)' => "applications#index", via: :options
  
  resources :tags do
    resources :resources
  end
  
  resources :resources do
    resources :tags
    resource :user
    resource :licence
    resource :resource_type
  end

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
