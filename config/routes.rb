AccupassFb::Application.routes.draw do
  root 'users#login'

#users
  get "/register" =>'users#register'
  get "/user_index" =>'users#user_index'
  get '/create_login_session'=>'users#manager_index'
  get '/bid_list' => 'users#bid_list'
  get '/sign_up_list' => 'users#sign_up_list'
  get '/bid_detail' => 'users#bid_detail'

  post "/register" =>'users#create'
  post '/create_login_session' => 'users#create_login_session'

#admin

  get "/manager_index" =>'admin#manager_index'
  get "/add_user" =>'admin#add_user'
  get '/change_password' => 'admin#change_password'
  get '/forgot_1' => 'admin#forgot_1'
  get '/forgot_2' => 'admin#forgot_2'
  get '/forgot_3' => 'admin#forgot_3'

  post "/add_user" =>'admin#save_user'
  post '/update_password' => 'admin#update_password'
  post '/judge_q_and_a' => 'admin#judge_q_and_a'
  post '/update_reset_password' => 'admin#update_reset_password'
  post '/forgot_pw_1' => 'admin#forgot_pw_1'
  post '/process_phone_login' => 'admin#process_phone_login'
  post '/process_phone_data' => 'admin#process_phone_data'

  delete  '/del_user'=> 'admin#del_user'


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
