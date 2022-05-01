Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: "passwords"
  }
  
  devise_scope :user do
    get "/enter", to: "users/registrations#new", as: :sign_up
  end
  
  root "stories#index"
  
  get "/async_info/base_data", controller: "async_info#base_data", defaults: { format: :json }

  resources :articles

  post "/image_uploads", to: "article_images#create"
end