Leelol::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }

  resources :users do
    resources :tokens, only: [:create, :destroy]
  end

  resources :items do
    get '/retrieve_items', on: :collection, to: 'items#retrieve_items', as: :retrieve
  end

  resources :champions do
    get '/retrieve_data', on: :collection, to: 'champions#retrieve_data', as: :retrieve_data
  end

  namespace :api do
    namespace :v1 do
      match '/ping' => 'base#ping'           
      resources :champions, only: [:index, :show]
      resources :items, only: [:index, :show]
      match 'v:api/*path', to: redirect('/api/v1/%{path}')
      match '*path', to: redirect('/api/v1/%{path}')
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'champions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
