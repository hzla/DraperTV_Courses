OnlineSchool::Application.routes.draw do

  root :to => 'home#index'

  ##### DEVISE #####

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  devise_scope :user do
    #get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'you-rock', to: 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end


  ##### RESOURCES #####

  resources :apps
  resources :charges
  resources :skills
  resources :activity_feeds
  resources :community
  resources :social
  resources :resources
  resources :contests
  resources :courses
  resources :feedbacks
  resources :activities
  resources :users


  resources :events do
    resources :user_comments
    resources :user
  end

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

  resources :assignments do
    resources :user_comments
    resources :user_assignments
  end


  ##### GET #####
  get 'workreport', to: 'users#workreport', via: :all
  get 'workreport2', to: 'users#workreport2', via: :all
  get 'milestones', to: 'users#milestone', via: :all

  get 'activity', to: 'activity_feeds#index', as: :feed
  get 'notifications', to: 'activities#index', via: :all
  get 'feedback', to: 'feedbacks#index'
  get 'profile', to: 'profiles#show', as: :profile
  get 'users/:id', to: 'users#show'
  get 'network', to: 'users#list', as: :network
  get 'profile/:id', to: 'profiles#profile', as: :student_profile
  get 'access', to: 'users#access'
  get 'tags/:tag', to: 'users#index', as: :tag
  get 'activity', to: 'activity_feeds#index'
  get 'discussions', to: 'posts#index', via: :all
  get 'discussions/:id', to: 'posts#show', via: :all
  get '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :get
  get "/delayed_jobs" => DelayedJobWeb, :anchor => false, via: :all

  post '/assignments/:id/quiz_save_attempt', to: 'assignments#quiz_save_attempt', as: :assignments_survey_attempts
  mount Ckeditor::Engine => '/ckeditor'

  #Email Methods
  get "email_panel", to: 'email_panel#index', via: :all
  get "weekly_tops", to: 'email_panel#weekly_tops', as: :weekly_tops
  get "progress_report", to: 'email_panel#progress_report', as: :progress_report
  get "course_open", to: 'email_panel#course_open', as: :course_open



end


