EOPES::Application.routes.draw do
  resources :user_skills, :only => [:index,:create]

  get 'market_explorer/index'
  get 'market_explorer/market_groups'
  get 'market_explorer/set_location'
  get 'market_explorer/set_current_location'
  get 'market_explorer/get_market'

  resources :estimates do
    collection do
      get "select"
      post "select_new"
      get "set_location"
      get "set_material"
      get "set_result"
      get "set_sell_market_list"
    end

    member do
      get "set_location"
      get "set_material"
      get "set_result"
      get "set_sell_market_list"
    end
  end

  get 'crest_debugs', to:"crest_debugs#index"
  get 'crest_debugs/get_crest'

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
  get "home/index"
  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get "home", to: "home#index", as: "user_root"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
