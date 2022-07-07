Rails.application.routes.draw do
  get 'chat/index'
  post 'chat/say'
  root "chat#index"
end
