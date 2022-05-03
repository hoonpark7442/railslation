Rails.application.routes.draw do
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
  
  root "stories#index"
  
  get "/async_info/base_data", controller: "async_info#base_data", defaults: { format: :json }

  resources :articles, only: [:create, :update]
  get "/new", to: "articles#new"

  post "/image_uploads", to: "article_images#create"

  get "/:username/:slug/edit", to: "articles#edit"
  get "/:username/:slug", to: "stories#show"
end