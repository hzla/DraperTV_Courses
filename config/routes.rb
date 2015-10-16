OnlineSchool::Application.routes.draw do

  root :to => 'topics#index'

  ##### DEVISE #####

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions", passwords: "passwords"}
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'sessions#destroy', as: :logout
  end

  ##### RESOURCES #####

  resources :topics 
  resources :tracks
  resources :lessons
  resources :progresses

  resources :comments
  get '/comments/:id/upvote', to: "comments#upvote", as: "comment_upvote"

  get '/announcements/hide', to: 'announcements#hide', as: "hide_announcements"
  resources :announcements

  
  resources :amas
  resources :charges, only: ["create", "new"]
  get '/edit_subscription', to: "charges#edit", as: "edit_charge"
  post '/update_subscription', to: "charges#update", as: "update_charge"
  get '/cancel_subscription', to: 'charges#destroy', as: "destroy_charge"

  get '/auth/facebook/callback', :to => 'auths#facebook_create'
  post '/codes/update', to: 'codes#update', as: "update_code"
  get '/biweeklies', to: "amas#biweeklies", as: 'biweeklies'

  get '/privacy', to: 'home#privacy_policy', as: 'privacy'
  get '/terms', to: 'home#terms', as: 'terms'

  ##### OLD #####
  resources :events
  resources :users, only: ["update", "destroy"]
  get '/users/settings/edit', to: "users#edit", as: "edit_user"
end


