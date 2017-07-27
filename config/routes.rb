Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admins

  mount RailsAdmin::Engine => '/admin', :as => 'admin'

  resources :teams do

    resources :organizations

    resources :people

    resources :activities

    resources :deals do
      get '/archive' => 'deals#archive', as: 'archive'
      get '/unarchive' => 'deals#unarchive', as: 'unarchive'
      get '/status' => 'deals#status', as: 'status'
    end

  end

  resources :visibilities
  get '/contacts/gmail', as: :contacts_push
  get '/teams/:team_id/contacts_callback' => 'people#contacts_callback', as: :contacts_callback
  get '/teams/:team_id/search' => 'teams#search', as: :search_team
  get '/teams/:team_id/export_deals' => 'teams#export_deals', as: :export_deals
  get '/teams/:team_id/export_people' => 'teams#export_people', as: :export_people
  get '/teams/:team_id/export_organizations' => 'teams#export_organizations', as: :export_organizations
  get '/teams/:team_id/export_activities' => 'teams#export_activities', as: :export_activities
  get '/teams/:team_id/export' => 'teams#export', as: :export_team
  get '/teams/:team_id/settings' => 'teams#settings', as: :settings_team

  get '/teams/:team_id/stats' => 'teams#stats', as: :stats_team
  get '/teams/:team_id/eagleview' => 'teams#eagleview', as: :eagleview_team
  get '/teams/:team_id/invite' => 'teams#invite', as: :invite_team
  get '/teams/:team_id/stages' => 'teams#stages', as: :stages_team
  get '/teams/:team_id/remove' => 'teams#remove', as: :remove_team
  post '/teams/:team_id/add_member' => 'teams#add_member', as: :add_member_team
  post '/teams/:team_id/upgrade' => 'teams#upgrade', as: :upgrade_team
  post '/teams/:team_id/card_edit' => 'teams#card_edit', as: :card_edit_team
  get '/teams/:team_id/change_card' => 'teams#change_card', as: :change_card_team
  get '/teams/:team_id/payment' => 'teams#payment', as: :payment_team
  post 'teams/:team_id/payment' => 'teams#payment', as: :post_payment_team
  devise_for :users, :controllers => { :registrations => "my_devise/registrations"}
  get '/tnc' => 'pages#tnc'
  get '/privacy_policy' => 'pages#privacy_policy'
  get '/refund_policy' => 'pages#refund_policy'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
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
