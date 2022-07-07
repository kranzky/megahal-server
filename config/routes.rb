Rails.application.routes.draw do
  get 'chat/index'
  get 'chat/say'
  root "chat#index"
end
