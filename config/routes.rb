Rails.application.routes.draw do

  resources :transactions, only: [:new, :create]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                        :registrations => "registrations" }

  post '/rate' => 'rater#create', :as => 'rate'

  get 'search', to: 'search#search'

  root "welcome#home"

  resources :users, only: [:show]

  resources :reviews

  resources :events


  resources :requests do
    get 'confirm', on: :member
    get 'decline', on: :member
  end

  get '/myeventsandrequests' => "users#myeventsandrequests", :as => "myeventsandrequests"



  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end


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
