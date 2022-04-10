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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
