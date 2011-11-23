NsgThesis::Application.routes.draw do
  scope "(:locale)", :locale => /en|fi/ do
    match "/auth/:provider/callback" => "sessions#create"
    match "/signin" => "sessions#signin", :as => :signin
    match "/signout" => "sessions#destroy", :as => :signout
    match "/myevents" => "events#my_events", :as => :myevents
  
  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :events do
    resources :comments
    resources :galleries
    resources :hotels
    get 'unapproved', :on => :collection
    get 'approve', :on => :member
    get 'feed', :on => :collection
    get 'recent', :on => :collection
    get 'most_watched', :on => :collection
    get 'nearby', :on => :collection
    get 'upcoming', :on => :collection
    get 'like', :on => :member
  end

  resources :tags
  resources :categories
  resources :search do
    get 'advanced', :on => :collection
  end

  resources :ads do
    get 'unconfirmed', :on => :collection
    get 'confirm', :on => :member
    get 'my', :on => :collection
  end
  
  resources :clients do
    get 'unconfirmed', :on => :collection
    get 'confirm', :on => :member
  end

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
    root :to => 'home#index'
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
