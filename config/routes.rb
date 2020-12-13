# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  resources :books
  resources :fruits
  namespace "api" do
    resources :fruits, only: %i(update)
  end
end
