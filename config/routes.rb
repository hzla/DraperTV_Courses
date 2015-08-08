OnlineSchool::Application.routes.draw do

  root :to => 'topics#index'

  ##### DEVISE #####

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  ##### RESOURCES #####

  resources :topics 
  resources :tracks
  resources :lessons
  resources :progresses

  resources :comments
  get '/comments/:id/upvote', to: "comments#upvote", as: "comment_upvote"
  
  resources :amas
  resources :charges

  get '/auth/facebook/callback', :to => 'auths#facebook_create'
  post '/codes/update', to: 'codes#update', as: "update_code"
  get '/biweeklies', to: "amas#biweeklies", as: 'biweeklies'

  ##### OLD #####
  resources :events
  resources :users
end


