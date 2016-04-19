Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :attachments
    resources :categories
    resources :departments
    resources :opportunities
    resources :questions
    resources :vendors

    root to: 'users#index'
  end

  devise_for :users
  root to: 'home#index'

  resources :opportunities do
    collection do
      get 'pending'
    end

    member do
      get 'submit'
      post 'approve'
      post 'subscribe'
    end

    resources :questions, only: [:create, :update, :destroy]
    resources :attachments, only: [:create, :destroy]
  end
end
