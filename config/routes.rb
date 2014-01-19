OnlineSchool::Application.routes.draw do
  


  #root :to => 'profiles#show'
  root :to => 'home#index'
  resources :messages
  resources :apps
  get 'apply', to: 'apps#new'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  ActiveAdmin.routes(self)

  devise_scope :user do
    #get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'you-rock', to: 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end
  
  get 'tags/:tag', to: 'users#index', as: :tag

  resources :charges
  
  resources :calendar
  get 'calendar', to: 'calendar#index', as: :calendar
  
  resources :skills

  resources :events do
    resources :user_comments
    resources :user
  end

  get 'community', to: 'community#index'
  resources :community
  get 'community', to: 'community#index', as: :community

  resources :social
  get 'social', to: 'social#index', as: :social

  resources :resources
  get 'resources', to: 'resources#index', as: :resources

  resources :users
  get 'profile', to: 'profiles#show', as: :profile
  get 'users/:id', to: 'users#show'
  get 'network', to: 'users#list', as: :network
  get 'profile/:id', to: 'profiles#profile', as: :student_profile
  get 'access', to: 'users#access'
 
  resources :contests
  resources :courses
  resources :feedbacks
  get 'feedback', to: 'feedbacks#index', as: :feedbacks


  resources :user_assignments do
    resources :assignments
  end

  resources :videos do
    resources :user_comments
  end

  resources :posts do
    resources :user_comments
  end

  get 'videos', to: 'videos#index', as: :videos

  resources :assignments do
    resources :user_comments
    resources :user_assignments
  end

  resources :activities

  post '/assignments/:id/quiz_save_attempt', to: 'assignments#quiz_save_attempt', as: :assignments_survey_attempts


  # get "profile/show"
  # get '/:id', to: 'profiles#show'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
