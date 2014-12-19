Rails.application.routes.draw do
  namespace :api do
    resources :chats, only: [:create]
    resources :inputs, only: [:create]
    resources :replies, only: [:create]
  end
end
