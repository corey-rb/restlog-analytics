Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.

  root :to => 'application#index'

  devise_for :users, :controllers => { :registrations => 'registration'}

  get 'users/profile(.:format)' => 'users#profile'
  put 'users/profile(.:format)' => 'users#update'
  get 'users/generate_key/' => 'users#gen_key'

  # Analaytics and data
  get 'message_analytics/app_data'                => 'message_analytics#app_data'
  get 'message_analytics/new_messages/'           => 'message_analytics#new_messages_since_timestamp'
  get 'message_analytics/dailyappscount'          => 'message_analytics#daily_app_message_count'

  get '/bug_report/' => 'users#bug_report'

  #user apps CRUD
  get  '/user/apps(.:format)'                   => 'apps#index'
  get  '/user/apps/:id(.:format)'               => 'apps#show'
  post '/user/apps(.:format)'                   => 'apps#create'
  put  '/user/apps/:id(.:format)'               => 'apps#edit'

  #apps - messages by app_id parameter
  get '/app/messages(.:format)'                 => 'messages#index'

  #current user
  get '/user/account(.:format)'                 => 'accounts#show'

  #get our base message log level data
  get 'messagelevels/levels(.:format)'          => 'message_level#index'

  #message collections
  get  'messages/collections(.:format)'          => 'message_collections#index'
  post 'messages/collections(.:format)'           => 'message_collections#create'
  #get 'messages/collections/:app_id'                => 'message_collections#list'

  get 'configuration/version(.:format)'         => 'configuration#index'

  # Our API Route Definitions
  namespace :api do
    namespace :v1 do
      resources :messages, :defaults => { :format => 'json' }
    end
  end

  get '*path' => 'application#index'
end
