StarterRubyRails::Application.routes.draw do
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

  # # Home page
  # GET     /                                           controllers.Application.index(ref: Option[String])
  root 'application#index'

  # # Document detail
   get '/document/:id/:slug', to: 'application#document', constraints: {id: /[-_a-zA-Z0-9]{16}/}, as: :document

  # # Basic search
  # GET     /search                                     controllers.Application.search(q: Option[String] ?= None, ref: Option[String] ?= None)

  # # Prismic.io OAuth
  # GET     /signin                                     controllers.Prismic.signin
  # GET     /auth_callback                              controllers.Prismic.callback(code: Option[String], redirect_uri: Option[String])
  # POST    /signout                                    controllers.Prismic.signout()
end
