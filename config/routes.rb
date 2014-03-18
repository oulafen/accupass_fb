AccupassFb::Application.routes.draw do
  root 'users#login'

  get "/register" =>'users#register'
  get "/welcome" =>'users#welcome'
  get "/manager_index" =>'users#manager_index'
  get "/add_user" =>'users#add_user'
  get '/create_login_session'=>'users#manager_index'
  get '/change_password' => 'users#change_password'
  get '/forgot_1' => 'users#forgot_1'
  get '/forgot_2' => 'users#forgot_2'
  get '/forgot_3' => 'users#forgot_3'



  post "/register" =>'users#create'
  post "/add_user" =>'users#save_user'
  post '/create_login_session' => 'users#create_login_session'
  post '/update_password' => 'users#update_password'
  post '/judge_q_and_a' => 'users#judge_q_and_a'
  post '/update_reset_password' => 'users#update_reset_password'
  post '/forgot_pw_1' => 'users#forgot_pw_1'
  post '/process_phone_login' => 'users#process_phone_login'

  delete  '/del_user'=> 'users#del_user'


  #resources :users, only: [:create]
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
