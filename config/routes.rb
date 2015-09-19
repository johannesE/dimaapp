Rails.application.routes.draw do
  resources :topics do
    resources :possibilities
  end
  root to: 'visitors#index'
  devise_for :users
end
