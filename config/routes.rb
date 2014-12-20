Rails.application.routes.draw do
  root to: 'megahal#about'
  get 'chat', to: 'megahal#chat'
  get 'transcripts', to: 'megahal#transcripts'
  namespace :api do
    resources :chats, only: [:create]
    resources :inputs, only: [:create]
    resources :replies, only: [:create]
  end
end
