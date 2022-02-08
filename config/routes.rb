Rails.application.routes.draw do

  # GET /about
  get "about", to: "about#index"

  # Defines the root path route ("/")
  # root "articles#index"
  root "main#index"
end
