OnlineSchool::Application.routes.draw do

  resources :activity_feeds

  mount Ckeditor::Engine => '/ckeditor'
  #root :to => 'profiles#show'
  root :to => 'home#index'
  # resources :messages
  resources :apps

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  devise_scope :user do
    #get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'you-rock', to: 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  get 'tags/:tag', to: 'users#index', as: :tag

  resources :charges

  resources :calendar
  #get 'calendar', to: 'calendar#index', as: :calendar

  resources :skills

  resources :events do
    resources :user_comments
    resources :user
  end

  #get 'community', to: 'community#index'
  resources :community
  #get 'community', to: 'community#index', as: :community

  resources :social
  #get 'social', to: 'social#index', as: :social

  resources :resources
  #get 'resources', to: 'resources#index', as: :resources

  resources :users
  get 'profile', to: 'profiles#show', as: :profile
  get 'users/:id', to: 'users#show'
  get 'network', to: 'users#list', as: :network
  get 'profile/:id', to: 'profiles#profile', as: :student_profile
  get 'access', to: 'users#access'

  resources :contests
  resources :courses
  resources :feedbacks
  get 'feedback', to: 'feedbacks#index'

  #map.resources :user_assignments, :has_many => :user_comments
  resources :user_assignments do
    resources :assignments
    resources :user_comments
    resources :user
  end

  resources :videos do
    resources :user_comments
  end

  resources :posts do
    resources :user_comments do
      collection { post :vote_for_comment }
      collection { post :unvote_for_comment }
    end

    collection { post :vote_for_post }
    collection { post :unvote_for_post }
  end

  resources :user_comments do
      collection { post :vote_for_comment }
      collection { post :unvote_for_comment }
  end

  #get 'videos', to: 'videos#index', as: :videos

  resources :assignments do
    resources :user_comments
    resources :user_assignments
  end

  resources :activities
  get 'notifications', to: 'activities#index', via: :all


  post '/assignments/:id/quiz_save_attempt', to: 'assignments#quiz_save_attempt', as: :assignments_survey_attempts

  # match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/ }, via: :all

  get '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :get
  get "/delayed_jobs" => DelayedJobWeb, :anchor => false, via: [:get, :post]


  get 'discussions', to: 'posts#index', via: :all
  get 'discussions/:id', to: 'posts#show', via: :all

end


