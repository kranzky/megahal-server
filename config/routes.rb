Rails.application.routes.draw do
  namespace :api do
    resources :chats, only: [:create]
  end
end
