Rails.application.routes.draw do
  resources :users
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
