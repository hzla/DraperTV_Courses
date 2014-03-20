
OnlineSchool::Application.routes.draw do
  
  #root :to => 'profiles#show'
  root :to => 'home#index'
  resources :messages
  resources :apps
  get 'apply', to: 'apps#new'

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

  post '/assignments/:id/quiz_save_attempt', to: 'assignments#quiz_save_attempt', as: :assignments_survey_attempts




  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/ }, via: :all
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


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

# == Route Map (Updated 2014-03-07 16:21)
#
#                            Prefix Verb       URI Pattern                                                            Controller#Action
#                              root GET        /                                                                      home#index
#                          messages GET        /messages(.:format)                                                    messages#index
#                                   POST       /messages(.:format)                                                    messages#create
#                       new_message GET        /messages/new(.:format)                                                messages#new
#                      edit_message GET        /messages/:id/edit(.:format)                                           messages#edit
#                           message GET        /messages/:id(.:format)                                                messages#show
#                                   PATCH      /messages/:id(.:format)                                                messages#update
#                                   PUT        /messages/:id(.:format)                                                messages#update
#                                   DELETE     /messages/:id(.:format)                                                messages#destroy
#                              apps GET        /apps(.:format)                                                        apps#index
#                                   POST       /apps(.:format)                                                        apps#create
#                           new_app GET        /apps/new(.:format)                                                    apps#new
#                          edit_app GET        /apps/:id/edit(.:format)                                               apps#edit
#                               app GET        /apps/:id(.:format)                                                    apps#show
#                                   PATCH      /apps/:id(.:format)                                                    apps#update
#                                   PUT        /apps/:id(.:format)                                                    apps#update
#                                   DELETE     /apps/:id(.:format)                                                    apps#destroy
#                             apply GET        /apply(.:format)                                                       apps#new
#            new_admin_user_session GET        /admin/login(.:format)                                                 active_admin/devise/sessions#new
#                admin_user_session POST       /admin/login(.:format)                                                 active_admin/devise/sessions#create
#        destroy_admin_user_session DELETE|GET /admin/logout(.:format)                                                active_admin/devise/sessions#destroy
#               admin_user_password POST       /admin/password(.:format)                                              active_admin/devise/passwords#create
#           new_admin_user_password GET        /admin/password/new(.:format)                                          active_admin/devise/passwords#new
#          edit_admin_user_password GET        /admin/password/edit(.:format)                                         active_admin/devise/passwords#edit
#                                   PATCH      /admin/password(.:format)                                              active_admin/devise/passwords#update
#                                   PUT        /admin/password(.:format)                                              active_admin/devise/passwords#update
#                        admin_root GET        /admin(.:format)                                                       admin/dashboard#index
#    batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)                              admin/admin_users#batch_action
#                 admin_admin_users GET        /admin/admin_users(.:format)                                           admin/admin_users#index
#                                   POST       /admin/admin_users(.:format)                                           admin/admin_users#create
#              new_admin_admin_user GET        /admin/admin_users/new(.:format)                                       admin/admin_users#new
#             edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)                                  admin/admin_users#edit
#                  admin_admin_user GET        /admin/admin_users/:id(.:format)                                       admin/admin_users#show
#                                   PATCH      /admin/admin_users/:id(.:format)                                       admin/admin_users#update
#                                   PUT        /admin/admin_users/:id(.:format)                                       admin/admin_users#update
#                                   DELETE     /admin/admin_users/:id(.:format)                                       admin/admin_users#destroy
#    batch_action_admin_assignments POST       /admin/assignments/batch_action(.:format)                              admin/assignments#batch_action
#                 admin_assignments GET        /admin/assignments(.:format)                                           admin/assignments#index
#                                   POST       /admin/assignments(.:format)                                           admin/assignments#create
#              new_admin_assignment GET        /admin/assignments/new(.:format)                                       admin/assignments#new
#             edit_admin_assignment GET        /admin/assignments/:id/edit(.:format)                                  admin/assignments#edit
#                  admin_assignment GET        /admin/assignments/:id(.:format)                                       admin/assignments#show
#                                   PATCH      /admin/assignments/:id(.:format)                                       admin/assignments#update
#                                   PUT        /admin/assignments/:id(.:format)                                       admin/assignments#update
#                                   DELETE     /admin/assignments/:id(.:format)                                       admin/assignments#destroy
#        batch_action_admin_courses POST       /admin/courses/batch_action(.:format)                                  admin/courses#batch_action
#                     admin_courses GET        /admin/courses(.:format)                                               admin/courses#index
#                                   POST       /admin/courses(.:format)                                               admin/courses#create
#                  new_admin_course GET        /admin/courses/new(.:format)                                           admin/courses#new
#                 edit_admin_course GET        /admin/courses/:id/edit(.:format)                                      admin/courses#edit
#                      admin_course GET        /admin/courses/:id(.:format)                                           admin/courses#show
#                                   PATCH      /admin/courses/:id(.:format)                                           admin/courses#update
#                                   PUT        /admin/courses/:id(.:format)                                           admin/courses#update
#                                   DELETE     /admin/courses/:id(.:format)                                           admin/courses#destroy
#                   admin_dashboard GET        /admin/dashboard(.:format)                                             admin/dashboard#index
#      batch_action_admin_resources POST       /admin/resources/batch_action(.:format)                                admin/resources#batch_action
#                   admin_resources GET        /admin/resources(.:format)                                             admin/resources#index
#                                   POST       /admin/resources(.:format)                                             admin/resources#create
#                new_admin_resource GET        /admin/resources/new(.:format)                                         admin/resources#new
#               edit_admin_resource GET        /admin/resources/:id/edit(.:format)                                    admin/resources#edit
#                    admin_resource GET        /admin/resources/:id(.:format)                                         admin/resources#show
#                                   PATCH      /admin/resources/:id(.:format)                                         admin/resources#update
#                                   PUT        /admin/resources/:id(.:format)                                         admin/resources#update
#                                   DELETE     /admin/resources/:id(.:format)                                         admin/resources#destroy
#         batch_action_admin_skills POST       /admin/skills/batch_action(.:format)                                   admin/skills#batch_action
#                      admin_skills GET        /admin/skills(.:format)                                                admin/skills#index
#                                   POST       /admin/skills(.:format)                                                admin/skills#create
#                   new_admin_skill GET        /admin/skills/new(.:format)                                            admin/skills#new
#                  edit_admin_skill GET        /admin/skills/:id/edit(.:format)                                       admin/skills#edit
#                       admin_skill GET        /admin/skills/:id(.:format)                                            admin/skills#show
#                                   PATCH      /admin/skills/:id(.:format)                                            admin/skills#update
#                                   PUT        /admin/skills/:id(.:format)                                            admin/skills#update
#                                   DELETE     /admin/skills/:id(.:format)                                            admin/skills#destroy
# batch_action_admin_survey_surveys POST       /admin/survey_surveys/batch_action(.:format)                           admin/survey_surveys#batch_action
#              admin_survey_surveys GET        /admin/survey_surveys(.:format)                                        admin/survey_surveys#index
#                                   POST       /admin/survey_surveys(.:format)                                        admin/survey_surveys#create
#           new_admin_survey_survey GET        /admin/survey_surveys/new(.:format)                                    admin/survey_surveys#new
#          edit_admin_survey_survey GET        /admin/survey_surveys/:id/edit(.:format)                               admin/survey_surveys#edit
#               admin_survey_survey GET        /admin/survey_surveys/:id(.:format)                                    admin/survey_surveys#show
#                                   PATCH      /admin/survey_surveys/:id(.:format)                                    admin/survey_surveys#update
#                                   PUT        /admin/survey_surveys/:id(.:format)                                    admin/survey_surveys#update
#                                   DELETE     /admin/survey_surveys/:id(.:format)                                    admin/survey_surveys#destroy
#          batch_action_admin_users POST       /admin/users/batch_action(.:format)                                    admin/users#batch_action
#                       admin_users GET        /admin/users(.:format)                                                 admin/users#index
#                                   POST       /admin/users(.:format)                                                 admin/users#create
#                    new_admin_user GET        /admin/users/new(.:format)                                             admin/users#new
#                   edit_admin_user GET        /admin/users/:id/edit(.:format)                                        admin/users#edit
#                        admin_user GET        /admin/users/:id(.:format)                                             admin/users#show
#                                   PATCH      /admin/users/:id(.:format)                                             admin/users#update
#                                   PUT        /admin/users/:id(.:format)                                             admin/users#update
#                                   DELETE     /admin/users/:id(.:format)                                             admin/users#destroy
#         batch_action_admin_videos POST       /admin/videos/batch_action(.:format)                                   admin/videos#batch_action
#                      admin_videos GET        /admin/videos(.:format)                                                admin/videos#index
#                                   POST       /admin/videos(.:format)                                                admin/videos#create
#                   new_admin_video GET        /admin/videos/new(.:format)                                            admin/videos#new
#                  edit_admin_video GET        /admin/videos/:id/edit(.:format)                                       admin/videos#edit
#                       admin_video GET        /admin/videos/:id(.:format)                                            admin/videos#show
#                                   PATCH      /admin/videos/:id(.:format)                                            admin/videos#update
#                                   PUT        /admin/videos/:id(.:format)                                            admin/videos#update
#                                   DELETE     /admin/videos/:id(.:format)                                            admin/videos#destroy
#       batch_action_admin_comments POST       /admin/comments/batch_action(.:format)                                 admin/comments#batch_action
#                    admin_comments GET        /admin/comments(.:format)                                              admin/comments#index
#                                   POST       /admin/comments(.:format)                                              admin/comments#create
#                     admin_comment GET        /admin/comments/:id(.:format)                                          admin/comments#show
#                  new_user_session GET        /users/sign_in(.:format)                                               devise/sessions#new
#                      user_session POST       /users/sign_in(.:format)                                               devise/sessions#create
#              destroy_user_session DELETE     /users/sign_out(.:format)                                              devise/sessions#destroy
#                     user_password POST       /users/password(.:format)                                              devise/passwords#create
#                 new_user_password GET        /users/password/new(.:format)                                          devise/passwords#new
#                edit_user_password GET        /users/password/edit(.:format)                                         devise/passwords#edit
#                                   PATCH      /users/password(.:format)                                              devise/passwords#update
#                                   PUT        /users/password(.:format)                                              devise/passwords#update
#          cancel_user_registration GET        /users/cancel(.:format)                                                devise/registrations#cancel
#                 user_registration POST       /users(.:format)                                                       devise/registrations#create
#             new_user_registration GET        /users/sign_up(.:format)                                               devise/registrations#new
#            edit_user_registration GET        /users/edit(.:format)                                                  devise/registrations#edit
#                                   PATCH      /users(.:format)                                                       devise/registrations#update
#                                   PUT        /users(.:format)                                                       devise/registrations#update
#                                   DELETE     /users(.:format)                                                       devise/registrations#destroy
#                             login GET        /login(.:format)                                                       devise/sessions#new
#                                   GET        /you-rock(.:format)                                                    devise/registrations#new
#                            logout GET        /logout(.:format)                                                      devise/sessions#destroy
#                               tag GET        /tags/:tag(.:format)                                                   users#index
#                           charges GET        /charges(.:format)                                                     charges#index
#                                   POST       /charges(.:format)                                                     charges#create
#                        new_charge GET        /charges/new(.:format)                                                 charges#new
#                       edit_charge GET        /charges/:id/edit(.:format)                                            charges#edit
#                            charge GET        /charges/:id(.:format)                                                 charges#show
#                                   PATCH      /charges/:id(.:format)                                                 charges#update
#                                   PUT        /charges/:id(.:format)                                                 charges#update
#                                   DELETE     /charges/:id(.:format)                                                 charges#destroy
#                    calendar_index GET        /calendar(.:format)                                                    calendar#index
#                                   POST       /calendar(.:format)                                                    calendar#create
#                      new_calendar GET        /calendar/new(.:format)                                                calendar#new
#                     edit_calendar GET        /calendar/:id/edit(.:format)                                           calendar#edit
#                          calendar GET        /calendar/:id(.:format)                                                calendar#show
#                                   PATCH      /calendar/:id(.:format)                                                calendar#update
#                                   PUT        /calendar/:id(.:format)                                                calendar#update
#                                   DELETE     /calendar/:id(.:format)                                                calendar#destroy
#                            skills GET        /skills(.:format)                                                      skills#index
#                                   POST       /skills(.:format)                                                      skills#create
#                         new_skill GET        /skills/new(.:format)                                                  skills#new
#                        edit_skill GET        /skills/:id/edit(.:format)                                             skills#edit
#                             skill GET        /skills/:id(.:format)                                                  skills#show
#                                   PATCH      /skills/:id(.:format)                                                  skills#update
#                                   PUT        /skills/:id(.:format)                                                  skills#update
#                                   DELETE     /skills/:id(.:format)                                                  skills#destroy
#               event_user_comments GET        /events/:event_id/user_comments(.:format)                              user_comments#index
#                                   POST       /events/:event_id/user_comments(.:format)                              user_comments#create
#            new_event_user_comment GET        /events/:event_id/user_comments/new(.:format)                          user_comments#new
#           edit_event_user_comment GET        /events/:event_id/user_comments/:id/edit(.:format)                     user_comments#edit
#                event_user_comment GET        /events/:event_id/user_comments/:id(.:format)                          user_comments#show
#                                   PATCH      /events/:event_id/user_comments/:id(.:format)                          user_comments#update
#                                   PUT        /events/:event_id/user_comments/:id(.:format)                          user_comments#update
#                                   DELETE     /events/:event_id/user_comments/:id(.:format)                          user_comments#destroy
#                  event_user_index GET        /events/:event_id/user(.:format)                                       user#index
#                                   POST       /events/:event_id/user(.:format)                                       user#create
#                    new_event_user GET        /events/:event_id/user/new(.:format)                                   user#new
#                   edit_event_user GET        /events/:event_id/user/:id/edit(.:format)                              user#edit
#                        event_user GET        /events/:event_id/user/:id(.:format)                                   user#show
#                                   PATCH      /events/:event_id/user/:id(.:format)                                   user#update
#                                   PUT        /events/:event_id/user/:id(.:format)                                   user#update
#                                   DELETE     /events/:event_id/user/:id(.:format)                                   user#destroy
#                            events GET        /events(.:format)                                                      events#index
#                                   POST       /events(.:format)                                                      events#create
#                         new_event GET        /events/new(.:format)                                                  events#new
#                        edit_event GET        /events/:id/edit(.:format)                                             events#edit
#                             event GET        /events/:id(.:format)                                                  events#show
#                                   PATCH      /events/:id(.:format)                                                  events#update
#                                   PUT        /events/:id(.:format)                                                  events#update
#                                   DELETE     /events/:id(.:format)                                                  events#destroy
#                   community_index GET        /community(.:format)                                                   community#index
#                                   POST       /community(.:format)                                                   community#create
#                     new_community GET        /community/new(.:format)                                               community#new
#                    edit_community GET        /community/:id/edit(.:format)                                          community#edit
#                         community GET        /community/:id(.:format)                                               community#show
#                                   PATCH      /community/:id(.:format)                                               community#update
#                                   PUT        /community/:id(.:format)                                               community#update
#                                   DELETE     /community/:id(.:format)                                               community#destroy
#                      social_index GET        /social(.:format)                                                      social#index
#                                   POST       /social(.:format)                                                      social#create
#                        new_social GET        /social/new(.:format)                                                  social#new
#                       edit_social GET        /social/:id/edit(.:format)                                             social#edit
#                            social GET        /social/:id(.:format)                                                  social#show
#                                   PATCH      /social/:id(.:format)                                                  social#update
#                                   PUT        /social/:id(.:format)                                                  social#update
#                                   DELETE     /social/:id(.:format)                                                  social#destroy
#                         resources GET        /resources(.:format)                                                   resources#index
#                                   POST       /resources(.:format)                                                   resources#create
#                      new_resource GET        /resources/new(.:format)                                               resources#new
#                     edit_resource GET        /resources/:id/edit(.:format)                                          resources#edit
#                          resource GET        /resources/:id(.:format)                                               resources#show
#                                   PATCH      /resources/:id(.:format)                                               resources#update
#                                   PUT        /resources/:id(.:format)                                               resources#update
#                                   DELETE     /resources/:id(.:format)                                               resources#destroy
#                             users GET        /users(.:format)                                                       users#index
#                                   POST       /users(.:format)                                                       users#create
#                          new_user GET        /users/new(.:format)                                                   users#new
#                         edit_user GET        /users/:id/edit(.:format)                                              users#edit
#                              user GET        /users/:id(.:format)                                                   users#show
#                                   PATCH      /users/:id(.:format)                                                   users#update
#                                   PUT        /users/:id(.:format)                                                   users#update
#                                   DELETE     /users/:id(.:format)                                                   users#destroy
#                           profile GET        /profile(.:format)                                                     profiles#show
#                                   GET        /users/:id(.:format)                                                   users#show
#                           network GET        /network(.:format)                                                     users#list
#                   student_profile GET        /profile/:id(.:format)                                                 profiles#profile
#                            access GET        /access(.:format)                                                      users#access
#                          contests GET        /contests(.:format)                                                    contests#index
#                                   POST       /contests(.:format)                                                    contests#create
#                       new_contest GET        /contests/new(.:format)                                                contests#new
#                      edit_contest GET        /contests/:id/edit(.:format)                                           contests#edit
#                           contest GET        /contests/:id(.:format)                                                contests#show
#                                   PATCH      /contests/:id(.:format)                                                contests#update
#                                   PUT        /contests/:id(.:format)                                                contests#update
#                                   DELETE     /contests/:id(.:format)                                                contests#destroy
#                           courses GET        /courses(.:format)                                                     courses#index
#                                   POST       /courses(.:format)                                                     courses#create
#                        new_course GET        /courses/new(.:format)                                                 courses#new
#                       edit_course GET        /courses/:id/edit(.:format)                                            courses#edit
#                            course GET        /courses/:id(.:format)                                                 courses#show
#                                   PATCH      /courses/:id(.:format)                                                 courses#update
#                                   PUT        /courses/:id(.:format)                                                 courses#update
#                                   DELETE     /courses/:id(.:format)                                                 courses#destroy
#                         feedbacks GET        /feedbacks(.:format)                                                   feedbacks#index
#                                   POST       /feedbacks(.:format)                                                   feedbacks#create
#                      new_feedback GET        /feedbacks/new(.:format)                                               feedbacks#new
#                     edit_feedback GET        /feedbacks/:id/edit(.:format)                                          feedbacks#edit
#                          feedback GET        /feedbacks/:id(.:format)                                               feedbacks#show
#                                   PATCH      /feedbacks/:id(.:format)                                               feedbacks#update
#                                   PUT        /feedbacks/:id(.:format)                                               feedbacks#update
#                                   DELETE     /feedbacks/:id(.:format)                                               feedbacks#destroy
#                                   GET        /feedback(.:format)                                                    feedbacks#index
#       user_assignment_assignments GET        /user_assignments/:user_assignment_id/assignments(.:format)            assignments#index
#                                   POST       /user_assignments/:user_assignment_id/assignments(.:format)            assignments#create
#    new_user_assignment_assignment GET        /user_assignments/:user_assignment_id/assignments/new(.:format)        assignments#new
#   edit_user_assignment_assignment GET        /user_assignments/:user_assignment_id/assignments/:id/edit(.:format)   assignments#edit
#        user_assignment_assignment GET        /user_assignments/:user_assignment_id/assignments/:id(.:format)        assignments#show
#                                   PATCH      /user_assignments/:user_assignment_id/assignments/:id(.:format)        assignments#update
#                                   PUT        /user_assignments/:user_assignment_id/assignments/:id(.:format)        assignments#update
#                                   DELETE     /user_assignments/:user_assignment_id/assignments/:id(.:format)        assignments#destroy
#     user_assignment_user_comments GET        /user_assignments/:user_assignment_id/user_comments(.:format)          user_comments#index
#                                   POST       /user_assignments/:user_assignment_id/user_comments(.:format)          user_comments#create
#  new_user_assignment_user_comment GET        /user_assignments/:user_assignment_id/user_comments/new(.:format)      user_comments#new
# edit_user_assignment_user_comment GET        /user_assignments/:user_assignment_id/user_comments/:id/edit(.:format) user_comments#edit
#      user_assignment_user_comment GET        /user_assignments/:user_assignment_id/user_comments/:id(.:format)      user_comments#show
#                                   PATCH      /user_assignments/:user_assignment_id/user_comments/:id(.:format)      user_comments#update
#                                   PUT        /user_assignments/:user_assignment_id/user_comments/:id(.:format)      user_comments#update
#                                   DELETE     /user_assignments/:user_assignment_id/user_comments/:id(.:format)      user_comments#destroy
#        user_assignment_user_index GET        /user_assignments/:user_assignment_id/user(.:format)                   user#index
#                                   POST       /user_assignments/:user_assignment_id/user(.:format)                   user#create
#          new_user_assignment_user GET        /user_assignments/:user_assignment_id/user/new(.:format)               user#new
#         edit_user_assignment_user GET        /user_assignments/:user_assignment_id/user/:id/edit(.:format)          user#edit
#              user_assignment_user GET        /user_assignments/:user_assignment_id/user/:id(.:format)               user#show
#                                   PATCH      /user_assignments/:user_assignment_id/user/:id(.:format)               user#update
#                                   PUT        /user_assignments/:user_assignment_id/user/:id(.:format)               user#update
#                                   DELETE     /user_assignments/:user_assignment_id/user/:id(.:format)               user#destroy
#                  user_assignments GET        /user_assignments(.:format)                                            user_assignments#index
#                                   POST       /user_assignments(.:format)                                            user_assignments#create
#               new_user_assignment GET        /user_assignments/new(.:format)                                        user_assignments#new
#              edit_user_assignment GET        /user_assignments/:id/edit(.:format)                                   user_assignments#edit
#                   user_assignment GET        /user_assignments/:id(.:format)                                        user_assignments#show
#                                   PATCH      /user_assignments/:id(.:format)                                        user_assignments#update
#                                   PUT        /user_assignments/:id(.:format)                                        user_assignments#update
#                                   DELETE     /user_assignments/:id(.:format)                                        user_assignments#destroy
#               video_user_comments GET        /videos/:video_id/user_comments(.:format)                              user_comments#index
#                                   POST       /videos/:video_id/user_comments(.:format)                              user_comments#create
#            new_video_user_comment GET        /videos/:video_id/user_comments/new(.:format)                          user_comments#new
#           edit_video_user_comment GET        /videos/:video_id/user_comments/:id/edit(.:format)                     user_comments#edit
#                video_user_comment GET        /videos/:video_id/user_comments/:id(.:format)                          user_comments#show
#                                   PATCH      /videos/:video_id/user_comments/:id(.:format)                          user_comments#update
#                                   PUT        /videos/:video_id/user_comments/:id(.:format)                          user_comments#update
#                                   DELETE     /videos/:video_id/user_comments/:id(.:format)                          user_comments#destroy
#                            videos GET        /videos(.:format)                                                      videos#index
#                                   POST       /videos(.:format)                                                      videos#create
#                         new_video GET        /videos/new(.:format)                                                  videos#new
#                        edit_video GET        /videos/:id/edit(.:format)                                             videos#edit
#                             video GET        /videos/:id(.:format)                                                  videos#show
#                                   PATCH      /videos/:id(.:format)                                                  videos#update
#                                   PUT        /videos/:id(.:format)                                                  videos#update
#                                   DELETE     /videos/:id(.:format)                                                  videos#destroy
#                post_user_comments GET        /posts/:post_id/user_comments(.:format)                                user_comments#index
#                                   POST       /posts/:post_id/user_comments(.:format)                                user_comments#create
#             new_post_user_comment GET        /posts/:post_id/user_comments/new(.:format)                            user_comments#new
#            edit_post_user_comment GET        /posts/:post_id/user_comments/:id/edit(.:format)                       user_comments#edit
#                 post_user_comment GET        /posts/:post_id/user_comments/:id(.:format)                            user_comments#show
#                                   PATCH      /posts/:post_id/user_comments/:id(.:format)                            user_comments#update
#                                   PUT        /posts/:post_id/user_comments/:id(.:format)                            user_comments#update
#                                   DELETE     /posts/:post_id/user_comments/:id(.:format)                            user_comments#destroy
#                             posts GET        /posts(.:format)                                                       posts#index
#                                   POST       /posts(.:format)                                                       posts#create
#                          new_post GET        /posts/new(.:format)                                                   posts#new
#                         edit_post GET        /posts/:id/edit(.:format)                                              posts#edit
#                              post GET        /posts/:id(.:format)                                                   posts#show
#                                   PATCH      /posts/:id(.:format)                                                   posts#update
#                                   PUT        /posts/:id(.:format)                                                   posts#update
#                                   DELETE     /posts/:id(.:format)                                                   posts#destroy
#          assignment_user_comments GET        /assignments/:assignment_id/user_comments(.:format)                    user_comments#index
#                                   POST       /assignments/:assignment_id/user_comments(.:format)                    user_comments#create
#       new_assignment_user_comment GET        /assignments/:assignment_id/user_comments/new(.:format)                user_comments#new
#      edit_assignment_user_comment GET        /assignments/:assignment_id/user_comments/:id/edit(.:format)           user_comments#edit
#           assignment_user_comment GET        /assignments/:assignment_id/user_comments/:id(.:format)                user_comments#show
#                                   PATCH      /assignments/:assignment_id/user_comments/:id(.:format)                user_comments#update
#                                   PUT        /assignments/:assignment_id/user_comments/:id(.:format)                user_comments#update
#                                   DELETE     /assignments/:assignment_id/user_comments/:id(.:format)                user_comments#destroy
#       assignment_user_assignments GET        /assignments/:assignment_id/user_assignments(.:format)                 user_assignments#index
#                                   POST       /assignments/:assignment_id/user_assignments(.:format)                 user_assignments#create
#    new_assignment_user_assignment GET        /assignments/:assignment_id/user_assignments/new(.:format)             user_assignments#new
#   edit_assignment_user_assignment GET        /assignments/:assignment_id/user_assignments/:id/edit(.:format)        user_assignments#edit
#        assignment_user_assignment GET        /assignments/:assignment_id/user_assignments/:id(.:format)             user_assignments#show
#                                   PATCH      /assignments/:assignment_id/user_assignments/:id(.:format)             user_assignments#update
#                                   PUT        /assignments/:assignment_id/user_assignments/:id(.:format)             user_assignments#update
#                                   DELETE     /assignments/:assignment_id/user_assignments/:id(.:format)             user_assignments#destroy
#                       assignments GET        /assignments(.:format)                                                 assignments#index
#                                   POST       /assignments(.:format)                                                 assignments#create
#                    new_assignment GET        /assignments/new(.:format)                                             assignments#new
#                   edit_assignment GET        /assignments/:id/edit(.:format)                                        assignments#edit
#                        assignment GET        /assignments/:id(.:format)                                             assignments#show
#                                   PATCH      /assignments/:id(.:format)                                             assignments#update
#                                   PUT        /assignments/:id(.:format)                                             assignments#update
#                                   DELETE     /assignments/:id(.:format)                                             assignments#destroy
#                        activities GET        /activities(.:format)                                                  activities#index
#                                   POST       /activities(.:format)                                                  activities#create
#                      new_activity GET        /activities/new(.:format)                                              activities#new
#                     edit_activity GET        /activities/:id/edit(.:format)                                         activities#edit
#                          activity GET        /activities/:id(.:format)                                              activities#show
#                                   PATCH      /activities/:id(.:format)                                              activities#update
#                                   PUT        /activities/:id(.:format)                                              activities#update
#                                   DELETE     /activities/:id(.:format)                                              activities#destroy
#       assignments_survey_attempts POST       /assignments/:id/quiz_save_attempt(.:format)                           assignments#quiz_save_attempt
#

