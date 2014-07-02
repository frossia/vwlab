Rails.application.routes.draw do

  # get 'receptions/create'

  get 'pages/index'

  get 'pages/show'

  get 'items/add_to_favorites'
  get 'items/remove_from_favorites'
  get 'items/clear_favorites'
  get 'items/remove_image'
  resources :item_attachments

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  namespace :admin do
    resources :items do
      collection do
        get :add_all_generations
      end
    end

    resources :catalogs do
      collection do
        get :manage
        post :rebuild
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'test/index'
  # You can have the root of your site routed with "root"
  root 'catalogs#index'
  resources :receptions
  resources :items
  resources :pages
  resources :catalogs do
    collection do
      resources :autos
    end
    resources :autos
  end

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
