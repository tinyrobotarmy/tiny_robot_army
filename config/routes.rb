TinyRobotArmy::Application.routes.draw do
  devise_for :users

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create, :show]
  end
  match '/contact' => 'home#contact'
  root :to => 'home#index'

  namespace :admin do
    resources :posts
  end
end
