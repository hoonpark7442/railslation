require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: "passwords"
  }
  
  devise_scope :user do
    get "/enter", to: "users/registrations#new", as: :sign_up
    delete "/sign_out", to: "users/sessions#destroy"
  end
  
  get "/async_info/base_data", controller: "async_info#base_data", defaults: { format: :json }

  resources :articles, only: [:create, :update]
  get "/new", to: "articles#new"

  post "/image_uploads", to: "article_images#create"

  get '/search/feed_content', to: "search#feed_content", as: :search

  get "/:feed_type", to: "stories#index"

  get "/:username/:slug/edit", to: "articles#edit"
  get "/:username/:slug", to: "stories#show"

  get "/:username", to: "stories#index"

  root "stories#index"
end