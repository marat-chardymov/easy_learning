EasyLearning::Application.routes.draw do

  mount RailsAdmin::Engine => 'administration', :as => 'rails_admin'
  
  get "home/index"

  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }
 
  root "home#index"

  get "files_sharing" => "files_sharing#index"
  get "files_sharing/omniauth_callback" => "files_sharing#omniauth_callback"
  post "files_sharing/upload" => "files_sharing#upload"

  resources :home do
    collection do
      get 'contact'
      get 'about'
      get 'services'
      get 'portfolio'
    end
  end
  
  resources :tests
  resources :events
   
  namespace :user do
    resources :home
    resource :settings, :only => [:show, :update]
    resource :schedule, :only => [:show]
  end
  
  namespace :user, path: "", only: [] do
    namespace :admin do
      root "home#index"
      resources :home
      resource :settings, :only => [:show, :update]
      resource :schedule, :only => [:show]
    end

    namespace :lecturer do
      root "home#index"
      resources :home
      resource :settings, :only => [:show, :update]
      resource :schedule, :only => [:show]
    end

    namespace :student do
      root "home#index"
      resources :home
      resource :settings, :only => [:show, :update]
      resource :schedule, :only => [:show]
    end
  end

  get '/test/edit/getTest' => 'tests#getTest'
  post '/test/edit/question/add' => 'tests#addQuestion'



  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
