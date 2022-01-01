Rails.application.routes.draw do
  devise_for :users

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create, :show]
  end
  get '/about' => 'home#about'
  get '/blog', to: 'posts#index', as: :blog
  get '/blog/:id', to: 'posts#show', as: :blog_entry
  root 'posts#index'

  namespace :admin do
    get 'dashboard' => 'admin#dashboard', as: :dashboard
    resources :categories
    resources :posts
    resources :images
    resources :users
  end
 end
