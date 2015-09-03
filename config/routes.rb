Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)
  
  # https://github.com/plataformatec/devise/wiki/How-To%3a-redirect-to-a-specific-page-on-successful-sign-in
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }

  
  root 'home#show'
  
  scope "/do" do 
  
    resources :posts, :pins
    
    resources :brands do
      resources :establishments, shallow: true
    end
    
    resources :itineraries, only: [:show, :create, :destroy] do
      resources :build, only: [:show, :update], controller: 'itinerary/build'
      resources :stops
    end
    
    resource :map, :only => [:none] do
      member do
        get 'static'
        get 'selectable'
        get 'itinerary/:itinerary_id', :to => 'maps#itinerary', as: 'itinerary'
        get 'geolocalised'
        get 'near(/:latitude/:longitude)', to: 'maps#near', as: 'near', constraints: { latitude: /-?[0-9]+[0-9\.]*/, longitude: /-?[0-9]+[0-9\.]*/}
      end
    end
    
     get 'likes/:voteable/:id',          :to => "users#likes", as: 'user_likes'
     
     resource :user, :except => [:show] do
       member do
         get 'liked/:voteable/:id',     :to => "users#liked",    as: 'liked'
         get 'unliked/:voteable/:id',   :to => "users#unliked",  as: 'unliked'
         get 'brands'
         get 'posts'
         get 'itineraries'
       end
     end
     
     resource :editor, :only => [:none]  do
       resources 'itineraries', :except => [:new, :create], controller: 'editors/itineraries' do
         member do
         patch ':review', action: "update", constraints: { review: /(accept|reject|review)/}, as: 'review'
       end
       end
     end
     
     resources :users, :only => [:index] do
       member do
         get 'brands'
         get 'posts'
         get 'itineraries'
         get 'users'
         get 'followers'
         get 'following'
       end
     end
  
  end
  
  get ':username',        :to => "users#show" , constraints: { username: /[A-Za-z]+[A-Za-z0-9\.]*/ }, as: "profile"
 
 
  
  

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
