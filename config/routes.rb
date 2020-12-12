Rails.application.routes.draw do
  root "home#index"
  resources :books
  resources :fruits
end
