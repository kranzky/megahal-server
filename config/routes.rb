Rails.application.routes.draw do
  get 'chat/index'
  get 'chat/logs'
  post 'chat/say'
  root "chat#index"
end
