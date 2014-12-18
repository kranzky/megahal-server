Rails.application.routes.draw do
  namespace :api do
    resources :chats, only: [:create]
    resources :inputs, only: [:create]
  end
end
