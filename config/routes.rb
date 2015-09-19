Rails.application.routes.draw do
  resources :topics do
    resources :possibilities
    get :vote, to: 'possibilities#vote'
  end
  root to: 'visitors#index'
  devise_for :users
end
